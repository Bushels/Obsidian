# Multi-Operator Tenancy — Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Enable per-company login where each operator sees only their wells on the map, heatmaps, and dashboards.

**Architecture:** Leverage existing multi-tenant RLS (Migration 008), existing provisioning scripts, and per-operator static GeoJSON files loaded by `ProductionGlow.ts` based on auth context. Admin sees combined view with operator selector.

**Tech Stack:** Supabase (RLS, auth), React 19, Mapbox GL JS, TypeScript, Vite, Node.js build scripts

**Design Doc:** `docs/plans/2026-03-18-multi-operator-tenancy-design.md`

---

## Task 1: Verify Existing Infrastructure

**Files:**
- Read: `supabase/migrations/008_multi_operator_tenancy.sql`
- Read: `scripts/provision_operator_users.ts`
- Read: `scripts/import_operator_basin_wells.ts`

**Step 1: Confirm Supabase CLI connectivity**

Run: `cd wellfi-app && npx supabase projects list`
Expected: List of projects including WellFi

**Step 2: Verify operators table has Obsidian**

Run: `npx supabase db execute --project-ref <REF> "SELECT slug, display_name, status FROM operators;"`
Expected: One row — `obsidian-energy-ltd | Obsidian Energy Ltd. | active`

**Step 3: Verify RLS helper functions exist**

Run: `npx supabase db execute --project-ref <REF> "SELECT proname FROM pg_proc WHERE proname LIKE 'current_app_user%';"`
Expected: Three functions — `current_app_user_role`, `current_app_user_operator_id`, `current_app_user_is_admin`

**Step 4: Dry-run provisioning script for one operator**

Run: `cd wellfi-app && tsx scripts/provision_operator_users.ts --operator baytex-energy-ltd --dry-run`
Expected: JSON output with `operatorSpec`, `appUserSpec`, `dryRun: true`

**Step 5: Dry-run import script for one operator**

Run: `tsx scripts/import_operator_basin_wells.ts --operator baytex-energy-ltd --dry-run`
Expected: JSON output with `importRows` count > 0, `dryRun: true`

**Step 6: Commit checkpoint**

```bash
git add -A && git commit -m "chore: verify multi-tenant infrastructure before provisioning"
```

---

## Task 2: Update Import Script to Use Newer CSV

The import script currently reads from the stale `active_bluesky_clearwater_wells_AB_SK.csv` (~Sept 2025). Update it to use `active_clearwater_bluesky_recent_prod_ab_sk.csv` (Jan 2026) which has different column names.

**Files:**
- Modify: `scripts/import_operator_basin_wells.ts`

**Step 1: Compare CSV column names**

Stale CSV columns (from SourceRow interface):
```
operator, well_id, formatted_well_id, well_name, petro_ninja_well_status,
well_status, producing_formation, intersecting_formations, field_name,
surface_latitude, surface_longitude, last_oil_rate, cumulative_oil,
on_production_date, last_production_date
```

New CSV columns (from `active_clearwater_bluesky_recent_prod_ab_sk.csv`):
```
uwi, operator_licensee, producing_formation, field_name, well_status,
well_fluid_type, surface_latitude, surface_longitude, last_oil_production_rate,
cumulative_oil_production, recent_oil, recent_gas, recent_water,
recent_steam_injection, last_production_date, spud_date
```

**Step 2: Update `SourceRow` interface**

In `scripts/import_operator_basin_wells.ts`, update the interface and field mappings:

```typescript
interface SourceRow {
  uwi?: string;                      // was well_id
  operator_licensee?: string;        // was operator
  producing_formation?: string;      // same
  field_name?: string;               // same
  well_status?: string;              // same
  well_fluid_type?: string;          // new
  surface_latitude?: string;         // same
  surface_longitude?: string;        // same
  last_oil_production_rate?: string;  // was last_oil_rate
  cumulative_oil_production?: string; // was cumulative_oil
  recent_oil?: string;               // new
  recent_gas?: string;               // new
  recent_water?: string;             // new
  recent_steam_injection?: string;   // new
  last_production_date?: string;     // same
  spud_date?: string;                // was on_production_date (not quite — spud vs on_prod)
}
```

