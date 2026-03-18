# WellFi Execution Plan Template

Use this template for longer or cross-cutting work before implementation.

## Goal

- What user or operator problem is being solved?

## Context

- Which files, systems, docs, dashboards, or alerts are involved?
- What current behavior or bug is being changed?

## Constraints

- What must not change?
- What credentials, customer-only systems, or live services are out of scope?
- What operational or safety assumptions must stay true?

## Plan

1. Inspect the current implementation and relevant docs.
2. Identify the minimum set of files and systems to change.
3. Implement the behavior change.
4. Update any user-facing or operator-facing docs that changed.
5. Run the required verification steps.

## Verification

- `npm run lint`
- `npm run build`
- Browser smoke test steps:
- Alerting or data-flow checks:

## Risks

- What could still be wrong after the planned change?
- What requires customer data, production credentials, or field validation to confirm?
