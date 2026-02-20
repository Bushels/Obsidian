# Agent: Layer Architect — Session 7

## Mission
Design and implement all Mapbox GL layer specifications for the parcel-based health visualization, including the ambient heatmap glow, health-colored parcel layers, summary labels, and click popup with well list.

## Scope
- **Creates**: `src/components/map/HealthHeatmap.ts`, `src/components/map/ParcelLayers.ts`, `src/components/map/ParcelPopup.ts`
- **Modifies**: `src/components/map/glassmorphicStyle.ts`, `src/lib/mapUtils.ts`
- **Reads**: `src/types.ts` (frozen), `src/components/map/ProductionHeatmap.ts` (pattern reference), `src/components/map/WellPopup.tsx` (popup pattern reference)
- **Must not touch**: `src/types.ts`, `src/lib/supabase.ts`, `src/components/map/WellMap.tsx` (Agent 3 owns this)

## Tasks

### 1. Update `src/components/map/glassmorphicStyle.ts`

Add health color constants to `GLASS_COLORS`:

```typescript
// Health-based parcel colors (fill / stroke / glow variants)
healthGreenFill: 'rgba(34, 197, 94, 0.08)',
healthGreenStroke: 'rgba(34, 197, 94, 0.25)',
healthGreenGlow: 'rgba(34, 197, 94, 0.08)',
healthYellowFill: 'rgba(234, 179, 8, 0.10)',
healthYellowStroke: 'rgba(234, 179, 8, 0.30)',
healthYellowGlow: 'rgba(234, 179, 8, 0.10)',
healthOrangeFill: 'rgba(249, 115, 22, 0.12)',
healthOrangeStroke: 'rgba(249, 115, 22, 0.35)',
healthOrangeGlow: 'rgba(249, 115, 22, 0.12)',
healthRedFill: 'rgba(239, 68, 68, 0.14)',
healthRedStroke: 'rgba(239, 68, 68, 0.4)',
healthRedGlow: 'rgba(239, 68, 68, 0.15)',
healthPurpleFill: 'rgba(168, 85, 247, 0.12)',
healthPurpleStroke: 'rgba(168, 85, 247, 0.4)',
healthPurpleGlow: 'rgba(168, 85, 247, 0.15)',
healthGrayFill: 'rgba(107, 114, 128, 0.06)',
healthGrayStroke: 'rgba(107, 114, 128, 0.20)',
healthGrayGlow: 'rgba(107, 114, 128, 0.06)',
healthEmptyFill: 'rgba(0, 212, 255, 0.025)',
healthEmptyStroke: 'rgba(0, 212, 255, 0.15)',
healthEmptyGlow: 'rgba(0, 212, 255, 0.04)',
```

Also add hover variants (2x opacity of normal fill/stroke).

### 2. Create `src/components/map/HealthHeatmap.ts`

Replaces `ProductionHeatmap.ts`. Follow the same module pattern.

**Key differences from ProductionHeatmap:**
- Weight: `months_running` instead of `dec_rate_bbl_d`
- Color ramp: green → yellow → orange → red (health colors, not neon)
- Radius: larger (30-60px) for more atmospheric blending
- Opacity: subtler peak (0.7 max) so parcels remain legible on top

```typescript
export function addHealthHeatmap(map: mapboxgl.Map): void
export function removeHealthHeatmap(map: mapboxgl.Map): void
export function setHealthHeatmapVisibility(map: mapboxgl.Map, visible: boolean): void
```

Source: `'wells-source'` (same as the existing well points source — it still exists even though dot layers are removed).

Heatmap weight expression:
```
['interpolate', ['linear'], ['get', 'months_running'],
  0, 0.1,    // new pumps barely register
  9, 0.3,    // green threshold
  14, 0.6,   // orange threshold
  17, 0.85,  // red threshold
  24, 1.0    // max weight
]
```

Heatmap color ramp:
```
['interpolate', ['linear'], ['heatmap-density'],
  0,    'rgba(34, 197, 94, 0)',
  0.15, 'rgba(34, 197, 94, 0.25)',
  0.35, 'rgba(234, 179, 8, 0.35)',
  0.55, 'rgba(249, 115, 22, 0.45)',
  0.75, 'rgba(239, 68, 68, 0.55)',
  1.0,  'rgba(239, 68, 68, 0.70)',
]
```

Radius: `['interpolate', ['linear'], ['zoom'], 0, 4, 9, 40, 13, 60]`

Insert BEFORE the mineral rights layers (so it renders underneath the parcels).

### 3. Create `src/components/map/ParcelLayers.ts`

Central module for all parcel visualization layers.

**Layer IDs:**
- `PARCEL_SOURCE = 'parcel-health-source'`
- `PARCEL_CENTROIDS_SOURCE = 'parcel-centroids-source'`
- `PARCEL_GLOW = 'parcel-health-glow'`
- `PARCEL_FILL = 'parcel-health-fill'`
- `PARCEL_LINE = 'parcel-health-line'`
- `PARCEL_LABELS = 'parcel-labels'`

**Exported functions:**

#### `addParcelLayers(map: mapboxgl.Map, parcels: GeoJSON.FeatureCollection, centroids: GeoJSON.FeatureCollection, beforeLayerId?: string): void`
Adds the parcel source and all 4 layers:

1. **Glow layer** (line, wide + blurred):
   - `line-width`: 8
   - `line-blur`: 6
   - `line-opacity`: 0.6
   - `line-color`: driven by `feature-state` `health_level` (0=empty, 1=green, 2=yellow, 3=orange, 4=red, 5=purple, 6=gray)