**Step 3: Update DEFAULT_SOURCE_PATH**

```typescript
const DEFAULT_SOURCE_PATH = path.resolve(
  __dirname, '..', '..', 'Data', 'active_clearwater_bluesky_recent_prod_ab_sk.csv'
);
```

**Step 4: Update field mappings in `importRows` builder**

```typescript
const importRows = activeRows.flatMap((row) => {
  const wellId = normalize(row.uwi);  // was row.well_id
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

  return [{
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
  }];
});
```

**Step 5: Update `isActive` function**

The new CSV doesn't have `petro_ninja_well_status`. Simplify:

```typescript
function isActive(row: SourceRow): boolean {
  const wellStatus = normalize(row.well_status).toLowerCase();
  return ['active', 'pumping', 'flowing', 'producing', 'operating'].includes(wellStatus);
}
```

**Step 6: Update operator matching**

The new CSV uses `operator_licensee` not `operator`. Update the filter:

```typescript
const matchedSourceRows = sourceRows.filter((row) => {
  const operatorName = normalize(row.operator_licensee);  // was row.operator
  return operatorName === sourceOperatorName || slugifyOperator(operatorName) === options.operatorSlug;
});
```

**Step 7: Update `deriveFormation`**

The new CSV has `producing_formation` but not `intersecting_formations`:

```typescript
function deriveFormation(row: SourceRow): 'Bluesky' | 'Clearwater' | null {
  const text = normalize(row.producing_formation).toLowerCase();
  if (text.includes('clearwater')) return 'Clearwater';
  if (text.includes('bluesky')) return 'Bluesky';
  return null;
}
```

**Step 8: Dry-run to verify**

Run: `tsx scripts/import_operator_basin_wells.ts --operator baytex-energy-ltd --dry-run --source ../Data/active_clearwater_bluesky_recent_prod_ab_sk.csv`
Expected: JSON with `importRows > 0`, no errors

**Step 9: Commit**

```bash
git add scripts/import_operator_basin_wells.ts
git commit -m "feat: update import script to use Jan 2026 production CSV"
```

---

## Task 3: Provision Top 15 Operators

**Files:**
- Run: `scripts/provision_operator_users.ts` (15 times)

**Prerequisites:**
- `SUPABASE_URL` or `VITE_SUPABASE_URL` env var set
- `SUPABASE_SERVICE_ROLE_KEY` env var set
- `WELLFI_DEFAULT_COMPANY_PASSWORD` env var set

**Step 1: Set environment variables**

```bash
export SUPABASE_URL="https://<project-ref>.supabase.co"
export SUPABASE_SERVICE_ROLE_KEY="<service-role-key>"
export WELLFI_DEFAULT_COMPANY_PASSWORD="<generic-password>"
```

**Step 2: Provision each operator**

Run this loop (Obsidian already exists — skip it):

```bash
cd wellfi-app

for slug in \
  imperial-oil-resources-limited \
  canadian-natural-resources-limited \
  spur-petroleum-ltd \
  tamarack-valley-energy-ltd \
  baytex-energy-ltd \
  headwater-exploration-inc \
  strathcona-resources-ltd \
  peyto-exploration-and-development-corp \
  cenovus-energy-inc \
  tourmaline-oil-corp \
  rubellite-energy-inc \
  ipc-canada-ltd \
  paramount-resources-ltd \
  clear-north-energy-corp; do
  echo "=== Provisioning $slug ==="
  tsx scripts/provision_operator_users.ts --operator "$slug"
  echo ""
done
```

Expected: For each operator — JSON output with `operatorAction: "upserted"`, `authAction: "created"`, `appUserAction: "created"`

**Step 3: Verify operator count in Supabase**

Run: `npx supabase db execute --project-ref <REF> "SELECT slug, display_name, onboarding_status FROM operators ORDER BY display_name;"`
Expected: 15 rows (14 new + 1 Obsidian)

**Step 4: Test login as one operator**

In browser, go to the app and try logging in as:
- Username: `baytex-energy-ltd`
- Password: `<generic-password>`
Expected: Login succeeds, map loads (though data will be limited until wells are imported)

---

