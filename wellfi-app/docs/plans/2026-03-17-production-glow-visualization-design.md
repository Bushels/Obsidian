# Production Glow Visualization — Design Document

**Date:** 2026-03-17
**Status:** Approved
**Scope:** Bluesky + Clearwater oil/bitumen wells (6,064 total)

---

## Summary

Add a production-weighted radial glow visualization to the WellFi Mapbox map. Each producing well contributes to a formation-colored heatmap where overlapping wells create deeper, more saturated color — making high-production zones immediately visible at regional zoom. As the user zooms in, the heatmap fades out and individual well dots fade in, colored by operational status.

## Data Profile

| Formation | Total Wells | Producing | Production Range | Heatmap Color |
|-----------|-------------|-----------|-----------------|---------------|
| Clearwater | 5,194 | 4,669 | 0.1 – 4,991 bbl/day | Green |
| Bluesky | 870 | 832 | 0.2 – 1,482 bbl/day | Amber |
| **Combined** | **6,064** | **5,501** | | |

- Source CSV: `Data/active_clearwater_bluesky_recent_prod_ab_sk.csv`
- Formations overlap geographically (lat ~55.8-56.4, lng ~-117 to -116) but at different depths
- Production distribution is right-skewed: median Clearwater 180 bbl/day, median Bluesky 80 bbl/day

## Layer Architecture

### Layer Stack (bottom to top)

```
Existing base layers (terrain, dark overlay, DLS grid)
  |
  v
clearwater-production-heatmap   <- green, weight=recent_oil, fade out by zoom ~14
bluesky-production-heatmap      <- amber, weight=recent_oil, fade out by zoom ~14
  |
  v  (zoom crossfade at ~12-14)
  |
production-well-dots            <- circle layer, fade IN at zoom ~12
  |
  v
Existing parcel layers (Obsidian's 210 wells — unchanged)
```

### Zoom Behavior

- **Zoom 0–11:** Only heatmap glow visible. Regional production intensity.
- **Zoom 11–13:** Crossfade. Heatmap fading out, dots fading in.
- **Zoom 13+:** Only dots visible. Individual well identification.

## Heatmap Layers

### Shared Properties

- **Type:** `heatmap` (Mapbox native — Gaussian KDE with additive blending)
- **Source:** `bluesky-clearwater-production-source` (single GeoJSON, filtered by formation)
- **Weight:** `sqrt(recent_oil)` normalized to 0–1 (compresses 0–5000 range, prevents outlier dominance)
- **Filter:** Exclude `well_down` status (not producing)
- **Radius:** 4px at zoom 0 → 40px at zoom 9 → 60px at zoom 13
- **Opacity:** Fade from 0.7 at zoom 7 → 0 at zoom 14

### Clearwater Color Ramp (Green)

```
density 0.0  -> rgba(74, 222, 128, 0)       // transparent
density 0.15 -> rgba(74, 222, 128, 0.15)    // faint green
density 0.35 -> rgba(34, 197, 94, 0.25)     // green
density 0.55 -> rgba(22, 163, 74, 0.40)     // deep green
density 0.75 -> rgba(21, 128, 61, 0.55)     // forest
density 1.0  -> rgba(20, 83, 45, 0.70)      // dark emerald
```

### Bluesky Color Ramp (Gold)

```
density 0.0  -> rgba(253, 224, 71, 0)       // transparent
density 0.15 -> rgba(253, 224, 71, 0.15)    // faint gold
density 0.35 -> rgba(250, 204, 21, 0.25)    // gold
density 0.55 -> rgba(234, 179, 8, 0.40)     // deep gold
density 0.75 -> rgba(202, 138, 4, 0.55)     // dark gold
density 1.0  -> rgba(161, 98, 7, 0.70)      // rich amber
```

## Well Dots Layer

### Circle Properties

- **Type:** `circle`
- **Radius:** 3–5px
- **Opacity:** Fade in from 0 at zoom 11 → 1 at zoom 13 (inverse of heatmap)
- **Filter:** Exclude `well_down` (dot disappears entirely)

### Dot Color Logic

