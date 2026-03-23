# Clearwater / Bluesky Multi-Operator Rollout Status

**Updated:** 2026-03-19

## Completed

- Multi-operator tenancy schema and operator-scoped RLS are in place in Supabase.
- The app supports admin plus operator-scoped viewer access.
- The map now uses:
  - live Supabase base well dots
  - monthly CSV-derived production heatmap overlays
- A standard monthly sync workflow exists:
  - `npm run production:sync -- "<csv-path>"`
- An overlay-only fallback exists:
  - `npm run production:refresh -- "<csv-path>"`

## Current Rollout Boundary

- **15 operator tenants are provisioned in Supabase today.**
- Monthly sync writes only for those provisioned operators.
- Operators present in the CSV but not provisioned yet are reported and skipped.

## Verified January 2026 Snapshot State

- `9189` source rows
- `7946` overlay features after zero-production filtering
- `15` provisioned operators processed
- `36` operators with snapshot rows skipped because they are not onboarded yet
- `0` new wells detected in the January 2026 dry-run
- `23` Obsidian wells missing from the January 2026 snapshot

## Next Expansion Path

1. onboard the next operator into Supabase
2. smoke-test that operator
3. include that operator in the next monthly live sync
4. repeat in controlled batches

## Source Of Truth

For current status and workflow details, use:

- `docs/current-state.md`
- `docs/monthly-production-refresh.md`
- `docs/agent-workflows.md`