## Task 4: Import Wells for Top 15 Operators

**Files:**
- Run: `scripts/import_operator_basin_wells.ts` (14 times — skip Obsidian)

**Step 1: Import wells for each operator**

```bash
cd wellfi-app

for slug in \
  imperial-oil-resources-limited \
  canadian-natural-resources-limited \
  spur-petroleum-ltd \
  tamarack-valley-energy-ltd \
  baytex-energy-ltd \
  headwater-exploration-inc \
  strathcona-resources-ltd \
  peyto-exploration-and-development-corp \
  cenovus-energy-inc \
  tourmaline-oil-corp \
  rubellite-energy-inc \
  ipc-canada-ltd \
  paramount-resources-ltd \
  clear-north-energy-corp; do
  echo "=== Importing wells for $slug ==="
  tsx scripts/import_operator_basin_wells.ts --operator "$slug"
  echo ""
done
```

Expected: For each operator — JSON with `upsertedRows > 0`

**Step 2: Verify total well count in Supabase**

Run: `npx supabase db execute --project-ref <REF> "SELECT o.display_name, COUNT(w.id) as well_count FROM wells w JOIN operators o ON w.operator_id = o.id GROUP BY o.display_name ORDER BY well_count DESC;"`
Expected: ~9,000+ wells total across 15 operators

**Step 3: Verify RLS isolation**

Log in as `baytex-energy-ltd` and check that `useWells()` only returns Baytex wells. Open browser dev tools > Network and look at the Supabase response — it should only contain wells where operator matches Baytex.

---

## Task 5: Build Per-Operator GeoJSON Split Script

**Files:**
- Create: `scripts/build_operator_geojson.ts`

**Step 1: Write the build script**

