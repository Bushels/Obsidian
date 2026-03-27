---
name: monthly-production-refresh
description: Run the standard monthly Clearwater / Bluesky CSV workflow. Use when the user wants to ingest the newest basin production file, rebuild per-operator production overlays, sync production into Supabase, zero current-month production for wells missing from the latest file, and verify the result.
---

# Monthly Production Sync

Use this skill for the monthly production snapshot workflow.

## Canonical files

- `../../scripts/sync_monthly_production.ts`
- `../../scripts/verify_monthly_production_sync.ts`
- `../../scripts/refresh_monthly_production.ts`
- `../../scripts/build_operator_geojson.ts`
- `../../scripts/import_operator_basin_wells.ts`
- `../../docs/current-state.md`
- `../../docs/monthly-production-refresh.md`
- `../data-integrity-rules/SKILL.md`

## Workflow

### 1. Confirm the source snapshot

Default source:

```text
C:\Users\kyle\MPS\Obsidian\Data\active_clearwater_bluesky_recent_prod_ab_sk.csv
```

If the user provides a newer dated file, use that explicit path instead.

### 2. State the model clearly

Before running anything, keep the distinction explicit:

- Supabase wells are the canonical well-master for identity, tenancy, and placement.
- The monthly CSV drives the production cloud, inserts new wells for provisioned operators, and updates production state on existing wells.
- Missing wells from the latest CSV are not deleted from Supabase, but their current-month production rate is forced to `0`.
- Each synced well is stamped with `latest_production_snapshot_month` and `latest_production_snapshot_status`.
- If the source file includes `well_name`, the sync should preserve it for new wells and backfill missing DB names.
- Monthly sync only writes for operators already provisioned in Supabase. Not-yet-onboarded operators are reported and skipped.

### 3. Run the standard monthly sync

From `wellfi-app` run:

```bash
npm run production:sync -- "<snapshot-path>"
```

If the user gives you an alternate-schema file with columns like `internal_id`, `licensee`, `recent_oil_m3`, or `recent_gas_e3m3`, normalize it first:

```bash
npm run production:normalize-imperial -- --input "<snapshot-path>"
```

Then run the standard sync against the canonical output written beside the source file or against the explicit `--output` path you passed to the normalizer.

The script validates required columns, cleans stale operator overlay output, rebuilds `public/data/operators/`, inserts or syncs provisioned-operator wells into Supabase, backfills missing names when available, and writes a report to `output/monthly-production-sync/latest.json`.

Live Supabase reconciliation requires `SUPABASE_URL` (or `VITE_SUPABASE_URL`) and `SUPABASE_SERVICE_ROLE_KEY`. The scripts auto-load `.env` and `.env.local`, so the normal setup is to keep the service-role key in `wellfi-app/.env.local`. If that key is unavailable, use `--dry-run` and make it explicit that DB diff counts are not available.

### 4. Verify immediately after sync

From `wellfi-app` run:

```bash
npm run production:verify -- "<snapshot-path>"
```

This must come after every live sync. It fails if:

- Supabase has duplicate logical wells
- snapshot-present wells do not match the CSV on synced fields
- snapshot-missing wells were not zeroed and stamped correctly

Run verification sequentially after the sync finishes. Do not run it in parallel with the live write.

### 4a. Cohort safety check

Before and after the live sync, check the install-linked tables so the user can see that production refresh did not erase deployment work:

- `wellfi_devices`
- `device_inventory` with `assigned` / `installed`

Monthly sync must not delete wells or break UUID-linked install records. A well that already exists in Supabase and is slated for WellFi should remain in place even if it is missing from the newest monthly production file.

### 5. Use overlay-only refresh only when that is explicitly what the user wants

If the user wants cloud rebuild only and does not want Supabase reconciliation:

```bash
npm run production:refresh -- "<snapshot-path>"
```

### 6. Review the reports

Confirm:

- source row count looks plausible
- zero-production skips are plausible
- `_all` plus per-operator files were generated
- new snapshot wells were inserted for provisioned operators
- wells missing from the current snapshot were zeroed and stamped
- wells that previously showed `Unnamed Well` were backfilled when `well_name` exists in the source file
- `output/monthly-production-sync/verification-latest.json` is clean

### 7. Call out the zero-production rule accurately

- Zero-production rows are excluded from the overlay GeoJSON.
- Missing-from-snapshot wells keep their base dot if they already exist in Supabase.
- Missing-from-snapshot wells also get `dec_rate_bbl_d = 0` for the current month.
- The cloud disappears because the overlay is rebuilt from the latest snapshot only.

### 7a. Call out current UI semantics accurately

- `Dec rate` in the old schema is the latest oil production rate in `bbl/d`, not December production.
- Grey wells are fallback `NO DATA` / missing run-life wells in the current map styling, not necessarily failed monthly sync rows.
- `WellFi Cohort` in the admin production deck reflects active WellFi installs, not planned installs, unless the product explicitly adds a pipeline cohort.

### 8. Smoke test

After a sync, test:

1. one admin view
2. one operator view
3. one well detail panel to confirm snapshot month and snapshot status render correctly

## Guardrails

- Do not overwrite manually curated operational fields from the monthly snapshot.
- Do not add a bespoke agent workflow when a script + skill is sufficient.
- If a snapshot operator is not in the rollout manifest, treat that as a workflow gap and report it explicitly.
- If the latest file month is not what the user thinks it is, state the actual month explicitly from the CSV and use that month in the report.
- Prefer strengthening this skill over creating a duplicate monthly-sync skill. One clean runbook is easier to trust than two overlapping ones.
