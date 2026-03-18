import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import XLSX from 'xlsx';

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
}

const OPERATOR_ALIASES: Record<string, string> = {
  'Canadian Natural Upgrading Limited': 'Canadian Natural Resources Limited',
};

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const DEFAULT_INPUT_PATH = path.resolve(
  __dirname,
  '..',
  '..',
  'Data',
  'active_clearwater_bluesky_recent_prod_ab_sk.csv',
);
const OUTPUT_BASE = path.resolve(__dirname, '..', 'public', 'data', 'operators');

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
      '  --help          Show this message',
      '',
    ].join('\n'),
  );
}

function parseArgs(argv: string[]): CliOptions {
  let inputPath = DEFAULT_INPUT_PATH;

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
    throw new Error(`Unknown argument: ${arg}`);
  }

  return { inputPath };
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

function main(): void {
  const options = parseArgs(process.argv.slice(2));

  if (!fs.existsSync(options.inputPath)) {
    throw new Error(`Input file not found: ${options.inputPath}`);
  }

  diag(`Reading ${options.inputPath}...`);
  const rows = parseRows(options.inputPath);
  diag(`Source rows: ${rows.length}`);

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

  diag(`Skipped (missing coords): ${skippedCoords}`);
  diag(`Skipped (zero production): ${skippedZeroProd}`);
  diag(`Features after filtering: ${allFeatures.length}`);

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

  diag('');
  diag('Per-operator feature counts:');

  for (const slug of sortedSlugs) {
    const group = operatorGroups.get(slug)!;
    const collection: GeoJsonCollection = {
      type: 'FeatureCollection',
      features: group.features,
    };
    const outPath = path.join(OUTPUT_BASE, slug, 'production.geojson');
    writeGeoJson(outPath, collection);
    diag(`  ${slug}: ${group.features.length} (${group.operator})`);
  }

  // Write _all combined
  const allCollection: GeoJsonCollection = {
    type: 'FeatureCollection',
    features: allFeatures,
  };
  const allPath = path.join(OUTPUT_BASE, '_all', 'production.geojson');
  writeGeoJson(allPath, allCollection);

  diag('');
  diag(`Total operators: ${operatorGroups.size}`);
  diag(`Total features (_all): ${allFeatures.length}`);
  diag(`Wrote ${sortedSlugs.length + 1} GeoJSON files to ${OUTPUT_BASE}`);
}

try {
  main();
} catch (error: unknown) {
  process.stderr.write(`${error instanceof Error ? error.message : String(error)}\n`);
  process.exit(1);
}