```typescript
/**
 * build_operator_geojson.ts
 *
 * Splits the basin production CSV into per-operator GeoJSON files
 * for use by ProductionGlow.ts on the frontend.
 *
 * Output: public/data/operators/{slug}/production.geojson
 *         public/data/operators/_all/production.geojson (combined)
 *
 * Usage: tsx scripts/build_operator_geojson.ts [--input <csv>]
 */
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import XLSX from 'xlsx';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const DEFAULT_INPUT = path.resolve(
  __dirname, '..', '..', 'Data', 'active_clearwater_bluesky_recent_prod_ab_sk.csv',
);
const OUTPUT_BASE = path.resolve(__dirname, '..', 'public', 'data', 'operators');

// CNUL → CNRL merge
const OPERATOR_ALIASES: Record<string, string> = {
  'Canadian Natural Upgrading Limited': 'Canadian Natural Resources Limited',
};

function normalize(value: unknown): string {
  return String(value ?? '').trim();
}

function slugify(operator: string): string {
  return operator
    .toLowerCase()
    .replace(/&/g, ' and ')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
    .replace(/-{2,}/g, '-')
    .slice(0, 40);
}

function parseNumber(value: unknown): number {
  const n = Number(normalize(value));
  return Number.isFinite(n) ? n : 0;
}

interface CsvRow {
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

interface GeoFeature {
  type: 'Feature';
  geometry: { type: 'Point'; coordinates: [number, number] };
  properties: Record<string, string | number>;
}

function deriveFormation(producing: string): string {
  const lower = producing.toLowerCase();
  if (lower.includes('clearwater')) return 'Clearwater';
  if (lower.includes('bluesky')) return 'Bluesky';
  return 'Unknown';
}

function deriveFluidType(wellFluidType: string): string {
  const lower = wellFluidType.toLowerCase();
  if (lower.includes('gas')) return 'gas';
  return 'oil';
}

function main() {
  const inputPath = process.argv.includes('--input')
    ? path.resolve(process.argv[process.argv.indexOf('--input') + 1])
    : DEFAULT_INPUT;

  if (!fs.existsSync(inputPath)) {
    throw new Error(`Input not found: ${inputPath}`);
  }

  const workbook = XLSX.readFile(inputPath, { raw: false });
  const sheet = workbook.Sheets[workbook.SheetNames[0]];
  const rows = XLSX.utils.sheet_to_json<CsvRow>(sheet, { defval: '', raw: false });

  // Group features by operator slug
  const byOperator = new Map<string, GeoFeature[]>();
  const allFeatures: GeoFeature[] = [];
  let skipped = 0;

  for (const row of rows) {
    const lat = parseNumber(row.surface_latitude);
    const lon = parseNumber(row.surface_longitude);
    const uwi = normalize(row.uwi);

    if (!uwi || lat === 0 || lon === 0) {
      skipped++;
      continue;
    }

    const recentOil = parseNumber(row.recent_oil);
    const recentGas = parseNumber(row.recent_gas);

    // Skip zero-production wells
    if (recentOil === 0 && recentGas === 0) {
      skipped++;
      continue;
    }

    let operatorName = normalize(row.operator_licensee);
    operatorName = OPERATOR_ALIASES[operatorName] ?? operatorName;
    const slug = slugify(operatorName);
    const formation = deriveFormation(normalize(row.producing_formation));
    const fluidType = deriveFluidType(normalize(row.well_fluid_type));

    const feature: GeoFeature = {
      type: 'Feature',
      geometry: { type: 'Point', coordinates: [lon, lat] },
      properties: {
        uwi,
        operator: operatorName,
        formation,
        field_name: normalize(row.field_name),
        well_fluid_type: normalize(row.well_fluid_type),
        fluid_type: fluidType,
        well_status: normalize(row.well_status),
        recent_oil: recentOil,
        cumulative_oil: parseNumber(row.cumulative_oil_production),
        recent_gas: recentGas,
        recent_water: parseNumber(row.recent_water),
        recent_steam_injection: parseNumber(row.recent_steam_injection),
        last_production_date: normalize(row.last_production_date),
        spud_date: normalize(row.spud_date),
        op_status: 'normal',
      },
    };

    if (!byOperator.has(slug)) byOperator.set(slug, []);
    byOperator.get(slug)!.push(feature);
    allFeatures.push(feature);
  }

  // Write per-operator GeoJSON files
  let written = 0;
  for (const [slug, features] of byOperator) {
    const dir = path.join(OUTPUT_BASE, slug);
    fs.mkdirSync(dir, { recursive: true });
    const geojson = { type: 'FeatureCollection' as const, features };
    fs.writeFileSync(
      path.join(dir, 'production.geojson'),
      JSON.stringify(geojson),
      'utf8',
    );
    written++;
    process.stderr.write(`  ${slug}: ${features.length} features\n`);
  }

  // Write combined _all file for admin
  const allDir = path.join(OUTPUT_BASE, '_all');
  fs.mkdirSync(allDir, { recursive: true });
  fs.writeFileSync(
    path.join(allDir, 'production.geojson'),
    JSON.stringify({ type: 'FeatureCollection', features: allFeatures }),
    'utf8',
  );

  process.stderr.write(`\nWrote ${written} operator files + _all (${allFeatures.length} features)\n`);
  process.stderr.write(`Skipped ${skipped} rows (missing coords or zero production)\n`);

  process.stdout.write(JSON.stringify({
    inputPath,
    outputBase: OUTPUT_BASE,
    operatorCount: written,
    totalFeatures: allFeatures.length,
    skippedRows: skipped,
    operators: [...byOperator.entries()].map(([slug, f]) => ({
      slug, featureCount: f.length,
    })).sort((a, b) => b.featureCount - a.featureCount),
  }, null, 2) + '\n');
}

main();
```

**Step 2: Run the build script**

Run: `cd wellfi-app && tsx scripts/build_operator_geojson.ts`
Expected: Per-operator directories created under `public/data/operators/`, plus `_all/production.geojson`

**Step 3: Verify output**

Run: `ls -la public/data/operators/ | head -20`
Expected: ~30+ directories (one per operator with non-zero production)

Run: `node -e "const d=JSON.parse(require('fs').readFileSync('public/data/operators/baytex-energy-ltd/production.geojson','utf8'));console.log(d.features.length)"`
Expected: ~465 features

Run: `node -e "const d=JSON.parse(require('fs').readFileSync('public/data/operators/_all/production.geojson','utf8'));console.log(d.features.length)"`
Expected: ~6,932 features

