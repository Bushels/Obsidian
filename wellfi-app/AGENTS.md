# WellFi App Agent Guide

This is the Codex-facing project guide for `wellfi-app`.

## Product scope

- Shared WellFi dashboard for Clearwater / Bluesky operators, with Obsidian retaining the richer internal operations workflow.
- Primary v1 workflows: operator-scoped map access, basin inventory review, field and formation filtering, basic well detail review, plus Obsidian-only internal workflows for pump changes, operational statuses, devices, and notifications.
- Engineers, not the model, decide when a pump is down or when a change should be scheduled.

## Repo map

- `src/pages/MapPage.tsx`: main dashboard shell.
- `src/components/map/`: Mapbox layers, popups, parcel logic, and on-map interactions.
- `src/components/panels/`: right panel, summaries, device and pump-change UI.
- `src/components/forms/`: operator forms for status, pump-change, and device workflows.
- `src/hooks/useWells.ts`: joined well/device/pump-change/operational-status data for the UI.
- `scripts/build_operator_inventory.ts`: basin inventory audit and manifest generation.
- `scripts/provision_operator_users.ts`: per-operator tenant and login provisioning.
- `scripts/import_operator_basin_wells.ts`: per-operator basin well import path.
- `supabase/functions/notify-operational-status/`: Slack and email alert delivery.
- `skills/`: portable repo skills for repeated validation or workflow execution.
- `TESTING_PROTOCOL.md`: release and smoke checklist.
- `code_review.md`: review rubric for `/review`.
- `PLANS.md`: execution-plan template for longer or cross-cutting tasks.
- `agents/`: historical swarm coordination artifacts. These are not production runtime code.

## Run commands

- Install: `npm install`
- Dev server: `npm run dev`
- Production build: `npm run build`
- Lint: `npm run lint`
- Preview build: `npm run preview`

## Working rules

- Do not hardcode customer credentials, StackDX credentials, webhook URLs, or tokens in the repo.
- Keep WellFi-local skills in `wellfi-app/skills` only. Do not duplicate them into `.agents` or `.claude`.
- Treat engineer-set operational status as the current source of truth unless a task explicitly adds telemetry-backed status logic.
- Keep map, side-panel, and notification behavior aligned. If one changes, check the others.
- Preserve the freeze on `src/types.ts` and `src/lib/supabase.ts` unless the task explicitly calls for a coordinated schema/type change.
- If a task changes operator workflow, update the relevant docs in the same pass.
- Preserve the editable rollout manifest when refreshing inventory outputs.
- Use MCP or approved external tools for live systems when available; do not copy secrets into prompts or markdown files.

## Done means

- Run `npm run lint` and `npm run build` after code changes unless the task is docs-only.
- If the UI changed, smoke-test login, map loading, well selection, and the affected form or panel.
- If notifications changed, verify success and failure handling plus any deep links.
- Call out residual risk clearly when live data, external services, or customer-only access prevents full verification.

## Review expectations

- Findings first, ordered by severity.
- Prioritize regressions that could hide a down well, misroute a notification, corrupt operator-entered status, or break field workflows.
- Follow `code_review.md` for review structure and focus.

## Planning expectations

- Use `PLANS.md` for multi-step changes, schema work, alerting changes, or work that spans UI plus data flow plus docs.
- Ask for clarification before coding if the task is ambiguous and touches customer data, alerting, or automation credentials.
