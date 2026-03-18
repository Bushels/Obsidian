---
name: documentation-patrol
description: Detect stale documentation across the WellFi project. Use this skill after major changes (new features, renamed constants, changed well counts, removed components), before creating PRs, or when the user asks to audit documentation freshness. Also use when conventions change (color constants, formation names, status values, layer IDs).
---

# Documentation Patrol

Systematic staleness detection across all WellFi documentation. Run after any major change to catch silent documentation drift.

## When to Run
- After adding/removing map layers or components
- After changing well counts (new data import, filter changes)
- After renaming constants, color values, or status strings
- Before creating a PR or merging to main
- As Gate 4 (Document) in the 6-gate workflow

## Patrol Checklist

### 1. Well Count Consistency
Grep for stale well counts across all docs:
```bash
cd wellfi-app
grep -rn "6,064\|6064\|5,194\|5194\|870\b" docs/ agents/ CLAUDE.md AGENTS.md *.md --include="*.md"
```
Current correct counts: 6,932 total (5,501 oil + 1,431 gas). Flag any file still referencing old counts.

### 2. Removed Component References
Grep for references to removed systems:
```bash
grep -rn "ParcelLayers\|HealthHeatmap\|parcelHealth\|showLand\|toggleLand\|showProduction\|toggleProduction\|HEALTH_LEVEL_LABELS\|posterStyle" src/ --include="*.ts" --include="*.tsx"
```
These were removed in Session 10. Any import or reference is a bug.

### 3. Color Constant Drift
Verify color constants are consistent across files:
```bash
grep -rn "#22C55E\|#F59E0B\|#86EFAC\|#FCD34D\|#3B82F6\|#EF4444" src/components/map/ --include="*.ts" --include="*.tsx"
```
Cross-reference with `ProductionGlow.ts` constants. Flag any hardcoded hex that doesn't match.

### 4. Layer ID Consistency
Verify layer IDs referenced in WellMap.tsx match ProductionGlow.ts exports:
```bash
grep -rn "clearwater-production-heatmap\|bluesky-production-heatmap\|clearwater-gas-heatmap\|bluesky-gas-heatmap\|production-well-dots" src/ --include="*.ts" --include="*.tsx"
```
Layer IDs should only be referenced via `PRODUCTION_LAYER_IDS` export, never hardcoded.

### 5. Memory File Currency
Check memory file ages:
```bash
ls -la ~/.claude/projects/C--Users-kyle-MPS-Obsidian/memory/
```
Flag any file older than 14 days for review. Check that `MEMORY.md` index references all memory files.

### 6. Agent Framework Sync
Verify MANIFEST.json and STATUS.json are consistent:
- All sessions in MANIFEST.json have entries in STATUS.json
- STATUS.json `last_updated` is within 7 days
- All completed sessions have `status: "completed"`

### 7. Design Doc Accuracy
For each design doc in `docs/plans/`, verify:
- Well counts match current GeoJSON
- Color values match current code
- Layer stack description matches current ProductionGlow.ts
- Normalization constants match current code

## Output Format
Report findings as:
```
STALE: [file:line] — references [old value], should be [new value]
OK: [file] — all references current
```