```
Fill always = formation color:
  Clearwater -> #22C55E (green-500)
  Bluesky    -> #F59E0B (amber-500)

Stroke indicates operational status:
  Normal     -> no stroke
  Watch      -> #3B82F6 (blue-500), width 2px
  Warning    -> #EF4444 (red-500), width 2.5px
  Well Down  -> HIDDEN (filtered out from both dots and heatmap)
```

### Dot State Machine

| Operational Status | Fill Color | Stroke | Visible? | In Heatmap? |
|---|---|---|---|---|
| Normal | Formation color | None | Yes | Yes |
| Watch | Formation color | Blue border | Yes | Yes (still producing) |
| Warning | Formation color | Red border | Yes | Yes (still producing) |
| Well Down | — | — | No | No |
| Restored | Formation color | None | Yes | Yes |

## Data Source

### GeoJSON Structure

```typescript
{
  type: "FeatureCollection",
  features: [
    {
      type: "Feature",
      geometry: { type: "Point", coordinates: [lng, lat] },
      properties: {
        uwi: string,
        operator: string,
        formation: "Clearwater" | "Bluesky",
        field_name: string,
        well_fluid_type: string,
        recent_oil: number,       // bbl/day — drives heatmap weight
        cumulative_oil: number,
        recent_gas: number,
        recent_water: number,
        recent_steam_injection: number,
        last_production_date: string,
        spud_date: string,
        op_status: "normal" | "watch" | "warning" | "well_down"
      }
    }
  ]
}
```

### Heatmap Weight Expression

```typescript
'heatmap-weight': [
  'interpolate', ['linear'],
  ['sqrt', ['get', 'recent_oil']],
  0, 0,
  70.7, 1   // sqrt(5000) ≈ 70.7
]
```

## Audit Fixes (from Gemini review)

### Fix 1: Independent Heatmap Normalization

Each formation normalizes against its own production max so both get full visual range:

```typescript
// Clearwater: normalize against sqrt(5000) ≈ 70.7
'heatmap-weight': ['min', 1, ['interpolate', ['linear'],
  ['sqrt', ['get', 'recent_oil']], 0, 0, 70.7, 1]]

// Bluesky: normalize against sqrt(1500) ≈ 38.7
'heatmap-weight': ['min', 1, ['interpolate', ['linear'],
  ['sqrt', ['get', 'recent_oil']], 0, 0, 38.7, 1]]
```

The `['min', 1, ...]` wrapper clamps output to prevent extrapolation if future wells exceed current max.

### Fix 2: Status via Stroke, Not Fill Override

Dot fill color always reflects formation (green/amber). Operational status uses a stroke border:

```
Normal:  fill=formation color, no stroke
Watch:   fill=formation color, stroke=#3B82F6 (blue), stroke-width=2
Warning: fill=formation color, stroke=#EF4444 (red), stroke-width=2.5
Down:    hidden entirely
```

This preserves formation identity while showing status — both data dimensions visible at once.

### Fix 3: Formation Toggles

Add UI controls to toggle Clearwater/Bluesky heatmap visibility independently. This prevents muddy brown blending in geographic overlap zones and lets users focus on one play at a time.

### Fix 4: Dot Interactivity

- **Hover:** Tooltip showing UWI, operator, formation, recent_oil (bbl/day)
- **Click:** Open well detail panel (or navigate to well page if available)

### Fix 5: Pre-process CSV to GeoJSON

Convert CSV → `.geojson` at build time (or as a static file in `public/data/`). Avoids main-thread CSV parsing on page load.

### Fix 6: Zero/Null Production Handling

Wells with `recent_oil = 0` or null: weight = 0 (invisible in heatmap), but still appear as dots when zoomed in. They represent wells that exist but aren't currently producing oil.

## What This Replaced

The production glow visualization replaced the following Session 6-7 systems:

- **ParcelLayers.ts** — 5-layer parcel health polygon system (green/yellow/orange/red filled mineral rights parcels). Removed from WellMap.tsx; files kept for reference.
- **HealthHeatmap.ts** — Gaussian green glow weighted by pump age (months_running). Removed from WellMap.tsx; file kept for reference.
- **"Land" toggle button** — controlled parcel visibility. Replaced by CW/BS formation toggles.
- **"Glow" toggle button** — controlled health heatmap. Replaced by CW/BS formation toggles.
- **Health Zones legend** — replaced by Production Glow legend (Clearwater/Bluesky) + Well Status legend (Watch/Warning/Down).

