# Well Event Workflow Implementation Spec

**Date:** 2026-03-21

## Direct Recommendation

- Build one operator-facing `Well Event` workflow with four states: `clear`, `watch`, `warning`, `down`.
- Let operators create, update, and clear events on their own wells.
- Keep tool assignment, dispatch, installation, and close-out as MPS-only fulfillment steps.
- Use outbound Slack in phase 1.
- Treat inbound Slack commands as phase 2, not as the primary v1 input.

Why:

- The current app already has status flags, pump-change workflow, inventory assignment, map display, and Slack notification plumbing.
- The main problem is not missing pieces. It is that the process is split across multiple models and only admins can operate it today.

## Goal

- Give operators a low-friction way to tell MPS that a well needs attention.
- Let MPS prepare the correct tool, assign it from inventory, schedule support, and track execution.
- Keep the well visible on the operator dashboard at every step.
- Support both planned degradation and abrupt down-well events.

## Product Decisions

### 1. Single Operator Input Workflow

- Operators interact with one `Well Event` card in the well detail panel.
- They do not need to understand `operational_statuses` versus `pump_changes`.
- They can move directly between `clear`, `watch`, `warning`, and `down` in any order.

### 2. Separate Fulfillment Workflow

- MPS uses a secondary fulfillment workflow after an operator event exists.
- Fulfillment covers tool reservation, crew assignment, visit date, install progress, and completion.
- Operators can see fulfillment status, but MPS owns the fields.

### 3. Keep Tool Inventory Separate From WellFi Device Inventory

- Decision locked: MPS field tools and current `device_inventory` are separate systems.
- Create a separate `tool_inventory` model, with event-level assignment owned by fulfillment records.
- Do not overload the current `device_inventory` table, which is currently shaped around WellFi device lifecycle.

Reason:

- `device_inventory` is a serial-tracked installed-device lifecycle.
- The requested workflow sounds like field-service tooling and planning inventory, which has different business meaning.

### 4. Outbound Slack First

- Phase 1 must send Slack alerts when a well event is created, escalated, de-escalated, or cleared.
- Phase 1 does not require inbound Slack or Telegram commands.
- Phase 2 can add Slack-triggered event creation using a signed slash command or Slack workflow.

## Scope

### In Scope

- New operator-facing `Well Event` UX
- New MPS fulfillment UX
- Status history and auditability
- Tool reservation and assignment
- Dispatch date and expected downtime planning
- Operator-scoped permissions
- Slack outbound notifications
- Mobile usability
- Test coverage and release checklist updates

### Out of Scope

- Telegram bot integration
- AI-generated recommendations
- Automated telemetry-derived well status
- Historical production-loss forecasting beyond a simple estimated impact field
- Full optimization or routing engine for crew scheduling

## User Roles

### Operator User

- Can create, edit, and clear events on wells in their own operator scope
- Can enter:
  - event state
  - expected down date
  - expected date window
  - abrupt/unplanned flag
  - notes
  - support requested flag
  - requested tool type
- Can view MPS fulfillment progress
- Cannot assign tools from inventory
- Cannot assign crew
- Cannot mark internal execution steps complete

### MPS Admin

- Can do everything operator users can do
- Can assign or reserve tools
- Can assign a field tech or crew
- Can set planned service date
- Can advance fulfillment stages
- Can close the event

## Workflow

## Operator Workflow

1. Operator opens a well from the map, search, or action list.
2. Operator sees a top-of-panel `Well Event` card.
3. Operator taps one of:
   - `Watch`
   - `Warning`
   - `Down`
   - `Clear`
4. Operator optionally adds:
   - expected down date
   - earliest/latest window
   - abrupt event toggle
   - notes
   - support requested toggle
   - requested tool type
5. Operator saves.
6. Dashboard updates immediately.
7. Slack alert goes to MPS.
8. MPS begins fulfillment.

## MPS Workflow

1. MPS sees the event in Slack and in the dashboard queues.
2. MPS opens the well.
3. MPS assigns or reserves a tool.
4. MPS sets planned field support date.
5. MPS assigns a technician or crew.
6. MPS advances fulfillment stages as work progresses.
7. MPS closes the fulfillment when work is complete.
8. Operator clears the event, or MPS clears it if operationally appropriate.

## Required Transition Rules

- `clear -> watch`
- `clear -> warning`
- `clear -> down`
- `watch -> warning`
- `watch -> down`
- `warning -> watch`
- `warning -> down`
- `down -> warning`
- `down -> clear`
- `watch -> clear`
- `warning -> clear`

No forced sequence is required.

## State Model