**Step 4: Add `public/data/operators/` to .gitignore**

These are generated files — don't commit them. Add to `.gitignore`:
```
public/data/operators/
```

**Step 5: Add npm script for convenience**

In `package.json` scripts:
```json
"build:operator-geojson": "tsx scripts/build_operator_geojson.ts"
```

**Step 6: Commit**

```bash
git add scripts/build_operator_geojson.ts .gitignore package.json
git commit -m "feat: add per-operator GeoJSON split build script"
```

---

## Task 6: Modify ProductionGlow.ts for Operator Scoping

**Files:**
- Modify: `src/components/map/ProductionGlow.ts:12-13,84-103`

**Step 1: Update the function signature**

Replace the hardcoded `GEOJSON_URL` constant and update `addProductionGlow`:

```typescript
// Remove this line:
// const GEOJSON_URL = '/data/bluesky-clearwater-production.geojson';

// Update function signature:
export async function addProductionGlow(
  map: MapboxMap,
  operatorSlug: string | null,
  isAdmin: boolean,
  beforeLayerId?: string,
): Promise<void> {
  // Skip if source already exists (idempotent)
  if (map.getSource(SOURCE_ID)) return;

  // Determine which GeoJSON to load
  const geojsonUrl = isAdmin || !operatorSlug
    ? '/data/operators/_all/production.geojson'
    : `/data/operators/${operatorSlug}/production.geojson`;

  // Fetch pre-processed GeoJSON
  const response = await fetch(geojsonUrl);
  if (!response.ok) {
    console.warn(`ProductionGlow: failed to load ${geojsonUrl} (${response.status})`);
    return;
  }
  const geojson = await response.json();

  // Guard: map may have been destroyed while fetch was in-flight
  try { map.getStyle(); } catch { return; }
  if (map.getSource(SOURCE_ID)) return; // re-check after async gap

  // Add source
  map.addSource(SOURCE_ID, {
    type: 'geojson',
    data: geojson,
    generateId: true,
  });

  // ... rest of layer additions unchanged
```

**Step 2: Add a `reloadProductionGlow` export**

Add a function to remove and re-add layers when operator context changes (logout/login):

```typescript
/**
 * Remove production layers and source so they can be re-added with a different operator.
 */
export function removeProductionGlow(map: MapboxMap): void {
  const layerIds = [
    LAYER_CW_GAS_HEATMAP, LAYER_BS_GAS_HEATMAP,
    LAYER_CW_HEATMAP, LAYER_BS_HEATMAP, LAYER_DOTS,
  ];
  for (const id of layerIds) {
    if (map.getLayer(id)) map.removeLayer(id);
  }
  if (map.getSource(SOURCE_ID)) map.removeSource(SOURCE_ID);
}
```

**Step 3: Verify TypeScript compiles**

Run: `cd wellfi-app && npx tsc --noEmit`
Expected: Errors about the changed `addProductionGlow` call in `WellMap.tsx` (expected — will fix in Task 7)

**Step 4: Commit**

```bash
git add src/components/map/ProductionGlow.ts
git commit -m "feat: ProductionGlow accepts operator slug for scoped GeoJSON loading"
```

---

## Task 7: Thread Operator Context into WellMap

**Files:**
- Modify: `src/components/map/WellMap.tsx:14-18,162-167`
- Modify: `src/pages/MapPage.tsx` (pass new props)

**Step 1: Add operator props to WellMapProps**

In `WellMap.tsx`:

```typescript
interface WellMapProps {
  wells: WellEnriched[];
  onWellClick: (well: WellEnriched) => void;
  filters: MapFilters;
  flyToCoords?: { lng: number; lat: number } | null;
  operatorSlug: string | null;   // NEW
  isAdmin: boolean;               // NEW
}
```

**Step 2: Destructure new props in the component**

Where WellMap destructures props, add:

```typescript
export default function WellMap({
  wells, onWellClick, filters, flyToCoords,
  operatorSlug, isAdmin,  // NEW
}: WellMapProps) {
```

**Step 3: Update the `addProductionGlow` call**

In the map `load` handler where `addProductionGlow` is called (~line 166):

