import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

import { createClient, type SupabaseClient } from '@supabase/supabase-js';
import XLSX from 'xlsx';
import { loadScriptEnv } from './load_script_env.js';
import { dedupeMonthlySnapshotRows } from './monthly_snapshot.js';

export interface SourceRow {
  uwi?: string;
  well_name?: string;
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

export interface RolloutRow {
  operator_slug?: string;
  source_operator_name?: string;
}

export interface BasinImportRow {
  well_id: string;
  formatted_id: null;
  name: string | null;
  lat: number;
  lon: number;
  formation: 'Bluesky' | 'Clearwater' | null;
  field: string | null;
  well_status: 'Pumping' | 'Operating' | 'Suspended' | 'Abandoned';
  risk_level: 'NO DATA';
  months_running: null;
  dec_rate_bbl_d: number | null;
  total_2025_bbl: null;
  cumulative_oil: number | null;
  on_production_date: string | null;
  last_production_date: string | null;
  annual_uptime_pct: null;
  total_downtime_days: null;
  monthly_hrs: null;
  monthly_oil: null;
  monthly_uptime: null;
  status_note: string;
}

export interface PreparedOperatorImport {
  operatorSlug: string;
  sourceOperatorName: string;
  sourcePath: string;
  manifestPath: string;
  matchedSourceRows: number;
  activeRows: number;
  duplicateSnapshotRowsCollapsed: number;
  duplicateSnapshotWellCount: number;
  sampleDuplicateSnapshotWellIds: string[];
  importRows: BasinImportRow[];
  snapshotWellIds: string[];
  skippedRows: string[];
}

export interface AppliedOperatorImport extends PreparedOperatorImport {
  dryRun: boolean;
  status: 'synced' | 'dry-run' | 'skipped-unprovisioned';
  writeMode: 'update-production-and-zero-missing';
  dbDiffAvailable: boolean;
  operatorId: string | null;
  existingOperatorWellCount: number;
  insertedWellIds: string[];
  updatedWellIds: string[];
  newSnapshotWellIds: string[];
  crossOperatorSnapshotWellIds: string[];
  missingFromSnapshotWellIds: string[];
}

export interface PrepareOperatorImportOptions {
  operatorSlug: string;
  sourceRows: SourceRow[];
  manifestRows: RolloutRow[];
  sourcePath: string;
  manifestPath: string;
  allowEmptySnapshot?: boolean;
}

export interface ApplyOperatorImportOptions {
  dryRun?: boolean;
  logger?: (message: string) => void;
  supabase?: SupabaseClient;
  allowUnprovisionedSkip?: boolean;
  snapshotMonth?: string | null;
  insertNewSnapshotWells?: boolean;
}

export interface UnmappedSnapshotOperator {
  sourceOperatorName: string;
  operatorSlug: string;
  matchedRows: number;
}

interface ExistingWellOwnerRow {
  well_id: string | null;
  operator_id: string | null;
  formatted_id: string | null;
  name: string | null;
  lat: number | null;
  lon: number | null;
  formation: BasinImportRow['formation'];
  field: string | null;
  well_status: BasinImportRow['well_status'] | null;
  risk_level: BasinImportRow['risk_level'] | null;
  months_running: number | null;
  dec_rate_bbl_d: number | null;
  total_2025_bbl: number | null;
  cumulative_oil: number | null;
  on_production_date: string | null;
  last_production_date: string | null;
  annual_uptime_pct: number | null;
  total_downtime_days: number | null;
  monthly_hrs: number[] | null;
  monthly_oil: number[] | null;
  monthly_uptime: number[] | null;
  status_note: string | null;
  latest_production_snapshot_month: string | null;
  latest_production_snapshot_status: 'present' | 'missing' | 'unknown' | null;
}

interface ExistingOperatorWellRow {
  well_id: string | null;
}

type ProductionOnlySyncRow = Pick<
  BasinImportRow,
  | 'well_id'
  | 'dec_rate_bbl_d'
  | 'cumulative_oil'
  | 'last_production_date'
> & {
  latest_production_snapshot_month: string | null;
  latest_production_snapshot_status: 'present' | 'missing';
};

type InsertableWellRow = {
  well_id: string;
  formatted_id: string | null;
  name: string | null;
  lat: number;
  lon: number;
  formation: BasinImportRow['formation'];
  field: string | null;
  well_status: BasinImportRow['well_status'];
  risk_level: BasinImportRow['risk_level'];
  months_running: number | null;
  dec_rate_bbl_d: number | null;
  total_2025_bbl: number | null;
  cumulative_oil: number | null;
  on_production_date: string | null;
  last_production_date: string | null;
  annual_uptime_pct: number | null;
  total_downtime_days: number | null;
  monthly_hrs: number[] | null;
  monthly_oil: number[] | null;
  monthly_uptime: number[] | null;
  status_note: string | null;
  operator_id: string;
  latest_production_snapshot_month: string | null;
  latest_production_snapshot_status: 'present' | 'missing' | 'unknown';
};

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

export const DEFAULT_SOURCE_PATH = path.resolve(
  __dirname,
  '..',
  '..',
  '..',
  'Data',
  'active_clearwater_bluesky_recent_prod_ab_sk.csv',
);

export const DEFAULT_MANIFEST_PATH = path.resolve(
  __dirname,
  '..',
  '..',
  '..',
  'Data',
  'operator_rollout_manifest_clearwater_bluesky.csv',
);

export const OPERATOR_SLUG_ALIASES: Record<string, string> = {
  'canadian-natural-upgrading-limited': 'canadian-natural-resources-limited',
};

loadScriptEnv();

function normalize(value: unknown): string {
  return String(value ?? '').trim();
}

export function slugifyOperator(operator: string): string {
  return operator
    .toLowerCase()
    .replace(/&/g, ' and ')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
    .replace(/-{2,}/g, '-')
    .slice(0, 40);
}

function parseRows<T>(filePath: string): T[] {
  const workbook = XLSX.readFile(filePath, { raw: true });
  const firstSheetName = workbook.SheetNames[0];
  const sheet = workbook.Sheets[firstSheetName];
  return XLSX.utils.sheet_to_json<T>(sheet, {
    defval: '',
    raw: true,
  });
}

export function loadSourceRows(sourcePath: string): SourceRow[] {
  return parseRows<SourceRow>(sourcePath);
}

export function loadManifestRows(manifestPath: string): RolloutRow[] {
  return parseRows<RolloutRow>(manifestPath);
}

function matchOperatorSlug(operatorName: string): string {
  const operatorNameSlug = slugifyOperator(operatorName);
  return OPERATOR_SLUG_ALIASES[operatorNameSlug] ?? operatorNameSlug;
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

  const isoMatch = text.match(/^(\d{4})-(\d{2})-(\d{2})$/);
  if (isoMatch) {
    return `${isoMatch[1]}-${isoMatch[2]}-${isoMatch[3]}`;
  }

  const slashMatch = text.match(/^(\d{1,2})\/(\d{1,2})\/(\d{2}|\d{4})$/);
  if (slashMatch) {
    const month = Number(slashMatch[1]);
    const day = Number(slashMatch[2]);
    let year = Number(slashMatch[3]);
    if (slashMatch[3].length === 2) {
      year += 2000;
      const currentYear = new Date().getUTCFullYear();
      if (year > currentYear + 1) {
        year -= 100;
      }
    }

    const utcDate = new Date(Date.UTC(year, month - 1, day));
    if (!Number.isNaN(utcDate.getTime())) {
      return utcDate.toISOString().slice(0, 10);
    }
  }

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

function buildImportRows(activeRows: SourceRow[]): { importRows: BasinImportRow[]; skippedRows: string[] } {
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
        name: normalize(row.well_name) || null,
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
        status_note: 'Imported from Clearwater / Bluesky basin snapshot.',
      },
    ];
  });

  return { importRows, skippedRows };
}

