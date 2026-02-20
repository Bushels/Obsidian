# Session 7: Parcel-Based Health Visualization with Ambient Glow

**Date:** 2026-02-19
**Status:** Completed
**Agents:** agent-data-engine, agent-layer-architect, agent-integrator

---

## Objectives
1. Replace individual well dots with parcel-centric health visualization
2. Color each mineral rights parcel by aggregate pump health of wells inside
3. Add ambient glow heatmap that blends naturally between adjacent parcels
4. Create synthetic parcels for 59 orphan wells (wells outside mineral rights)
5. Make parcels clickable with well list popup showing details and WellFi status
6. Add parcel summary labels (well count, avg months, WellFi count)

## What Was Accomplished

### Phase 1: Data Engine (agent-data-engine)
- Created `src/lib/parcelHealth.ts` — runtime utility with zero external deps
  - Ray-casting point-in-polygon algorithm (ported from Session 6 validation script)
  - `assignWellsToParcels()` — assigns 210 wells to 911 parcels (852 real + 59 synthetic)
  - `generateSyntheticParcels()` — creates ~1.6km x 1.6km squares for orphan wells
  - `computeParcelCentroids()` — centroid computation for label placement
  - Runtime: ~8.5ms for 210 wells x 900+ parcels (with bbox pre-filtering)
- Created `scripts/generate-synthetic-parcels.ts` — build-time script
- Generated `public/data/synthetic-parcels.geojson` — 59 synthetic parcels

### Phase 2: Layer Architect (agent-layer-architect)
- Created `src/components/map/HealthHeatmap.ts` — ambient glow layer
  - Mapbox heatmap using `months_running` weight (green → yellow → orange → red)
  - Large radius (4-40-60px across zoom) for Gaussian blending between adjacent parcels
  - Gaussian kernel density creates natural color mixing at parcel boundaries
- Created `src/components/map/ParcelLayers.ts` — 4 parcel visualization layers
  - Glow layer (wide blurred line, health-colored)
  - Fill layer (translucent, feature-state driven health colors)
  - Stroke layer (crisp border, health-tinted)
  - Labels layer (symbol on centroids, zoom >= 11)
  - All colors driven by `feature-state` for instant updates
- Created `src/components/map/ParcelPopup.ts` — glassmorphic popup
  - Parcel header with agreement type + health color bar
  - Summary grid: well count, WellFi count, avg run, risk badge
  - Scrollable well list with click-through to well details
- Updated `glassmorphicStyle.ts` — added 35 health color constants (fill/stroke/glow + hover variants)
- Updated `mapUtils.ts` — added `HEALTH_LEVEL_LABELS` for legend

### Phase 3: Integrator (agent-integrator)
- Refactored `src/components/map/WellMap.tsx` — major rewrite
  - Removed all well dot layers (LAYER_DOTS, LAYER_STROKES, LAYER_HALO)
  - Removed well dot click/hover handlers
  - Added parallel GeoJSON loading (mineral rights + synthetic parcels)
  - Added parcel health computation with `useMemo`/`useEffect`
  - Wired parcel click → popup → well click → RightPanel
  - Updated legend from dot circles to health zone squares
  - Renamed "Production" toggle to "Glow" (controls heatmap visibility)
  - Filter effect now targets heatmap layer instead of dot layers
- Deleted `ProductionHeatmap.ts` (replaced by HealthHeatmap.ts)

### Coordinator: Type Reconciliation
- Fixed duplicate `ParcelHealth` type definitions between Agent 1 and Agent 2
- Updated `ParcelLayers.ts` to import canonical types from `parcelHealth.ts`
- Updated `ParcelPopup.ts` to use `ParcelWellSummary` with nullable fields
- Updated click handler to accept `getParcelHealth` callback for full well list data

## Color System

| Parcel Health | Fill Color | Glow Color |
|--------------|-----------|-----------|
| < 9 months (healthy) | Green rgba(34,197,94,0.08) | Green glow |
| 9-13 months (watch) | Yellow rgba(234,179,8,0.10) | Yellow glow |
| 14-16 months (caution) | Orange rgba(249,115,22,0.12) | Orange glow |
| 17+ months (due) | Red rgba(239,68,68,0.14) | Red glow |
| Upcoming change | Purple rgba(168,85,247,0.12) | Purple glow |
| No data | Gray rgba(107,114,128,0.06) | Gray glow |
| Empty (no wells) | Cyan rgba(0,212,255,0.025) | Cyan glow |

## Layer Stack (bottom to top)
1. Base map (dark-v11 + glassmorphic overrides)
2. Health heatmap (ambient Gaussian glow)
3. Parcel glow (wide blurred health-colored line)
4. Parcel fill (translucent health-colored polygon)
5. Parcel stroke (crisp border)
6. Parcel labels (well count + avg months at zoom >= 11)
7. DLS grid layers

## Files Created/Modified
| File | Action | Agent |
|------|--------|-------|
| `src/lib/parcelHealth.ts` | Created | agent-data-engine |
| `scripts/generate-synthetic-parcels.ts` | Created | agent-data-engine |
| `public/data/synthetic-parcels.geojson` | Created | agent-data-engine |
| `src/components/map/HealthHeatmap.ts` | Created | agent-layer-architect |
| `src/components/map/ParcelLayers.ts` | Created | agent-layer-architect |
| `src/components/map/ParcelPopup.ts` | Created | agent-layer-architect |
| `src/components/map/glassmorphicStyle.ts` | Modified | agent-layer-architect |
| `src/lib/mapUtils.ts` | Modified | agent-layer-architect |
| `src/components/map/WellMap.tsx` | Modified (major) | agent-integrator |
| `src/components/map/ProductionHeatmap.ts` | Deleted | agent-integrator |

## Lessons Learned
1. When multiple agents define the same interface, reconcile types before integration
2. Feature-state in Mapbox only stores primitives — complex data (well lists) must be passed via refs/callbacks
3. Heatmap layers with Gaussian kernels provide natural color blending without custom shaders
4. `generateId: true` on GeoJSON sources is essential for feature-state to work correctly
5. Parallel GeoJSON fetch + merge is cleaner than loading a single massive file
