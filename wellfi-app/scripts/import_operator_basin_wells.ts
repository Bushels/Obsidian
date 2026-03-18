import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import XLSX from 'xlsx';
import { createClient } from '@supabase/supabase-js';

interface SourceRow {
  uwi?: string;
  operator_licensee?: string;
  producing_formation?: string;
  field_name?: string;
  well_status?: string;
  well_fluid_type?: string;
  surface_latitude?: string;
  surface_longitude?: string;
  last_oil_production_rate?: string;
  cumulative_oil_production?: string;
  recent_oil?: string;
  recent_gas?: string;
  recent_water?: string;
  recent_steam_injection?: string;
  last_production_date?: string;
  spud_date?: string;
}

interface RolloutRow {
  operator_slug?: string;
  source_operator_name?: string;
}

interface CliOptions {
  operatorSlug: string;
  sourcePath: string;
  manifestPath: string;
  dryRun: boolean;
}

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const DEFAULT_SOURCE_PATH = path.resolve(__dirname, '..', '..', 'Data', 'active_clearwater_bluesky_recent_prod_ab_sk.csv');
const DEFAULT_MANIFEST_PATH = path.resolve(__dirname, '..', '..', 'Data', 'operator_rollout_manifest_clearwater_bluesky.csv');

function printHelp() {
  process.stdout.write(
    [
      'Usage: tsx scripts/import_operator_basin_wells.ts --operator <slug> [options]',
      '',
      'Upsert one operator from the Clearwater / Bluesky basin snapshot into Supabase.',
      '',
      'Options:',
      '  --operator <slug>    Operator slug from the rollout manifest',
      '  --source <path>      Basin CSV/XLSX snapshot',
      '  --manifest <path>    Rollout manifest CSV',
      '  --dry-run            Build the import packet without writing to Supabase',
      '  --help               Show this message',
      '',
    ].join('\n'),
  );
}

function parseArgs(argv: string[]): CliOptions {
  let operatorSlug = normalize(process.env.npm_config_operator);
  if (operatorSlug === 'true') {
    operatorSlug = '';
  }
  let sourcePath = normalize(process.env.npm_config_source) || DEFAULT_SOURCE_PATH;
  let manifestPath = normalize(process.env.npm_config_manifest) || DEFAULT_MANIFEST_PATH;
  let dryRun = normalize(process.env.npm_config_dry_run).toLowerCase() === 'true';

  for (let index = 0; index < argv.length; index += 1) {
    const arg = argv[index];
    if (arg === '--help') {
      printHelp();
      process.exit(0);
    }

    if (arg === '--operator') {
      operatorSlug = String(argv[index + 1] ?? '');
      index += 1;
      continue;
    }

    if (arg === '--source') {
      sourcePath = path.resolve(argv[index + 1] ?? '');
      index += 1;
      continue;
    }

    if (arg === '--manifest') {
      manifestPath = path.resolve(argv[index + 1] ?? '');
      index += 1;
      continue;
    }

    if (arg === '--dry-run') {
      dryRun = true;
      continue;
    }

    if (!arg.startsWith('-')) {
      operatorSlug = operatorSlug || normalize(arg);
      continue;
    }

    throw new Error(`Unknown argument: ${arg}`);
  }

  if (!operatorSlug) {
    throw new Error('Missing required argument: --operator <slug>');
  }

  return {
    operatorSlug: normalize(operatorSlug),
    sourcePath,
    manifestPath,
    dryRun,
  };
}

function diag(message: string): void {
  process.stderr.write(`${message}\n`);
}

function normalize(value: unknown): string {
  return String(value ?? '').trim();
}

function slugifyOperator(operator: string): string {
  return operator
    .toLowerCase()
    .replace(/&/g, ' and ')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
    .replace(/-{2,}/g, '-')
    .slice(0, 40);
}

function parseRows<T>(filePath: string): T[] {
  const workbook = XLSX.readFile(filePath, { raw: false });
  const firstSheetName = workbook.SheetNames[0];
  const sheet = workbook.Sheets[firstSheetName];
  return XLSX.utils.sheet_to_json<T>(sheet, {
    defval: '',
    raw: false,
  });
}

function isActive(row: SourceRow): boolean {
  const wellStatus = normalize(row.well_status).toLowerCase();
  return ['active', 'pumping', 'flowing', 'producing', 'operating'].includes(wellStatus);
}

function parseNumber(value: unknown): number | null {
  const text = normalize(value);
  if (!text) return null;
  const numberValue = Number(text);
  return Number.isFinite(numberValue) ? numberValue : null;
}

function parseDate(value: unknown): string | null {
  const text = normalize(value);
  if (!text) return null;

  const parsed = new Date(text);
  if (Number.isNaN(parsed.getTime())) {
    return null;
  }

  return parsed.toISOString().slice(0, 10);
}

function deriveFormation(row: SourceRow): 'Bluesky' | 'Clearwater' | null {
  const text = normalize(row.producing_formation).toLowerCase();
  if (text.includes('clearwater')) return 'Clearwater';
  if (text.includes('bluesky')) return 'Bluesky';
  return null;
}

function mapWellStatus(value: unknown): 'Pumping' | 'Operating' | 'Suspended' | 'Abandoned' {
  const text = normalize(value).toLowerCase();
  if (text.includes('abandon')) return 'Abandoned';
  if (text.includes('suspend') || text.includes('shut')) return 'Suspended';
  if (text.includes('pumping')) return 'Pumping';
  return 'Operating';
}