2. **Fill layer** (fill):
   - `fill-color`: driven by `feature-state` `health_level` with hover brightness boost
   - `fill-opacity`: 1

3. **Stroke layer** (line, crisp):
   - `line-width`: hover ? 1.5 : 0.8
   - `line-color`: driven by `feature-state` `health_level`

4. **Labels layer** (symbol on centroids source):
   - `minzoom`: 11
   - `text-field`: `['format', ['get', 'label'], {}]`
   - `text-size`: 11
   - `text-allow-overlap`: false
   - `text-color`: `'rgba(255, 255, 255, 0.7)'`
   - `text-halo-color`: `'rgba(6, 9, 15, 0.9)'`

For the `feature-state` color expressions, use a `match` expression on `health_level`:
```typescript
['match', ['feature-state', 'health_level'],
  0, GLASS_COLORS.healthEmptyFill,
  1, GLASS_COLORS.healthGreenFill,
  2, GLASS_COLORS.healthYellowFill,
  3, GLASS_COLORS.healthOrangeFill,
  4, GLASS_COLORS.healthRedFill,
  5, GLASS_COLORS.healthPurpleFill,
  6, GLASS_COLORS.healthGrayFill,
  GLASS_COLORS.healthEmptyFill  // fallback
]
```

**IMPORTANT:** The `match` expression MUST use `['feature-state', 'health_level']` since we set health via `map.setFeatureState()` at runtime. The `feature-state` approach allows instant updates when well data changes without reloading GeoJSON.

#### `updateParcelHealth(map: mapboxgl.Map, healthMap: Map<number, ParcelHealth>): void`
For each entry in healthMap, call `map.setFeatureState()` with:
- `health_level`: number (0-6, matching the categories above)
- `well_count`: number
- `avg_months`: number
- `hover`: false (preserve hover state separately)

Also update the centroids source label text for each parcel.

#### `setupParcelInteraction(map: mapboxgl.Map, callbacks: { onWellClick: (wellId: string) => void }): void`
- Hover: `mousemove` on fill layer → `setFeatureState({ hover: true })` + cursor pointer
- Hover leave: reset hover state + cursor
- Click: show `parcelPopupHTML` popup with well list

#### `removeParcelLayers(map: mapboxgl.Map): void`
Remove all layers and sources.

#### `setParcelVisibility(map: mapboxgl.Map, visible: boolean): void`
Toggle all parcel layer visibility.

**`healthLevel(health: ParcelHealth): number` helper:**
```typescript
function healthLevel(h: ParcelHealth): number {
  if (h.wellCount === 0) return 0;  // empty
  if (h.hasUpcomingChange) return 5; // purple
  if (h.avgMonthsRunning >= 17) return 4; // red
  if (h.avgMonthsRunning >= 14) return 3; // orange
  if (h.avgMonthsRunning >= 9) return 2;  // yellow
  if (h.avgMonthsRunning > 0) return 1;   // green
  return 6; // gray / no data
}
```

### 4. Create `src/components/map/ParcelPopup.ts`

New popup generator replacing both `mineralPopupHTML` and `wellPopupHTML` for the parcel context.

#### `parcelPopupHTML(parcelProps: Record<string, unknown>, health: ParcelHealth): string`

Generates a glassmorphic popup with:

**Header section:**
- Agreement type (from parcel properties, e.g., "PNG Lease")
- Zone description
- Health bar: colored strip matching the health level

**Summary section (2×2 grid):**
- Wells: count
- WellFi: count with cyan dot indicator
- Avg Run: X.X months
- Risk: dominant risk level badge

**Well list section (scrollable, max-height 200px):**
Each well row shows:
- Name (truncated)
- Months running (colored by individual risk)
- WellFi dot indicator (cyan if has device)
- Click target: `data-well-id` attribute for click-through

**Style:** Follow existing glassmorphic popup patterns from `WellPopup.tsx`:
- Font: system-ui
- Colors: #e5e7eb text, #6b7280 labels, #9ca3af secondary
- Risk badge colors matching WELL_COLOR_EXPRESSION thresholds

### 5. Update `src/lib/mapUtils.ts`

Minor changes:
- Keep all existing exports (wellsToGeoJSON, expressions, etc.) — they're still used
- Add a `HEALTH_LEVEL_LABELS` constant for legend use:
```typescript
export const HEALTH_LEVEL_LABELS: { level: number; color: string; label: string }[] = [
  { level: 5, color: '#A855F7', label: 'Upcoming Change' },
  { level: 4, color: '#EF4444', label: '17+ months (Due)' },
  { level: 3, color: '#F97316', label: '14-16 months' },
  { level: 2, color: '#EAB308', label: '9-13 months' },
  { level: 1, color: '#22C55E', label: '< 9 months' },
  { level: 6, color: '#6B7280', label: 'No data' },
  { level: 0, color: '#00D4FF', label: 'No wells (empty parcel)' },
];
```

## Completion Criteria
- All 3 new files created with clean TypeScript (no any, proper types)
- `glassmorphicStyle.ts` updated with health colors
- `mapUtils.ts` updated with legend labels
- `npx tsc --noEmit` passes with zero errors
- All functions follow existing module patterns (see ProductionHeatmap.ts, FormationOverlay.ts)
- No frozen files modified
- No modifications to WellMap.tsx (Agent 3's responsibility)
