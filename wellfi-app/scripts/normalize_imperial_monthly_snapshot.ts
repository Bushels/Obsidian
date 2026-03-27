import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

import XLSX from 'xlsx';

import { dedupeMonthlySnapshotRows } from './lib/monthly_snapshot.js';

interface ImperialSnapshotRow {
  internal_id?: string;
  well_name?: string;
  licensee?: string;
  producing_formation?: string;
  surface_latitude?: string | number;
  surface_longitude?: string | number;
  recent_oil_m3?: string | number;
  recent_gas_e3m3?: string | number;
  recent_ngl_m3?: string | number;
  recent_oil_bbl?: string | number;
  recent_gas_mcf?: string | number;
  recent_ngl_bbl?: string | number;
  oil_bbl_per_day?: string | number;
  gas_mcf_per_day?: string | number;
  ngl_bbl_per_day?: string | number;
}

interface CanonicalSnapshotRow {
  uwi: string;
  well_name: string;
  operator_licensee: string;
  producing_formation: string;
  field_name: string;
  well_status: string;
  well_fluid_type: string;
  surface_latitude: string;
  surface_longitude: string;
  last_oil_production_rate: string;
  cumulative_oil_production: string;
  recent_oil: string;
  recent_gas: string;
  recent_water: string;
  recent_steam_injection: string;
  last_production_date: string;
  spud_date: string;
}

interface SnapshotReferenceRow {
  uwi?: string;
  well_name?: string;
  field_name?: string;
  well_status?: string;
  well_fluid_type?: string;
  surface_latitude?: string | number;
  surface_longitude?: string | number;
  last_oil_production_rate?: string | number;
  cumulative_oil_production?: string | number;
  recent_oil?: string | number;
  recent_gas?: string | number;
  recent_water?: string | number;
  recent_steam_injection?: string | number;
  last_production_date?: string;
  spud_date?: string;
}

interface CliOptions {
  inputPath: string;
  referencePath: string;
  outputPath: string;
  reportPath: string;
  snapshotMonth: string | null;
}

interface NormalizeReport {
  generatedAt: string;
  workflow: 'imperial-monthly-snapshot-normalize';
  inputPath: string;
  referencePath: string;
  outputPath: string;
  reportPath: string;
  snapshotMonth: string;
  sourceRows: number;
  uniqueRows: number;
  duplicateRowsCollapsed: number;
  referenceRows: number;
  referenceMatches: number;
  referenceMisses: number;
  backfills: Record<string, number>;
  notes: string[];
}

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const DEFAULT_INPUT_PATH = path.resolve(
  __dirname,
  '..',
  '..',
  'Data',
  'clearwater_bluesky_feb2026_prod_imperial.csv',
);

const DEFAULT_REFERENCE_PATH = path.resolve(
  __dirname,
  '..',
  '..',
  'Data',
  'active_clearwater_bluesky_recent_prod_ab_sk.csv',
);

const DEFAULT_OUTPUT_PATH = DEFAULT_INPUT_PATH.replace(/\.csv$/i, '_canonical.csv');
const DEFAULT_REPORT_PATH = path.resolve(
  __dirname,
  '..',
  'output',
  'monthly-production-normalize',
  'latest.json',
);

const CANONICAL_HEADER = [
  'uwi',
  'well_name',
  'operator_licensee',
  'producing_formation',
  'field_name',
  'well_status',
  'well_fluid_type',
  'surface_latitude',
  'surface_longitude',
  'last_oil_production_rate',
  'cumulative_oil_production',
  'recent_oil',
  'recent_gas',
  'recent_water',
  'recent_steam_injection',
  'last_production_date',
  'spud_date',
] as const;

function normalize(value: unknown): string {
  return String(value ?? '').trim();
}

function diag(message: string): void {
  process.stderr.write(`${message}\n`);
}