export function findUnmappedSnapshotOperators(
  sourceRows: SourceRow[],
  manifestRows: RolloutRow[],
): UnmappedSnapshotOperator[] {
  const manifestSlugs = new Set(
    manifestRows
      .map((row) => normalize(row.operator_slug))
      .filter(Boolean),
  );

  const counts = new Map<string, { sourceOperatorName: string; matchedRows: number }>();

  for (const row of sourceRows) {
    const sourceOperatorName = normalize(row.operator_licensee);
    if (!sourceOperatorName) continue;

    const operatorSlug = matchOperatorSlug(sourceOperatorName);
    const existing = counts.get(operatorSlug);
    if (existing) {
      existing.matchedRows += 1;
    } else {
      counts.set(operatorSlug, {
        sourceOperatorName,
        matchedRows: 1,
      });
    }
  }

  return [...counts.entries()]
    .filter(([operatorSlug]) => !manifestSlugs.has(operatorSlug))
    .map(([operatorSlug, value]) => ({
      sourceOperatorName: value.sourceOperatorName,
      operatorSlug,
      matchedRows: value.matchedRows,
    }))
    .sort((left, right) => right.matchedRows - left.matchedRows || left.operatorSlug.localeCompare(right.operatorSlug));
}

export function prepareOperatorImport(options: PrepareOperatorImportOptions): PreparedOperatorImport {
  const rolloutRow = options.manifestRows.find(
    (row) => normalize(row.operator_slug) === options.operatorSlug,
  );

  if (!rolloutRow) {
    throw new Error(`Operator ${options.operatorSlug} was not found in ${options.manifestPath}`);
  }

  const sourceOperatorName = normalize(rolloutRow.source_operator_name);
  if (!sourceOperatorName) {
    throw new Error(`Manifest row for ${options.operatorSlug} is missing source_operator_name`);
  }

  const matchedSourceRows = options.sourceRows.filter((row) => {
    const operatorName = normalize(row.operator_licensee);
    return operatorName === sourceOperatorName || matchOperatorSlug(operatorName) === options.operatorSlug;
  });

  const activeRows = matchedSourceRows.filter(isActive);
  const {
    rows: dedupedActiveRows,
    summary: dedupeSummary,
  } = dedupeMonthlySnapshotRows(activeRows);

  if (!options.allowEmptySnapshot) {
    if (matchedSourceRows.length === 0) {
      throw new Error(`No source rows matched ${sourceOperatorName} in ${options.sourcePath}`);
    }

    if (activeRows.length === 0) {
      throw new Error(`No active source rows matched ${sourceOperatorName} in ${options.sourcePath}`);
    }
  }

  const { importRows, skippedRows } = buildImportRows(dedupedActiveRows);
  const snapshotWellIds = [...new Set(importRows.map((row) => row.well_id))];

  return {
    operatorSlug: options.operatorSlug,
    sourceOperatorName,
    sourcePath: options.sourcePath,
    manifestPath: options.manifestPath,
    matchedSourceRows: matchedSourceRows.length,
    activeRows: activeRows.length,
    duplicateSnapshotRowsCollapsed: dedupeSummary.duplicateRowsCollapsed,
    duplicateSnapshotWellCount: dedupeSummary.duplicateWellCount,
    sampleDuplicateSnapshotWellIds: dedupeSummary.sampleDuplicateWellIds,
    importRows,
    snapshotWellIds,
    skippedRows,
  };
}

