import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import XLSX from 'xlsx';

type FluidClass = 'oil' | 'gas' | 'other';

interface SourceRow {
  operator?: string;
  province?: string;
  well_id?: string;
  formatted_well_id?: string;
  well_name?: string;
  petro_ninja_well_status?: string;
  well_status?: string;
  petro_ninja_well_fluid?: string;
  well_fluid?: string;
  well_symbol_name?: string;
  producing_formation?: string;
}

interface OperatorSummary {
  operator: string;
  suggestedUsername: string;
  totalWells: number;
  clearwaterWells: number;
  blueskyWells: number;
  oilWells: number;
  gasWells: number;
  otherWells: number;
  provinces: Set<string>;
  formationLabels: Map<string, number>;
  sampleWellName: string | null;
  sampleWellId: string | null;
}

interface CliOptions {
  inputPath: string;
  outputDir: string;
}

type OutputRow = Record<string, string | number>;
type CsvRow = Record<string, string>;

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const DEFAULT_INPUT_PATH = path.resolve(__dirname, '..', '..', 'Data', 'active_bluesky_clearwater_wells_AB_SK.csv');
const DEFAULT_OUTPUT_DIR = path.resolve(__dirname, '..', '..', 'Data');
const INVENTORY_CSV_PATH = 'operator_inventory_clearwater_bluesky.csv';
const INVENTORY_JSON_PATH = 'operator_inventory_clearwater_bluesky.json';
const INVENTORY_MD_PATH = 'operator_inventory_clearwater_bluesky.md';
const LOGIN_MANIFEST_CSV_PATH = 'operator_login_manifest_clearwater_bluesky.csv';
const ROLLOUT_MANIFEST_CSV_PATH = 'operator_rollout_manifest_clearwater_bluesky.csv';

function printHelp() {
  process.stdout.write(
    [
      'Usage: tsx scripts/build_operator_inventory.ts [--input <csv>] [--output-dir <dir>]',
      '',
      'Generate Clearwater / Bluesky operator inventory outputs and preserve the',
      'human-managed rollout manifest across reruns.',
      '',
      'Options:',
      '  --input <path>       Source CSV/XLSX snapshot',
      '  --output-dir <path>  Output directory for generated files',
      '  --help               Show this message',
      '',
    ].join('\n'),
  );
}

function parseArgs(argv: string[]): CliOptions {
  let inputPath = DEFAULT_INPUT_PATH;
  let outputDir = DEFAULT_OUTPUT_DIR;

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

    if (arg === '--output-dir') {
      outputDir = path.resolve(argv[index + 1] ?? '');
      index += 1;
      continue;
    }

    throw new Error(`Unknown argument: ${arg}`);
  }

  return { inputPath, outputDir };
}

function diag(message: string): void {
  process.stderr.write(`${message}\n`);
}

function normalize(value: unknown): string {
  return String(value ?? '').trim();
}

