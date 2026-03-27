import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import XLSX from 'xlsx';
import { dedupeMonthlySnapshotRows } from './lib/monthly_snapshot.js';

interface SourceRow {
  uwi?: string;
  operator_licensee?: string;
  producing_formation?: string;
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

interface GeoJsonFeature {
  type: 'Feature';
  geometry: {
    type: 'Point';
    coordinates: [number, number];
  };
  properties: {
    uwi: string;
    operator: string;
    formation: string;
    field_name: string;
    well_fluid_type: string;
    fluid_type: string;
    well_status: string;
    recent_oil: number;
    cumulative_oil: number;
    recent_gas: number;
    recent_water: number;
    recent_steam_injection: number;
    last_production_date: string;
    spud_date: string;
    op_status: string;
  };
}

interface GeoJsonCollection {
  type: 'FeatureCollection';
  features: GeoJsonFeature[];
}

interface CliOptions {
  inputPath: string;
  cleanOutput: boolean;
}

export interface BuildOperatorGeojsonOptions {
  inputPath: string;
  outputBase?: string;
  cleanOutput?: boolean;
  logger?: (message: string) => void;
}

export interface OperatorGeojsonSummaryEntry {
  slug: string;
  operator: string;
  featureCount: number;
}

export interface BuildOperatorGeojsonSummary {
  generatedAt: string;
  inputPath: string;
  outputBase: string;
  cleanOutput: boolean;
  sourceRows: number;
  uniqueSnapshotRows: number;
  duplicateRowsCollapsed: number;
  duplicateWellCount: number;
  skippedCoords: number;
  skippedZeroProd: number;
  totalFeatures: number;
  operatorCount: number;
  operators: OperatorGeojsonSummaryEntry[];
}

const OPERATOR_ALIASES: Record<string, string> = {
  'Canadian Natural Upgrading Limited': 'Canadian Natural Resources Limited',
};

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

export const DEFAULT_INPUT_PATH = path.resolve(
  __dirname,
  '..',
  '..',
  'Data',
  'active_clearwater_bluesky_recent_prod_ab_sk.csv',
);
export const OUTPUT_BASE = path.resolve(__dirname, '..', 'public', 'data', 'operators');

function diag(message: string): void {
  process.stderr.write(`${message}\n`);
}

function printHelp(): void {
  process.stdout.write(
    [
      'Usage: tsx scripts/build_operator_geojson.ts [--input <csv>]',
      '',
      'Split basin production CSV into per-operator GeoJSON files.',
      '',
      'Options:',
      '  --input <path>  Source CSV (default: ../../Data/active_clearwater_bluesky_recent_prod_ab_sk.csv)',
      '  --no-clean      Keep any existing operator output directories instead of rebuilding cleanly',
      '  --help          Show this message',
      '',
    ].join('\n'),
  );
}

function parseArgs(argv: string[]): CliOptions {
  let inputPath = DEFAULT_INPUT_PATH;
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
    if (arg === '--no-clean') {
      cleanOutput = false;
      continue;
    }
    throw new Error(`Unknown argument: ${arg}`);
  }

  return { inputPath, cleanOutput };
}

function normalize(value: unknown): string {
  return String(value ?? '').trim();
}

