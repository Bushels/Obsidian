# WellFi Code Review Guide

Use this when reviewing local changes, a branch, or a PR.

## Output format

- Start with findings, not summary.
- Order findings by severity.
- Include file and line references when possible.
- If there are no findings, say that explicitly and note residual risks or untested areas.

## Highest-priority risks

- Anything that can misstate whether a well is operating, in warning, or down.
- Anything that can send a Slack or email alert to the wrong place, fail silently, or break deep links.
- Anything that makes map selection, action items, or engineer workflows unstable.
- Data-join regressions between wells, devices, pump changes, operational statuses, and device inventory.
- Authentication or redirect issues that block customer access.

## Review checklist

- Behavior: does the change do what the request asked for?
- Regressions: does it break existing dashboard, map, form, or alerting behavior?
- Data integrity: are joins, IDs, filters, and status assumptions still correct?
- Operator UX: is the workflow faster and clearer for an engineer under time pressure?
- Failure handling: are errors surfaced, logged, and actionable?
- Verification: were the right checks run for the files touched?

## Testing expectations

- UI changes should normally be checked with at least a browser smoke pass.
- Data or alerting changes should be validated against realistic states, not just empty or happy-path data.
- If a change depends on live customer systems or customer-only credentials, flag that as a testing gap.
