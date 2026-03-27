---
name: operator-inventory-audit
description: Audit Clearwater / Bluesky operator coverage for WellFi, regenerate the machine inventory outputs, preserve the editable rollout manifest, and flag basin or operator anomalies. Use when the user asks to refresh operator inventory, verify which companies operate in the basins, review pilot candidates, check generated manifests, or validate the source CSV before onboarding new operators.
---

# Operator Inventory Audit

Use this skill when the basin source file or rollout files need to be refreshed without losing manual onboarding state.

## Canonical files

- `../../scripts/build_operator_inventory.ts`
- `../../../Data/active_bluesky_clearwater_wells_AB_SK.csv`
- `../../../Data/operator_inventory_clearwater_bluesky.csv`
- `../../../Data/operator_inventory_clearwater_bluesky.md`
- `../../../Data/operator_login_manifest_clearwater_bluesky.csv`
- `../../../Data/operator_rollout_manifest_clearwater_bluesky.csv`

## Workflow

### 1. Check the source snapshot first

- Confirm the source file exists and is the intended basin snapshot.
- Call out obvious mismatches before regenerating outputs.
- Example: if a file name says `AB_SK` but the province counts come back `AB` only, report that explicitly instead of assuming Saskatchewan data is present.

### 2. Run the audit script

From the repo root:

```bash
npm run operators:audit
```

The script should:

- regenerate the machine inventory outputs
- keep the rollout manifest as the human-managed file
- preserve manual rollout fields such as `pilot_flag`, `onboarding_status`, `import_status`, `smoke_test_status`, and `notes`
- emit JSON to stdout so the run is easy to inspect or automate later

### 3. Review the generated outputs

Confirm:

- operator totals look stable for the same source file
- `operator_inventory_clearwater_bluesky.csv` stays machine-only
- `operator_rollout_manifest_clearwater_bluesky.csv` still contains manual state after the rerun
- the markdown summary includes a sensible pilot shortlist

### 4. Flag anomalies instead of hiding them

Raise them clearly when you see:

- unexpected operator slug truncation or collisions
- province counts that contradict the file name
- operators that moved from `oil-target` to `gas-only-review`
- dramatic row count changes without a new source snapshot

## Success criteria

- The inventory files regenerate cleanly.
- Manual rollout fields survive the rerun.
- Counts and operator ranking are explainable from the source snapshot.
- Any anomaly is written down instead of silently normalized.
