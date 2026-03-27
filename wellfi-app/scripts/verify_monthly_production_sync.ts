import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

import { createClient, type SupabaseClient } from '@supabase/supabase-js';

import {
  DEFAULT_MANIFEST_PATH,
  DEFAULT_SOURCE_PATH,
  assertFileExists,
  loadManifestRows,
  loadSourceRows,
  prepareOperatorImport,
  type BasinImportRow,
} from './lib/operator_basin_sync.js';
import { deriveSnapshotMonth } from './lib/monthly_snapshot.js';

interface CliOptions {
  inputPath: string;
  manifestPath: string;
  reportPath: string;
}

interface DbWellRow {
  well_id: string | null;
  operator_id: string | null;
  formation: string | null;
  dec_rate_bbl_d: number | string | null;
  cumulative_oil: number | string | null;
  last_production_date: string | null;
  latest_production_snapshot_month: string | null;
  latest_production_snapshot_status: string | null;
}

interface OperatorVerificationResult {
  operatorSlug: string;
  snapshotRows: number;
  importRows: number;
  dbRows: number;
  missingFromDbCount: number;
  mismatchedPresentRows: number;
  mismatchedMissingRows: number;
  missingFromSnapshotCount: number;
  sampleIssues: Array<{
    well_id: string;
    issue: string;
    db?: unknown;
    expected?: unknown;
  }>;
}

interface VerificationReport {
  generatedAt: string;
  workflow: 'monthly-production-verify';
  snapshotMonth: string;
  inputPath: string;
  manifestPath: string;
  reportPath: string;
  totals: {
    dbWells: number;
    exactDuplicateWellIds: number;
    logicalDuplicateWellIds: number;
    operatorsChecked: number;
    snapshotRowsMissingFromDb: number;
    mismatchedPresentRows: number;
    mismatchedMissingRows: number;
    missingFromSnapshotRows: number;
  };
  sampleLogicalDuplicates: Array<{
    normalizedWellId: string;
    wellIds: string[];
  }>;
  operators: OperatorVerificationResult[];
}

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const DEFAULT_REPORT_PATH = path.resolve(
  __dirname,
  '..',
  'output',
  'monthly-production-sync',
  'verification-latest.json',
);

function normalize(value: unknown): string {
  return String(value ?? '').trim();
}

function normalizeWellId(value: unknown): string {
  return normalize(value).toUpperCase().replace(/[^A-Z0-9]/g, '');
}

function parseNumber(value: unknown): number | null {
  if (value == null || value === '') {
    return null;
  }
  const parsed = Number(value);
  return Number.isFinite(parsed) ? parsed : null;
}

function dateKey(value: unknown): string | null {
  const text = normalize(value);
  if (!text) {
    return null;
  }

  const parsed = new Date(text);
  if (Number.isNaN(parsed.getTime())) {
    return null;
  }

  return parsed.toISOString().slice(0, 10);
}

function diag(message: string): void {
  process.stderr.write(`${message}\n`);
}

function printHelp(): void {
  process.stdout.write(
    [
      'Usage: tsx scripts/verify_monthly_production_sync.ts [options]',
      '',
      'Verify that monthly production sync state in Supabase matches the latest snapshot.',
      '',
      'Options:',
      `  --input <path>     Snapshot CSV/XLSX (default: ${DEFAULT_SOURCE_PATH})`,
      `  --manifest <path>  Operator rollout manifest (default: ${DEFAULT_MANIFEST_PATH})`,
      `  --report <path>    JSON report output (default: ${DEFAULT_REPORT_PATH})`,
      '  --help             Show this message',
      '',
    ].join('\n'),
  );
}

function parseArgs(argv: string[]): CliOptions {
  let inputPath = normalize(process.env.npm_config_input) || DEFAULT_SOURCE_PATH;
  let manifestPath = normalize(process.env.npm_config_manifest) || DEFAULT_MANIFEST_PATH;
  let reportPath = normalize(process.env.npm_config_report) || DEFAULT_REPORT_PATH;

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
  };
}

