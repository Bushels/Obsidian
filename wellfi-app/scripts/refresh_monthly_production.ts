import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import XLSX from 'xlsx';

import {
  buildOperatorGeojson,
  DEFAULT_INPUT_PATH,
  OUTPUT_BASE,
  type BuildOperatorGeojsonSummary,
} from './build_operator_geojson.js';

interface CliOptions {
  inputPath: string;
  reportPath: string;
  cleanOutput: boolean;
}

interface RefreshReport {
  generatedAt: string;
  workflow: 'monthly-production-refresh';
  mode: 'overlay-only';
  inputPath: string;
  reportPath: string;
  outputBase: string;
  cleanOutput: boolean;
  requiredColumns: string[];
  zeroProductionRule: string;
  warnings: string[];
  geojson: BuildOperatorGeojsonSummary;
}

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const DEFAULT_REPORT_PATH = path.resolve(
  __dirname,
  '..',
  'output',
  'monthly-production-refresh',
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

function diag(message: string): void {
  process.stderr.write(`${message}\n`);
}

function printHelp(): void {
  process.stdout.write(
    [
      'Usage: tsx scripts/refresh_monthly_production.ts [options]',
      '',
      'Validate the monthly Clearwater / Bluesky production snapshot and rebuild',
      'per-operator production GeoJSON overlays.',
      '',
      'This workflow is overlay-only. It does not update Supabase wells.',
      '',
      'Options:',
      `  --input <path>   Snapshot CSV/XLSX (default: ${DEFAULT_INPUT_PATH})`,
      `  --report <path>  JSON report output (default: ${DEFAULT_REPORT_PATH})`,
      '  --no-clean       Keep existing operator output directories instead of rebuilding cleanly',
      '  --help           Show this message',
      '',
    ].join('\n'),
  );
}

function parseArgs(argv: string[]): CliOptions {
  let inputPath = DEFAULT_INPUT_PATH;
  let reportPath = DEFAULT_REPORT_PATH;
  let cleanOutput = true;

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

    if (arg === '--report') {
      reportPath = path.resolve(argv[index + 1] ?? '');
      index += 1;
      continue;
    }

    if (arg === '--no-clean') {
      cleanOutput = false;
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
    reportPath,
    cleanOutput,
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
  return header.map((value) => String(value ?? '').trim());
}

function validateColumns(inputPath: string): void {
  const header = readHeaderRow(inputPath);
  const missing = REQUIRED_COLUMNS.filter((column) => !header.includes(column));

  if (missing.length > 0) {
    throw new Error(
      `Monthly snapshot is missing required columns: ${missing.join(', ')}`,
    );
  }
}

function writeReport(reportPath: string, report: RefreshReport): void {
  fs.mkdirSync(path.dirname(reportPath), { recursive: true });
  fs.writeFileSync(reportPath, `${JSON.stringify(report, null, 2)}\n`, 'utf8');
}

function buildWarnings(inputPath: string): string[] {
  return [
    'Overlay-only refresh: this workflow rebuilds public production GeoJSON and does not modify Supabase wells.',
    'Missing wells in the monthly snapshot are not deleted from Supabase by this workflow.',
    `Zero-production rows are excluded from ${path.basename(OUTPUT_BASE)} GeoJSON output. Base-well dot persistence depends on separate map/base-well rendering.`,
    `Treat ${inputPath} as a monthly production snapshot, not a destructive full-replacement well-master feed.`,
  ];
}

function main(): void {
  const options = parseArgs(process.argv.slice(2));

  if (!fs.existsSync(options.inputPath)) {
    throw new Error(`Input file not found: ${options.inputPath}`);
  }

  diag(`Validating required columns in ${options.inputPath}...`);
  validateColumns(options.inputPath);
  diag('Required columns present.');

  const geojsonSummary = buildOperatorGeojson({
    inputPath: options.inputPath,
    cleanOutput: options.cleanOutput,
    logger: diag,
  });

  const report: RefreshReport = {
    generatedAt: new Date().toISOString(),
    workflow: 'monthly-production-refresh',
    mode: 'overlay-only',
    inputPath: options.inputPath,
    reportPath: options.reportPath,
    outputBase: OUTPUT_BASE,
    cleanOutput: options.cleanOutput,
    requiredColumns: [...REQUIRED_COLUMNS],
    zeroProductionRule:
      'Rows with both recent_oil = 0 and recent_gas = 0 are excluded from production overlay GeoJSON.',
    warnings: buildWarnings(options.inputPath),
    geojson: geojsonSummary,
  };

  writeReport(options.reportPath, report);

  diag('');
  diag(`Wrote refresh report to ${options.reportPath}`);
  diag('Workflow complete: monthly production overlay refreshed.');
}

try {
  main();
} catch (error: unknown) {
  process.stderr.write(`${error instanceof Error ? error.message : String(error)}\n`);
  process.exit(1);
}