function csvEscape(value: unknown): string {
  const text = String(value ?? '');
  if (/[",\n]/.test(text)) {
    return `"${text.replace(/"/g, '""')}"`;
  }
  return text;
}

function parseRows(inputPath: string): SourceRow[] {
  const workbook = XLSX.readFile(inputPath, { raw: false });
  const firstSheetName = workbook.SheetNames[0];
  const sheet = workbook.Sheets[firstSheetName];
  return XLSX.utils.sheet_to_json<SourceRow>(sheet, {
    defval: '',
    raw: false,
  });
}

function parseCsvRows(filePath: string): CsvRow[] {
  if (!fs.existsSync(filePath)) {
    return [];
  }

  const workbook = XLSX.readFile(filePath, { raw: false });
  const firstSheetName = workbook.SheetNames[0];
  const sheet = workbook.Sheets[firstSheetName];
  return XLSX.utils.sheet_to_json<CsvRow>(sheet, {
    defval: '',
    raw: false,
  });
}

function isActive(row: SourceRow): boolean {
  const petroStatus = normalize(row.petro_ninja_well_status).toLowerCase();
  const wellStatus = normalize(row.well_status).toLowerCase();

  if (petroStatus === 'active') return true;
  return ['active', 'pumping', 'flowing', 'producing', 'operating'].includes(wellStatus);
}

function classifyFluid(row: SourceRow): FluidClass {
  const fluid = [
    normalize(row.petro_ninja_well_fluid),
    normalize(row.well_fluid),
    normalize(row.well_symbol_name),
  ]
    .join(' ')
    .toLowerCase();

  if (fluid.includes('bitumen') || fluid.includes('oil') || fluid.includes('crude')) {
    return 'oil';
  }

  if (fluid.includes('gas') || fluid.includes('condensate')) {
    return 'gas';
  }

  return 'other';
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

function incrementMap(map: Map<string, number>, key: string): void {
  map.set(key, (map.get(key) ?? 0) + 1);
}

function toSortedArray(summaries: Map<string, OperatorSummary>): OutputRow[] {
  return [...summaries.values()]
    .map((summary) => {
      const provinces = [...summary.provinces].sort().join('|');
      const topFormations = [...summary.formationLabels.entries()]
        .sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0]))
        .slice(0, 5)
        .map(([label, count]) => `${label} (${count})`)
        .join('; ');

      return {
        operator: summary.operator,
        suggested_username: summary.suggestedUsername,
        total_wells: summary.totalWells,
        clearwater_wells: summary.clearwaterWells,
        bluesky_wells: summary.blueskyWells,
        oil_wells: summary.oilWells,
        gas_wells: summary.gasWells,
        other_wells: summary.otherWells,
        target_segment:
          summary.oilWells > 0 ? 'oil-target' : summary.gasWells > 0 ? 'gas-only-review' : 'manual-review',
        provinces,
        top_formations: topFormations,
        sample_well_id: summary.sampleWellId ?? '',
        sample_well_name: summary.sampleWellName ?? '',
      };
    })
    .sort((a, b) => {
      if (Number(b.oil_wells) !== Number(a.oil_wells)) {
        return Number(b.oil_wells) - Number(a.oil_wells);
      }
      if (Number(b.total_wells) !== Number(a.total_wells)) {
        return Number(b.total_wells) - Number(a.total_wells);
      }
      return String(a.operator).localeCompare(String(b.operator));
    });
}

function writeCsv(outputPath: string, rows: OutputRow[]): void {
  if (rows.length === 0) {
    fs.writeFileSync(outputPath, '', 'utf8');
    return;
  }

  const headers = Object.keys(rows[0]);
  const lines = [
    headers.map(csvEscape).join(','),
    ...rows.map((row) => headers.map((header) => csvEscape(row[header] ?? '')).join(',')),
  ];
  fs.writeFileSync(outputPath, `${lines.join('\n')}\n`, 'utf8');
}

function isRecommendedPilot(row: OutputRow): boolean {
  const totalWells = Number(row.total_wells);
  const oilWells = Number(row.oil_wells);
  return (
    row.operator !== 'Obsidian Energy Ltd.' &&
    row.target_segment === 'oil-target' &&
    oilWells > 0 &&
    totalWells >= 10 &&
    totalWells <= 150
  );
}

function readExistingRolloutManifest(filePath: string): Map<string, CsvRow> {
  return new Map(
    parseCsvRows(filePath)
      .filter((row) => normalize(row.operator_slug))
      .map((row) => [normalize(row.operator_slug), row]),
  );
}

function buildRolloutManifestRows(inventoryRows: OutputRow[], rolloutManifestPath: string): OutputRow[] {
  const existingRows = readExistingRolloutManifest(rolloutManifestPath);

  return inventoryRows.map((row) => {
    const operatorSlug = String(row.suggested_username);
    const existing = existingRows.get(operatorSlug);
    const isObsidian = row.operator === 'Obsidian Energy Ltd.';

    return {
      operator_slug: operatorSlug,
      source_operator_name: String(row.operator),
      username: normalize(existing?.username) || operatorSlug,
      login_email: `${normalize(existing?.username) || operatorSlug}@wellfi.local`,
      target_segment: String(row.target_segment),
      total_wells: Number(row.total_wells),
      oil_wells: Number(row.oil_wells),
      clearwater_wells: Number(row.clearwater_wells),
      bluesky_wells: Number(row.bluesky_wells),
      recommended_pilot: isRecommendedPilot(row) ? 'yes' : '',
      pilot_flag: normalize(existing?.pilot_flag),
      onboarding_status: normalize(existing?.onboarding_status) || (isObsidian ? 'ready' : 'planned'),
      import_status: normalize(existing?.import_status) || (isObsidian ? 'imported' : 'pending'),
      smoke_test_status: normalize(existing?.smoke_test_status) || (isObsidian ? 'passed' : 'pending'),
      notes:
        normalize(existing?.notes) ||
        (isObsidian ? 'Legacy rich workflow already onboarded.' : ''),
    };
  });
}

