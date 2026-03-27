---
name: documentation-patrol
description: Detect stale documentation across the WellFi project. Use this skill after major changes, before PRs, or when the user asks to audit documentation freshness.
---

# Documentation Patrol

Systematic staleness detection across all WellFi documentation. Run after any major change to catch silent documentation drift.

## When to Run

- After adding or removing map layers or components
- After changing well counts or monthly data workflow behavior
- After renaming constants, color values, status strings, or commands
- Before creating a PR or merging to main
- As Gate 4 (Document) in the 6-gate workflow
- Hand off to `skills/docs-maintainer/SKILL.md` when docs need to be updated, not just audited

## Patrol Checklist

### 0. Cross-Model Entrypoint Sync

Check the model-facing entrypoints together:

```bash
grep -rn "current-state.md\|agent-workflows.md\|docs-maintainer\|monthly-production-refresh" AGENTS.md CLAUDE.md GEMINI.md docs/ skills/ --include="*.md"
```

If workflow discovery changed, `AGENTS.md`, `CLAUDE.md`, and `GEMINI.md` should not disagree about where the current runbooks live.

### 1. Well Count Consistency

Grep for stale well counts across all docs:

```bash
cd wellfi-app
grep -rn "6,064\|6064\|5,194\|5194\|870\b" docs/ agents/ CLAUDE.md GEMINI.md AGENTS.md *.md --include="*.md"
```

Current correct counts should come from `docs/current-state.md` or the latest verified report, not old plan notes.

### 2. Removed Component References

Grep for references to removed systems:

```bash
grep -rn "ParcelLayers\|HealthHeatmap\|parcelHealth\|showLand\|toggleLand\|showProduction\|toggleProduction\|HEALTH_LEVEL_LABELS\|posterStyle" src/ --include="*.ts" --include="*.tsx"
```

If these are supposed to be gone, any remaining import or reference is a bug.

### 3. Color Constant Drift

Verify color constants are consistent across files:

```bash
grep -rn "#22C55E\|#F59E0B\|#86EFAC\|#FCD34D\|#3B82F6\|#EF4444" src/components/map/ --include="*.ts" --include="*.tsx"
```

Cross-reference with `ProductionGlow.ts` constants. Flag any hardcoded hex that no longer matches.

### 4. Layer And Map Architecture Consistency

Verify map docs describe the current split correctly:

```bash
grep -rn "clearwater-production-heatmap\|bluesky-production-heatmap\|clearwater-gas-heatmap\|bluesky-gas-heatmap\|clearwater-production-dots\|bluesky-production-dots\|production overlay" docs/ skills/ AGENTS.md CLAUDE.md GEMINI.md --include=\"*.md\"
```

Current implementation: base well dots come from live WellFi well data in `WellMap.tsx`, and `ProductionGlow.ts` hands off from heatmap to formation/fluid production dots at close zoom using the same palette as the heatmap. Flag any active doc that still presents the overlay as heatmap-only, leaves the color-match rule implicit, or references removed components like `ProductionPopup.ts`.

### 5. Memory File Currency

Check memory file ages:

```bash
ls -la ~/.claude/projects/C--Users-kyle-MPS-Obsidian/memory/
```

Flag any file older than 14 days for review. Check that `MEMORY.md` index references all memory files.

### 6. Agent Framework Sync

Verify `MANIFEST.json` and `STATUS.json` are consistent:

- All sessions in `MANIFEST.json` have entries in `STATUS.json`
- `STATUS.json` `last_updated` is within 7 days
- All completed sessions have `status: "completed"`

### 7. Plan Doc Hygiene

Stale plan docs should be deleted instead of preserved in place:

```bash
ls docs/plans
```

If `docs/plans/` contains outdated implementation plans that no longer match the live code, remove them so they cannot be accidentally treated as current architecture.

### 8. Monthly Workflow Currency

Verify the standard monthly workflow docs point to the current command:

```bash
grep -rn "production:sync\|production:refresh" docs/ skills/ AGENTS.md CLAUDE.md GEMINI.md package.json --include="*.md"
```

`production:sync` should be the standard monthly import path. `production:refresh` should be documented as overlay-only fallback.

## Output Format

Report findings as:

```text
STALE: [file:line] - references [old value], should be [new value]
OK: [file] - all references current
```
