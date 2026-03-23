import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

import { createClient, type SupabaseClient } from '@supabase/supabase-js';
import XLSX from 'xlsx';

import {
  DEFAULT_MANIFEST_PATH,
  DEFAULT_SOURCE_PATH,
  applyOperatorImport,
  assertFileExists,
  findUnmappedSnapshotOperators,
  loadManifestRows,
  loadSourceRows,
  prepareOperatorImport,
  type AppliedOperatorImport,
} from './lib/operator_basin_sync.js';
import {
  buildOperatorGeojson,
  OUTPUT_BASE,
  type BuildOperatorGeojsonSummary,
} from './build_operator_geojson.js';
import { deriveSnapshotMonth } from './lib/monthly_snapshot.js';

interface CliOptions {
  inputPath: string;
  manifestPath: string;
  reportPath: string;
  cleanOutput: boolean;
  dryRun: boolean;
}

interface OperatorSyncFailure {
  operatorSlug: string;
  reason: string;
}

interface OperatorRolloutWarning {
  operatorSlug: string;
  reason: string;
}

interface MonthlySyncReport {
  generatedAt: string;
  workflow: 'monthly-production-sync';
  mode: 'overlay-plus-production-state-sync';
  dryRun: boolean;
  snapshotMonth: string;
  inputPath: string;
  manifestPath: string;
  reportPath: string;
  outputBase: string;
  cleanOutput: boolean;
  requiredColumns: string[];
  zeroProductionRule: string;
  warnings: string[];
  geojson: BuildOperatorGeojsonSummary;
  imports: {
    totalManifestOperators: number;
    totalProvisionedOperators: number;
    operatorsWithSnapshotRows: number;
    provisionedOperatorsWithSnapshotRows: number;
    operatorsWithNewSnapshotWells: number;
    totalNewSnapshotWells: number;
    totalInsertedWells: number;
    totalUpdatedWells: number;
    totalCrossOperatorSnapshotWells: number;
    totalZeroedMissingWells: number;
    totalDuplicateSnapshotRowsCollapsed: number;
    totalSkippedUnprovisionedWithSnapshotRows: number;
    rolloutWarnings: OperatorRolloutWarning[];
    failures: OperatorSyncFailure[];
    operators: AppliedOperatorImport[];
  };
  unmatchedSnapshotOperators: Array<{
    sourceOperatorName: string;
    operatorSlug: string;
    matchedRows: number;
  }>;
}

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const DEFAULT_REPORT_PATH = path.resolve(
  __dirname,
  '..',
  'output',
  'monthly-production-sync',
  'latest.json',
);

const REQUIRED_COLUMNS = [
  'uwi',
  'operator_licensee',
  'producing_formation',
  'well_fluid_type',
  'surface_latitude',
  'surface_longitude',
  'recent_oil',
  'recent_gas',
] as const;

function normalize(value: unknown): string {
  return String(value ?? '').trim();
}

function diag(message: string): void {
  process.stderr.write(`${message}\n`);
}

function formatError(error: unknown): string {
  if (error instanceof Error) {
    return error.message;
  }

  try {
    return JSON.stringify(error);
  } catch {
    return String(error);
  }
}

function printHelp(): void {
  process.stdout.write(
    [
      'Usage: tsx scripts/sync_monthly_production.ts [options]',
      '',
      'Standard monthly Clearwater / Bluesky sync workflow:',
      '  1. validate the snapshot',
      '  2. collapse duplicate UWIs inside the snapshot',
      '  3. rebuild per-operator production GeoJSON',
      '  4. insert new Supabase wells for provisioned operators',
      '  5. update production fields on existing Supabase wells by operator',
      '  6. zero current-month production rate for provisioned wells missing from the snapshot',
      '  7. stamp wells with the snapshot month and present/missing status',
      '  8. report duplicate rows, inserted wells, and missing wells that were zeroed',
      '',
      'Options:',
      `  --input <path>     Snapshot CSV/XLSX (default: ${DEFAULT_SOURCE_PATH})`,
      `  --manifest <path>  Operator rollout manifest (default: ${DEFAULT_MANIFEST_PATH})`,
      `  --report <path>    JSON report output (default: ${DEFAULT_REPORT_PATH})`,
      '  --no-clean         Keep existing operator output directories instead of rebuilding cleanly',
      '  --dry-run          Build the report without writing to Supabase',
      '  --help             Show this message',
      '',
    ].join('\n'),
  );
}