function buildLoginManifestRows(inventoryRows: OutputRow[]): OutputRow[] {
  return inventoryRows.map((row) => ({
    operator: row.operator,
    suggested_username: row.suggested_username,
    login_email: `${row.suggested_username}@wellfi.local`,
    role: 'viewer',
    target_segment: row.target_segment,
    total_wells: row.total_wells,
    oil_wells: row.oil_wells,
    clearwater_wells: row.clearwater_wells,
    bluesky_wells: row.bluesky_wells,
    onboarding_status: row.operator === 'Obsidian Energy Ltd.' ? 'ready' : 'planned',
    password_source: 'env:WELLFI_DEFAULT_COMPANY_PASSWORD',
  }));
}

function buildMarkdownSummary(
  sourceRowCount: number,
  activeRowCount: number,
  uniqueOperators: number,
  oilTargetOperators: number,
  provinceCounts: Map<string, number>,
  inventoryRows: OutputRow[],
  rolloutRows: OutputRow[],
): string {
  const provinceSummary = [...provinceCounts.entries()]
    .sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0]))
    .map(([province, count]) => `- ${province || 'UNKNOWN'}: ${count}`)
    .join('\n');

  const topRows = inventoryRows.slice(0, 20).map((row) => {
    return `| ${row.operator} | ${row.total_wells} | ${row.oil_wells} | ${row.clearwater_wells} | ${row.bluesky_wells} | ${row.target_segment} |`;
  });

  const pilotRows = rolloutRows
    .filter((row) => row.recommended_pilot === 'yes')
    .slice(0, 10)
    .map((row) => `| ${row.source_operator_name} | ${row.total_wells} | ${row.oil_wells} | ${row.recommended_pilot} |`);

  return [
    '# Clearwater / Bluesky Operator Inventory',
    '',
    '## Snapshot',
    `- Source rows: ${sourceRowCount}`,
    `- Active rows kept: ${activeRowCount}`,
    `- Unique operators: ${uniqueOperators}`,
    `- Oil-target operators: ${oilTargetOperators}`,
    '',
    '## Province Coverage',
    provinceSummary || '- No province data found',
    '',
    '## Top Operators',
    '| Operator | Total Wells | Oil Wells | Clearwater | Bluesky | Segment |',
    '| --- | ---: | ---: | ---: | ---: | --- |',
    ...topRows,
    '',
    '## Recommended Pilot Candidates',
    '| Operator | Total Wells | Oil Wells | Suggested |',
    '| --- | ---: | ---: | --- |',
    ...(pilotRows.length > 0 ? pilotRows : ['| None | 0 | 0 | no |']),
    '',
    '## Notes',
    '- Machine outputs are regenerated from `Data/active_bluesky_clearwater_wells_AB_SK.csv`.',
    '- `Data/operator_rollout_manifest_clearwater_bluesky.csv` is the editable onboarding file; manual status fields are preserved across reruns.',
    '- `oil-target` means the operator has at least one oil or bitumen well in the source file.',
    '- `gas-only-review` means the operator appears in the basin file but currently looks gas-weighted and should be reviewed before outreach.',
  ].join('\n');
}

