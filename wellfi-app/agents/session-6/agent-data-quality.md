# Agent: Data Quality — Session 6

## Mission
Ensure the WellFi map only displays valid, active wells. Remove abandoned wells from being fetched/displayed.

## Scope
- **Owns**: `src/hooks/useWells.ts` (data query modification)
- **Reads**: `src/types.ts` (frozen), `supabase/migrations/001_initial_schema.sql`, `supabase/seed_rows.json`
- **Must not touch**: `src/types.ts`, `src/lib/supabase.ts`

## Tasks

### 1. Filter Abandoned Wells from Supabase Query
- Modify `useWells.ts` to exclude `well_status = 'Abandoned'` from the query
- Use `.neq('well_status', 'Abandoned')` in the Supabase chain
- This ensures abandoned wells never reach the frontend

### 2. Verify Well Status Distribution
- Confirm the 211-well dataset breakdown:
  - Pumping: 201
  - Suspended: 5
  - Operating: 4
  - Abandoned: 1 (PENN WEST SEAL 16-8-82-15 at 56.0987947, -116.3217575)
- After filtering, map should show 210 wells

### 3. Document Findings
- Write findings to `agents/session-6/data-quality-report.md`
- Include: what was filtered, why, well count before/after

## Completion Criteria
- Abandoned wells are excluded from the Supabase query
- Build passes (`npx tsc --noEmit`)
- Report written
