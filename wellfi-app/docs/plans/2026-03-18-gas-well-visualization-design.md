# Gas Well Production Glow Visualization — Design

**Date:** 2026-03-18
**Branch:** `codex/bluesky-clearwater-import`
**Status:** Approved
**Builds on:** `2026-03-17-production-glow-visualization-design.md`

## Summary

Add 751 Clearwater/Bluesky gas wells to the existing production glow map as lighter-shaded heatmap layers beneath the oil/bitumen layers. Only wells with non-zero production are included (~414 gas wells with `recent_gas > 0`, plus filtering existing oil wells to `recent_oil > 0`).

## Scope

- **In scope:** CW + BS gas wells (`well_fluid_type === 'Gas'`) with `recent_gas > 0`
- **Also:** Filter existing oil wells to `recent_oil > 0` (remove zero-production oil wells)
- **Out of scope:** Gas wells in other formations (Falher, Spirit River, etc.), BOE conversion

## Data Profile

| Metric | Oil/Bitumen (existing) | Gas (new) |
|--------|----------------------|-----------|
| CW wells | 5,194 → filtered to recent_oil > 0 | 268 → ~180 with recent_gas > 0 |
| BS wells | 870 → filtered to recent_oil > 0 | 483 → ~234 with recent_gas > 0 |
| Production field | `recent_oil` (bbl/day) | `recent_gas` (mcf/day) |
| Max production | CW: ~5,000, BS: ~1,500 | CW: ~328, BS: ~38 |
| Normalization | sqrt(5000)=70.7, sqrt(1500)=38.7 | sqrt(328)≈18.1, sqrt(38)≈6.2 |

## Layer Architecture

**6 layers from a single GeoJSON source** (bottom to top):

```
┌─────────────────────────────────────────────┐
│  5. production-well-dots (circle)           │ ← zoom 11+ crossfade
├─────────────────────────────────────────────┤
│  4. bluesky-production-heatmap (gold)       │ ← oil, opacity 0.7
│  3. clearwater-production-heatmap (green)   │ ← oil, opacity 0.7
├─────────────────────────────────────────────┤
│  2. bluesky-gas-heatmap (light gold)        │ ← gas, opacity 0.5
│  1. clearwater-gas-heatmap (light green)    │ ← gas, opacity 0.5
└─────────────────────────────────────────────┘
```

**Why gas below oil:** Oil production dominates visually. Gas shows as a subtle secondary glow beneath, visible in areas where oil is sparse. Additive blending won't muddy the oil colors because gas opacity is capped at 0.5.

## Color Scheme

| Layer | Heatmap Glow | Dot Fill | Notes |
|-------|-------------|----------|-------|
| CW Oil | Green ramp → #22C55E | #22C55E (green-500) | Existing, unchanged |
| CW Gas | Light green ramp → #86EFAC | #86EFAC (green-300) | New |
| BS Oil | Gold ramp → #F59E0B | #F59E0B (amber-500) | Existing, unchanged |
| BS Gas | Light gold ramp → #FCD34D | #FCD34D (amber-300) | New |

## Heatmap Weight Expressions

Each layer uses independent normalization:

```
Oil layers (existing):
  weight = min(1, sqrt(recent_oil) / SQRT_MAX)

Gas layers (new):
  weight = min(1, sqrt(recent_gas) / GAS_SQRT_MAX)
```

Constants:
- `CW_SQRT_MAX = 70.7` (oil, unchanged)
- `BS_SQRT_MAX = 38.7` (oil, unchanged)
- `CW_GAS_SQRT_MAX = 18.1` (gas, new)
- `BS_GAS_SQRT_MAX = 6.2` (gas, new)

## Filters

Each heatmap layer filters on both `formation` AND `fluid_type`:

```
CW oil:  ['all', ['==', 'formation', 'Clearwater'], ['==', 'fluid_type', 'oil']]
CW gas:  ['all', ['==', 'formation', 'Clearwater'], ['==', 'fluid_type', 'gas']]
BS oil:  ['all', ['==', 'formation', 'Bluesky'],    ['==', 'fluid_type', 'oil']]
BS gas:  ['all', ['==', 'formation', 'Bluesky'],    ['==', 'fluid_type', 'gas']]
```

Dot layer uses `fluid_type` for color assignment via `case` expression.

## Dot Color Expression

```javascript
'circle-color': [
  'case',
  ['all', ['==', ['get', 'formation'], 'Clearwater'], ['==', ['get', 'fluid_type'], 'gas']],
  '#86EFAC',  // CW gas — light green
  ['all', ['==', ['get', 'formation'], 'Bluesky'], ['==', ['get', 'fluid_type'], 'gas']],
  '#FCD34D',  // BS gas — light gold
  ['==', ['get', 'formation'], 'Bluesky'],
  '#F59E0B',  // BS oil — amber
  '#22C55E'   // CW oil — green (default)
]
```

## Toggle Behavior

CW/BS buttons toggle both oil AND gas layers for that formation:
- CW toggle → `clearwater-production-heatmap` + `clearwater-gas-heatmap`
- BS toggle → `bluesky-production-heatmap` + `bluesky-gas-heatmap`

No separate gas toggle — keeps UI simple.

## Build Script Changes

**`scripts/build-production-geojson.js`:**

1. Remove `Crude Oil`/`Crude Bitumen` filter — include `Gas` fluid type
2. Add production filter: skip if `recent_oil <= 0` (for oil) and `recent_gas <= 0` (for gas)
3. Add `fluid_type` property: `'oil'` or `'gas'`
4. Estimated output: ~6,400-6,500 features (after zero-production filtering), ~3.0 MB

## Popup Changes

**`ProductionPopup.ts`:**
- Show fluid type badge: "Oil/Bitumen" or "Gas"
- For gas wells: display `recent_gas` prominently, hide `recent_oil` (it's 0)
- For oil wells: display `recent_oil` prominently (unchanged)

## Legend Update

Add to existing "Production Glow" legend section:
```
PRODUCTION GLOW
  ● Clearwater Oil
  ○ Clearwater Gas
  ● Bluesky Oil
  ○ Bluesky Gas
```

## Performance Notes

- 5 heatmap layers is within Mapbox GL performance budget for ~6,500 features
- Gas layers have fewer features (~414) than oil (~6,064), so GPU cost is modest
- Same GeoJSON source = no additional network request
- Gas heatmaps at lower opacity (0.5) means less alpha compositing work

## Gemini Audit Recommendations Incorporated

1. **Gas below oil** — prevents additive blending from muddying oil colors
2. **Lower gas opacity (0.5)** — reinforces visual hierarchy
3. **Independent normalization** — gas mcf/day scale differs from oil bbl/day
4. **Tighter crossfade** — consider narrowing heatmap-to-dot transition window (future optimization)

## Files to Modify

1. `scripts/build-production-geojson.js` — include gas, add fluid_type, filter zero production
2. `src/components/map/ProductionGlow.ts` — add 2 gas heatmap layers, update dot colors, update filters
3. `src/components/map/ProductionPopup.ts` — fluid type badge, conditional production display
4. `src/components/map/WellMap.tsx` — toggle both oil+gas layers, update legend
5. `public/data/bluesky-clearwater-production.geojson` — regenerated with gas wells