```typescript
// Before:
addProductionGlow(map, productionBeforeLayer)

// After:
addProductionGlow(map, operatorSlug, isAdmin, productionBeforeLayer)
```

**Step 4: Pass props from MapPage**

In `src/pages/MapPage.tsx`, where `<WellMap>` is rendered, add the new props:

```tsx
<WellMap
  wells={filteredWells}
  onWellClick={handleWellClick}
  filters={filters}
  flyToCoords={flyToCoords}
  operatorSlug={user?.operatorSlug ?? null}
  isAdmin={isAdmin}
/>
```

**Step 5: Verify TypeScript compiles**

Run: `cd wellfi-app && npx tsc --noEmit`
Expected: Zero errors

**Step 6: Verify build succeeds**

Run: `cd wellfi-app && npm run build`
Expected: Build succeeds with no errors

**Step 7: Commit**

```bash
git add src/components/map/WellMap.tsx src/pages/MapPage.tsx
git commit -m "feat: thread operator context into WellMap for scoped production layers"
```

---

## Task 8: Admin Operator Selector

**Files:**
- Create: `src/components/admin/OperatorSelector.tsx`
- Modify: `src/pages/MapPage.tsx`

**Step 1: Create OperatorSelector component**

```typescript
import { useEffect, useState } from 'react';
import { supabase } from '@/lib/supabase';
import { GLASS_COLORS } from '@/components/map/glassmorphicStyle';

interface Operator {
  id: string;
  slug: string;
  display_name: string;
}

interface OperatorSelectorProps {
  selectedSlug: string | null;
  onSelect: (slug: string | null) => void;
}

export default function OperatorSelector({ selectedSlug, onSelect }: OperatorSelectorProps) {
  const [operators, setOperators] = useState<Operator[]>([]);

  useEffect(() => {
    supabase
      .from('operators' as never)
      .select('id, slug, display_name')
      .eq('status', 'active')
      .order('display_name')
      .then(({ data }) => {
        if (data) setOperators(data as unknown as Operator[]);
      });
  }, []);

  return (
    <select
      value={selectedSlug ?? '__all__'}
      onChange={(e) => onSelect(e.target.value === '__all__' ? null : e.target.value)}
      className="text-xs rounded px-2 py-1 border bg-black/40 text-gray-300 border-white/10 backdrop-blur"
      style={{ color: GLASS_COLORS.textSecondary }}
    >
      <option value="__all__">All Operators</option>
      {operators.map((op) => (
        <option key={op.id} value={op.slug}>{op.display_name}</option>
      ))}
    </select>
  );
}
```

**Step 2: Integrate into MapPage admin header**

In `MapPage.tsx`, add state for admin operator selection:

```typescript
const [adminOperatorSlug, setAdminOperatorSlug] = useState<string | null>(null);

// Derive effective operator slug
const effectiveOperatorSlug = isAdmin ? adminOperatorSlug : (user?.operatorSlug ?? null);
```

Pass `effectiveOperatorSlug` instead of `user?.operatorSlug` to `<WellMap>`:

```tsx
<WellMap
  wells={filteredWells}
  onWellClick={handleWellClick}
  filters={filters}
  flyToCoords={flyToCoords}
  operatorSlug={effectiveOperatorSlug}
  isAdmin={isAdmin}
/>
```

Add `<OperatorSelector>` in the admin header area (near the operator display name):

```tsx
{isAdmin && (
  <OperatorSelector
    selectedSlug={adminOperatorSlug}
    onSelect={setAdminOperatorSlug}
  />
)}
```

**Step 3: Handle production layer reload on operator change**

In `WellMap.tsx`, add an effect that reloads production layers when `operatorSlug` changes:

```typescript
import { addProductionGlow, removeProductionGlow, setFormationHeatmapVisibility, PRODUCTION_LAYER_IDS } from './ProductionGlow';

// Inside the component, after map initialization:
useEffect(() => {
  if (!mapRef.current) return;
  const map = mapRef.current;

  // Remove existing production layers
  removeProductionGlow(map);

  // Re-add with new operator context
  const beforeLayer = map.getLayer('parcel-health-glow') ? 'parcel-health-glow' :
    map.getLayer('mineral-rights-glow') ? 'mineral-rights-glow' :
    undefined;

  addProductionGlow(map, operatorSlug, isAdmin, beforeLayer)
    .catch((err) => console.warn('ProductionGlow reload failed:', err));
}, [operatorSlug, isAdmin]);
```