### Operator-Facing Event State

- `clear`
- `watch`
- `warning`
- `down`

### MPS Fulfillment State

- `unassigned`
- `tool_reserved`
- `scheduled`
- `dispatched`
- `on_site`
- `completed`
- `cancelled`

These states solve two different problems:

- event state = what is happening to the well
- fulfillment state = what MPS is doing about it

They must not be collapsed into one field.

## Data Model

## Keep Existing Tables

- `wells`
- `operational_statuses`
- `pump_changes`
- `device_inventory`

## New Tables

### `well_events`

Purpose:

- canonical operator-facing event record for this workflow
- one stable open incident row per well while the event is active
- audit log stores the state-change history for that open row

Suggested columns:

- `id UUID PRIMARY KEY`
- `well_id UUID NOT NULL REFERENCES wells(id)`
- `operator_id UUID NOT NULL REFERENCES operators(id)`
- `state TEXT NOT NULL CHECK (state IN ('watch','warning','down'))`
- `is_active BOOLEAN NOT NULL DEFAULT TRUE`
- `is_abrupt BOOLEAN NOT NULL DEFAULT FALSE`
- `support_requested BOOLEAN NOT NULL DEFAULT TRUE`
- `expected_down_date DATE`
- `expected_start_date DATE`
- `expected_end_date DATE`
- `requested_tool_type TEXT`
- `notes TEXT`
- `created_by_user_id UUID`
- `created_by_name TEXT NOT NULL`
- `updated_by_user_id UUID`
- `updated_by_name TEXT`
- `source_channel TEXT NOT NULL DEFAULT 'app' CHECK (source_channel IN ('app','slack','telegram','admin'))`
- `created_at TIMESTAMPTZ NOT NULL DEFAULT now()`
- `updated_at TIMESTAMPTZ NOT NULL DEFAULT now()`
- `cleared_at TIMESTAMPTZ`
- `cleared_by_user_id UUID`
- `cleared_by_name TEXT`

Constraints:

- one active event per well
- `expected_start_date <= expected_end_date` when both exist
- `state` is required whenever `is_active = true`

### `well_event_fulfillment`

Purpose:

- one fulfillment record tied to the active event

Suggested columns:

- `id UUID PRIMARY KEY`
- `well_event_id UUID NOT NULL REFERENCES well_events(id) ON DELETE CASCADE`
- `status TEXT NOT NULL CHECK (status IN ('unassigned','tool_reserved','scheduled','dispatched','on_site','completed','cancelled'))`
- `assigned_tool_id UUID REFERENCES tool_inventory(id)`
- `assigned_tech_user_id UUID`
- `assigned_tech_name TEXT`
- `planned_service_date DATE`
- `expected_downtime_hours NUMERIC`
- `estimated_production_loss_bbl NUMERIC`
- `internal_notes TEXT`
- `last_updated_by_user_id UUID`
- `last_updated_by_name TEXT`
- `created_at TIMESTAMPTZ NOT NULL DEFAULT now()`
- `updated_at TIMESTAMPTZ NOT NULL DEFAULT now()`
- `completed_at TIMESTAMPTZ`

Constraint:

- one fulfillment record per active event

### `tool_inventory`

Purpose:

- inventory of MPS field tools available for assignment or reservation

Suggested columns:

- `id UUID PRIMARY KEY`
- `serial_number TEXT UNIQUE`
- `tool_type TEXT NOT NULL`
- `model TEXT`
- `status TEXT NOT NULL CHECK (status IN ('in_stock','reserved','deployed','service','retired'))`
- `notes TEXT`
- `created_at TIMESTAMPTZ NOT NULL DEFAULT now()`
- `updated_at TIMESTAMPTZ NOT NULL DEFAULT now()`

### `well_event_audit_log`

Purpose:

- append-only audit trail for every event change

Suggested columns:

- `id UUID PRIMARY KEY`
- `well_event_id UUID REFERENCES well_events(id)`
- `well_id UUID NOT NULL REFERENCES wells(id)`
- `actor_user_id UUID`
- `actor_name TEXT NOT NULL`
- `actor_role TEXT NOT NULL`
- `action TEXT NOT NULL`
- `from_state TEXT`
- `to_state TEXT`
- `source_channel TEXT NOT NULL`
- `payload JSONB NOT NULL DEFAULT '{}'::jsonb`
- `created_at TIMESTAMPTZ NOT NULL DEFAULT now()`

### `well_activity_log`

Purpose:

- unified per-well timeline for later reference in the app
- captures major operational events across workflows
- includes WellFi installation timestamps

Suggested columns:

