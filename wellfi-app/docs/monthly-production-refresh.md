# Monthly Production Sync

This runbook defines the standard monthly workflow for the Clearwater / Bluesky production snapshot.

## Current Verified State

As of **2026-03-23**, the latest live sync has been run against the February 2026 canonical snapshot:

`C:\Users\kyle\MPS\Obsidian\Data\clearwater_bluesky_feb2026_prod_imperial_canonical.csv`

- `15` provisioned operators are currently in scope for live sync
- `33` operators with snapshot rows are currently out of scope and were reported/skipped
- `0` duplicate UWI rows were found in the February snapshot
- `436` new snapshot wells were detected inside the provisioned operator scope
- `436` new provisioned-operator wells were inserted into Supabase by the monthly sync
- `7574` existing provisioned-operator wells were updated
- `1321` provisioned-operator wells were missing from the February snapshot and were zeroed for the month while keeping their base dot
- Verification is now fully clean:
  - `0` snapshot rows missing from DB
  - `0` snapshot-present field mismatches
  - `0` snapshot-missing zeroing/status mismatches

For the broader implementation summary, see `docs/current-state.md`.

## Data Model

- `Supabase wells` are the canonical well-master for identity, tenancy, and placement.
- The monthly CSV snapshot drives the production cloud, inserts new wells for provisioned operators, and updates production state on existing wells.
- The monthly CSV snapshot cannot reassign well ownership or create duplicate base dots.
- `wells.latest_production_snapshot_month` and `wells.latest_production_snapshot_status` track how current each well is relative to the latest synced file.
- `monthly_production_sync_runs` records the latest sync month and run totals inside Supabase.
- The monthly CSV is still not a destructive full-replacement well-master feed.

## Source Snapshot

- Default input: `C:\Users\kyle\MPS\Obsidian\Data\active_clearwater_bluesky_recent_prod_ab_sk.csv`
- If the monthly source arrives in the alternate Imperial export schema, normalize it first with:

```bash
npm run production:normalize-imperial -- --input "C:\Users\kyle\MPS\Obsidian\Data\clearwater_bluesky_feb2026_prod_imperial.csv" --reference "C:\Users\kyle\MPS\Obsidian\Data\active_clearwater_bluesky_recent_prod_ab_sk.csv" --output "C:\Users\kyle\MPS\Obsidian\Data\clearwater_bluesky_feb2026_prod_imperial_canonical.csv"
```

Then point `production:sync` and `production:verify` at the canonical output.

## Business Rules

- MPS admins can see all tenant-scoped base wells in Supabase.
- Operator viewers can only see wells whose `operator_id` matches their account.
- Duplicate snapshot rows are collapsed by UWI before overlay generation or Supabase reconciliation.
- Zero-production rows are excluded from the production overlay GeoJSON.
- The app renders that overlay as a heatmap at basin scale and matching formation/fluid production dots at close zoom.
- The close-zoom dot colors intentionally match the heatmap palette by formation and fluid type so users can visually follow the transition.
- Missing wells in the monthly snapshot are not deleted from Supabase by this workflow.
- If a provisioned well is missing from the current snapshot, the sync sets `dec_rate_bbl_d = 0`, marks the well `latest_production_snapshot_status = 'missing'`, stamps the snapshot month, and keeps the base dot.
- Monthly sync writes are scoped to operators already provisioned in Supabase. Snapshot rows for not-yet-onboarded operators are reported and skipped.
- `wells.well_id` remains unique in Supabase, which prevents duplicate well records at the database level.

## Standard Command

Run from `wellfi-app`:

```bash
npm run production:sync -- "C:\Users\kyle\MPS\Obsidian\Data\active_clearwater_bluesky_recent_prod_ab_sk.csv"
```

Live Supabase reconciliation requires `SUPABASE_URL` (or `VITE_SUPABASE_URL`) plus `SUPABASE_SERVICE_ROLE_KEY`. The sync scripts now auto-load `.env` and `.env.local`, so the practical setup is to store the service-role key in `wellfi-app/.env.local`. Without that key, use `--dry-run` for an overlay rebuild preview only.

