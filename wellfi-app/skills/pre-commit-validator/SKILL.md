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
Any string interpolated into popup HTML must use the popup helper escape function, for example `escapeHtml()` in `WellPopup.tsx`:
```bash
grep -n "escapeHtml" wellfi-app/src/components/map/WellPopup.tsx
```
**Pass criteria:** Popup helpers use explicit HTML escaping before interpolating user or data values into HTML.

## Check 6: GeoJSON Freshness
If the monthly production sync scripts were modified, rerun the current workflow:
```bash
npm run production:sync -- --dry-run "C:\Users\kyle\MPS\Obsidian\Data\active_clearwater_bluesky_recent_prod_ab_sk.csv"
```
Verify output counts match expectations and review the generated report.

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