- `id UUID PRIMARY KEY`
- `well_id UUID NOT NULL REFERENCES wells(id)`
- `operator_id UUID NOT NULL REFERENCES operators(id)`
- `activity_type TEXT NOT NULL`
- `source_table TEXT NOT NULL`
- `source_record_id UUID`
- `actor_user_id UUID`
- `actor_name TEXT`
- `occurred_at TIMESTAMPTZ NOT NULL`
- `payload JSONB NOT NULL DEFAULT '{}'::jsonb`
- `created_at TIMESTAMPTZ NOT NULL DEFAULT now()`

Initial activity types:

- `well_event_created`
- `well_event_updated`
- `well_event_escalated`
- `well_event_deescalated`
- `well_event_cleared`
- `wellfi_installed`
- `wellfi_deactivated`

## Relationship to Existing Tables

### `operational_statuses`

Recommendation:

- stop using this as the long-term primary table for this workflow
- preserve it during transition
- optionally backfill from `well_events` for map compatibility during rollout

Reason:

- it is close, but too narrow for the required planning and audit fields
- it is already partially overloaded with pump-change dates

### `pump_changes`

Recommendation:

- keep it for MPS execution only if still needed
- do not expose it as the operator's primary workflow
- either:
  - derive it from `well_event_fulfillment`, or
  - retire it after fulfillment UI replaces it

Preferred path:

- migrate toward `well_event_fulfillment`

## RLS and Permissions

## `well_events`

Operator users:

- `SELECT` on events for their own operator wells
- `INSERT` on events for their own operator wells
- `UPDATE` active events for their own operator wells

MPS admins:

- full access

Rules:

- operator user must only touch wells where `wells.operator_id = current_app_user_operator_id()`
- operator user cannot edit MPS-only fulfillment fields

## `well_event_fulfillment`

Operator users:

- read-only for their own wells

MPS admins:

- full access

## `tool_inventory`

Operator users:

- no direct tool inventory access in phase 1
- expose assigned tool summary through fulfillment-facing UI later if needed

MPS admins:

- full access

## `well_activity_log`

Operator users:

- read timeline entries for their own wells

MPS admins:

- full access

## API / Hook Layer

## New Hooks

- `useWellEvents(wellId?)`
- `useSetWellEvent()`
- `useClearWellEvent()`
- `useWellEventFulfillment(wellEventId?)`
- `useUpdateWellEventFulfillment()`
- `useToolInventory()`
- `useAssignToolToEvent()`

## Required Service Behavior

- event set/replace must be atomic
- do not split event writes across separate client calls
- create, update, and clear through one trusted RPC or server-side path
- implement as:
  - RPC, meaning a database function callable from Supabase, or
  - Edge Function

Recommended:

- use a Postgres function `set_well_event(...)`

Why:

- avoids race conditions
- keeps event history and active-event uniqueness correct
- centralizes validation

## Validation Rules

- `expected_start_date <= expected_end_date`
- `expected_down_date` cannot coexist with a conflicting window without explicit rule
- `down` may be saved with no date if `is_abrupt = true`
- `requested_tool_type` is optional in phase 1
- `notes` optional but encouraged for `warning` and `down`

## UI Specification

## Desktop Well Detail Panel

Top card:

- Title: `Well Event`
- Primary action buttons:
  - `Watch`
  - `Warning`
  - `Down`
  - `Clear`

Below actions:

- `Expected date`
- `Date window`
- `Abrupt / unplanned`
- `Need MPS support`
- `Requested tool`
- `Notes`

Secondary read-only or MPS-only section:

- `Fulfillment Status`
- `Assigned Tool`
- `Planned Service Date`
- `Assigned Tech`
- `Expected Downtime`
- `Estimated Production Impact`

### Operator Experience Rules

- no hidden "add notes" or "add date window" reveal links in phase 1
- fields should be directly visible
- form must fit in the first screenful on desktop

### Mobile Experience Rules

- sticky bottom action row or sticky top action row
- same four primary actions
- no nested modal inside the bottom sheet
- save button always visible

## Dashboard Changes

### Replace or Extend Current Action Items

Required queues:

- `Down Now`
- `Warnings`
- `Watch`
- `Needs Tool Assignment`
- `Scheduled Support`

Each queue item should show:

- well name
- field
- current event state
- requested or assigned tool
- planned date
- fulfillment badge

## Filters

Add:

- `Flagged Only`
- `Needs Tool`
- `Scheduled Support`
- `Down Now`

Rename:

- current `Upcoming Only` is too vague
- replace with `Scheduled Support Only`

## Map Behavior

