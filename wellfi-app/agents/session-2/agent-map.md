# Agent: agent-map — Mapbox Map Component
**Session:** 2 | **Precedence:** 1 (highest in session) | **Mode:** Parallel with agent-hooks

---

## Pre-Start Checklist
1. Read `agents/MANIFEST.json`
2. Read `agents/STATUS.json` — Session 1 must be `"completed"` (gate check)
3. Read `src/types.ts` — **do not modify it, just understand the types**
4. Read `src/lib/supabase.ts` — **do not modify it**
5. Write `agents/locks/agent-map.lock`
6. Check for `agents/locks/agent-hooks.lock` — no file conflict expected; you own `components/map/`, they own `hooks/`

---

## Your Owned Files
```
src/components/map/WellMap.tsx
src/components/map/WellLayer.tsx
src/components/map/WellFiHalo.tsx
src/components/map/WellPopup.tsx
src/lib/mapUtils.ts
```

---

## Dependencies to Install
```bash
npm install mapbox-gl
npm install -D @types/mapbox-gl
```

---

## Tasks

### Task 1 — Map Utilities (install this first — WellLayer depends on it)
File: `src/lib/mapUtils.ts`

```typescript
import type { RiskLevel } from '../types';

// ── Color Expressions ──────────────────────────────────────────────────────
// Priority order: WellFi installed > pump change warning > risk level > gray
export const WELL_COLOR_EXPRESSION = [
  'case',
  // WellFi installed — handled by separate halo layer, base dot stays risk color
  ['==', ['get', 'has_upcoming_change'], true], '#A855F7',  // Purple — pump change flagged
  ['>=', ['get', 'months_running'], 17],         '#EF4444',  // Red — overdue
  ['>=', ['get', 'months_running'], 14],         '#F97316',  // Orange — due
  ['>=', ['get', 'months_running'], 9],          '#EAB308',  // Yellow — watch
  ['>', ['get', 'months_running'], 0],           '#22C55E',  // Green — healthy
  '#6B7280'                                                  // Gray — down/no data
] as mapboxgl.Expression;

// Dot size: scale 6–18px based on dec_rate_bbl_d (0–200 bbl/d range)
export const WELL_SIZE_EXPRESSION = [
  'interpolate', ['linear'], ['coalesce', ['get', 'dec_rate_bbl_d'], 0],
  0, 6,
  50, 10,
  100, 14,
  200, 18
] as mapboxgl.Expression;

// Stroke color — white normally, brighter for WellFi
export const WELL_STROKE_EXPRESSION = [
  'case',
  ['==', ['get', 'has_wellfi'], true], '#00D4FF',
  '#ffffff'
] as mapboxgl.Expression;

// ── Risk Label Helpers ────────────────────────────────────────────────────
export const RISK_COLORS: Record<string, string> = {
  'HIGH — DUE':       '#EF4444',
  'WATCH':            '#EAB308',
  'LOW':              '#22C55E',
  'RECENTLY CHANGED': '#22C55E',
  'DOWN NOW':         '#6B7280',
  'NO DATA':          '#6B7280',
  'UNKNOWN':          '#6B7280',
};

export const riskColor = (risk: string | null): string =>
  risk ? (RISK_COLORS[risk] ?? '#6B7280') : '#6B7280';

// ── GeoJSON Conversion ─────────────────────────────────────────────────────
import type { Well } from '../types';

export function wellsToGeoJSON(wells: Well[]): GeoJSON.FeatureCollection {
  return {
    type: 'FeatureCollection',
    features: wells.map(w => ({
      type: 'Feature',
      geometry: { type: 'Point', coordinates: [w.lon, w.lat] },
      properties: {
        id: w.id,
        well_id: w.well_id,
        name: w.name,
        formation: w.formation,
        field: w.field,
        well_status: w.well_status,
        risk_level: w.risk_level,
        months_running: w.months_running,
        dec_rate_bbl_d: w.dec_rate_bbl_d,
        total_2025_bbl: w.total_2025_bbl,
        has_wellfi: !!w.wellfi_device,
        has_upcoming_change: !!(w.active_pump_change &&
          ['warning','scheduled','in_progress'].includes(w.active_pump_change.status)),
        status_note: w.status_note,
      }
    }))
  };
}
```

