---
name: operator-smoke-test
description: Run a focused smoke test for an operator-scoped WellFi login, verifying tenant isolation, map load, filters, and read-only well details. Use when the user asks to validate a company login, confirm tenant scoping, check what a customer account can see, or test the operator viewer workflow after onboarding or release changes.
---

# Operator Smoke Test

Use this skill after provisioning and import, or after UI/auth changes that could affect tenant isolation.

## Canonical references

- `../wellfi-ops-smoke-test/SKILL.md`
- `../../TESTING_PROTOCOL.md`

## Workflow

### 1. Start the app

Use one of:

```bash
npm run dev
```

or

```bash
npm run preview
```

### 2. Confirm the target credentials

Before opening the browser, know:

- the operator username
- whether you are testing a viewer account or an admin account
- which operator should appear in the header

### 3. Run the viewer checks

Validate these in order:

1. Log in with the operator viewer account.
2. Confirm the map loads and the header shows the expected operator.
3. Confirm only operator-scoped wells appear.
4. Confirm the sidebar shows the operator overview card, not the admin widgets.
5. Use formation and field filters and confirm the counts stay scoped.
6. Open at least one well and confirm the right panel is read-only for operational status and device actions.
7. Confirm deep links such as `/map?well_id=...` still open the correct scoped well after login.

### 4. Optional admin compare pass

If the task involves tenant isolation, also log in as admin and confirm:

- admin can still see all operators
- admin widgets still render
- the same well opens correctly in the richer workflow

## Report format

Return:

- what account was tested
- what passed
- what failed
- exact reproduction steps for failures
- whether the issue is data, auth/RLS, or frontend behavior
