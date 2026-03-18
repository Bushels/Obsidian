---
name: pre-commit-validator
description: Mandatory checks before committing WellFi code. Use this skill before any git commit, especially after modifying map layers, Supabase queries, build scripts, or component files. Also triggered by the 6-gate workflow Gate 3 (Verify).
---

# Pre-Commit Validator

7 mandatory checks before committing code to the WellFi repository. These checks enforce Gate 3 (Verify) of the 6-gate workflow.

## Check 1: TypeScript Build
```bash
cd wellfi-app && npx tsc --noEmit
```
**Pass criteria:** Zero errors. Do NOT commit with TS errors.
**Common fixes:** `as unknown as number` for Mapbox expressions, `as never` for frozen Supabase types.

## Check 2: Vite Build
```bash
cd wellfi-app && npm run build
```
**Pass criteria:** Build completes without errors. Check for unused imports (TS6133), unreachable code, missing modules.

## Check 3: No Console Errors
Start dev server and verify zero console errors on fresh page load:
- Use `preview_start` + `preview_console_logs` (level: error)
- Or manually: `npm run dev` → open browser → check console

## Check 4: Stale Reference Scan
```bash
grep -rn "showLand\|toggleLand\|showProduction\|toggleProduction\|HEALTH_LEVEL_LABELS\|posterStyle" wellfi-app/src/ --include="*.ts" --include="*.tsx"
```
**Pass criteria:** Zero matches. These are removed features.

## Check 5: HTML Escaping
Any string interpolated into popup HTML must use `escapeHTML()`:
```bash
grep -n "properties\." wellfi-app/src/components/map/ProductionPopup.ts | grep -v "escapeHTML\|Number\|String"
```
**Pass criteria:** No unescaped string properties in HTML template literals.

## Check 6: GeoJSON Freshness
If `scripts/build-production-geojson.js` was modified, regenerate:
```bash
node scripts/build-production-geojson.js
```
Verify output counts match expectations. Commit both script AND generated GeoJSON.

## Check 7: Git Diff Review
```bash
git diff --stat
git diff --cached --stat
```
Verify:
- No `.env` or credential files staged
- No `node_modules/` or build artifacts staged
- Commit message follows conventional format (`feat:`, `fix:`, `docs:`, `refactor:`, `style:`)
- Co-Author line included for AI-assisted commits