**Step 4: Verify TypeScript compiles**

Run: `cd wellfi-app && npx tsc --noEmit`
Expected: Zero errors

**Step 5: Verify build succeeds**

Run: `cd wellfi-app && npm run build`
Expected: Build succeeds

**Step 6: Commit**

```bash
git add src/components/admin/OperatorSelector.tsx src/pages/MapPage.tsx src/components/map/WellMap.tsx
git commit -m "feat: add admin operator selector for cross-operator map views"
```

---

## Task 9: End-to-End Verification

**Step 1: Run the GeoJSON build script**

Run: `cd wellfi-app && tsx scripts/build_operator_geojson.ts`
Expected: All operator GeoJSON files generated

**Step 2: Start dev server**

Run: `cd wellfi-app && npm run dev`

**Step 3: Test Obsidian login**

- Login as existing Obsidian user
- Map should show only Obsidian's ~187 production wells (heatmap + dots)
- Dashboard widgets should show Obsidian-scoped data

**Step 4: Test new operator login**

- Login as `baytex-energy-ltd` with generic password
- Map should show only Baytex's ~465 production wells
- Heatmap should be concentrated in Bluesky area (512 of 516 wells are Bluesky)

**Step 5: Test admin login**

- Login as admin
- Map should show all ~6,932 wells
- Operator selector dropdown should appear in header
- Select "Baytex Energy Ltd." — map should reload with only Baytex wells
- Select "All Operators" — map should reload with all wells

**Step 6: Test Imperial Oil (largest operator)**

- Login as `imperial-oil-resources-limited`
- Map should show ~3,468 wells, all in Clearwater formation
- Heatmap should be bright and dense (largest operator)

**Step 7: Verify no cross-operator data leakage**

- When logged in as Baytex, open browser Network tab
- Confirm only `baytex-energy-ltd/production.geojson` is loaded
- Confirm Supabase queries return only Baytex wells

**Step 8: Commit verification notes**

```bash
git add -A && git commit -m "chore: end-to-end multi-operator verification complete"
```

---

## Task 10: Deploy

**Step 1: Build for production**

Run: `cd wellfi-app && npm run build`
Expected: Zero errors, zero warnings

**Step 2: Generate operator GeoJSON for production**

The GeoJSON files need to be generated before deploy since they're in `public/`:

Run: `tsx scripts/build_operator_geojson.ts`

Note: Since `public/data/operators/` is gitignored, we need to either:
- Add a `prebuild` script that generates them, OR
- Un-gitignore them and commit them (they're generated but static)

**Recommendation:** Add to `package.json`:
```json
"prebuild": "tsx scripts/build_operator_geojson.ts",
```

This ensures Vercel generates them during build.

**Step 3: Deploy to Vercel**

Run: `cd wellfi-app && npx vercel --prod`
Expected: Successful deployment

**Step 4: Verify production**

- Test login as Obsidian on production URL
- Test login as Baytex on production URL
- Test admin login with operator selector

**Step 5: Final commit**

```bash
git add package.json
git commit -m "feat: multi-operator tenancy — top 15 operators provisioned"
```

---

## Summary

| Task | Description | New Code | Risk |
|------|-------------|----------|------|
| 1 | Verify infrastructure | None (reads only) | Low |
| 2 | Update import script for Jan 2026 CSV | ~30 lines modified | Medium |
| 3 | Provision 15 operators | Script execution | Low |
| 4 | Import wells for 15 operators | Script execution | Medium |
| 5 | Build per-operator GeoJSON script | ~150 lines new | Low |
| 6 | ProductionGlow operator scoping | ~30 lines modified | Low |
| 7 | Thread operator context into WellMap | ~15 lines modified | Low |
| 8 | Admin operator selector | ~60 lines new + ~20 modified | Medium |
| 9 | End-to-end verification | None (testing) | Low |
| 10 | Deploy | Config only | Low |
