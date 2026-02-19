# Build Blockers — Pre-existing TypeScript Errors in Hooks

## Summary
`npm run build` fails due to TypeScript errors in `src/hooks/` files (owned by agent-hooks).
All agent-map files compile cleanly with zero errors.

## Root Cause
The `Database` type in `src/lib/supabase.ts` (FROZEN) defines table types in a shape that
the Supabase JS SDK v2.97 does not fully support for typed `.insert()`, `.update()`, and
`.upsert()` operations. The SDK expects a different generic structure for the `Tables` type,
causing `Insert` and `Update` types to resolve to `never`.

## Affected Files (NOT owned by agent-map)
- `src/hooks/usePumpChanges.ts` (lines 60, 86)
- `src/hooks/useWellFiDevices.ts` (lines 60, 67, 87)
- `src/hooks/useWells.ts` (lines 32, 33, 36, 37, 38)

## Suggested Fix
The `Database` type in `src/lib/supabase.ts` needs to match the Supabase typegen output format.
Specifically, each table needs `Row`, `Insert`, and `Update` with the correct structure that
the SDK recognizes. Running `npx supabase gen types typescript` against the project would
produce the correct type. Alternatively, the hooks can cast through `as any` but that reduces
type safety.

## Verification
Running `npx tsc -b 2>&1 | grep -E "^src/(lib/mapUtils|components/map|pages/MapPage)"` returns
zero errors, confirming all agent-map files are clean.