async function main() {
  const options = parseArgs(process.argv.slice(2));

  if (!fs.existsSync(options.sourcePath)) {
    throw new Error(`Source file not found: ${options.sourcePath}`);
  }

  if (!fs.existsSync(options.manifestPath)) {
    throw new Error(`Manifest file not found: ${options.manifestPath}`);
  }

  if (options.operatorSlug === 'obsidian-energy-ltd') {
    throw new Error('Obsidian should stay on the richer existing import path. Use scripts/process_well_data.ts instead.');
  }

  const manifestRows = parseRows<RolloutRow>(options.manifestPath);
  const rolloutRow = manifestRows.find(
    (row) => normalize(row.operator_slug) === options.operatorSlug,
  );

  if (!rolloutRow) {
    throw new Error(`Operator ${options.operatorSlug} was not found in ${options.manifestPath}`);
  }

  const sourceOperatorName = normalize(rolloutRow.source_operator_name);
  if (!sourceOperatorName) {
    throw new Error(`Manifest row for ${options.operatorSlug} is missing source_operator_name`);
  }

  const sourceRows = parseRows<SourceRow>(options.sourcePath);
  const matchedSourceRows = sourceRows.filter((row) => {
    const operatorName = normalize(row.operator_licensee);
    return operatorName === sourceOperatorName || slugifyOperator(operatorName) === options.operatorSlug;
  });
  const activeRows = matchedSourceRows.filter(isActive);

  if (matchedSourceRows.length === 0) {
    throw new Error(`No source rows matched ${sourceOperatorName} in ${options.sourcePath}`);
  }

  if (activeRows.length === 0) {
    throw new Error(`No active source rows matched ${sourceOperatorName} in ${options.sourcePath}`);
  }

  const skippedRows: string[] = [];
  const importRows = activeRows.flatMap((row) => {
    const wellId = normalize(row.uwi);
    const lat = parseNumber(row.surface_latitude);
    const lon = parseNumber(row.surface_longitude);

    if (!wellId) {
      skippedRows.push('Skipped row with missing uwi');
      return [];
    }

    if (lat == null || lon == null) {
      skippedRows.push(`Skipped ${wellId} because latitude/longitude is missing`);
      return [];
    }

    return [
      {
        well_id: wellId,
        formatted_id: null,
        name: null,
        lat,
        lon,
        formation: deriveFormation(row),
        field: normalize(row.field_name) || null,
        well_status: mapWellStatus(row.well_status),
        risk_level: 'NO DATA',
        months_running: null,
        dec_rate_bbl_d: parseNumber(row.last_oil_production_rate),
        total_2025_bbl: null,
        cumulative_oil: parseNumber(row.cumulative_oil_production),
        on_production_date: parseDate(row.spud_date),
        last_production_date: parseDate(row.last_production_date),
        annual_uptime_pct: null,
        total_downtime_days: null,
        monthly_hrs: null,
        monthly_oil: null,
        monthly_uptime: null,
        status_note: 'Imported from Clearwater / Bluesky basin snapshot (Jan 2026).',
      },
    ];
  });

  let operatorId: string | null = null;
  let upsertedCount = 0;

  if (!options.dryRun) {
    const supabaseUrl = process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL;
    const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

    if (!supabaseUrl || !serviceRoleKey) {
      throw new Error('Set SUPABASE_URL (or VITE_SUPABASE_URL) and SUPABASE_SERVICE_ROLE_KEY');
    }

    const supabase = createClient(supabaseUrl, serviceRoleKey, {
      auth: { persistSession: false },
    });

    const { data: operatorData, error: operatorError } = await supabase
      .from('operators')
      .select('id')
      .eq('slug', options.operatorSlug)
      .single();

    if (operatorError || !operatorData) {
      throw new Error(`Operator ${options.operatorSlug} is not provisioned in Supabase yet`);
    }

    operatorId = operatorData.id;

    const batchSize = 200;
    for (let index = 0; index < importRows.length; index += batchSize) {
      const batch = importRows
        .slice(index, index + batchSize)
        .map((row) => ({ ...row, operator_id: operatorId }));

      const { error } = await supabase
        .from('wells')
        .upsert(batch, { onConflict: 'well_id' });

      if (error) {
        throw error;
      }

      upsertedCount += batch.length;
    }
  }

  diag(`Prepared ${importRows.length} well rows for ${sourceOperatorName}`);
  if (skippedRows.length > 0) {
    diag(`Skipped ${skippedRows.length} rows with missing required fields`);
  }

  process.stdout.write(
    `${JSON.stringify(
      {
        operatorSlug: options.operatorSlug,
        sourceOperatorName,
        sourcePath: options.sourcePath,
        manifestPath: options.manifestPath,
        dryRun: options.dryRun,
        matchedSourceRows: matchedSourceRows.length,
        activeRows: activeRows.length,
        importRows: importRows.length,
        upsertedRows: options.dryRun ? 0 : upsertedCount,
        operatorId,
        skippedRows,
      },
      null,
      2,
    )}\n`,
  );
}

main().catch((error: unknown) => {
  process.stderr.write(`${error instanceof Error ? error.message : String(error)}\n`);
  process.exit(1);
});
