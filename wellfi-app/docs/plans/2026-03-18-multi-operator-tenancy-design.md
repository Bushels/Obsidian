# Multi-Operator Tenancy — Design Document

**Date:** 2026-03-18
**Branch:** `codex/bluesky-clearwater-import`
**Status:** Draft — awaiting approval

---

## Problem

WellFi currently shows all wells to all users. Companies (Obsidian, CNRL, Baytex, etc.) need to log in and see **only their own wells** on the map — production heatmaps, well dots, dashboards, and all related data. Admin users continue to see everything.

## Goals

1. Each operator company has their own login (username/password)
2. Operator users see ONLY their wells on the map (heatmaps + dots + dashboard)
3. Admin users see all wells across all operators
4. Top 10-15 operators provisioned first, remaining added later
5. Leverage existing multi-tenant infrastructure (Migration 008, provisioning scripts)

## Non-Goals

- Custom branding per operator (future)
- Operator self-service user management (future)
- Password change flow on first login (future — noted by Gemini as recommended)
- Denormalizing operator_id onto child tables (Gemini recommendation — deferred until perf issues arise)

---

## What Already Exists

### Database (Migration 008)
- `operators` table with Obsidian Energy seeded
- `wells.operator_id` + `app_users.operator_id` columns
- RLS helper functions: `current_app_user_operator_id()`, `current_app_user_is_admin()`
- Operator-scoped RLS policies on ALL tables (wells, wellfi_devices, pump_changes, operational_statuses, device_inventory, app_users, operators)

### Auth
- `AuthUser` type carries `operatorId`, `operatorSlug`, `operatorDisplayName`, `basinScope`
- `fetchAppUser()` loads operator info on every auth state change
- `useAuth()` exposes `isAdmin` boolean
- Login uses `{username}@wellfi.local` email pattern

### Scripts
- `build_operator_inventory.ts` — generates operator manifests from basin CSV (71 operators inventoried)
- `provision_operator_users.ts` — creates operator record + Supabase auth user + app_user (one at a time)
- `import_operator_basin_wells.ts` — upserts wells for one operator into `wells` table (batches of 200)

### Data
- `operator_login_manifest_clearwater_bluesky.csv` — 71 operators with usernames, emails, well counts
- `operator_rollout_manifest_clearwater_bluesky.csv` — rollout tracking with pilot flags, onboarding status
- `active_clearwater_bluesky_recent_prod_ab_sk.csv` — 9,189 wells with production data (Jan 2026)

### Frontend
- `ProductionGlow.ts` — loads a single `bluesky-clearwater-production.geojson` (3.3MB, 6,932 wells)
- `useWells()` — fetches from Supabase (RLS-filtered), enriches with devices/statuses
- Map, dashboard, panels all consume `useWells()` data

---

## Design

### Phase 1: Provision Top 15 Operators

**What:** Run existing `provision_operator_users.ts` for top 15 operators.

**Target operators (by well count):**

| # | Operator | Wells | Slug |
|---|----------|------:|------|
| 1 | Imperial Oil Resources Limited | 4,109 | imperial-oil-resources-limited |
| 2 | Canadian Natural Resources Limited | 1,777 | canadian-natural-resources-limited |
| 3 | Spur Petroleum Ltd. | 937 | spur-petroleum-ltd |
| 4 | Tamarack Valley Energy Ltd. | 750 | tamarack-valley-energy-ltd |
| 5 | Baytex Energy Ltd. | 516 | baytex-energy-ltd |
| 6 | Headwater Exploration Inc. | 400 | headwater-exploration-inc |
| 7 | Strathcona Resources Ltd. | 384 | strathcona-resources-ltd |
| 8 | Obsidian Energy Ltd. | 216 | obsidian-energy-ltd (exists) |
| 9 | Peyto Exploration & Development Corp. | 285 | peyto-exploration-and-development-corp |
| 10 | Cenovus Energy Inc. | 229 | cenovus-energy-inc |
| 11 | Tourmaline Oil Corp. | 213 | tourmaline-oil-corp |
| 12 | Rubellite Energy Inc. | 124 | rubellite-energy-inc |
| 13 | IPC Canada Ltd. | 80 | ipc-canada-ltd |
| 14 | Paramount Resources Ltd. | 71 | paramount-resources-ltd |
| 15 | Clear North Energy Corp. | 42 | clear-north-energy-corp |