function parseArgs(argv: string[]): CliOptions {
  let inputPath = normalize(process.env.npm_config_input) || DEFAULT_SOURCE_PATH;
  let manifestPath = normalize(process.env.npm_config_manifest) || DEFAULT_MANIFEST_PATH;
  let reportPath = normalize(process.env.npm_config_report) || DEFAULT_REPORT_PATH;
  let cleanOutput = normalize(process.env.npm_config_no_clean).toLowerCase() !== 'true';
  let dryRun = normalize(process.env.npm_config_dry_run).toLowerCase() === 'true';

  for (let index = 0; index < argv.length; index += 1) {
    const arg = argv[index];

    if (arg === '--help') {
      printHelp();
      process.exit(0);
    }

    if (arg === '--input') {
      inputPath = path.resolve(argv[index + 1] ?? '');
      index += 1;
      continue;
    }

    if (arg === '--manifest') {
      manifestPath = path.resolve(argv[index + 1] ?? '');
      index += 1;
      continue;
    }

    if (arg === '--report') {
      reportPath = path.resolve(argv[index + 1] ?? '');
      index += 1;
      continue;
    }

    if (arg === '--no-clean') {
      cleanOutput = false;
      continue;
    }

    if (arg === '--dry-run') {
      dryRun = true;
      continue;
    }

    if (!arg.startsWith('-')) {
      inputPath = path.resolve(arg);
      continue;
    }

    throw new Error(`Unknown argument: ${arg}`);
  }

  return {
    inputPath,
    manifestPath,
    reportPath,
    cleanOutput,
    dryRun,
  };
}

function readHeaderRow(inputPath: string): string[] {
  const workbook = XLSX.readFile(inputPath, { raw: false });
  const firstSheetName = workbook.SheetNames[0];
  const sheet = workbook.Sheets[firstSheetName];
  const rows = XLSX.utils.sheet_to_json<(string | number | null)[]>(sheet, {
    header: 1,
    raw: false,
    blankrows: false,
  });

  const header = rows[0] ?? [];
  return header.map((value) => normalize(value));
}

function validateColumns(inputPath: string): void {
  const header = readHeaderRow(inputPath);
  const missing = REQUIRED_COLUMNS.filter((column) => !header.includes(column));

  if (missing.length > 0) {
    throw new Error(`Monthly snapshot is missing required columns: ${missing.join(', ')}`);
  }
}

function writeReport(reportPath: string, report: MonthlySyncReport): void {
  fs.mkdirSync(path.dirname(reportPath), { recursive: true });
  fs.writeFileSync(reportPath, `${JSON.stringify(report, null, 2)}\n`, 'utf8');
}

function getSupabaseAdminClient(): SupabaseClient | null {
  const supabaseUrl = process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !serviceRoleKey) {
    return null;
  }

  return createClient(supabaseUrl, serviceRoleKey, {
    auth: { persistSession: false },
  });
}

async function recordSyncRun(report: MonthlySyncReport): Promise<void> {
  if (report.dryRun) {
    return;
  }

  const supabase = getSupabaseAdminClient();
  if (!supabase) {
    return;
  }

  const { error } = await supabase
    .from('monthly_production_sync_runs')
    .insert({
      snapshot_month: report.snapshotMonth,
      input_path: report.inputPath,
      report_path: report.reportPath,
      source_row_count: report.geojson.sourceRows,
      unique_snapshot_rows: report.geojson.uniqueSnapshotRows,
      duplicate_rows_collapsed: report.geojson.duplicateRowsCollapsed,
      zero_production_rows: report.geojson.skippedZeroProd,
      overlay_feature_count: report.geojson.totalFeatures,
      total_manifest_operators: report.imports.totalManifestOperators,
      total_provisioned_operators: report.imports.totalProvisionedOperators,
      total_updated_wells: report.imports.totalUpdatedWells,
      total_zeroed_missing_wells: report.imports.totalZeroedMissingWells,
      total_new_snapshot_wells: report.imports.totalNewSnapshotWells,
      total_cross_operator_snapshot_wells: report.imports.totalCrossOperatorSnapshotWells,
      total_skipped_unprovisioned_operators: report.imports.totalSkippedUnprovisionedWithSnapshotRows,
      generated_at: report.generatedAt,
    });

  if (error) {
    throw error;
  }
}