function main() {
  const options = parseArgs(process.argv.slice(2));
  const inventoryCsvPath = path.join(options.outputDir, INVENTORY_CSV_PATH);
  const inventoryJsonPath = path.join(options.outputDir, INVENTORY_JSON_PATH);
  const inventoryMdPath = path.join(options.outputDir, INVENTORY_MD_PATH);
  const loginManifestCsvPath = path.join(options.outputDir, LOGIN_MANIFEST_CSV_PATH);
  const rolloutManifestCsvPath = path.join(options.outputDir, ROLLOUT_MANIFEST_CSV_PATH);

  if (!fs.existsSync(options.inputPath)) {
    throw new Error(`Input file not found: ${options.inputPath}`);
  }

  fs.mkdirSync(options.outputDir, { recursive: true });

  const rows = parseRows(options.inputPath);
  const activeRows = rows.filter(isActive);
  const provinceCounts = new Map<string, number>();
  const summaries = new Map<string, OperatorSummary>();

  for (const row of activeRows) {
    const operator = normalize(row.operator) || 'UNKNOWN OPERATOR';
    const province = normalize(row.province);
    const formationLabel = normalize(row.producing_formation) || 'UNKNOWN';
    const fluidClass = classifyFluid(row);

    incrementMap(provinceCounts, province || 'UNKNOWN');

    let summary = summaries.get(operator);
    if (!summary) {
      summary = {
        operator,
        suggestedUsername: slugifyOperator(operator),
        totalWells: 0,
        clearwaterWells: 0,
        blueskyWells: 0,
        oilWells: 0,
        gasWells: 0,
        otherWells: 0,
        provinces: new Set<string>(),
        formationLabels: new Map<string, number>(),
        sampleWellName: normalize(row.well_name) || null,
        sampleWellId: normalize(row.well_id || row.formatted_well_id) || null,
      };
      summaries.set(operator, summary);
    }

    summary.totalWells += 1;
    if (formationLabel.toLowerCase().includes('clearwater')) summary.clearwaterWells += 1;
    if (formationLabel.toLowerCase().includes('bluesky')) summary.blueskyWells += 1;
    if (fluidClass === 'oil') summary.oilWells += 1;
    if (fluidClass === 'gas') summary.gasWells += 1;
    if (fluidClass === 'other') summary.otherWells += 1;
    if (province) summary.provinces.add(province);
    incrementMap(summary.formationLabels, formationLabel);
  }

  const inventoryRows = toSortedArray(summaries);
  const rolloutManifestRows = buildRolloutManifestRows(inventoryRows, rolloutManifestCsvPath);
  const loginManifestRows = buildLoginManifestRows(inventoryRows);

  const inventoryJson = {
    generated_at: new Date().toISOString(),
    source_file: options.inputPath,
    source_row_count: rows.length,
    active_row_count: activeRows.length,
    unique_operator_count: inventoryRows.length,
    oil_target_operator_count: inventoryRows.filter((row) => row.target_segment === 'oil-target').length,
    province_counts: Object.fromEntries(provinceCounts),
    operators: inventoryRows,
  };

  writeCsv(inventoryCsvPath, inventoryRows);
  writeCsv(loginManifestCsvPath, loginManifestRows);
  writeCsv(rolloutManifestCsvPath, rolloutManifestRows);
  fs.writeFileSync(inventoryJsonPath, `${JSON.stringify(inventoryJson, null, 2)}\n`, 'utf8');
  fs.writeFileSync(
    inventoryMdPath,
    `${buildMarkdownSummary(
      rows.length,
      activeRows.length,
      inventoryRows.length,
      inventoryRows.filter((row) => row.target_segment === 'oil-target').length,
      provinceCounts,
      inventoryRows,
      rolloutManifestRows,
    )}\n`,
    'utf8',
  );

  diag(`Wrote ${inventoryCsvPath}`);
  diag(`Wrote ${loginManifestCsvPath}`);
  diag(`Wrote ${rolloutManifestCsvPath}`);
  diag(`Wrote ${inventoryJsonPath}`);
  diag(`Wrote ${inventoryMdPath}`);

  process.stdout.write(
    `${JSON.stringify(
      {
        generatedAt: inventoryJson.generated_at,
        sourceFile: options.inputPath,
        outputDir: options.outputDir,
        sourceRowCount: rows.length,
        activeRowCount: activeRows.length,
        uniqueOperatorCount: inventoryRows.length,
        oilTargetOperatorCount: inventoryRows.filter((row) => row.target_segment === 'oil-target').length,
        recommendedPilotCount: rolloutManifestRows.filter((row) => row.recommended_pilot === 'yes').length,
        outputs: {
          inventoryCsv: inventoryCsvPath,
          inventoryJson: inventoryJsonPath,
          inventoryMarkdown: inventoryMdPath,
          loginManifestCsv: loginManifestCsvPath,
          rolloutManifestCsv: rolloutManifestCsvPath,
        },
      },
      null,
      2,
    )}\n`,
  );
}

try {
  main();
} catch (error: unknown) {
  process.stderr.write(`${error instanceof Error ? error.message : String(error)}\n`);
  process.exit(1);
}