function getSupabaseAdminClient(): SupabaseClient {
  const supabaseUrl = process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !serviceRoleKey) {
    throw new Error('Set SUPABASE_URL (or VITE_SUPABASE_URL) and SUPABASE_SERVICE_ROLE_KEY');
  }

  return createClient(supabaseUrl, serviceRoleKey, {
    auth: { persistSession: false },
  });
}

async function fetchAllWells(supabase: SupabaseClient): Promise<DbWellRow[]> {
  const rows: DbWellRow[] = [];
  const pageSize = 1000;

  for (let from = 0; ; from += pageSize) {
    const { data, error } = await supabase
      .from('wells')
      .select([
        'well_id',
        'operator_id',
        'formation',
        'dec_rate_bbl_d',
        'cumulative_oil',
        'last_production_date',
        'latest_production_snapshot_month',
        'latest_production_snapshot_status',
      ].join(', '))
      .range(from, from + pageSize - 1);

    if (error) {
      throw error;
    }

    const batch = (data as DbWellRow[] | null) ?? [];
    rows.push(...batch);

    if (batch.length < pageSize) {
      break;
    }
  }

  return rows;
}

async function fetchProvisionedOperators(
  supabase: SupabaseClient,
): Promise<Map<string, { id: string; slug: string }>> {
  const { data, error } = await supabase
    .from('operators')
    .select('id, slug');

  if (error) {
    throw error;
  }

  return new Map(
    ((data as Array<{ id: string; slug: string }> | null) ?? []).map((row) => [row.slug, row]),
  );
}

function comparePresentRow(
  dbRow: DbWellRow,
  importRow: BasinImportRow,
  snapshotMonth: string,
): Array<{ issue: string; db?: unknown; expected?: unknown }> {
  const issues: Array<{ issue: string; db?: unknown; expected?: unknown }> = [];

  if (parseNumber(dbRow.dec_rate_bbl_d) !== importRow.dec_rate_bbl_d) {
    issues.push({
      issue: 'dec_rate_bbl_d mismatch',
      db: parseNumber(dbRow.dec_rate_bbl_d),
      expected: importRow.dec_rate_bbl_d,
    });
  }

  if (parseNumber(dbRow.cumulative_oil) !== importRow.cumulative_oil) {
    issues.push({
      issue: 'cumulative_oil mismatch',
      db: parseNumber(dbRow.cumulative_oil),
      expected: importRow.cumulative_oil,
    });
  }

  if (dateKey(dbRow.last_production_date) !== importRow.last_production_date) {
    issues.push({
      issue: 'last_production_date mismatch',
      db: dateKey(dbRow.last_production_date),
      expected: importRow.last_production_date,
    });
  }

  if ((dbRow.formation ?? null) !== importRow.formation) {
    issues.push({
      issue: 'formation mismatch',
      db: dbRow.formation ?? null,
      expected: importRow.formation,
    });
  }

  if (dateKey(dbRow.latest_production_snapshot_month) !== snapshotMonth) {
    issues.push({
      issue: 'latest_production_snapshot_month mismatch',
      db: dateKey(dbRow.latest_production_snapshot_month),
      expected: snapshotMonth,
    });
  }

  if (normalize(dbRow.latest_production_snapshot_status) !== 'present') {
    issues.push({
      issue: 'latest_production_snapshot_status mismatch',
      db: normalize(dbRow.latest_production_snapshot_status) || null,
      expected: 'present',
    });
  }

  return issues;
}