**CNUL merge:** The CSV has both "Canadian Natural Resources Limited" (1,191 rows) and "Canadian Natural Upgrading Limited" (272 rows). The rollout manifest already merges them under `canadian-natural-resources-limited` slug (1,777 total). The import script matches by `source_operator_name` from the manifest, so both licensee names map to one operator.

**Execution:** Loop script for each slug:
```bash
for slug in imperial-oil-resources-limited canadian-natural-resources-limited spur-petroleum-ltd ...; do
  tsx scripts/provision_operator_users.ts --operator "$slug"
done
```

**Password:** Generic via `WELLFI_DEFAULT_COMPANY_PASSWORD` env var. Not in code or migrations.

### Phase 2: Import Wells into Supabase

**What:** Run existing `import_operator_basin_wells.ts` for each provisioned operator.

**Key considerations:**
- Obsidian wells (210) already exist in `wells` table — script explicitly blocks Obsidian re-import
- Script uses `upsert` with `onConflict: 'well_id'` — safe for re-runs
- Wells come from `active_bluesky_clearwater_wells_AB_SK.csv` (stale ~Sept 2025)
- **Decision needed:** Use the newer `active_clearwater_bluesky_recent_prod_ab_sk.csv` (Jan 2026) instead? The import script currently reads from the stale file. We should point it at the newer CSV and update the field mappings if needed.

**Data quality concern (Gemini):** When importing Obsidian wells from basin CSV, the script could overwrite rich analytics fields (monthly arrays, risk levels) with nulls. The current script blocks Obsidian explicitly (`if (operatorSlug === 'obsidian-energy-ltd') throw`), which is correct.

**Execution:**
```bash
for slug in imperial-oil-resources-limited canadian-natural-resources-limited ...; do
  tsx scripts/import_operator_basin_wells.ts --operator "$slug"
done
```

### Phase 3: Build Per-Operator GeoJSON Files

**What:** New build script that splits `active_clearwater_bluesky_recent_prod_ab_sk.csv` into per-operator GeoJSON files.

**Output structure:**
```
public/data/operators/
  imperial-oil-resources-limited/production.geojson
  canadian-natural-resources-limited/production.geojson
  spur-petroleum-ltd/production.geojson
  ...
  _all/production.geojson          # Combined file for admin view
```

**Operator mapping:** Use the same `slugifyOperator()` function from existing scripts. CNUL rows get mapped to CNRL slug.

**GeoJSON format:** Same as current `bluesky-clearwater-production.geojson` — point features with properties: uwi, operator, formation, fluid_type, well_fluid_type, recent_oil, recent_gas, cumulative_oil, recent_water, recent_steam_injection, last_production_date, spud_date, op_status, field_name.

**Normalization:** Basin-wide (not per-operator). This means a small operator's heatmap will look dimmer than Imperial's — which is accurate and preserves visual consistency when admin views all operators.

**Size estimates:**
- Imperial: ~4,100 features ≈ 1.5MB
- CNRL: ~1,800 features ≈ 0.7MB
- Most operators: <500 features ≈ <0.2MB
- Combined (_all): ~6,900 features ≈ 3.3MB (same as current)

### Phase 4: Frontend — Operator-Scoped ProductionGlow

**What:** Modify `ProductionGlow.ts` to load operator-scoped GeoJSON.

**Changes to `addProductionGlow()`:**
```typescript
// Before
const GEOJSON_URL = '/data/bluesky-clearwater-production.geojson';

// After
export async function addProductionGlow(
  map: MapboxMap,
  operatorSlug: string | null,  // null = admin (load all)
  isAdmin: boolean,
  beforeLayerId?: string,
): Promise<void> {
  const url = isAdmin
    ? '/data/operators/_all/production.geojson'
    : `/data/operators/${operatorSlug}/production.geojson`;
  // ... rest unchanged
}
```