function getDefaultWriteMode(): AppliedOperatorImport['writeMode'] {
  return 'update-production-and-zero-missing';
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

function shouldAttachSupabase(dryRun: boolean): boolean {
  if (!dryRun) return true;
  return Boolean((process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL) && process.env.SUPABASE_SERVICE_ROLE_KEY);
}

async function resolveOperatorId(
  supabase: SupabaseClient,
  operatorSlug: string,
): Promise<string | null> {
  const { data, error } = await supabase
    .from('operators')
    .select('id')
    .eq('slug', operatorSlug)
    .maybeSingle();

  if (error) {
    throw error;
  }

  return data?.id ?? null;
}

async function fetchExistingOperatorWellIds(
  supabase: SupabaseClient,
  operatorId: string,
): Promise<string[]> {
  const rows: ExistingOperatorWellRow[] = [];
  const batchSize = 1000;

  for (let index = 0; ; index += batchSize) {
    const { data, error } = await supabase
      .from('wells')
      .select('well_id')
      .eq('operator_id', operatorId)
      .range(index, index + batchSize - 1);

    if (error) {
      throw error;
    }

    const batch = (data as ExistingOperatorWellRow[] | null ?? []);
    rows.push(...batch);

    if (batch.length < batchSize) {
      break;
    }
  }

  return rows
    .map((row) => normalize(row.well_id))
    .filter(Boolean);
}

async function fetchExistingWellOwners(
  supabase: SupabaseClient,
  wellIds: string[],
): Promise<Map<string, ExistingWellOwnerRow>> {
  const result = new Map<string, ExistingWellOwnerRow>();

  if (wellIds.length === 0) {
    return result;
  }

  const batchSize = 200;
  for (let index = 0; index < wellIds.length; index += batchSize) {
    const batch = wellIds.slice(index, index + batchSize);
    const { data, error } = await supabase
      .from('wells')
      .select([
        'well_id',
        'operator_id',
        'formatted_id',
        'name',
        'lat',
        'lon',
        'formation',
        'field',
        'well_status',
        'risk_level',
        'months_running',
        'dec_rate_bbl_d',
        'total_2025_bbl',
        'cumulative_oil',
        'on_production_date',
        'last_production_date',
        'annual_uptime_pct',
        'total_downtime_days',
        'monthly_hrs',
        'monthly_oil',
        'monthly_uptime',
        'status_note',
        'latest_production_snapshot_month',
        'latest_production_snapshot_status',
      ].join(', '))
      .in('well_id', batch);

    if (error) {
      throw error;
    }

    for (const row of (data as ExistingWellOwnerRow[] | null ?? [])) {
      const wellId = normalize(row.well_id);
      if (wellId) {
        result.set(wellId, {
          well_id: wellId,
          operator_id: row.operator_id ?? null,
          formatted_id: row.formatted_id ?? null,
          name: row.name ?? null,
          lat: row.lat ?? null,
          lon: row.lon ?? null,
          formation: row.formation ?? null,
          field: row.field ?? null,
          well_status: row.well_status ?? null,
          risk_level: row.risk_level ?? null,
          months_running: row.months_running ?? null,
          dec_rate_bbl_d: row.dec_rate_bbl_d ?? null,
          total_2025_bbl: row.total_2025_bbl ?? null,
          cumulative_oil: row.cumulative_oil ?? null,
          on_production_date: row.on_production_date ?? null,
          last_production_date: row.last_production_date ?? null,
          annual_uptime_pct: row.annual_uptime_pct ?? null,
          total_downtime_days: row.total_downtime_days ?? null,
          monthly_hrs: row.monthly_hrs ?? null,
          monthly_oil: row.monthly_oil ?? null,
          monthly_uptime: row.monthly_uptime ?? null,
          status_note: row.status_note ?? null,
          latest_production_snapshot_month: row.latest_production_snapshot_month ?? null,
          latest_production_snapshot_status: row.latest_production_snapshot_status ?? null,
        });
      }
    }
  }

  return result;
}

function toPresentSnapshotSyncRow(
  row: BasinImportRow,
  snapshotMonth: string | null,
): ProductionOnlySyncRow {
  return {
    well_id: row.well_id,
    dec_rate_bbl_d: row.dec_rate_bbl_d,
    cumulative_oil: row.cumulative_oil,
    last_production_date: row.last_production_date,
    latest_production_snapshot_month: snapshotMonth,
    latest_production_snapshot_status: 'present',
  };
}

function toMissingSnapshotSyncRow(
  wellId: string,
  snapshotMonth: string | null,
): ProductionOnlySyncRow {
  return {
    well_id: wellId,
    dec_rate_bbl_d: 0,
    cumulative_oil: null,
    last_production_date: null,
    latest_production_snapshot_month: snapshotMonth,
    latest_production_snapshot_status: 'missing',
  };
}

function toInsertableWellRow(
  row: BasinImportRow,
  operatorId: string,
  snapshotMonth: string | null,
): InsertableWellRow {
  return {
    well_id: row.well_id,
    formatted_id: row.formatted_id,
    name: row.name,
    lat: row.lat,
    lon: row.lon,
    formation: row.formation,
    field: row.field,
    well_status: row.well_status,
    risk_level: row.risk_level,
    months_running: row.months_running,
    dec_rate_bbl_d: row.dec_rate_bbl_d,
    total_2025_bbl: row.total_2025_bbl,
    cumulative_oil: row.cumulative_oil,
    on_production_date: row.on_production_date,
    last_production_date: row.last_production_date,
    annual_uptime_pct: row.annual_uptime_pct,
    total_downtime_days: row.total_downtime_days,
    monthly_hrs: null,
    monthly_oil: null,
    monthly_uptime: null,
    status_note: row.status_note,
    operator_id: operatorId,
    latest_production_snapshot_month: snapshotMonth,
    latest_production_snapshot_status: 'present',
  };
}

async function applyProductionUpdatesInBatches(
  supabase: SupabaseClient,
  rows: ProductionOnlySyncRow[],
): Promise<void> {
  const batchSize = 200;
  for (let index = 0; index < rows.length; index += batchSize) {
    const batch = rows.slice(index, index + batchSize);
    const { error } = await supabase
      .rpc('apply_monthly_production_updates', { payload: batch });

    if (error) {
      throw error;
    }
  }
}

async function upsertWellsInBatches(
  supabase: SupabaseClient,
  rows: InsertableWellRow[],
): Promise<void> {
  const batchSize = 200;
  for (let index = 0; index < rows.length; index += batchSize) {
    const batch = rows.slice(index, index + batchSize);
    const { error } = await supabase
      .from('wells')
      .upsert(batch, { onConflict: 'well_id' });

    if (error) {
      throw error;
    }
  }
}

function toNameBackfillWellRow(
  existingRow: ExistingWellOwnerRow,
  name: string,
): InsertableWellRow {
  if (existingRow.operator_id == null || existingRow.lat == null || existingRow.lon == null) {
    throw new Error(`Cannot backfill well name for ${existingRow.well_id ?? 'unknown'} because the current row is incomplete.`);
  }

  return {
    well_id: normalize(existingRow.well_id),
    formatted_id: existingRow.formatted_id,
    name,
    lat: existingRow.lat,
    lon: existingRow.lon,
    formation: existingRow.formation,
    field: existingRow.field,
    well_status: existingRow.well_status ?? 'Operating',
    risk_level: existingRow.risk_level ?? 'NO DATA',
    months_running: existingRow.months_running,
    dec_rate_bbl_d: existingRow.dec_rate_bbl_d,
    total_2025_bbl: existingRow.total_2025_bbl,
    cumulative_oil: existingRow.cumulative_oil,
    on_production_date: existingRow.on_production_date,
    last_production_date: existingRow.last_production_date,
    annual_uptime_pct: existingRow.annual_uptime_pct,
    total_downtime_days: existingRow.total_downtime_days,
    monthly_hrs: existingRow.monthly_hrs,
    monthly_oil: existingRow.monthly_oil,
    monthly_uptime: existingRow.monthly_uptime,
    status_note: existingRow.status_note,
    operator_id: existingRow.operator_id,
    latest_production_snapshot_month: existingRow.latest_production_snapshot_month,
    latest_production_snapshot_status: existingRow.latest_production_snapshot_status ?? 'unknown',
  };
}

export async function applyOperatorImport(
  prepared: PreparedOperatorImport,
  options: ApplyOperatorImportOptions = {},
): Promise<AppliedOperatorImport> {
  const dryRun = options.dryRun ?? false;
  const writeMode = getDefaultWriteMode();
  const snapshotMonth = options.snapshotMonth ?? null;
  const logger = options.logger ?? (() => {});
  const baseResult: AppliedOperatorImport = {
    ...prepared,
    dryRun,
    status: dryRun ? 'dry-run' : 'synced',
    writeMode,
    dbDiffAvailable: false,
    operatorId: null,
    existingOperatorWellCount: 0,
    insertedWellIds: [],
    updatedWellIds: [],
    newSnapshotWellIds: [],
    crossOperatorSnapshotWellIds: [],
    missingFromSnapshotWellIds: [],
  };

  const supabase =
    options.supabase ??
    (shouldAttachSupabase(dryRun) ? getSupabaseAdminClient() : null);

  if (!supabase) {
    return baseResult;
  }

  const operatorId = await resolveOperatorId(supabase, prepared.operatorSlug);
  if (!operatorId) {
    if (options.allowUnprovisionedSkip) {
      return {
        ...baseResult,
        status: 'skipped-unprovisioned',
      };
    }
    throw new Error(`Operator ${prepared.operatorSlug} is not provisioned in Supabase yet`);
  }

  const existingOperatorWellIds = await fetchExistingOperatorWellIds(supabase, operatorId);
  const existingSnapshotOwners = await fetchExistingWellOwners(supabase, prepared.snapshotWellIds);
  const snapshotWellIdSet = new Set(prepared.snapshotWellIds);

  const missingFromSnapshotWellIds = existingOperatorWellIds.filter(
    (wellId) => !snapshotWellIdSet.has(wellId),
  );

  const updateRows: ProductionOnlySyncRow[] = [];
  const insertRows: InsertableWellRow[] = [];
  const nameBackfillRows: InsertableWellRow[] = [];
  const insertedWellIds: string[] = [];
  const updatedWellIds: string[] = [];
  const newSnapshotWellIds: string[] = [];
  const crossOperatorSnapshotWellIds: string[] = [];

  for (const row of prepared.importRows) {
    const existingSnapshotWell = existingSnapshotOwners.get(row.well_id);
    const existingOwnerId = existingSnapshotWell?.operator_id ?? null;

    if (!existingSnapshotOwners.has(row.well_id)) {
      newSnapshotWellIds.push(row.well_id);
      if (options.insertNewSnapshotWells) {
        insertRows.push(toInsertableWellRow(row, operatorId, snapshotMonth));
        insertedWellIds.push(row.well_id);
      }
      continue;
    }

    if (existingOwnerId !== operatorId) {
      crossOperatorSnapshotWellIds.push(row.well_id);
      continue;
    }

    if (!normalize(existingSnapshotWell?.name) && normalize(row.name)) {
      nameBackfillRows.push(toNameBackfillWellRow(existingSnapshotWell, row.name as string));
    }

    updateRows.push(toPresentSnapshotSyncRow(row, snapshotMonth));
    updatedWellIds.push(row.well_id);
  }

  for (const wellId of missingFromSnapshotWellIds) {
    updateRows.push(toMissingSnapshotSyncRow(wellId, snapshotMonth));
  }

  logger(
    [
      `${prepared.operatorSlug}: matched=${prepared.matchedSourceRows}`,
      `active=${prepared.activeRows}`,
      `import=${prepared.importRows.length}`,
      `deduped=${prepared.duplicateSnapshotRowsCollapsed}`,
      `new_snapshot=${newSnapshotWellIds.length}`,
      `insert=${insertedWellIds.length}`,
      `name_backfill=${nameBackfillRows.length}`,
      `cross_operator=${crossOperatorSnapshotWellIds.length}`,
      `update=${updatedWellIds.length}`,
      `zeroed_missing=${missingFromSnapshotWellIds.length}`,
      `mode=${writeMode}`,
    ].join(' '),
  );

  if (!dryRun) {
    if (insertRows.length > 0) {
      await upsertWellsInBatches(supabase, insertRows);
    }
    if (nameBackfillRows.length > 0) {
      await upsertWellsInBatches(supabase, nameBackfillRows);
    }
    if (updateRows.length > 0) {
      await applyProductionUpdatesInBatches(supabase, updateRows);
    }
  }

  return {
    ...baseResult,
    operatorId,
    dbDiffAvailable: true,
    existingOperatorWellCount: existingOperatorWellIds.length,
    insertedWellIds,
    updatedWellIds,
    newSnapshotWellIds,
    crossOperatorSnapshotWellIds,
    missingFromSnapshotWellIds,
  };
}

export function assertFileExists(filePath: string, label: string): void {
  if (!fs.existsSync(filePath)) {
    throw new Error(`${label} not found: ${filePath}`);
  }
}
