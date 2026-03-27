---
name: wellfi-ops-smoke-test
description: Runs a focused smoke test for the WellFi operations dashboard, including login, map load, action items, well selection, right-panel behavior, tenant-scoped visibility, and alert or pump-change UX. Use when the user asks to test the dashboard, inspect the map, verify a UI bug, run browser checks, validate a release, or confirm admin or operator workflows in the web app.
compatibility: Codex or Claude coding environments with terminal access, Node/npm, a runnable local app, and browser automation support.
metadata:
  author: OpenAI Codex
  version: 1.0.0
  project: wellfi-app
---

# WellFi Ops Smoke Test

Use this skill for repeated browser-based validation of the WellFi dashboard.

## Scope

Cover the operator-critical flows first:

1. Login and redirect behavior.
2. Map render and control visibility.
3. Tenant scoping for operator viewer accounts.
4. Action Items click-through and well selection stability.
5. Right panel details for operational status, pump-change context, and device state.
6. Any task-specific flow the user asked to verify.

## Workflow

### Step 1: Start the app

Run the local app before opening a browser.

- Preferred for inspection: `npm run preview`
- Preferred for active frontend edits: `npm run dev`

If a port is already in use, detect the actual listening port and report it clearly.

### Step 2: Confirm access assumptions

Before testing customer-only behavior, verify:

- Which environment is running: dev or preview
- Whether credentials are available in the current thread
- Whether the task depends on real customer data, mocked data, or empty-state behavior
- Whether the requested account is an admin or operator viewer

If credentials or data are missing, continue with the highest-value checks still possible and call out the gap.

### Step 3: Run the browser flow

Use a real browser driver and validate these in order:

1. Open the app and confirm the initial page loads.
2. Log in if required.
3. Confirm the map renders and controls are visible.
4. For operator viewer accounts, confirm the sidebar shows the operator overview card and no admin widgets.
5. Click at least one Action Item and verify the matching well opens.
6. If multiple flagged wells exist, click them in sequence and verify selection does not oscillate.
7. Open the well details panel and check the task-specific UI.
8. If the task involves alerts or monitoring overlays, inspect the map hover or click behavior directly.

### Step 4: Validate success criteria

Treat these as pass criteria unless the user asked for something narrower:

- No blocking console errors
- No broken navigation or stuck loading states
- Operator viewers only see their own wells and read-only controls
- Selected well matches the clicked item
- Right panel shows the expected well
- No obvious visual overlap, flicker, or repeated state churn

### Step 5: Report clearly

Return:

- What was tested
- What passed
- What failed
- Exact reproduction steps for failures
- Residual gaps caused by missing data, credentials, or production-only dependencies

## Common task prompts

- "Run the web app and inspect the dashboard"
- "Check whether the flagged wells flow is stable"
- "Test the map overlay and well detail panel"
- "Do a release smoke test before I review it"
- "Verify the engineer workflow for a pump-down decision"

## References

Load these only when needed:

- `references/checklist.md` for the detailed smoke-test checklist
- `../../TESTING_PROTOCOL.md` for the broader release checklist

## Troubleshooting

### App will not start

Check:

- `npm install` has been run
- the chosen port is not occupied
- the build succeeded if using preview mode

### Browser opens but login fails

Check:

- credentials were entered into the correct fields
- redirect or local auth state is not stale
- the current environment matches the requested data state

### Skill runs but misses the real bug

Tighten the repro:

- use the user's exact click order
- test with the same viewport class if the bug is mobile-only or desktop-only
- inspect console output and URL changes during the flow