What this does:

1. Validates that the snapshot includes the required columns.
2. Derives the snapshot month from the latest `last_production_date` in the file.
3. Collapses duplicate UWIs inside the snapshot before any downstream writes.
4. Rebuilds `public/data/operators/` from a clean slate.
5. Inserts new Supabase wells for provisioned operators found in the snapshot.
6. Updates production fields on existing Supabase wells by operator using the rollout manifest.
7. Zeroes current-month production rate for provisioned wells missing from the snapshot.
8. Stamps each synced well with the latest snapshot month and `present` / `missing` status.
9. Records the sync run in `monthly_production_sync_runs`.
10. Reports:
   - duplicate snapshot rows that were collapsed
   - new snapshot wells that were inserted for provisioned operators
   - existing wells updated with monthly production fields
   - snapshot wells that belong to another operator and were not reassigned
   - wells already in Supabase but missing from the current snapshot and zeroed for the current month
   - operators with snapshot rows that are not onboarded in Supabase yet
11. Writes a machine-readable report to `output/monthly-production-sync/latest.json`.

## Standard Verification Command

Run after every live sync:

```bash
npm run production:verify -- "C:\Users\kyle\MPS\Obsidian\Data\active_clearwater_bluesky_recent_prod_ab_sk.csv"
```

This verifies:

- there is still only one canonical Supabase row per well
- normalized well IDs do not create logical duplicates
- snapshot-present wells match the CSV on synced fields
- snapshot-missing wells are zeroed and stamped correctly

## Overlay-Only Fallback

If you only want to rebuild the production cloud and skip Supabase reconciliation:

```bash
npm run production:refresh -- "C:\Users\kyle\MPS\Obsidian\Data\active_clearwater_bluesky_recent_prod_ab_sk.csv"
```

That workflow is overlay-only and writes its report to `output/monthly-production-refresh/latest.json`.

## Generated Artifacts

- Per-operator production overlays:
  - `public/data/operators/{slug}/production.geojson`
- Combined overlay:
  - `public/data/operators/_all/production.geojson`
- Full monthly sync report:
  - `output/monthly-production-sync/latest.json`
- Full monthly verification report:
  - `output/monthly-production-sync/verification-latest.json`
- Overlay-only refresh report:
  - `output/monthly-production-refresh/latest.json`

## Required Columns

- `uwi`
- `operator_licensee`
- `producing_formation`
- `well_fluid_type`
- `surface_latitude`
- `surface_longitude`
- `recent_oil`
- `recent_gas`

## Guardrails

- Clean the operator overlay output on each monthly run to avoid stale operator files.
- Do not delete Supabase wells just because they are absent from the latest monthly snapshot.
- Do insert new wells only for already provisioned operators that appear in the monthly snapshot.
- Do not reassign operator ownership from the monthly snapshot workflow.
- Do zero the current-month production rate for provisioned wells that are missing from the latest snapshot.
- Do not overwrite manually curated operational fields, pump-risk logic, or richer Obsidian-derived data with the monthly basin snapshot.
- Treat rollout-manifest coverage as part of the workflow. If a snapshot operator is not in the manifest, fix the manifest before treating that operator as fully synced.

## Verification

After the monthly sync:

1. Inspect `output/monthly-production-sync/latest.json`.
2. Run `npm run production:verify -- "<snapshot-path>"`.
3. Confirm `_all/production.geojson` and at least one operator `production.geojson` were rebuilt.
4. Confirm the report shows plausible counts for:
   - duplicate rows collapsed
   - new snapshot wells that were inserted
   - updated wells
   - wells missing from the current snapshot and zeroed for the month
5. Confirm Supabase has a fresh `monthly_production_sync_runs` row for the current snapshot month.
6. Smoke-test one admin view and one operator view.

## Current Limitation

Production overlays are still written into `public/data/operators/`, so the cloud layer remains app-scoped by file path rather than fully database-secured. The tenant-secure source of truth remains the Supabase base well data.