function compareMissingRow(
  dbRow: DbWellRow,
  snapshotMonth: string,
): Array<{ issue: string; db?: unknown; expected?: unknown }> {
  const issues: Array<{ issue: string; db?: unknown; expected?: unknown }> = [];

  if (parseNumber(dbRow.dec_rate_bbl_d) !== 0) {
    issues.push({
      issue: 'missing well dec_rate_bbl_d not zeroed',
      db: parseNumber(dbRow.dec_rate_bbl_d),
      expected: 0,
    });
  }

  if (dateKey(dbRow.latest_production_snapshot_month) !== snapshotMonth) {
    issues.push({
      issue: 'missing well latest_production_snapshot_month mismatch',
      db: dateKey(dbRow.latest_production_snapshot_month),
      expected: snapshotMonth,
    });
  }

  if (normalize(dbRow.latest_production_snapshot_status) !== 'missing') {
    issues.push({
      issue: 'missing well latest_production_snapshot_status mismatch',
      db: normalize(dbRow.latest_production_snapshot_status) || null,
      expected: 'missing',
    });
  }

  return issues;
}

function writeReport(reportPath: string, report: VerificationReport): void {
  fs.mkdirSync(path.dirname(reportPath), { recursive: true });
  fs.writeFileSync(reportPath, `${JSON.stringify(report, null, 2)}\n`, 'utf8');
}

