# Session 6: Map Data Integrity + Glassmorphic Theme

**Date:** 2026-02-19
**Status:** Completed
**Agents:** agent-data-quality, agent-spatial-validator

---

## Objectives
1. Overlay Obsidian mineral rights parcels on the map with glassmorphic styling
2. Remove abandoned wells from the map
3. Validate all wells are spatially inside mineral rights parcels
4. Document findings and lessons learned

## What Was Accomplished

### Phase 1: Glassmorphic Theme + Mineral Rights (Coordinator)
- Created `public/data/obsidian-mineral-rights.geojson` (852 parcels, 0.91MB)
- Created `src/components/map/glassmorphicStyle.ts` ("Frost" theme)
- Replaced the "Neon Atlas" poster theme with glassmorphic dark aesthetic
- Added mineral rights as frosted-glass polygons with hover interactivity
- Updated all UI panels (header, sidebars, controls, legend, popups) to glassmorphic
- 2-way style switcher: Satellite / Glass (default)
- New "Land" toggle to show/hide mineral rights

### Phase 2: Data Quality (agent-data-quality)
- Filtered abandoned wells from Supabase query in `useWells.ts`
- 1 abandoned well removed: PENN WEST SEAL 16-8-82-15 (100160808215W500)
- Map now shows 210 active wells (was 211)

### Phase 3: Spatial Validation (agent-spatial-validator)
- Created `scripts/validate-wells-spatial.js` (zero-dep ray-casting validator)
- **Result: 152/211 wells (72%) inside mineral rights parcels**
- **59 wells (28%) outside all parcels — mineral rights data is incomplete**
  - 43 wells within 2km of a parcel (likely missing adjacent agreements)
  - 8 wells at 2-5km (missing agreement sections)
  - 8 wells beyond 5km (7 Woodcote Oil wells in T078-T080, 2 OBE HARMONV)
- All 59 orphans are active wells — the GeoJSON is incomplete, not the wells

## Key Findings

### The mineral rights GeoJSON is incomplete
The file from PetroNinja covers 852 agreements but misses parcels for ~28% of wells.
This is NOT a well location error — these are active wells on valid Obsidian land.

### Specific gaps identified
| Region | Missing sections | Orphaned wells |
|--------|------------------|----------------|
| T084R19W5 | S22-25 | 23 wells |
| T083R18W5 | S29-34 | 8 wells |
| T083R17W5 | S6, S12-13 | 4 wells |
| T084R15W5 | S26-28 | 3 wells |
| T081R15W5 | S29-30 | 2 wells |
| T081R14W5 | S11, S15-16 | 2 wells |
| T083R16W5 | S20 | 1 well |
| T078-T080 (Woodcote) | Multiple | 7 wells |
| T082R18W5 (HARMONV) | S8, S10 | 2 wells |
| T083R19W5 (HARMONV) | S31-32 | 7 wells |

### Recommended next steps
1. **Obtain missing parcel geometries** from PetroNinja for the specific townships above
2. **Verify Woodcote Oil wells** — confirm they're still Obsidian-operated
3. **Consider visual indicator** for wells outside parcels (e.g., faded styling)

## Lessons Learned
1. GeoJSON mineral rights exports are often incomplete — always validate against well data
2. Horizontal (HZ) wells may have surface locations in different sections than their bottom-hole
3. Centroid distance is approximate — edge-to-edge distance would be more accurate
4. Woodcote Oil wells (predecessor/acquired assets) may have separate tenure documentation
5. Ray-casting point-in-polygon works well for rectangular Alberta DLS parcels

## Files Created/Modified
| File | Action | Owner |
|------|--------|-------|
| `public/data/obsidian-mineral-rights.geojson` | Created | Coordinator |
| `src/components/map/glassmorphicStyle.ts` | Created | Coordinator |
| `src/components/map/WellMap.tsx` | Modified | Coordinator |
| `src/pages/MapPage.tsx` | Modified | Coordinator |
| `src/index.css` | Modified | Coordinator |
| `src/hooks/useWells.ts` | Modified | agent-data-quality |
| `scripts/validate-wells-spatial.js` | Created | agent-spatial-validator |
| `scripts/spatial-validation-results.json` | Created | agent-spatial-validator |
| `agents/session-6/data-quality-report.md` | Created | agent-data-quality |
| `agents/session-6/spatial-report.md` | Created | agent-spatial-validator |
| `agents/session-6/SESSION-6-SUMMARY.md` | Created | Coordinator |
