# Data Quality Agent -- Session 6 Completion Report

## Agent
- **ID:** agent-data-quality
- **Session:** 6
- **Date:** 2026-02-19

## What Was Changed

**File modified:** `src/hooks/useWells.ts`

Added a `.neq('well_status', 'Abandoned')` filter to the Supabase query that fetches wells. The filter is applied at the database level, before the `.order()` call, so abandoned wells are never returned to the client.

### Before
```ts
const { data: wells, error } = await supabase
  .from('wells')
  .select('*')
  .order('months_running', { ascending: false, nullsFirst: false });
```

### After
```ts
const { data: wells, error } = await supabase
  .from('wells')
  .select('*')
  .neq('well_status', 'Abandoned')
  .order('months_running', { ascending: false, nullsFirst: false });
```

## Why

WellFi is an operational monitoring dashboard. Abandoned wells are permanently decommissioned and have no active equipment, no pump life to track, and no WellFi devices. Displaying them on the map creates visual clutter and misleading well counts for field engineers. Filtering at the database level ensures:

1. Abandoned wells never reach the client, reducing payload size.
2. The map, sidebar lists, filter counts, and all downstream consumers automatically exclude abandoned wells with zero additional logic.
3. The filter is a single Supabase PostgREST clause, so there is no performance cost.

## Impact

| Metric | Before | After |
|--------|--------|-------|
| Total wells returned | 211 | 210 |
| Abandoned wells shown | 1 | 0 |

### Abandoned Well Removed
- **Well name:** PENN WEST SEAL 16-8-82-15
- **Well ID (DLS):** 100160808215W500

## Verification

- `npx tsc --noEmit` passed with zero errors.
- No frozen files (`src/types.ts`, `src/lib/supabase.ts`) were modified.
- No other files were modified.

## Files Written
- `src/hooks/useWells.ts` (modified -- 1 line added)
- `agents/session-6/data-quality-report.md` (created -- this file)