**Changes to `WellMap.tsx`:**
- Pass `user.operatorSlug` and `isAdmin` from auth context to `addProductionGlow()`
- Re-initialize production layers when operator changes (logout/login)

**Fallback:** If operator GeoJSON doesn't exist (operator not yet split), show empty map with message "Production data loading..."

### Phase 5: Admin Operator View

**What:** Admin can view individual operator dashboards or the aggregated view.

**UI:** Add an operator selector dropdown in the admin toolbar/header. Options:
- "All Operators" (default) — loads `_all/production.geojson`, shows all wells
- Individual operator names — loads that operator's GeoJSON, filters Supabase queries

**Implementation:** New `useOperatorContext()` hook or extend existing auth context with a `selectedOperatorSlug` state. When admin selects an operator:
- ProductionGlow reloads with that operator's GeoJSON
- `useWells()` refetches (Supabase RLS shows all for admin, but we can client-side filter)
- Dashboard widgets filter accordingly

**Deferred:** Full admin operator management UI (CRUD operators, manage users). For now, provisioning is script-based.

---

## Data Flow

```
CSV (Data/active_clearwater_bluesky_recent_prod_ab_sk.csv)
  │
  ├──[build_operator_inventory.ts]──→ Manifests (CSV)
  │
  ├──[provision_operator_users.ts]──→ Supabase: operators + auth.users + app_users
  │
  ├──[import_operator_basin_wells.ts]──→ Supabase: wells (with operator_id)
  │                                        │
  │                                        └──→ RLS automatically scopes queries
  │
  └──[build-operator-geojson.ts (NEW)]──→ public/data/operators/{slug}/production.geojson
                                            │
                                            └──→ ProductionGlow.ts loads by operatorSlug
```

---

## Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|-----------|
| Obsidian well data overwritten by thin CSV import | High | Import script blocks Obsidian explicitly |
| CNUL/CNRL merge produces duplicates | Medium | Both licensee names map to same operator slug via manifest |
| RLS JOIN performance on child tables | Low (now) | Monitor; denormalize operator_id to child tables if slow |
| Admin loading 3.3MB combined GeoJSON on every login | Low | Combined file is same size as current; cache-control headers |
| Generic password shared across companies | Medium | Acceptable for pilot; add password change flow later |
| Import script uses stale CSV (Sept 2025) | Medium | Point at newer Jan 2026 CSV; verify field name compatibility |
| 71 small GeoJSON files bloat `public/` | Low | Only generate for provisioned operators; gitignore the rest |

---

## Gemini Audit Notes

Gemini reviewed this plan and flagged:
1. **Denormalize `operator_id` onto child tables** — deferred but tracked. Current JOIN-based RLS is fine for <10k wells.
2. **JWT custom claims for operator_id** — optimization for future. Current `SECURITY DEFINER` functions work.
3. **`requires_password_change` flag** — good idea, deferred to post-pilot.
4. **COALESCE on upsert to protect rich fields** — handled by Obsidian exclusion in import script.
5. **Graceful null handling for thin Lane B wells** — UI already has optional chaining + "NO DATA" fallbacks on risk_level.

---

## Implementation Order

1. Provision top 15 operators (existing script)
2. Import wells for top 15 operators (existing script, point at newer CSV)
3. Build per-operator GeoJSON split script (new)
4. Modify ProductionGlow.ts to accept operator slug (frontend change)
5. Modify WellMap.tsx to pass auth context to ProductionGlow (frontend change)
6. Add admin operator selector (new component)
7. Verify: login as each operator, confirm map isolation
8. Deploy to Vercel + run Supabase migrations if needed

**Estimated difficulty:** Medium. Most backend work uses existing scripts. Main new code is the GeoJSON split script (~100 lines) and ProductionGlow.ts refactor (~20 lines changed). Admin selector is the most complex new UI component.