function buildWarnings(
  dryRun: boolean,
  inputPath: string,
  unmatchedSnapshotOperators: MonthlySyncReport['unmatchedSnapshotOperators'],
  dbDiffAvailable: boolean,
  skippedUnprovisionedWithSnapshotRows: number,
  provisionedOperators: number,
): string[] {
  const warnings = [
    `Missing wells in ${path.basename(inputPath)} are not deleted from Supabase by this workflow.`,
    'Zero-production rows are excluded from production overlay GeoJSON, so missing or zero-production wells lose the cloud but keep the base dot if they already exist in Supabase.',
    'Monthly sync inserts new wells for provisioned operators, updates production fields on existing wells, and zeroes provisioned wells missing from the current snapshot. It does not reassign cross-operator wells.',
    'If a provisioned well is missing from the latest snapshot, the sync marks it missing for that snapshot month and forces its current-month production rate to 0 while keeping the base well record.',
    'Overlay access still uses public per-operator GeoJSON files. True tenant enforcement continues to rely on Supabase row-level security for base well data.',
    `Current monthly sync scope is the provisioned operator rollout boundary in Supabase (${provisionedOperators} operator tenants).`,
  ];

  if (dryRun) {
    warnings.push('Dry run enabled: overlay files were rebuilt, but Supabase writes were skipped.');
  }

  if (dryRun && !dbDiffAvailable) {
    warnings.push('Dry run ran without Supabase credentials, so new/missing well diff counts are not available in this report.');
  }

  if (unmatchedSnapshotOperators.length > 0) {
    warnings.push(
      `Found ${unmatchedSnapshotOperators.length} operator slug(s) in the snapshot that are not present in the rollout manifest.`,
    );
  }

  if (skippedUnprovisionedWithSnapshotRows > 0) {
    warnings.push(
      `${skippedUnprovisionedWithSnapshotRows} operator(s) had snapshot rows but were skipped because they are not provisioned in Supabase yet.`,
    );
  }

  return warnings;
}