function toNumber(value: unknown): number {
  const n = Number(value);
  return Number.isFinite(n) ? n : 0;
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

function deriveFormation(producingFormation: string): string {
  const lower = producingFormation.toLowerCase();
  if (lower.includes('clearwater')) return 'Clearwater';
  if (lower.includes('bluesky')) return 'Bluesky';
  return 'Unknown';
}

function deriveFluidType(wellFluidType: string): string {
  return wellFluidType.toLowerCase().includes('gas') ? 'gas' : 'oil';
}

function parseRows(inputPath: string): SourceRow[] {
  const workbook = XLSX.readFile(inputPath, { raw: true });
  const firstSheetName = workbook.SheetNames[0];
  const sheet = workbook.Sheets[firstSheetName];
  return XLSX.utils.sheet_to_json<SourceRow>(sheet, {
    defval: '',
    raw: true,
  });
}

function rowToFeature(row: SourceRow): GeoJsonFeature | null {
  const lat = toNumber(row.surface_latitude);
  const lng = toNumber(row.surface_longitude);

  // Filter missing coordinates
  if (lat === 0 && lng === 0) return null;
  if (!Number.isFinite(lat) || !Number.isFinite(lng)) return null;

  const recentOil = toNumber(row.recent_oil);
  const recentGas = toNumber(row.recent_gas);

  // Filter zero-production wells
  if (recentOil === 0 && recentGas === 0) return null;

  const rawOperator = normalize(row.operator_licensee) || 'UNKNOWN';
  const operator = OPERATOR_ALIASES[rawOperator] ?? rawOperator;
  const producingFormation = normalize(row.producing_formation);
  const wellFluidType = normalize(row.well_fluid_type);

  return {
    type: 'Feature',
    geometry: {
      type: 'Point',
      coordinates: [lng, lat],
    },
    properties: {
      uwi: normalize(row.uwi),
      operator,
      formation: deriveFormation(producingFormation),
      field_name: normalize(row.field_name),
      well_fluid_type: wellFluidType,
      fluid_type: deriveFluidType(wellFluidType),
      well_status: normalize(row.well_status),
      recent_oil: recentOil,
      cumulative_oil: toNumber(row.cumulative_oil_production),
      recent_gas: recentGas,
      recent_water: toNumber(row.recent_water),
      recent_steam_injection: toNumber(row.recent_steam_injection),
      last_production_date: normalize(row.last_production_date),
      spud_date: normalize(row.spud_date),
      op_status: 'normal',
    },
  };
}

function writeGeoJson(filePath: string, collection: GeoJsonCollection): void {
  fs.mkdirSync(path.dirname(filePath), { recursive: true });
  fs.writeFileSync(filePath, JSON.stringify(collection), 'utf8');
}

export function buildOperatorGeojson(
  options: BuildOperatorGeojsonOptions,
): BuildOperatorGeojsonSummary {
  const inputPath = path.resolve(options.inputPath);
  const outputBase = path.resolve(options.outputBase ?? OUTPUT_BASE);
  const cleanOutput = options.cleanOutput ?? true;
  const logger = options.logger ?? diag;

  if (!fs.existsSync(inputPath)) {
    throw new Error(`Input file not found: ${inputPath}`);
  }

  logger(`Reading ${inputPath}...`);
  const rawRows = parseRows(inputPath);
  const { rows, summary: dedupeSummary } = dedupeMonthlySnapshotRows(rawRows);
  logger(`Source rows: ${rawRows.length}`);
  if (dedupeSummary.duplicateRowsCollapsed > 0) {
    logger(
      `Collapsed ${dedupeSummary.duplicateRowsCollapsed} duplicate snapshot row(s) across ${dedupeSummary.duplicateWellCount} well(s) before building overlays.`,
    );
  }

  if (cleanOutput) {
    fs.rmSync(outputBase, { recursive: true, force: true });
    logger(`Cleaned ${outputBase}`);
  }

  // Convert rows to features, filtering invalid/zero-production
  const allFeatures: GeoJsonFeature[] = [];
  let skippedCoords = 0;
  let skippedZeroProd = 0;

  for (const row of rows) {
    const lat = toNumber(row.surface_latitude);
    const lng = toNumber(row.surface_longitude);
    const hasCoords = (lat !== 0 || lng !== 0) && Number.isFinite(lat) && Number.isFinite(lng);
    const recentOil = toNumber(row.recent_oil);
    const recentGas = toNumber(row.recent_gas);
    const hasProduction = recentOil !== 0 || recentGas !== 0;

    if (!hasCoords) {
      skippedCoords += 1;
      continue;
    }
    if (!hasProduction) {
      skippedZeroProd += 1;
      continue;
    }

    const feature = rowToFeature(row);
    if (feature) {
      allFeatures.push(feature);
    }
  }

  logger(`Skipped (missing coords): ${skippedCoords}`);
  logger(`Skipped (zero production): ${skippedZeroProd}`);
  logger(`Features after filtering: ${allFeatures.length}`);

  // Group by operator slug
  const operatorGroups = new Map<string, { operator: string; features: GeoJsonFeature[] }>();

  for (const feature of allFeatures) {
    const operator = feature.properties.operator;
    const slug = slugifyOperator(operator);

    let group = operatorGroups.get(slug);
    if (!group) {
      group = { operator, features: [] };
      operatorGroups.set(slug, group);
    }
    group.features.push(feature);
  }

  // Write per-operator GeoJSON
  const sortedSlugs = [...operatorGroups.keys()].sort();
  const operatorSummaries: OperatorGeojsonSummaryEntry[] = [];

  logger('');
  logger('Per-operator feature counts:');

  for (const slug of sortedSlugs) {
    const group = operatorGroups.get(slug)!;
    const collection: GeoJsonCollection = {
      type: 'FeatureCollection',
      features: group.features,
    };
    const outPath = path.join(outputBase, slug, 'production.geojson');
    writeGeoJson(outPath, collection);
    operatorSummaries.push({
      slug,
      operator: group.operator,
      featureCount: group.features.length,
    });
    logger(`  ${slug}: ${group.features.length} (${group.operator})`);
  }

  // Write _all combined
  const allCollection: GeoJsonCollection = {
    type: 'FeatureCollection',
    features: allFeatures,
  };
  const allPath = path.join(outputBase, '_all', 'production.geojson');
  writeGeoJson(allPath, allCollection);

  logger('');
  logger(`Total operators: ${operatorGroups.size}`);
  logger(`Total features (_all): ${allFeatures.length}`);
  logger(`Wrote ${sortedSlugs.length + 1} GeoJSON files to ${outputBase}`);

  return {
    generatedAt: new Date().toISOString(),
    inputPath,
    outputBase,
    cleanOutput,
    sourceRows: rawRows.length,
    uniqueSnapshotRows: dedupeSummary.uniqueRows,
    duplicateRowsCollapsed: dedupeSummary.duplicateRowsCollapsed,
    duplicateWellCount: dedupeSummary.duplicateWellCount,
    skippedCoords,
    skippedZeroProd,
    totalFeatures: allFeatures.length,
    operatorCount: operatorGroups.size,
    operators: operatorSummaries,
  };
}

function main(): void {
  const options = parseArgs(process.argv.slice(2));
  buildOperatorGeojson({
    inputPath: options.inputPath,
    cleanOutput: options.cleanOutput,
  });
}

if (process.argv[1] && path.resolve(process.argv[1]) === __filename) {
  try {
    main();
  } catch (error: unknown) {
    process.stderr.write(`${error instanceof Error ? error.message : String(error)}\n`);
    process.exit(1);
  }
}