function parseArgs(argv: string[]): CliOptions {
  let inputPath = normalize(process.env.npm_config_input) || DEFAULT_INPUT_PATH;
  let referencePath = normalize(process.env.npm_config_reference) || DEFAULT_REFERENCE_PATH;
  let outputPath = normalize(process.env.npm_config_output) || DEFAULT_OUTPUT_PATH;
  let reportPath = normalize(process.env.npm_config_report) || DEFAULT_REPORT_PATH;
  let snapshotMonth = normalize(process.env.npm_config_snapshot_month) || null;

  for (let index = 0; index < argv.length; index += 1) {
    const arg = argv[index];

    if (arg === '--help') {
      process.stdout.write(
        [
          'Usage: tsx scripts/normalize_imperial_monthly_snapshot.ts [options]',
          '',
          'Normalize an alternate Imperial-style monthly production export into the canonical snapshot schema.',
          '',
          'Options:',
          `  --input <path>           Imperial-style export (default: ${DEFAULT_INPUT_PATH})`,
          `  --reference <path>       Canonical snapshot used for field backfills (default: ${DEFAULT_REFERENCE_PATH})`,
          `  --output <path>          Canonical CSV output (default: ${DEFAULT_OUTPUT_PATH})`,
          `  --report <path>          JSON summary output (default: ${DEFAULT_REPORT_PATH})`,
          '  --snapshot-month <YYYY-MM|YYYY-MM-DD|monYYYY>',
          '                           Explicit snapshot month when it cannot be inferred from the filename',
          '  --help                   Show this message',
          '',
        ].join('\n'),
      );
      process.exit(0);
    }

    if (arg === '--input') {
      inputPath = path.resolve(argv[index + 1] ?? '');
      index += 1;
      continue;
    }

    if (arg === '--reference') {
      referencePath = path.resolve(argv[index + 1] ?? '');
      index += 1;
      continue;
    }

    if (arg === '--output') {
      outputPath = path.resolve(argv[index + 1] ?? '');
      index += 1;
      continue;
    }

    if (arg === '--report') {
      reportPath = path.resolve(argv[index + 1] ?? '');
      index += 1;
      continue;
    }

    if (arg === '--snapshot-month') {
      snapshotMonth = normalize(argv[index + 1] ?? '');
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
    referencePath,
    outputPath,
    reportPath,
    snapshotMonth,
  };
}

function readRows<T>(filePath: string): T[] {
  const workbook = XLSX.readFile(filePath, { raw: false });
  const firstSheetName = workbook.SheetNames[0];
  const sheet = workbook.Sheets[firstSheetName];
  return XLSX.utils.sheet_to_json<T>(sheet, {
    defval: '',
    raw: false,
  });
}

function parseNumber(value: unknown): number | null {
  const text = normalize(value);
  if (!text) {
    return null;
  }

  const parsed = Number(text);
  return Number.isFinite(parsed) ? parsed : null;
}

function toNumberText(value: unknown, fallback = '0'): string {
  const parsed = parseNumber(value);
  if (parsed == null) {
    return fallback;
  }

  return String(parsed);
}

function normalizeWellId(value: unknown): string {
  return normalize(value).toUpperCase().replace(/[^A-Z0-9]/g, '');
}

function inferSnapshotMonth(inputPath: string, explicitMonth: string | null): string {
  const raw = normalize(explicitMonth);
  if (raw) {
    return normalizeMonthInput(raw);
  }

  const fileName = path.basename(inputPath).toLowerCase();
  const monthMatch = fileName.match(
    /(jan|feb|mar|apr|may|jun|jul|aug|sep|sept|oct|nov|dec)[-_ ]?(\d{4})/,
  );
  if (monthMatch) {
    const [, monthAbbrev, yearText] = monthMatch;
    return normalizeMonthInput(`${monthAbbrev}${yearText}`);
  }

  const numericMatch = fileName.match(/(\d{4})[-_]?(\d{2})/);
  if (numericMatch) {
    const [, yearText, monthText] = numericMatch;
    return normalizeMonthInput(`${yearText}-${monthText}`);
  }

  throw new Error(
    'Unable to infer the snapshot month from the filename. Pass --snapshot-month YYYY-MM or YYYY-MM-DD.',
  );
}

function normalizeMonthInput(value: string): string {
  const lower = value.trim().toLowerCase();

  const monthNameMatch = lower.match(
    /^(jan|feb|mar|apr|may|jun|jul|aug|sep|sept|oct|nov|dec)[-_ ]?(\d{4})$/,
  );
  if (monthNameMatch) {
    const monthMap: Record<string, string> = {
      jan: '01',
      feb: '02',
      mar: '03',
      apr: '04',
      may: '05',
      jun: '06',
      jul: '07',
      aug: '08',
      sep: '09',
      sept: '09',
      oct: '10',
      nov: '11',
      dec: '12',
    };
    const [, monthAbbrev, yearText] = monthNameMatch;
    return `${yearText}-${monthMap[monthAbbrev]}-01`;
  }

  const isoMatch = lower.match(/^(\d{4})-(\d{2})(?:-\d{2})?$/);
  if (isoMatch) {
    const [, yearText, monthText] = isoMatch;
    return `${yearText}-${monthText}-01`;
  }

  throw new Error(`Unsupported snapshot month format: ${value}`);
}

function endOfMonthText(snapshotMonth: string): string {
  const [yearText, monthText] = snapshotMonth.split('-');
  const year = Number(yearText);
  const monthIndex = Number(monthText) - 1;
  const date = new Date(Date.UTC(year, monthIndex + 1, 0));
  const mm = String(date.getUTCMonth() + 1);
  const dd = String(date.getUTCDate());
  const yy = String(date.getUTCFullYear()).slice(-2);
  return `${mm}/${dd}/${yy}`;
}

function deriveFieldName(wellName: string): string {
  const trimmed = normalize(wellName);
  if (!trimmed) {
    return '';
  }

  const withoutLegalLocation = trimmed.replace(/\s+\d+-\d+-\d+-\d+.*$/, '').trim();
  if (!withoutLegalLocation) {
    return '';
  }

  const parts = withoutLegalLocation.split(/\s+/).filter(Boolean);
  return parts[parts.length - 1] ?? '';
}

function deriveWellFluidType(row: ImperialSnapshotRow, reference?: SnapshotReferenceRow): string {
  if (reference?.well_fluid_type) {
    return normalize(reference.well_fluid_type);
  }

  const formation = normalize(row.producing_formation).toLowerCase();
  if (formation.includes('clearwater')) {
    return 'Crude Bitumen';
  }
  if (formation.includes('bluesky')) {
    return 'Gas';
  }

  const oil = parseNumber(row.recent_oil_bbl) ?? 0;
  const gas = parseNumber(row.recent_gas_mcf) ?? 0;
  if (oil > 0 && gas === 0) {
    return 'Crude Bitumen';
  }
  if (gas > 0 && oil === 0) {
    return 'Gas';
  }

  return 'Gas';
}

function deriveWellStatus(row: ImperialSnapshotRow, reference?: SnapshotReferenceRow): string {
  if (reference?.well_status) {
    return normalize(reference.well_status);
  }

  const oil = parseNumber(row.recent_oil_bbl) ?? 0;
  const gas = parseNumber(row.recent_gas_mcf) ?? 0;
  return oil > 0 || gas > 0 ? 'Active' : 'Inactive';
}

function toCanonicalRow(
  row: ImperialSnapshotRow,
  reference?: SnapshotReferenceRow,
  snapshotDateText = '1/1/26',
): CanonicalSnapshotRow {
  const uwi = normalize(row.internal_id);
  if (!uwi) {
    throw new Error('Encountered an Imperial row with a missing internal_id');
  }

  const fallbackFieldName = deriveFieldName(row.well_name ?? '');
  const fieldName = normalize(reference?.field_name) || fallbackFieldName;
  const referenceSurfaceLat = reference?.surface_latitude;
  const referenceSurfaceLon = reference?.surface_longitude;
  const surfaceLatitude = parseNumber(row.surface_latitude) ?? parseNumber(referenceSurfaceLat);
  const surfaceLongitude = parseNumber(row.surface_longitude) ?? parseNumber(referenceSurfaceLon);

  if (surfaceLatitude == null || surfaceLongitude == null) {
    throw new Error(`Missing coordinates for Imperial well ${uwi}`);
  }

  return {
    uwi,
    well_name: normalize(row.well_name),
    operator_licensee: normalize(row.licensee),
    producing_formation: normalize(row.producing_formation),
    field_name: fieldName,
    well_status: deriveWellStatus(row, reference),
    well_fluid_type: deriveWellFluidType(row, reference),
    surface_latitude: String(surfaceLatitude),
    surface_longitude: String(surfaceLongitude),
    last_oil_production_rate: toNumberText(row.oil_bbl_per_day),
    cumulative_oil_production:
      toNumberText(reference?.cumulative_oil_production, '0'),
    recent_oil: toNumberText(row.recent_oil_bbl),
    recent_gas: toNumberText(row.recent_gas_mcf),
    recent_water: toNumberText(reference?.recent_water, '0'),
    recent_steam_injection: toNumberText(reference?.recent_steam_injection, '0'),
    last_production_date: snapshotDateText,
    spud_date: normalize(reference?.spud_date),
  };
}

function escapeCsv(value: unknown): string {
  const text = normalize(value);
  if (text === '') {
    return '';
  }

  if (/[",\r\n]/.test(text)) {
    return `"${text.replace(/"/g, '""')}"`;
  }

  return text;
}

function writeCsv(filePath: string, rows: CanonicalSnapshotRow[]): void {
  const lines = [
    CANONICAL_HEADER.join(','),
    ...rows.map((row) => CANONICAL_HEADER.map((key) => escapeCsv(row[key])).join(',')),
  ];

  fs.mkdirSync(path.dirname(filePath), { recursive: true });
  fs.writeFileSync(filePath, `${lines.join('\n')}\n`, 'utf8');
}

function writeReport(reportPath: string, report: NormalizeReport): void {
  fs.mkdirSync(path.dirname(reportPath), { recursive: true });
  fs.writeFileSync(reportPath, `${JSON.stringify(report, null, 2)}\n`, 'utf8');
}

function main(): void {
  const options = parseArgs(process.argv.slice(2));

  if (!fs.existsSync(options.inputPath)) {
    throw new Error(`Imperial source file not found: ${options.inputPath}`);
  }

  if (!fs.existsSync(options.referencePath)) {
    throw new Error(`Reference canonical file not found: ${options.referencePath}`);
  }

  const snapshotMonth = inferSnapshotMonth(options.inputPath, options.snapshotMonth);
  const snapshotDateText = endOfMonthText(snapshotMonth);

  diag(`Reading imperial snapshot ${options.inputPath}...`);
  const sourceRows = readRows<ImperialSnapshotRow>(options.inputPath);
  diag(`Reading canonical reference ${options.referencePath}...`);
  const referenceRows = readRows<SnapshotReferenceRow>(options.referencePath);

  const referenceMap = new Map(
    referenceRows
      .map((row) => [normalizeWellId(row.uwi), row] as const)
      .filter(([wellId]) => Boolean(wellId)),
  );

  const canonicalCandidates = sourceRows.map((row) => {
    const reference = referenceMap.get(normalizeWellId(row.internal_id));
    return toCanonicalRow(row, reference, snapshotDateText);
  });

  const backfills = {
    field_name: 0,
    well_status: 0,
    well_fluid_type: 0,
    surface_latitude: 0,
    surface_longitude: 0,
    cumulative_oil_production: 0,
    recent_water: 0,
    recent_steam_injection: 0,
    spud_date: 0,
  };

  for (const row of sourceRows) {
    const reference = referenceMap.get(normalizeWellId(row.internal_id));
    if (!reference) {
      continue;
    }

    if (!normalize(reference.field_name)) backfills.field_name += 1;
    if (!normalize(reference.well_status)) backfills.well_status += 1;
    if (!normalize(reference.well_fluid_type)) backfills.well_fluid_type += 1;
    if (!normalize(reference.surface_latitude)) backfills.surface_latitude += 1;
    if (!normalize(reference.surface_longitude)) backfills.surface_longitude += 1;
    if (!normalize(reference.cumulative_oil_production)) backfills.cumulative_oil_production += 1;
    if (!normalize(reference.recent_water)) backfills.recent_water += 1;
    if (!normalize(reference.recent_steam_injection)) backfills.recent_steam_injection += 1;
    if (!normalize(reference.spud_date)) backfills.spud_date += 1;
  }

  const { rows, summary } = dedupeMonthlySnapshotRows(canonicalCandidates);

  writeCsv(options.outputPath, rows);

  const report: NormalizeReport = {
    generatedAt: new Date().toISOString(),
    workflow: 'imperial-monthly-snapshot-normalize',
    inputPath: options.inputPath,
    referencePath: options.referencePath,
    outputPath: options.outputPath,
    reportPath: options.reportPath,
    snapshotMonth,
    sourceRows: sourceRows.length,
    uniqueRows: rows.length,
    duplicateRowsCollapsed: summary.duplicateRowsCollapsed,
    referenceRows: referenceRows.length,
    referenceMatches: sourceRows.filter((row) =>
      referenceMap.has(normalizeWellId(row.internal_id)),
    ).length,
    referenceMisses: sourceRows.filter((row) =>
      !referenceMap.has(normalizeWellId(row.internal_id)),
    ).length,
    backfills,
    notes: [
      'Imperial export coordinates and production rates were kept from the source file.',
      'Missing metadata was backfilled from the canonical reference file when a matching UWI existed.',
      'Rows without a canonical reference fell back to inferred field and fluid labels, and zero defaults for non-critical metadata.',
      `Last production date was stamped to the end of ${snapshotMonth.slice(0, 7)} for compatibility with the existing monthly pipeline.`,
    ],
  };

  writeReport(options.reportPath, report);

  diag(`Wrote canonical CSV to ${options.outputPath}`);
  diag(`Wrote normalization report to ${options.reportPath}`);
  diag(`Snapshot month: ${snapshotMonth}`);
  diag(`Rows: source=${sourceRows.length} unique=${rows.length} collapsed=${summary.duplicateRowsCollapsed}`);
}

try {
  main();
} catch (error: unknown) {
  process.stderr.write(`${error instanceof Error ? error.message : String(error)}\n`);
  process.exit(1);
}