### Task 2 — WellMap Root Component
File: `src/components/map/WellMap.tsx`

```typescript
// Root Mapbox GL JS component. Receives wells data and renders the map.
// Props:
//   wells: Well[]
//   onWellClick: (well: Well) => void
//   filters: MapFilters (from types.ts)

// Implementation:
// 1. useRef for map container div
// 2. useEffect to init mapboxgl.Map once — satellite-streets-v12 style
//    Center: [-116.63, 56.16], Zoom: 9
// 3. On map load: add 'wells-source' GeoJSON source + WellLayer + WellFiHalo layers
// 4. useEffect on wells/filters change: update source data + apply filters
// 5. Map click handler: find clicked feature, call onWellClick with matching Well
// 6. Include map legend (inline — 6 color swatches + WellFi halo swatch)
// 7. Satellite/terrain style toggle button (top-right corner)
// 8. Fullscreen button
// Clean up map instance on unmount.
// Get token from: import.meta.env.VITE_MAPBOX_TOKEN
```

### Task 3 — Well Layer (dots)
File: `src/components/map/WellLayer.tsx`

```typescript
// Manages the Mapbox circle layers for well dots.
// Called by WellMap after map loads.
// Adds two layers:
//   1. 'wells-dots' — circle layer for all wells using WELL_COLOR_EXPRESSION, WELL_SIZE_EXPRESSION
//   2. 'wells-strokes' — circle layer with white/cyan stroke (1.5px)
// Exports: addWellLayers(map: mapboxgl.Map): void
// Exports: updateWellFilters(map: mapboxgl.Map, filters: MapFilters): void
//   → Uses mapboxgl setFilter() with expressions built from MapFilters
```

### Task 4 — WellFi Halo
File: `src/components/map/WellFiHalo.tsx`

```typescript
// Pulsing cyan ring around WellFi-installed wells.
// Adds a third circle layer 'wells-wellfi-halo' with:
//   - filter: ['==', ['get', 'has_wellfi'], true]
//   - circle-radius: 20
//   - circle-color: 'transparent'
//   - circle-stroke-color: '#00D4FF'
//   - circle-stroke-width: 2.5
//   - circle-opacity: animated via requestAnimationFrame (pulse 0.3 → 1.0)
// Exports: addWellFiHaloLayer(map: mapboxgl.Map): void
// Exports: startHaloPulse(map: mapboxgl.Map): () => void  ← returns cleanup fn
```

### Task 5 — Well Popup
File: `src/components/map/WellPopup.tsx`

```typescript
// Mapbox popup displayed on well click.
// NOT a React component — returns an HTML string for mapboxgl.Popup setHTML().
// Exports: wellPopupHTML(well: Well): string
// Content to include:
//   - Well name + formatted ID
//   - Risk badge (colored pill)
//   - Formation / Field
//   - Months running (with visual bar)
//   - Dec bbl/d + 2025 total bbl
//   - WellFi status: "Installed [date] by [name]" or "Not Installed"
//   - Pump change warning: if active, show scheduled date + status
//   - "Details" button that triggers onWellClick (use data-well-id attribute)
// Style with inline CSS (no Tailwind — Mapbox popups are outside React tree)
```

---

## Completion
1. Update lock file → `"completed"`
2. Update `agents/STATUS.json`: set `sessions.2.agents.agent-map` → `"completed"`
   - If agent-hooks is also done, set session 2 → `"completed"` and unlock Session 3
3. Create `agents/proposals/agent-map-completion.md`

**FROZEN FILES — DO NOT TOUCH:** `src/types.ts`, `src/lib/supabase.ts`
**DO NOT TOUCH:** `src/hooks/**`, `supabase/**`, `src/pages/**`
