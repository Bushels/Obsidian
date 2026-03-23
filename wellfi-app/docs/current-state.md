# WellFi Current State

**Updated:** 2026-03-23

## What Is Complete

- WellFi is now a **multi-operator Clearwater / Bluesky portal**, not an Obsidian-only app.
- **Supabase tenancy and RLS** are in place for `operators`, `wells.operator_id`, and operator-scoped reads.
- The map is split into:
  - **base well dots from live Supabase well data**
  - **production overlay from monthly CSV-derived GeoJSON overlays**
  - production overlay now behaves as **heatmap at basin scale and matching formation/fluid production dots at close zoom**
  - the close-zoom dots intentionally use the same Clearwater/Bluesky oil/gas colors as the heatmap so the handoff is visually obvious
  - the close-zoom production dots render above the live base-well dots so the color handoff stays visible while inspecting wells
- MPS admin now has an **admin-only production deck** with:
  - operator or formation breakdown
  - oil or gas toggle
  - WellFi cohort filter
  - scoped behavior that follows the selected operator
- Monthly data workflows now exist as:
  - `npm run production:sync -- "<csv-path>"` for the standard monthly sync
  - `npm run production:refresh -- "<csv-path>"` for overlay-only rebuilds
- The monthly sync scripts now auto-load `.env` and `.env.local`.
- Old production-dot plan docs were removed so they cannot be mistaken for current architecture.

## Current Rollout Boundary

- Supabase currently has **15 provisioned operator tenants**.
- The live `wells` table currently has **15 provisioned operators with loaded non-abandoned wells**.
- Monthly sync writes only for those provisioned operators.
- Operators that appear in the monthly CSV but are **not yet provisioned** are reported and skipped.

Current provisioned operators:

- `baytex-energy-ltd`
- `canadian-natural-resources-limited`
- `cenovus-energy-inc`
- `clear-north-energy-corp`
- `headwater-exploration-inc`
- `imperial-oil-resources-limited`
- `ipc-canada-ltd`
- `obsidian-energy-ltd`
- `paramount-resources-ltd`
- `peyto-exploration-and-development-corp`
- `rubellite-energy-inc`
- `spur-petroleum-ltd`
- `strathcona-resources-ltd`
- `tamarack-valley-energy-ltd`
- `tourmaline-oil-corp`

## Verified Monthly Snapshot State

Verified against the February 2026 canonical snapshot, **February 2026** (`2026-02-01`), at:

`C:\Users\kyle\MPS\Obsidian\Data\clearwater_bluesky_feb2026_prod_imperial_canonical.csv`

Latest verified live sync / verification state:

- `8472` source rows
- `0` duplicate UWI rows in the current source file
- `20` zero-production rows excluded from overlay
- `8452` overlay features written
- `62` operator overlay slugs written, plus `_all`
- `15` provisioned operators processed
- `33` operators with snapshot rows skipped because they are not onboarded yet
- `436` new snapshot wells were detected inside the provisioned operator scope
- `436` new provisioned-operator wells were inserted into Supabase
- Monthly sync now runs as **insert-new-plus-update-production-and-zero-missing**
- `7574` existing provisioned-operator wells were updated
- `1321` provisioned-operator wells were missing from the February snapshot and were zeroed for the month while their base dot remained
- `0` snapshot-present field mismatches after the live sync
- `0` snapshot-missing zeroing/status mismatches after the live sync
- `0` snapshot rows missing from DB after the live sync
- `monthly_production_sync_runs` now records the February 2026 sync run in Supabase

See:

- `output/monthly-production-sync/latest.json`
- `output/monthly-production-sync/verification-latest.json`

## Operating Rules

- Dashboard counts such as **Total Wells**, **Loaded Operators**, and formation split come from the live Supabase `wells` table, not directly from the CSV overlay.
- MPS production analytics come from the latest monthly snapshot overlay, not from a dedicated historical production mart.
- Because of that split, live well counts and production snapshot coverage are related but not identical concepts.
- The monthly CSV is **not** the destructive well-master.
- The monthly CSV **is** allowed to insert new wells for already provisioned operators, but it is **not** allowed to reassign operator ownership.
- The monthly CSV **does** force `dec_rate_bbl_d = 0` for provisioned wells missing from the latest snapshot month.
- Each well now carries `latest_production_snapshot_month` plus `latest_production_snapshot_status` so the system can show whether it was present or missing in the latest file.
- Duplicate base dots are blocked in three places:
  - `wells.well_id` is unique in Supabase
  - duplicate UWIs are collapsed before monthly overlay and sync processing
  - frontend map GeoJSON defensively dedupes repeated well IDs before rendering
- Missing wells in the latest monthly snapshot are **not deleted** from Supabase.
- Zero-production rows are excluded from the overlay, not from the base well map.

## Verified Dashboard State

- Live dashboard counts verified on 2026-03-23:
  - `9331` non-abandoned wells
  - `15` provisioned operators
  - `15` loaded operators with live wells
  - `6795` Clearwater wells
  - `2536` Bluesky wells
- February 2026 snapshot sync verified against Supabase for all 15 provisioned operators:
  - `0` duplicate exact or logical well IDs in Supabase
  - `0` snapshot wells are missing from DB
  - `0` field mismatches on snapshot-present wells
  - `0` zeroing/status mismatches on snapshot-missing wells
  - Obsidian now has `178` wells marked `present`, `34` wells marked `missing`, and `212` total wells for snapshot month `2026-02-01`
- Operator viewers do **not** see production analytics or production controls.
- MPS admin sees production overlay controls plus the production deck.
- MPS admin well details now show snapshot month and snapshot status in the production panel.
- Full multi-operator month-over-month trend history still requires a dedicated production fact table in Supabase.

## Primary Docs

- `AGENTS.md`
- `CLAUDE.md`
- `GEMINI.md`
- `docs/agent-workflows.md`
- `docs/monthly-production-refresh.md`
