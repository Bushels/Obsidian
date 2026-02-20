# Agent: Integrator — Session 7

## Mission
Refactor WellMap.tsx to replace individual well dots with the parcel-based health visualization system. Wire together the data engine (Agent 1) and layer architect (Agent 2) modules into a cohesive map experience.

## Scope
- **Modifies**: `src/components/map/WellMap.tsx` (major), `src/pages/MapPage.tsx` (minor if needed)
- **Removes**: `src/components/map/ProductionHeatmap.ts` (replaced by HealthHeatmap.ts)
- **Reads**: All Agent 1 and Agent 2 outputs, `src/types.ts` (frozen)
- **Must not touch**: `src/types.ts`, `src/lib/supabase.ts`

## Prerequisites
- Agent 1 (Data Engine) must have completed `src/lib/parcelHealth.ts` and `public/data/synthetic-parcels.geojson`
- Agent 2 (Layer Architect) must have completed `HealthHeatmap.ts`, `ParcelLayers.ts`, `ParcelPopup.ts`

## Tasks

### 1. Update imports in WellMap.tsx

**Remove:**
- `WELL_COLOR_EXPRESSION`, `WELL_SIZE_EXPRESSION`, `WELL_STROKE_EXPRESSION` from mapUtils import
- `wellPopupHTML` from WellPopup import
- `addProductionHeatmap`, `setProductionHeatmapVisibility` from ProductionHeatmap import
- `GLASS_WELL_OVERRIDES` from glassmorphicStyle import

**Add:**
- `assignWellsToParcels`, `generateSyntheticParcels`, `computeParcelCentroids`, `ParcelHealth` from `@/lib/parcelHealth`
- `addHealthHeatmap`, `setHealthHeatmapVisibility` from `./HealthHeatmap`
- `addParcelLayers`, `updateParcelHealth`, `setupParcelInteraction`, `setParcelVisibility` from `./ParcelLayers`
- `HEALTH_LEVEL_LABELS` from `@/lib/mapUtils`

### 2. Remove well dot layers from `addSourceAndLayers`

Keep `wells-source` GeoJSON source (needed for heatmap), but remove:
- `LAYER_HALO` circle layer creation
- `LAYER_STROKES` circle layer creation
- `LAYER_DOTS` circle layer creation
- Well dot click handler (`map.on('click', LAYER_DOTS, ...)`)
- Well dot hover handlers (`mouseenter`/`mouseleave` on LAYER_DOTS)

The function now only adds the wells-source and nothing else.

### 3. Replace `loadMineralRights` with new parcel loading flow

New function: `loadParcels(map: mapboxgl.Map)`

```
1. Fetch both GeoJSON files in parallel:
   - /data/obsidian-mineral-rights.geojson
   - /data/synthetic-parcels.geojson
2. Merge features into single FeatureCollection (re-index IDs)
3. Compute centroids via computeParcelCentroids()
4. Call addParcelLayers(map, mergedParcels, centroids, beforeLayerId)
5. Store merged parcels in a ref for health computation
6. Run initial health assignment (if wells are already loaded)
```

### 4. Add parcel health computation

Add a `useMemo` or `useEffect` that runs when `wells` or `parcelsRef.current` changes:

```typescript
const parcelHealthMap = useMemo(() => {
  if (!parcelsRef.current || wells.length === 0) return null;
  const { healthMap } = assignWellsToParcels(wells, parcelsRef.current);
  return healthMap;
}, [wells]);
```

Add an effect that updates feature-state when healthMap changes:
```typescript
useEffect(() => {
  const map = mapRef.current;
  if (!map || !mapLoaded || !parcelHealthMap) return;
  updateParcelHealth(map, parcelHealthMap);
}, [parcelHealthMap, mapLoaded]);
```

### 5. Replace ProductionHeatmap with HealthHeatmap

In the map load callback:
- Replace `addProductionHeatmap(map)` with `addHealthHeatmap(map)`
- Update the production toggle effect to use `setHealthHeatmapVisibility`

### 6. Wire parcel click → well details

After `loadParcels`, call:
```typescript
setupParcelInteraction(map, {
  onWellClick: (wellId: string) => {
    const well = wellsRef.current.find(w => w.id === wellId);
    if (well) onWellClickRef.current(well);
  }
});
```

### 7. Remove `applyGlassWellOverrides`

Delete the `applyGlassWellOverrides` callback and its call in the load handler. There are no more well dot layers to override.

### 8. Update mineral rights visibility toggle

Replace the current effect that toggles `MINERAL_FILL`, `MINERAL_LINE`, `MINERAL_GLOW` with a call to `setParcelVisibility(map, showLand)`.

### 9. Update filter application

Filters still apply to the wells-source for heatmap visualization. But now also need to trigger parcel health recomputation:
- When filters change → re-run `assignWellsToParcels` with filtered wells → `updateParcelHealth`
- The heatmap source filter still works the same way (set filter on heatmap layer)

### 10. Update legend

Replace the current dot-based legend with parcel health swatches:
- Use `HEALTH_LEVEL_LABELS` for the color/label mapping
- Replace circle dots with small squares (matching parcel shape)
- Keep the "Mineral Rights" label but rename to "Health Zones"

### 11. Update toggle buttons

- "Land" button → controls parcel visibility via `setParcelVisibility`
- "Production" button → rename to "Glow" (controls health heatmap visibility)
- Grid button → unchanged
- Style switcher → unchanged

### 12. Delete `ProductionHeatmap.ts`

Remove the file entirely (replaced by HealthHeatmap.ts).

### 13. Clean up layer ID constants

Remove unused constants:
- `LAYER_DOTS`, `LAYER_STROKES`, `LAYER_HALO`
- `MINERAL_SOURCE`, `MINERAL_FILL`, `MINERAL_LINE`, `MINERAL_GLOW`

Add new ones as needed (or import from ParcelLayers.ts).

## Completion Criteria
- WellMap.tsx compiles cleanly with no TypeScript errors
- No individual well dots visible on the map
- Parcels colored by health level
- Heatmap glow visible as ambient atmosphere
- Clicking a parcel shows well list popup
- Clicking a well in the popup triggers onWellClick
- All toggles (Land, Glow, Grid, Style) work correctly
- Filter changes update parcel colors
- `npx tsc --noEmit` passes
- `npx vite build` succeeds
