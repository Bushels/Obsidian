---
name: operator-onboarding
description: Onboard one Clearwater / Bluesky operator into WellFi by reading the rollout manifest, provisioning the operator and viewer login, preparing the import packet, and defining the manual checkpoint. Use when the user asks to add a new operator account, create a company login, provision tenant metadata, or move one company from manifest row to imported dashboard access.
---

# Operator Onboarding

Use this skill for one operator at a time. Do not batch-provision every company in one pass.

## Canonical files and scripts

- `../../scripts/provision_operator_users.ts`
- `../../scripts/import_operator_basin_wells.ts`
- `../../../Data/operator_rollout_manifest_clearwater_bluesky.csv`
- `../../../Data/operator_login_manifest_clearwater_bluesky.csv`

## Workflow

### 1. Confirm the rollout row

Read the target operator row in `operator_rollout_manifest_clearwater_bluesky.csv` and confirm:

- `operator_slug`
- `source_operator_name`
- `username`
- `pilot_flag`
- `onboarding_status`

If the row is missing or obviously stale, stop and run the inventory audit first.

### 2. Build the provisioning packet in dry-run mode

```bash
npx tsx scripts/provision_operator_users.ts --operator <slug> --dry-run
```

Review the JSON output for:

- operator spec
- viewer login email
- basin scope
- next step command

### 3. Human checkpoint

Pause here and confirm:

- the operator name is correct
- the username is acceptable
- the shared starter password should be used from `WELLFI_DEFAULT_COMPANY_PASSWORD`

Do not continue if the user wants a different username or the rollout row is still incomplete.

### 4. Provision the operator and login

```bash
npx tsx scripts/provision_operator_users.ts --operator <slug>
```

This should upsert:

- `operators`
- the Supabase Auth user
- `app_users`

### 5. Prepare the import packet

First run the import in dry-run mode:

```bash
npx tsx scripts/import_operator_basin_wells.ts --operator <slug> --dry-run
```

Confirm the matched row count and any skipped wells.

### 6. Import the operator wells

```bash
npx tsx scripts/import_operator_basin_wells.ts --operator <slug>
```

This is an upsert path, not a destructive sync. Missing wells are not deleted.

## Guardrails

- Do not use this workflow for Obsidian. Obsidian stays on the richer existing import path.
- Do not write the shared password into the repo.
- Keep the rollout manifest as the source of onboarding state; do not invent parallel tracking files.
- Require a human checkpoint after provisioning and before smoke testing.
