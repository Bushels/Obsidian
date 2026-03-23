# Well Event Workflow Phase Execution Plan

**Date:** 2026-03-21
**Depends on:** `docs/plans/2026-03-21-well-event-implementation-spec.md`

## Direct Recommendation

- Execute this in 6 phases.
- Stop after each phase and verify before moving on.
- Do not try to build the full operator workflow, tool inventory, Slack behavior, and legacy migration in one pass.

Why:

- The workflow crosses schema, RLS, UI, notifications, and mobile.
- If all of that moves at once, you will lose track of what broke and why.

## Locked Decisions

- `tool_inventory` stays separate from existing `device_inventory`
- `well_events` becomes the canonical operator-facing workflow
- MPS fulfillment is separate from operator event entry
- outbound Slack is phase 4
- inbound Slack is not part of this execution plan

## Delivery Shape

### Phase 0: Design Freeze and Legacy Mapping

Goal:

- freeze the business rules before touching schema

Deliverables:

- confirm final event vocabulary:
  - `watch`
  - `warning`
  - `down`
  - `clear`
- confirm fulfillment vocabulary:
  - `unassigned`
  - `tool_reserved`
  - `scheduled`
  - `dispatched`
  - `on_site`
  - `completed`
  - `cancelled`
- confirm what `requested_tool_type` values should look like in v1
- confirm whether `estimated_production_loss_bbl` is manual-only in v1
- confirm whether clearing an event should auto-cancel fulfillment or require explicit MPS action

Files:

- [2026-03-21-well-event-implementation-spec.md](C:/Users/kyle/MPS/Obsidian/wellfi-app/docs/plans/2026-03-21-well-event-implementation-spec.md)

Exit gate:

- no unresolved vocabulary or workflow ambiguity

### Phase 1: Canonical Schema and Atomic Write Path

Goal:

- create the new data model without changing the UI yet

Build:

- add migration for `well_events`
- add migration for `well_event_fulfillment`
- add migration for `tool_inventory`
- add migration for `well_event_audit_log`
- add migration for `well_activity_log`
- add indexes and constraints
- add RLS policies for operator-scoped event writes and MPS-only fulfillment writes
- add RPC or Postgres function:
  - `set_well_event(...)`
  - `clear_well_event(...)`
- make event writes atomic

Key rules:

- one active event per well
- append history, do not overwrite history
- validate date ranges in SQL
- write audit rows inside the same transaction
- write timeline rows for operator events and WellFi installs

Primary files:

- new files under [supabase/migrations](C:/Users/kyle/MPS/Obsidian/wellfi-app/supabase/migrations)
- [auth.tsx](C:/Users/kyle/MPS/Obsidian/wellfi-app/src/lib/auth.tsx) only if role data must expand
- [supabase.ts](C:/Users/kyle/MPS/Obsidian/wellfi-app/src/lib/supabase.ts) for generated or updated table typing

Tests:

- migration applies cleanly
- operator can insert event only for own operator wells
- operator cannot write fulfillment
- admin can write everything
- invalid date ranges fail
- repeated set replaces active event cleanly

Exit gate:

- schema is stable
- atomic event write path works
- no UI changes merged yet

### Phase 2: Read Layer and Legacy Bridge

Goal:

- make frontend able to consume the new model before replacing the UX

Build:

- add hooks:
  - `useWellEvents`
  - `useSetWellEvent`
  - `useClearWellEvent`
  - `useWellEventFulfillment`
  - `useUpdateWellEventFulfillment`
  - `useToolInventory`
  - `useAssignToolToEvent`
- update the well join layer to include:
  - active event
  - fulfillment summary
  - assigned tool summary
- keep old `operational_statuses` and `pump_changes` joins temporarily if needed
- define a temporary bridge strategy for map and action list rendering

Decision point:

- either render the map from new `well_events` immediately
- or temporarily map `well_events` into the current status shape until phase 3 completes

Primary files:

- [useWells.ts](C:/Users/kyle/MPS/Obsidian/wellfi-app/src/hooks/useWells.ts)
- new files under [src/hooks](C:/Users/kyle/MPS/Obsidian/wellfi-app/src/hooks)
- [operationalStatus.ts](C:/Users/kyle/MPS/Obsidian/wellfi-app/src/types/operationalStatus.ts) if transitional typing is needed
- new type files under [src/types](C:/Users/kyle/MPS/Obsidian/wellfi-app/src/types)

Tests:

- realtime invalidation still works
- well detail loads new event data
- no duplicate active event shown
- operator scope still respected

Exit gate:

- frontend can read new workflow data end-to-end
- old UI still works during transition

### Phase 3: Operator Well Event UX

Goal:

- replace the current status entry flow with the new operator workflow

Build:

- add `WellEventForm.tsx`
- replace `OperationalStatusForm` in the right panel for operator entry
- keep the event card at the top of the well detail panel
- expose direct actions:
  - `Watch`
  - `Warning`
  - `Down`
  - `Clear`
- include always-visible fields:
  - expected date
  - date window
  - abrupt toggle
  - support requested
  - requested tool type
  - notes
- create mobile-first layout behavior with sticky primary actions

Primary files:

- [RightPanel.tsx](C:/Users/kyle/MPS/Obsidian/wellfi-app/src/components/panels/RightPanel.tsx)
- new [WellEventForm.tsx](C:/Users/kyle/MPS/Obsidian/wellfi-app/src/components/forms/WellEventForm.tsx)
- [MapPage.tsx](C:/Users/kyle/MPS/Obsidian/wellfi-app/src/pages/MapPage.tsx)

Remove or hide:

- old admin-only operator status entry points
- hidden "add notes" / "add date window" reveal pattern

Tests:

- operator can create event on desktop
- operator can create event on mobile
- operator can jump straight from clear to down
- operator can clear an event
- refresh preserves state

Exit gate:

- operator can perform the core action in under 15 seconds
- mobile flow feels obvious

### Phase 4: MPS Fulfillment and Tool Inventory

Goal:

- give MPS the internal workflow needed after an event is raised

Build:

- add `WellEventFulfillment.tsx`
- add `tool_inventory` admin views
- allow MPS to:
  - reserve tool
  - assign tool
  - set planned service date
  - assign tech
  - update fulfillment stage
  - set downtime and production-impact estimates
- add dashboard queues:
  - `Down Now`
  - `Warnings`
  - `Watch`
  - `Needs Tool Assignment`
  - `Scheduled Support`

Primary files:

- new [WellEventFulfillment.tsx](C:/Users/kyle/MPS/Obsidian/wellfi-app/src/components/panels/WellEventFulfillment.tsx)
- [UpcomingList.tsx](C:/Users/kyle/MPS/Obsidian/wellfi-app/src/components/panels/UpcomingList.tsx)
- [OperatorOverviewCard.tsx](C:/Users/kyle/MPS/Obsidian/wellfi-app/src/components/panels/OperatorOverviewCard.tsx)
- [InventoryOverview.tsx](C:/Users/kyle/MPS/Obsidian/wellfi-app/src/components/panels/InventoryOverview.tsx)
- new admin inventory components if needed

Tests:

- MPS can reserve a tool to an event
- only one active tool assignment exists where intended
- operator sees assigned tool but cannot change it
- queues reflect fulfillment state correctly

Exit gate:

- MPS can operationally prepare for a down well from inside the app

### Phase 5: Map, Dashboard, and Notification Integration

Goal:

- make the whole system visible and actionable everywhere it matters

Build:

- update map rendering to use canonical event state
- fix legend consistency
- update popups to show event + fulfillment summary
- wire outbound Slack from `well_events` and fulfillment changes
- verify production webhook or trigger path to the existing edge function, or replace it with a new event notifier
- add operator and MPS dashboard filters:
  - `Flagged Only`
  - `Needs Tool`
  - `Scheduled Support`
  - `Down Now`

Primary files:

- [WellMap.tsx](C:/Users/kyle/MPS/Obsidian/wellfi-app/src/components/map/WellMap.tsx)
- [notify-operational-status/index.ts](C:/Users/kyle/MPS/Obsidian/wellfi-app/supabase/functions/notify-operational-status/index.ts) or successor function
- [MapPage.tsx](C:/Users/kyle/MPS/Obsidian/wellfi-app/src/pages/MapPage.tsx)

Tests:

- Slack message on create
- Slack message on escalate
- Slack message on clear
- Slack deep link opens the correct well
- map and dashboard counts match active events

Exit gate:

- event is visible in panel, dashboard, map, and Slack

### Phase 6: Legacy Cleanup and Release Hardening

Goal:

- remove transitional complexity and lock the workflow down

Build:

- remove deprecated UI paths based on `operational_statuses`
- retire or reduce dependency on `pump_changes` if replaced
- update docs and testing protocol
- tighten type safety for new tables
- clean up any temporary compatibility code in `useWells`

Primary files:

- [useWells.ts](C:/Users/kyle/MPS/Obsidian/wellfi-app/src/hooks/useWells.ts)
- [TESTING_PROTOCOL.md](C:/Users/kyle/MPS/Obsidian/wellfi-app/TESTING_PROTOCOL.md)
- [User_Walkthrough.md](C:/Users/kyle/MPS/Obsidian/wellfi-app/User_Walkthrough.md)
- [AGENTS.md](C:/Users/kyle/MPS/Obsidian/wellfi-app/AGENTS.md)
- [CLAUDE.md](C:/Users/kyle/MPS/Obsidian/wellfi-app/CLAUDE.md)
- [GEMINI.md](C:/Users/kyle/MPS/Obsidian/wellfi-app/GEMINI.md)
- [current-state.md](C:/Users/kyle/MPS/Obsidian/wellfi-app/docs/current-state.md)

Tests:

- full release checklist
- operator smoke test
- MPS smoke test
- mobile smoke test
- no dead UI branches

Exit gate:

- workflow is canonical
- legacy split model is no longer confusing product behavior

## Suggested Build Order Inside Each Phase

For every phase:

1. schema or contract first
2. hooks or data plumbing second
3. UI third
4. tests and docs last

This order matters because it keeps the app from growing orphaned UI that has no stable backend contract.

## Recommended Implementation Sequence

If you want the cleanest engineering path:

1. Phase 1
2. Phase 2
3. demo read-path internally
4. Phase 3
5. operator UX review
6. Phase 4
7. MPS operations review
8. Phase 5
9. end-to-end testing
10. Phase 6

## What Not To Do

- do not let operators write directly to the old `operational_statuses` path while also creating `well_events`
- do not mix tool inventory into `device_inventory`
- do not add inbound Slack before the in-app flow is stable
- do not keep both old and new dashboard queues active longer than necessary
- do not ship without mobile verification

## Recommended First Implementation Ticket

Start with:

- Phase 1 only

Concrete first ticket:

- add `well_events`
- add `well_event_fulfillment`
- add `tool_inventory`
- add `well_event_audit_log`
- add `well_activity_log`
- add atomic SQL write functions
- add RLS

Why:

- everything else depends on a clean canonical model
- this is the point where complexity is either prevented or created

## Verification Checklist By Phase

### Phase 1

- migrations apply
- RLS works
- audit rows write
- atomic event replacement works

### Phase 2

- hooks return correct data
- realtime invalidation works
- no duplicate active event in well joins

### Phase 3

- operator can set and clear events in under 15 seconds
- mobile sheet is usable

### Phase 4

- MPS can assign tool and service date
- queues reflect operational reality

### Phase 5

- Slack messages and deep links work
- map and dashboard show consistent state

### Phase 6

- docs match product
- legacy code path removed or quarantined

## Final Recommendation

- Treat this as a controlled migration, not a feature patch.
- The highest-value next move is Phase 1 schema and atomic write path.
- Once that exists, the UI work becomes much easier to reason about.