- flagged wells remain visually distinct
- legend must match actual colors and labels
- `Down` must be the highest-severity visual state
- map popup should show:
  - event state
  - event date/window
  - fulfillment status
  - assigned tool if present

## Notifications

## Outbound Slack

Trigger events:

- event created
- event escalated
- event de-escalated
- event cleared
- fulfillment tool assigned
- service date scheduled

Slack payload should include:

- operator name
- well name
- formatted identifier
- event state
- abrupt/planned indicator
- expected date or window
- requested tool
- notes
- fulfillment status if applicable
- deep link to `/map?well_id=...`

## Existing Function

- The current outbound notifier exists at `supabase/functions/notify-operational-status/index.ts`.
- Phase 1 must verify production wiring:
  - function deployed
  - secrets configured
  - database webhook or trigger actually invoking it

## Inbound Slack

Phase 2 only.

Recommended design:

- Slack slash command or Slack workflow form
- signed request verification
- well lookup within operator scope
- write through a server-side trusted path
- append audit log entry

## Telegram

Phase 3 only.

Reason:

- adds a second bot surface
- adds identity and security complexity
- should not be built before product adoption proves demand

## Migration Strategy

## Phase 1A: Foundation

- add new tables
- add RLS
- add RPC or Edge Function for atomic event set/clear
- add hooks
- add audit log
- add unified well activity log

## Phase 1B: UI

- replace current operator-facing status form with `Well Event` card
- add MPS fulfillment section
- update dashboard queues and filters
- fix map legend and popup consistency

## Phase 1C: Notifications

- connect outbound Slack to new event model
- verify deep links
- update testing docs

## Phase 1D: Transition

- keep old `operational_statuses` and `pump_changes` code running during transition if needed
- remove or hide old UI entry points once new flow is stable

## Acceptance Criteria

### Operator

- Operator can set `watch`, `warning`, `down`, and `clear` on their own wells.
- Operator can do this on desktop and mobile in under 15 seconds.
- Operator sees the well remain flagged on their dashboard after refresh.

### MPS

- MPS receives Slack alert for every meaningful event change.
- MPS can assign a tool and set a service date.
- MPS can see all flagged wells across scoped operators.

### Data Integrity

- Only one active event per well
- All state changes audited
- No cross-operator access
- Tool assignment always tied to an active event

## Test Plan

## Automated

- migration applies cleanly
- RLS tests for operator scope
- validation tests for date rules
- atomic replace tests for active events

## Manual

1. Operator logs in.
2. Operator opens a well.
3. Operator sets `watch`.
4. Operator updates to `warning`.
5. Operator updates to abrupt `down`.
6. Operator clears the event.
7. MPS assigns a tool.
8. MPS sets planned service date.
9. Slack messages arrive with correct details and links.
10. Mobile sheet flow works without hidden controls.

## Risks

- Running both old and new workflows in parallel for too long will create data drift.
- If event writes remain client-side and non-atomic, concurrent edits will eventually create history and active-state bugs.
- Inbound chat commands without strong auth and audit would be a high-risk mistake.

## Recommended File / System Change List

### Database

- new migration for `well_events`
- new migration for `well_event_fulfillment`
- new migration for `tool_inventory`
- new migration for `well_event_audit_log`
- new migration for RLS and helper functions
- optional migration to bridge legacy `operational_statuses`

### Frontend

- `src/pages/MapPage.tsx`
- `src/components/panels/RightPanel.tsx`
- `src/components/panels/UpcomingList.tsx`
- `src/components/panels/OperatorOverviewCard.tsx`
- `src/components/panels/InventoryOverview.tsx`
- `src/components/map/WellMap.tsx`
- new `src/components/forms/WellEventForm.tsx`
- new `src/components/panels/WellEventFulfillment.tsx`
- new hooks under `src/hooks/`

### Notifications

- update `supabase/functions/notify-operational-status/index.ts` or replace with a new event-oriented notifier
- add production deployment and trigger verification steps

### Docs

- `TESTING_PROTOCOL.md`
- `User_Walkthrough.md`
- `AGENTS.md`
- `CLAUDE.md`
- `GEMINI.md`
- `docs/current-state.md`

## Final Recommendation

- This should be implemented as a focused product lane, not a loose UI tweak.
- The cleanest path is:
  1. canonical `well_events`
  2. MPS fulfillment model
  3. operator write permissions
  4. unified panel UX
  5. Slack outbound
  6. Slack inbound later

- If this is done well, it becomes the operational heartbeat of the app.
- If it is done as layered patches on top of the current split model, it will get hard to reason about very quickly.
