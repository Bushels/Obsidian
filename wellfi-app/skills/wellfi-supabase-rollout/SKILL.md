---
name: wellfi-supabase-rollout
description: Apply and verify WellFi multi-operator Supabase changes, especially tenant schema, operator scoping, and RLS. Use when the user asks to push tenant migrations, roll out operator access controls, verify row-level security, or safely deploy the multi-operator schema to Supabase.
---

# WellFi Supabase Rollout

Use this skill when the task touches `operators`, `wells.operator_id`, `app_users.operator_id`, or operator-scoped RLS.

## Canonical files

- `../../supabase/migrations/008_multi_operator_tenancy.sql`
- `../../src/lib/auth.tsx`
- `../../src/hooks/useWells.ts`
- `../../src/pages/MapPage.tsx`

## Workflow

### 1. Review the migration slice before pushing

Confirm the tenant rollout includes:

- `operators` table
- `wells.operator_id`
- `app_users.operator_id`
- helper functions for current user role and operator
- operator-scoped RLS for wells and related tables

If the change also modifies unrelated migrations, split that work first.

### 2. Apply the migration safely

Use the repo's normal Supabase migration path. Do not blindly push unrelated local migrations just because they are present in the folder.

Typical command:

```bash
npx supabase db push
```

### 3. Verify access behavior

After the rollout, confirm:

- admin sees all wells
- viewer sees only wells whose `operator_id` matches the viewer account
- wrong-operator access returns zero rows
- related tables such as `pump_changes`, `operational_statuses`, and `device_inventory` respect the same scope

### 4. Verify the app layer matches the database layer

RLS is the source of truth, but the app should still behave cleanly:

- auth context should surface operator metadata
- query keys should be user-scoped so account switching does not leak cached data
- viewer UI should hide admin-only widgets and write actions

## Guardrails

- Keep MPS admins globally visible across operators.
- Keep operator users as `viewer` only in v1.
- Do not hardcode the shared password into migrations, SQL, or committed config.
- Call out the backfill assumption if existing wells in the remote database are not all Obsidian-owned.
