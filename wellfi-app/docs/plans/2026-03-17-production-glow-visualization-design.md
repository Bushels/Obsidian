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

### Bluesky Color Ramp (Amber)

```
density 0.0  -> rgba(251, 191, 36, 0)       // transparent
density 0.15 -> rgba(251, 191, 36, 0.15)    // faint amber
density 0.35 -> rgba(245, 158, 11, 0.25)    // amber
density 0.55 -> rgba(217, 119, 6, 0.40)     // dark amber
density 0.75 -> rgba(180, 83, 9, 0.55)      // burnt orange
density 1.0  -> rgba(120, 53, 15, 0.70)     // deep sienna
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

## What This Does NOT Change

- Obsidian's existing 210-well parcel system (parcels, health colors, op status forms)
- Existing HealthHeatmap.ts (will be evaluated for removal/replacement later)
- Existing DLS grid, terrain, dark overlay layers
- Auth system, admin panels, device inventory

## Implementation Notes

- CSV parsing: handle quoted fields with commas (e.g., "Bluesky, Gething, Cadomin")
- Formation detection: `includes('Clearwater')` or `includes('Bluesky')` on producing_formation
- Fluid type filter: only "Crude Oil" and "Crude Bitumen" (exclude Gas, Water wells)
- op_status: defaults to "normal" — future integration with operational_statuses table
- Performance: 6,064 points is trivial for Mapbox heatmap layer (GPU-accelerated KDE)