Files removed from rendering but NOT deleted (available for reference):
- `src/components/map/HealthHeatmap.ts`
- `src/components/map/ParcelLayers.ts`
- `src/lib/parcelHealth.ts`

## What This Does NOT Change

- Existing DLS grid, terrain, dark overlay layers
- Auth system, admin panels, device inventory
- Monitored alert dots (glow + points for WellFi-equipped wells)

## Implementation Notes

- CSV parsing: handle quoted fields with commas (e.g., "Bluesky, Gething, Cadomin")
- Formation detection: `includes('Clearwater')` or `includes('Bluesky')` on producing_formation
- Fluid type filter: only "Crude Oil" and "Crude Bitumen" (exclude Gas, Water wells)
- op_status: defaults to "normal" — future integration with operational_statuses table
- Performance: 6,064 points is trivial for Mapbox heatmap layer (GPU-accelerated KDE)

## Troubleshooting & Lessons Learned

### Race condition on async GeoJSON fetch
**Problem:** `addProductionGlow()` fetches GeoJSON via `fetch()`. If the user toggles Glass/Satellite mode during the fetch, the map instance is destroyed and `map.addSource()` throws.
**Fix:** After `await fetch()`, check `map.getStyle()` inside a try/catch. If the map is gone, return early. Also re-check `map.getSource(SOURCE_ID)` after the async gap.

### Independent normalization prevents visual bias
**Problem:** Clearwater's max production (4,991 bbl/day) is 3.4x higher than Bluesky's max (1,482). A shared normalization scale makes Bluesky look washed out.
**Fix:** Each formation normalizes against its own max: CW uses `sqrt(5000)=70.7`, BS uses `sqrt(1500)=38.7`. Both formations get full visual intensity range.

### Stroke-based status preserves formation identity
**Problem:** If op_status overrides the dot fill color (blue for watch, red for warning), you lose which formation the well belongs to.
**Fix:** Dot fill always = formation color (green/amber). Op status is communicated via stroke border color instead.

### Popup ref conflicts between layers
**Problem:** Production dots and monitored alert points share the same `popupRef.current`. Fast mouse movement between layers can create ghost popups.
**Status:** Known issue, deferred. Future fix: separate popup refs per layer, or a popup manager.

### NaN rendering in tooltips
**Problem:** If a CSV field contains non-numeric text (e.g., "N/A"), `Number(value)` returns NaN, and `NaN.toFixed(1)` renders as "NaN" in the popup.
**Fix:** Use `Number(value) || 0` pattern (falsy coalescing) instead of `Number(value ?? 0)` (null coalescing only).

### CSV quoted field parsing
**Problem:** The CSV has multi-formation entries like `"Bluesky, Gething, Cadomin"` where commas inside quotes break simple `split(',')` parsing.
**Fix:** Custom `parseCSVLine()` function that tracks quote state. Run as build-time script, not runtime.

### Brainstorming pivot saved complexity
**Lesson:** Started with 3D extruded cylinders (deck.gl/Three.js), pivoted to native Mapbox heatmap after clarifying the real need. The heatmap approach: (1) zero new dependencies, (2) follows existing HealthHeatmap.ts pattern, (3) GPU-accelerated KDE for free, (4) ~350 lines vs estimated ~1000+ for 3D.

### Gold vs brown color ramp for Bluesky
**Problem:** Original Bluesky ramp used Tailwind amber-500→amber-900 scale which trends toward burnt sienna/brown at high density. On the dark map, the dense production zones looked muddy rather than distinctive.
**Fix:** Shifted to Tailwind yellow-300→amber-700 scale (gold family). Keeps warm character but reads as gold, not brown. Better visual distinction from Clearwater green.

### Gemini as design auditor
**Lesson:** Having Gemini audit the design doc before implementation caught two critical issues (normalization bias, color blending in overlap zones) that would have required post-implementation rework. Cost: one API call. Saved: hours of visual debugging.