async function main(): Promise<void> {
  const options = parseArgs(process.argv.slice(2));

  assertFileExists(options.inputPath, 'Input file');
  assertFileExists(options.manifestPath, 'Manifest file');

  diag(`Validating required columns in ${options.inputPath}...`);
  validateColumns(options.inputPath);
  diag('Required columns present.');

  const sourceRows = loadSourceRows(options.inputPath);
  const manifestRows = loadManifestRows(options.manifestPath);
  const unmatchedSnapshotOperators = findUnmappedSnapshotOperators(sourceRows, manifestRows);
  const snapshotMonth = deriveSnapshotMonth(sourceRows);

  if (!snapshotMonth) {
    throw new Error('Could not derive snapshot month from last_production_date in the monthly snapshot.');
  }

  const geojsonSummary = buildOperatorGeojson({
    inputPath: options.inputPath,
    cleanOutput: options.cleanOutput,
    logger: diag,
  });

  const operatorSlugs = [...new Set(
    manifestRows
      .map((row) => normalize(row.operator_slug))
      .filter(Boolean),
  )].sort();

  const operatorResults: AppliedOperatorImport[] = [];
  const rolloutWarnings: OperatorRolloutWarning[] = [];
  const failures: OperatorSyncFailure[] = [];

  diag('');
  diag('Syncing operators into Supabase...');

  for (const operatorSlug of operatorSlugs) {
    try {
      const prepared = prepareOperatorImport({
        operatorSlug,
        sourceRows,
        manifestRows,
        sourcePath: options.inputPath,
        manifestPath: options.manifestPath,
        allowEmptySnapshot: true,
      });

      const result = await applyOperatorImport(prepared, {
        dryRun: options.dryRun,
        allowUnprovisionedSkip: true,
        logger: diag,
        snapshotMonth,
        insertNewSnapshotWells: true,
      });

      operatorResults.push(result);

      if (result.status === 'skipped-unprovisioned' && prepared.matchedSourceRows > 0) {
        rolloutWarnings.push({
          operatorSlug,
          reason: 'Snapshot rows exist for this operator, but the operator is not provisioned in Supabase.',
        });
      }
    } catch (error: unknown) {
      failures.push({
        operatorSlug,
        reason: formatError(error),
      });
    }
  }

  const dbDiffAvailable = operatorResults.some((result) => result.dbDiffAvailable);
  const totalProvisionedOperators = operatorResults.filter((result) => result.operatorId !== null).length;
  const totalSkippedUnprovisionedWithSnapshotRows = operatorResults.filter(
    (result) => result.status === 'skipped-unprovisioned' && result.matchedSourceRows > 0,
  ).length;
  const provisionedOperatorsWithSnapshotRows = operatorResults.filter(
    (result) => result.operatorId !== null && result.matchedSourceRows > 0,
  ).length;

  const report: MonthlySyncReport = {
    generatedAt: new Date().toISOString(),
    workflow: 'monthly-production-sync',
    mode: 'overlay-plus-production-state-sync',
    dryRun: options.dryRun,
    snapshotMonth,
    inputPath: options.inputPath,
    manifestPath: options.manifestPath,
    reportPath: options.reportPath,
    outputBase: OUTPUT_BASE,
    cleanOutput: options.cleanOutput,
    requiredColumns: [...REQUIRED_COLUMNS],
    zeroProductionRule:
      'Rows with both recent_oil = 0 and recent_gas = 0 are excluded from production overlay GeoJSON.',
    warnings: buildWarnings(
      options.dryRun,
      options.inputPath,
      unmatchedSnapshotOperators,
      dbDiffAvailable,
      totalSkippedUnprovisionedWithSnapshotRows,
      totalProvisionedOperators,
    ),
    geojson: geojsonSummary,
    imports: {
      totalManifestOperators: operatorSlugs.length,
      totalProvisionedOperators,
      operatorsWithSnapshotRows: operatorResults.filter((result) => result.matchedSourceRows > 0).length,
      provisionedOperatorsWithSnapshotRows,
      operatorsWithNewSnapshotWells: operatorResults.filter((result) => result.newSnapshotWellIds.length > 0).length,
      totalNewSnapshotWells: operatorResults.reduce((sum, result) => sum + result.newSnapshotWellIds.length, 0),
      totalInsertedWells: operatorResults.reduce((sum, result) => sum + result.insertedWellIds.length, 0),
      totalUpdatedWells: operatorResults.reduce((sum, result) => sum + result.updatedWellIds.length, 0),
      totalCrossOperatorSnapshotWells: operatorResults.reduce(
        (sum, result) => sum + result.crossOperatorSnapshotWellIds.length,
        0,
      ),
      totalZeroedMissingWells: operatorResults.reduce(
        (sum, result) => sum + result.missingFromSnapshotWellIds.length,
        0,
      ),
      totalDuplicateSnapshotRowsCollapsed: operatorResults.reduce(
        (sum, result) => sum + result.duplicateSnapshotRowsCollapsed,
        0,
      ),
      totalSkippedUnprovisionedWithSnapshotRows,
      rolloutWarnings,
      failures,
      operators: operatorResults,
    },
    unmatchedSnapshotOperators,
  };

  writeReport(options.reportPath, report);
  await recordSyncRun(report);

  diag('');
  diag(`Wrote sync report to ${options.reportPath}`);
  diag(
    [
      `Snapshot month: ${snapshotMonth}`,
      `Provisioned operators: ${totalProvisionedOperators}`,
      `New snapshot wells: ${report.imports.totalNewSnapshotWells}`,
      `Inserted wells: ${report.imports.totalInsertedWells}`,
      `Updated wells: ${report.imports.totalUpdatedWells}`,
      `Duplicate rows collapsed: ${report.imports.totalDuplicateSnapshotRowsCollapsed}`,
      `Zeroed missing wells: ${report.imports.totalZeroedMissingWells}`,
      `Skipped not onboarded: ${totalSkippedUnprovisionedWithSnapshotRows}`,
      `Failures: ${failures.length}`,
    ].join(' | '),
  );

  if (failures.length > 0) {
    throw new Error(`Monthly production sync completed with ${failures.length} operator failure(s). See report.`);
  }
}

main().catch((error: unknown) => {
  process.stderr.write(`${error instanceof Error ? error.message : String(error)}\n`);
  process.exit(1);
});
