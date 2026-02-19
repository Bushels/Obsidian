# agent-hooks Completion Report — Session 2

## Files Created

### src/hooks/useWells.ts
- `useWells()` hook fetches all wells with joined WellFi devices and active pump changes
- Three parallel Supabase queries: wells, active devices, active pump changes (warning/scheduled/in_progress)
- In-memory join by `wells.id` (UUID) — not `wells.well_id` (TEXT)
- 30-second stale time for caching
- Real-time subscription on `wells`, `wellfi_devices`, and `pump_changes` tables invalidates the query cache

### src/hooks/usePumpChanges.ts
- `usePumpChanges(wellId?)` — query hook with optional well UUID filter, ordered by `flagged_at` descending
- `useCreatePumpChange()` — mutation to insert a new pump change row
- `useUpdatePumpChange()` — mutation accepting `{ id, updates }` to patch an existing pump change
- Both mutations invalidate `['pump_changes']` and `['wells']` query keys on success
- Real-time subscription on `pump_changes` table

### src/hooks/useWellFiDevices.ts
- `useWellFiDevices(wellId?)` — query hook with optional well UUID filter, ordered by `created_at` descending
- `useRegisterWellFiDevice()` — mutation that deactivates existing active devices for the well, then inserts the new device
- `useDeactivateWellFiDevice()` — mutation to set `is_active = false` on a device by its ID
- All mutations invalidate `['wellfi_devices']` and `['wells']` query keys on success
- Real-time subscription on `wellfi_devices` table

## Key Design Decisions
- All joins use `wells.id` (UUID PK), never `wells.well_id` (TEXT)
- `import type` used for all type-only imports (verbatimModuleSyntax compliance)
- No unused imports or parameters (noUnusedLocals / noUnusedParameters compliance)
- Path alias `@/*` used for all imports
- Real-time channels use unique names per hook instance (incorporating wellId when applicable)
- Supabase channel cleanup in useEffect return functions