async function main(): Promise<void> {
  const options = parseArgs(process.argv.slice(2));

  assertFileExists(options.inputPath, 'Input file');
  assertFileExists(options.manifestPath, 'Manifest file');

  const sourceRows = loadSourceRows(options.inputPath);
  const manifestRows = loadManifestRows(options.manifestPath);
  const snapshotMonth = deriveSnapshotMonth(sourceRows);

  if (!snapshotMonth) {
    throw new Error('Could not derive snapshot month from last_production_date in the monthly snapshot.');
  }

  const supabase = getSupabaseAdminClient();
  const [allWells, provisionedOperators] = await Promise.all([
    fetchAllWells(supabase),
    fetchProvisionedOperators(supabase),
  ]);

  const exactCounts = new Map<string, number>();
  const logicalCounts = new Map<string, string[]>();
  const wellsByOperatorId = new Map<string, DbWellRow[]>();

  for (const row of allWells) {
    const wellId = normalize(row.well_id);
    if (wellId) {
      exactCounts.set(wellId, (exactCounts.get(wellId) ?? 0) + 1);
    }

    const normalizedWellId = normalizeWellId(row.well_id);
    if (normalizedWellId) {
      const bucket = logicalCounts.get(normalizedWellId) ?? [];
      bucket.push(wellId);
      logicalCounts.set(normalizedWellId, bucket);
    }

    const operatorId = normalize(row.operator_id);
    if (operatorId) {
      const bucket = wellsByOperatorId.get(operatorId) ?? [];
      bucket.push(row);
      wellsByOperatorId.set(operatorId, bucket);
    }
  }

  const operatorSlugs = [...new Set(
    manifestRows
      .map((row) => normalize(row.operator_slug))
      .filter(Boolean),
  )].sort();

  const operatorResults: OperatorVerificationResult[] = [];

  for (const operatorSlug of operatorSlugs) {
    const prepared = prepareOperatorImport({
      operatorSlug,
      sourceRows,
      manifestRows,
      sourcePath: options.inputPath,
      manifestPath: options.manifestPath,
      allowEmptySnapshot: true,
    });

    const operator = provisionedOperators.get(operatorSlug);
    if (!operator) {
      continue;
    }

    const dbRows = wellsByOperatorId.get(operator.id) ?? [];
    const dbByWellId = new Map(
      dbRows
        .map((row) => [normalize(row.well_id), row] as const)
        .filter(([wellId]) => Boolean(wellId)),
    );
    const snapshotWellIdSet = new Set(prepared.importRows.map((row) => row.well_id));

    const result: OperatorVerificationResult = {
      operatorSlug,
      snapshotRows: prepared.matchedSourceRows,
      importRows: prepared.importRows.length,
      dbRows: dbRows.length,
      missingFromDbCount: 0,
      mismatchedPresentRows: 0,
      mismatchedMissingRows: 0,
      missingFromSnapshotCount: 0,
      sampleIssues: [],
    };

    for (const row of prepared.importRows) {
      const dbRow = dbByWellId.get(row.well_id);
      if (!dbRow) {
        result.missingFromDbCount += 1;
        if (result.sampleIssues.length < 10) {
          result.sampleIssues.push({
            well_id: row.well_id,
            issue: 'snapshot row missing from db',
          });
        }
        continue;
      }

      const issues = comparePresentRow(dbRow, row, snapshotMonth);
      if (issues.length > 0) {
        result.mismatchedPresentRows += 1;
        for (const issue of issues) {
          if (result.sampleIssues.length >= 10) {
            break;
          }
          result.sampleIssues.push({
            well_id: row.well_id,
            issue: issue.issue,
            db: issue.db,
            expected: issue.expected,
          });
        }
      }
    }

    for (const dbRow of dbRows) {
      const wellId = normalize(dbRow.well_id);
      if (!wellId || snapshotWellIdSet.has(wellId)) {
        continue;
      }

      result.missingFromSnapshotCount += 1;
      const issues = compareMissingRow(dbRow, snapshotMonth);
      if (issues.length > 0) {
        result.mismatchedMissingRows += 1;
        for (const issue of issues) {
          if (result.sampleIssues.length >= 10) {
            break;
          }
          result.sampleIssues.push({
            well_id: wellId,
            issue: issue.issue,
            db: issue.db,
            expected: issue.expected,
          });
        }
      }
    }

    operatorResults.push(result);
  }

  const exactDuplicateWellIds = [...exactCounts.values()].filter((count) => count > 1).length;
  const logicalDuplicateEntries = [...logicalCounts.entries()].filter(([, wellIds]) => wellIds.length > 1);

  const report: VerificationReport = {
    generatedAt: new Date().toISOString(),
    workflow: 'monthly-production-verify',
    snapshotMonth,
    inputPath: options.inputPath,
    manifestPath: options.manifestPath,
    reportPath: options.reportPath,
    totals: {
      dbWells: allWells.length,
      exactDuplicateWellIds,
      logicalDuplicateWellIds: logicalDuplicateEntries.length,
      operatorsChecked: operatorResults.length,
      snapshotRowsMissingFromDb: operatorResults.reduce((sum, result) => sum + result.missingFromDbCount, 0),
      mismatchedPresentRows: operatorResults.reduce((sum, result) => sum + result.mismatchedPresentRows, 0),
      mismatchedMissingRows: operatorResults.reduce((sum, result) => sum + result.mismatchedMissingRows, 0),
      missingFromSnapshotRows: operatorResults.reduce((sum, result) => sum + result.missingFromSnapshotCount, 0),
    },
    sampleLogicalDuplicates: logicalDuplicateEntries.slice(0, 10).map(([normalizedWellId, wellIds]) => ({
      normalizedWellId,
      wellIds,
    })),
    operators: operatorResults,
  };

  writeReport(options.reportPath, report);

  diag(`Wrote verification report to ${options.reportPath}`);
  diag(
    [
      `Snapshot month: ${report.snapshotMonth}`,
      `DB wells: ${report.totals.dbWells}`,
      `Exact duplicates: ${report.totals.exactDuplicateWellIds}`,
      `Logical duplicates: ${report.totals.logicalDuplicateWellIds}`,
      `Missing from DB: ${report.totals.snapshotRowsMissingFromDb}`,
      `Present mismatches: ${report.totals.mismatchedPresentRows}`,
      `Missing mismatches: ${report.totals.mismatchedMissingRows}`,
      `Missing from snapshot rows: ${report.totals.missingFromSnapshotRows}`,
    ].join(' | '),
  );

  if (
    report.totals.exactDuplicateWellIds > 0 ||
    report.totals.logicalDuplicateWellIds > 0 ||
    report.totals.snapshotRowsMissingFromDb > 0 ||
    report.totals.mismatchedPresentRows > 0 ||
    report.totals.mismatchedMissingRows > 0
  ) {
    throw new Error('Monthly production verification failed. See report for details.');
  }
}

main().catch((error: unknown) => {
  process.stderr.write(`${error instanceof Error ? error.message : String(error)}\n`);
  process.exit(1);
});
