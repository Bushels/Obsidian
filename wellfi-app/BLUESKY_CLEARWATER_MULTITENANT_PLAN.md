# Clearwater / Bluesky Multi-Operator Rollout Plan

## Goal

- Expand WellFi from an Obsidian-only deployment into a multi-operator portal for active Clearwater and Bluesky operators.
- Give each company its own login and ensure each login only sees that operator's wells.
- Preserve the existing Obsidian workflow while creating a clean path to onboard additional companies.

## Context

- The current app is effectively single-tenant even though Supabase Auth already exists.
- The app currently fetches every row from `wells` in [`src/hooks/useWells.ts`](/Users/kyle/MPS/Obsidian/wellfi-app/src/hooks/useWells.ts).
- Current RLS allows any authenticated user to read all wells in [`supabase/migrations/003_rls_policies.sql`](/Users/kyle/MPS/Obsidian/wellfi-app/supabase/migrations/003_rls_policies.sql).
- The new source file is [`Data/active_bluesky_clearwater_wells_AB_SK.csv`](/Users/kyle/MPS/Obsidian/Data/active_bluesky_clearwater_wells_AB_SK.csv).
- A repeatable operator inventory can be generated with `npm run operators:audit`.

## Current Findings

- Current branch head is the same commit as `main`; the large body of work is in the uncommitted working tree, not in extra branch commits.
- The basin source currently appears Alberta-only even though the filename says `AB_SK`; the active rows found so far are all `AB`.
- The current `wells` table does not store operator ownership, so tenant isolation cannot be enforced yet.
- The non-Obsidian basin CSV does not include the same monthly pump-risk detail as the Obsidian Excel workflow, so new operators will initially have thinner analytics unless we add more source data.

## Constraints

- Do not hardcode the shared starter password in the repo. Use an environment variable such as `WELLFI_DEFAULT_COMPANY_PASSWORD` during user provisioning.
- Preserve existing Obsidian workflows while we add tenant isolation.
- Keep `src/types.ts` frozen until the schema plan is approved and executed in one coordinated pass.
- Avoid mixing customer provisioning, RLS, and CSV import changes into one large unreviewable patch.

## Plan

1. Baseline and freeze the onboarding list.
   - Generate the operator inventory and login manifest from the basin CSV.
   - Decide which operators are true oil targets versus gas-only basin participants.

2. Add tenant data to the database.
   - Create an `operators` table with a stable slug, display name, and onboarding status.
   - Add `operator_id` to `wells`.
   - Add `operator_id` to `app_users`.
   - Backfill Obsidian and future operators from the generated manifest.

3. Enforce row-level isolation in Supabase.
   - Replace `authenticated_read_wells USING (true)` with an operator-scoped policy.
   - Allow admins to read all operators.
   - Mirror the same operator-scoped access on `wellfi_devices`, `pump_changes`, `operational_statuses`, and `device_inventory`.

4. Split ingestion into two lanes.
   - Lane A: keep the richer Obsidian ETL for wells that have Excel-backed risk data.
   - Lane B: add a CSV-based basin importer for all operators using the new source file, defaulting missing analytics fields to null or `NO DATA`.

5. Provision company logins cleanly.
   - Create one viewer account per operator using the generated manifest.
   - Use username-to-email mapping already present in [`src/lib/auth.tsx`](/Users/kyle/MPS/Obsidian/wellfi-app/src/lib/auth.tsx).
   - Feed the initial shared password from an environment variable, then rotate later.

6. Adjust the app for multi-tenant visibility.
   - Keep the current map query simple and let RLS filter the rows.
   - Show the operator name in the header for non-admin users.
   - Add an admin operator switcher only after the core tenant isolation is verified.

7. Roll out in phases.
   - Phase 1: Obsidian plus one non-Obsidian pilot operator.
   - Phase 2: top oil-target operators by well count.
   - Phase 3: remaining operators once provisioning and support workflow are stable.

## Verification

- `npm run operators:audit`
- `npm run lint`
- `npm run build`
- Manual checks after schema work:
  - Sign in as admin and confirm all wells are visible.
  - Sign in as an operator viewer and confirm only that operator's wells appear.
  - Verify map counts, popup details, and right-panel forms still work with null analytics fields.

## Risks

- If we import non-Obsidian wells without operator-scoped RLS first, every authenticated user can see every company.
- If we force all operators through the Obsidian risk model, we will create bad data because the required Excel detail does not exist for most operators.
- If we keep using a single giant `wells` table without explicit tenant metadata, future onboarding will get harder with every customer added.

## First Recommended Execution Slice

1. Approve the operator inventory and target list generated from the new CSV.
2. Implement the schema change for `operators`, `wells.operator_id`, and `app_users.operator_id`.
3. Implement operator-scoped RLS before importing any non-Obsidian wells.
4. Import one pilot operator and verify login isolation end to end.
