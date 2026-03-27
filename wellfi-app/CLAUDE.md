# WellFi App - Claude Project Guide

## Project Summary

WellFi is now a **multi-operator Clearwater / Bluesky portal**, not an Obsidian-only app.

Current implementation state:

- Supabase tenancy and operator-scoped RLS are active
- base well dots come from live Supabase well data
- production overlay comes from monthly CSV-derived overlay GeoJSON: heatmap at basin scale, then formation/fluid production dots at close zoom using the same colors as the heatmap for easier visual handoff
- the current rollout boundary is **15 provisioned operator tenants**
- unprovisioned operators are reported and skipped during monthly syncs

## Read These First

1. `AGENTS.md`
2. `docs/current-state.md`
3. `docs/agent-workflows.md`
4. the relevant workflow `skills/*/SKILL.md`

## Workflow Discovery

For documentation or workflow-oriented tasks, use these runbooks:

- `skills/docs-maintainer/SKILL.md`
- `skills/documentation-patrol/SKILL.md`
- `skills/monthly-production-refresh/SKILL.md`
- `skills/operator-onboarding/SKILL.md`
- `skills/operator-smoke-test/SKILL.md`
- `skills/wellfi-supabase-rollout/SKILL.md`

## Important Rules

- Treat `docs/current-state.md` as the concise implementation status summary.
- Treat `docs/agent-workflows.md` as the vendor-neutral workflow index.
- Treat each `SKILL.md` as the real workflow runbook.
- Do not rely on historical `agents/session-*` files for current architecture decisions.
- Delete stale implementation plans if they no longer reflect the live system.
- Keep docs aligned with the actual rollout boundary, not the future desired rollout.
