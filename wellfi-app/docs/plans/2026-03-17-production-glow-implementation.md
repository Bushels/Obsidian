# Production Glow Visualization — Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add production-weighted radial glow heatmaps (green=Clearwater, amber=Bluesky) for 6,064 oil/bitumen wells, with zoom-crossfaded well dots colored by formation + op status stroke.

**Architecture:** Pre-process CSV → static GeoJSON in `public/data/`. Two Mapbox heatmap layers (one per formation) share a single GeoJSON source filtered by `formation` property. A circle layer renders well dots that fade in as heatmaps fade out. Toggle buttons in the existing map control bar let users show/hide each formation independently.

**Tech Stack:** Mapbox GL JS heatmap + circle layers, Node.js build script for CSV→GeoJSON, TypeScript, existing glassmorphicStyle color system.

**Design Doc:** `docs/plans/2026-03-17-production-glow-visualization-design.md`

---

## Task 1: CSV → GeoJSON Build Script

**Files:**
- Create: `scripts/build-production-geojson.js`
- Create: `public/data/bluesky-clearwater-production.geojson` (output)

**Step 1: Write the build script**

```javascript
// scripts/build-production-geojson.js
//
// Converts active_clearwater_bluesky_recent_prod_ab_sk.csv into a GeoJSON
// FeatureCollection for the production glow visualization.
//
// Filters: only Clearwater/Bluesky formations, only Crude Oil/Crude Bitumen fluid type.
// Run: node scripts/build-production-geojson.js

const fs = require('fs');
const path = require('path');

const CSV_PATH = path.resolve(__dirname, '../Data/active_clearwater_bluesky_recent_prod_ab_sk.csv');
const OUT_PATH = path.resolve(__dirname, '../wellfi-app/public/data/bluesky-clearwater-production.geojson');

// ── CSV parser (handles quoted fields with internal commas) ──────────────

function parseCSVLine(line) {
  const result = [];
  let current = '';
  let inQuotes = false;
  for (let i = 0; i < line.length; i++) {
    if (line[i] === '"') { inQuotes = !inQuotes; }
    else if (line[i] === ',' && !inQuotes) { result.push(current.trim()); current = ''; }
    else { current += line[i]; }
  }
  result.push(current.trim());
  return result;
}

// ── Main ─────────────────────────────────────────────────────────────────

const raw = fs.readFileSync(CSV_PATH, 'utf8');
const lines = raw.split('\n').filter(l => l.trim());
const header = parseCSVLine(lines[0]);

const idx = Object.fromEntries(header.map((h, i) => [h, i]));

const features = [];

for (let i = 1; i < lines.length; i++) {
  const row = parseCSVLine(lines[i]);
  const formation = row[idx['producing_formation']] || '';
  const fluidType = row[idx['well_fluid_type']] || '';

  // Filter: only Clearwater/Bluesky oil/bitumen wells
  const isClearwater = formation.includes('Clearwater');
  const isBluesky = formation.includes('Bluesky');
  if (!isClearwater && !isBluesky) continue;
  if (fluidType !== 'Crude Oil' && fluidType !== 'Crude Bitumen') continue;

  const lat = parseFloat(row[idx['surface_latitude']]);
  const lng = parseFloat(row[idx['surface_longitude']]);
  if (isNaN(lat) || isNaN(lng)) continue;

  // Canonical formation name (pick primary if multi-formation)
  const canonicalFormation = isClearwater ? 'Clearwater' : 'Bluesky';

  features.push({
    type: 'Feature',
    geometry: { type: 'Point', coordinates: [lng, lat] },
    properties: {
      uwi: row[idx['uwi']] || '',
      operator: row[idx['operator_licensee']] || '',
      formation: canonicalFormation,
      field_name: row[idx['field_name']] || '',
      well_fluid_type: fluidType,
      well_status: row[idx['well_status']] || '',
      recent_oil: parseFloat(row[idx['recent_oil']]) || 0,
      cumulative_oil: parseFloat(row[idx['cumulative_oil']]) || 0,
      recent_gas: parseFloat(row[idx['recent_gas']]) || 0,
      recent_water: parseFloat(row[idx['recent_water']]) || 0,
      recent_steam_injection: parseFloat(row[idx['recent_steam_injection']]) || 0,
      last_production_date: row[idx['last_production_date']] || '',
      spud_date: row[idx['spud_date']] || '',
      op_status: 'normal',  // Default — future Supabase integration
    },
  });
}

const geojson = { type: 'FeatureCollection', features };

fs.writeFileSync(OUT_PATH, JSON.stringify(geojson));

console.log(`Written ${features.length} features to ${OUT_PATH}`);
console.log(`  Clearwater: ${features.filter(f => f.properties.formation === 'Clearwater').length}`);
console.log(`  Bluesky: ${features.filter(f => f.properties.formation === 'Bluesky').length}`);
console.log(`  File size: ${(fs.statSync(OUT_PATH).size / 1024 / 1024).toFixed(2)} MB`);
```

**Step 2: Run the script and verify output**

Run: `node scripts/build-production-geojson.js`

Expected:
```
Written 6064 features to .../public/data/bluesky-clearwater-production.geojson
  Clearwater: 5194
  Bluesky: 870
  File size: ~1.5 MB
```

**Step 3: Spot-check the GeoJSON**

Run: `node -e "const d=require('./wellfi-app/public/data/bluesky-clearwater-production.geojson'); console.log('Total:', d.features.length); console.log('Sample:', JSON.stringify(d.features[0].properties, null, 2));"`

Verify: feature has `formation`, `recent_oil`, `uwi`, `op_status` fields.

**Step 4: Commit**

```bash
git add scripts/build-production-geojson.js wellfi-app/public/data/bluesky-clearwater-production.geojson
git commit -m "data: pre-process Clearwater/Bluesky CSV to production GeoJSON (6,064 wells)"
```

---

## Task 2: Production Heatmap Layer Module

**Files:**
- Create: `wellfi-app/src/components/map/ProductionGlow.ts`

**Step 1: Create the heatmap + dots layer module**

Follow the exact pattern from `HealthHeatmap.ts`. This module manages 3 layers:
1. `clearwater-production-heatmap` — green glow, filtered to Clearwater
2. `bluesky-production-heatmap` — amber glow, filtered to Bluesky
3. `production-well-dots` — circle layer with formation fill + op_status stroke

```typescript
// wellfi-app/src/components/map/ProductionGlow.ts
/**
 * ProductionGlow — Formation-colored production heatmap + well dots
 *
 * Two heatmap layers (Clearwater=green, Bluesky=amber) weighted by recent_oil.
 * Well dots fade in as heatmaps fade out at zoom ~12-14.
 * Dot fill = formation color, stroke = operational status.
 */
import type { Map as MapboxMap } from 'mapbox-gl';

// ─── Constants ─────────────────────────────────────────────────────────────

const SOURCE_ID = 'bluesky-clearwater-production-source';
const GEOJSON_URL = '/data/bluesky-clearwater-production.geojson';

const LAYER_CW_HEATMAP = 'clearwater-production-heatmap';
const LAYER_BS_HEATMAP = 'bluesky-production-heatmap';
const LAYER_DOTS = 'production-well-dots';

// Normalization: sqrt(max_production) per formation
const CW_SQRT_MAX = 70.7;  // sqrt(5000)
const BS_SQRT_MAX = 38.7;  // sqrt(1500)

// ─── Color Ramps ───────────────────────────────────────────────────────────

const CLEARWATER_RAMP = [
  'interpolate', ['linear'], ['heatmap-density'],
  0,    'rgba(74, 222, 128, 0)',
  0.15, 'rgba(74, 222, 128, 0.15)',
  0.35, 'rgba(34, 197, 94, 0.25)',
  0.55, 'rgba(22, 163, 74, 0.40)',
  0.75, 'rgba(21, 128, 61, 0.55)',
  1.0,  'rgba(20, 83, 45, 0.70)',
];

const BLUESKY_RAMP = [
  'interpolate', ['linear'], ['heatmap-density'],
  0,    'rgba(251, 191, 36, 0)',
  0.15, 'rgba(251, 191, 36, 0.15)',
  0.35, 'rgba(245, 158, 11, 0.25)',
  0.55, 'rgba(217, 119, 6, 0.40)',
  0.75, 'rgba(180, 83, 9, 0.55)',
  1.0,  'rgba(120, 53, 15, 0.70)',
];

// ─── Dot Colors ────────────────────────────────────────────────────────────

const CW_DOT_COLOR = '#22C55E';  // green-500
const BS_DOT_COLOR = '#F59E0B';  // amber-500
const WATCH_STROKE = '#3B82F6';  // blue-500
const WARNING_STROKE = '#EF4444'; // red-500

// ─── Public API ────────────────────────────────────────────────────────────

/**
 * Fetch production GeoJSON and add all three layers.
 * Call after map 'load' event, after base layers are set up.
 */
export async function addProductionGlow(
  map: MapboxMap,
  beforeLayerId?: string,
): Promise<void> {
  // Skip if source already exists (idempotent)
  if (map.getSource(SOURCE_ID)) return;

  // Fetch pre-processed GeoJSON
  const response = await fetch(GEOJSON_URL);
  const geojson = await response.json();

  // Add source
  map.addSource(SOURCE_ID, {
    type: 'geojson',
    data: geojson,
    generateId: true,
  });

  // ── Clearwater heatmap ──────────────────────────────────────────────────

  map.addLayer(
    {
      id: LAYER_CW_HEATMAP,
      type: 'heatmap',
      source: SOURCE_ID,
      maxzoom: 15,
      filter: ['==', ['get', 'formation'], 'Clearwater'],
      paint: {
        'heatmap-weight': [
          'min', 1,
          ['interpolate', ['linear'],
            ['sqrt', ['get', 'recent_oil']],
            0, 0,
            CW_SQRT_MAX, 1,
          ],
        ] as unknown as number,
        'heatmap-intensity': [
          'interpolate', ['linear'], ['zoom'],
          0, 1,
          9, 3,
        ] as unknown as number,
        'heatmap-color': CLEARWATER_RAMP as unknown as string,
        'heatmap-radius': [
          'interpolate', ['linear'], ['zoom'],
          0, 4,
          9, 40,
          13, 60,
        ] as unknown as number,
        'heatmap-opacity': [
          'interpolate', ['linear'], ['zoom'],
          7, 0.7,
          14, 0,
        ] as unknown as number,
      },
    },
    beforeLayerId,
  );

  // ── Bluesky heatmap ─────────────────────────────────────────────────────

  map.addLayer(
    {
      id: LAYER_BS_HEATMAP,
      type: 'heatmap',
      source: SOURCE_ID,
      maxzoom: 15,
      filter: ['==', ['get', 'formation'], 'Bluesky'],
      paint: {
        'heatmap-weight': [
          'min', 1,
          ['interpolate', ['linear'],
            ['sqrt', ['get', 'recent_oil']],
            0, 0,
            BS_SQRT_MAX, 1,
          ],
        ] as unknown as number,
        'heatmap-intensity': [
          'interpolate', ['linear'], ['zoom'],
          0, 1,
          9, 3,
        ] as unknown as number,
        'heatmap-color': BLUESKY_RAMP as unknown as string,
        'heatmap-radius': [
          'interpolate', ['linear'], ['zoom'],
          0, 4,
          9, 40,
          13, 60,
        ] as unknown as number,
        'heatmap-opacity': [
          'interpolate', ['linear'], ['zoom'],
          7, 0.7,
          14, 0,
        ] as unknown as number,
      },
    },
    beforeLayerId,
  );

  // ── Well dots ───────────────────────────────────────────────────────────

  map.addLayer(
    {
      id: LAYER_DOTS,
      type: 'circle',
      source: SOURCE_ID,
      minzoom: 10,
      // Hide well_down wells
      filter: ['!=', ['get', 'op_status'], 'well_down'],
      paint: {
        // Fill = formation color (always visible)
        'circle-color': [
          'case',
          ['==', ['get', 'formation'], 'Clearwater'], CW_DOT_COLOR,
          BS_DOT_COLOR,
        ] as unknown as string,
        'circle-radius': [
          'interpolate', ['linear'], ['zoom'],
          10, 2,
          13, 4,
          16, 6,
        ] as unknown as number,
        // Fade in as heatmap fades out
        'circle-opacity': [
          'interpolate', ['linear'], ['zoom'],
          11, 0,
          13, 0.9,
        ] as unknown as number,
        // Stroke = operational status
        'circle-stroke-color': [
          'case',
          ['==', ['get', 'op_status'], 'watch'], WATCH_STROKE,
          ['==', ['get', 'op_status'], 'warning'], WARNING_STROKE,
          'rgba(0, 0, 0, 0)',  // transparent for normal
        ] as unknown as string,
        'circle-stroke-width': [
          'case',
          ['==', ['get', 'op_status'], 'watch'], 2,
          ['==', ['get', 'op_status'], 'warning'], 2.5,
          0,
        ] as unknown as number,
        'circle-stroke-opacity': [
          'interpolate', ['linear'], ['zoom'],
          11, 0,
          13, 1,
        ] as unknown as number,
      },
    },
    beforeLayerId,
  );
}

/**
 * Remove all production glow layers and source.
 */
export function removeProductionGlow(map: MapboxMap): void {
  for (const id of [LAYER_DOTS, LAYER_BS_HEATMAP, LAYER_CW_HEATMAP]) {
    if (map.getLayer(id)) map.removeLayer(id);
  }
  if (map.getSource(SOURCE_ID)) map.removeSource(SOURCE_ID);
}

/**
 * Toggle visibility of a specific formation's heatmap layer.
 */
export function setFormationHeatmapVisibility(
  map: MapboxMap,
  formation: 'Clearwater' | 'Bluesky',
  visible: boolean,
): void {
  const layerId = formation === 'Clearwater' ? LAYER_CW_HEATMAP : LAYER_BS_HEATMAP;
  if (map.getLayer(layerId)) {
    map.setLayoutProperty(layerId, 'visibility', visible ? 'visible' : 'none');
  }
}

/**
 * Toggle visibility of well dots.
 */
export function setProductionDotsVisibility(
  map: MapboxMap,
  visible: boolean,
): void {
  if (map.getLayer(LAYER_DOTS)) {
    map.setLayoutProperty(LAYER_DOTS, 'visibility', visible ? 'visible' : 'none');
  }
}

/**
 * Returns the layer IDs for external use (e.g., popup hover handlers).
 */
export const PRODUCTION_LAYER_IDS = {
  clearwaterHeatmap: LAYER_CW_HEATMAP,
  blueskyHeatmap: LAYER_BS_HEATMAP,
  dots: LAYER_DOTS,
  source: SOURCE_ID,
} as const;
```

**Step 2: Verify TypeScript compiles**

Run: `cd wellfi-app && npx tsc --noEmit src/components/map/ProductionGlow.ts`

Expected: No errors.

**Step 3: Commit**

```bash
git add wellfi-app/src/components/map/ProductionGlow.ts
git commit -m "feat: add ProductionGlow layer module (heatmaps + dots)"
```

---

## Task 3: Integrate into WellMap.tsx

**Files:**
- Modify: `wellfi-app/src/components/map/WellMap.tsx`

**Step 1: Add import**

At the top of WellMap.tsx, add alongside existing map layer imports:

```typescript
import { addProductionGlow, PRODUCTION_LAYER_IDS } from './ProductionGlow';
```

**Step 2: Call addProductionGlow in map load handler**

In the `map.on('load', ...)` callback, after `addHealthHeatmap(map)` (line ~182) and before `addMonitoredAlertLayers`, add:

```typescript
// Production glow for Clearwater/Bluesky wells (async, loads GeoJSON)
addProductionGlow(map, 'parcel-health-glow').catch(console.error);
```

The `beforeLayerId` of `'parcel-health-glow'` places the heatmaps below the parcel layers. If that layer doesn't exist yet (parcels load async), pass `undefined` — the layers will still render in correct order since parcels are added later.

Adjust `beforeLayerId` based on what layers exist at call time:

```typescript
const productionBeforeLayer =
  map.getLayer('parcel-health-glow') ? 'parcel-health-glow' :
  map.getLayer('mineral-rights-glow') ? 'mineral-rights-glow' :
  undefined;
addProductionGlow(map, productionBeforeLayer).catch(console.error);
```

**Step 3: Verify map loads without errors**

Run: `cd wellfi-app && npm run dev`

Open browser at localhost, check:
- No console errors
- Green glow appears in Clearwater regions
- Amber glow appears in Bluesky regions
- Dots appear when zoomed to ~13+
- Existing parcel layers still render on top

**Step 4: Commit**

```bash
git add wellfi-app/src/components/map/WellMap.tsx
git commit -m "feat: integrate ProductionGlow into WellMap load sequence"
```

---

## Task 4: Dot Hover Tooltip

**Files:**
- Create: `wellfi-app/src/components/map/ProductionPopup.ts`
- Modify: `wellfi-app/src/components/map/WellMap.tsx`

**Step 1: Write the popup HTML generator**

Follow the exact pattern from `ParcelPopup.ts` — pure function returning HTML string.

```typescript
// wellfi-app/src/components/map/ProductionPopup.ts
/**
 * ProductionPopup — Hover tooltip for production well dots
 */

export function productionDotPopupHTML(
  properties: Record<string, unknown>,
): string {
  const uwi = String(properties.uwi ?? '');
  const operator = String(properties.operator ?? '');
  const formation = String(properties.formation ?? '');
  const recentOil = Number(properties.recent_oil ?? 0);
  const recentGas = Number(properties.recent_gas ?? 0);
  const recentWater = Number(properties.recent_water ?? 0);
  const fieldName = String(properties.field_name ?? '');
  const opStatus = String(properties.op_status ?? 'normal');

  const formationColor = formation === 'Clearwater' ? '#22C55E' : '#F59E0B';
  const statusBadge = opStatus !== 'normal'
    ? `<span style="
        display:inline-block; padding:1px 6px; border-radius:4px; font-size:10px;
        background:${opStatus === 'watch' ? 'rgba(59,130,246,0.2)' : 'rgba(239,68,68,0.2)'};
        color:${opStatus === 'watch' ? '#60A5FA' : '#F87171'};
        margin-left:6px;
      ">${opStatus.toUpperCase()}</span>`
    : '';

  return `
    <div style="font-family:Inter,system-ui,sans-serif; color:#E5E7EB; min-width:200px;">
      <div style="font-size:11px; color:#9CA3AF; margin-bottom:4px;">
        ${uwi}${statusBadge}
      </div>
      <div style="font-size:13px; font-weight:600; margin-bottom:2px;">
        ${operator}
      </div>
      <div style="font-size:11px; margin-bottom:8px;">
        <span style="color:${formationColor}; font-weight:500;">${formation}</span>
        <span style="color:#6B7280; margin-left:4px;">${fieldName}</span>
      </div>
      <div style="display:grid; grid-template-columns:1fr 1fr 1fr; gap:4px; font-size:11px;">
        <div>
          <div style="color:#9CA3AF;">Oil</div>
          <div style="font-weight:600; color:${formationColor};">${recentOil.toFixed(1)}</div>
        </div>
        <div>
          <div style="color:#9CA3AF;">Gas</div>
          <div style="font-weight:500;">${recentGas.toFixed(1)}</div>
        </div>
        <div>
          <div style="color:#9CA3AF;">Water</div>
          <div style="font-weight:500;">${recentWater.toFixed(1)}</div>
        </div>
      </div>
    </div>
  `;
}
```

**Step 2: Wire hover events in WellMap.tsx**

In WellMap.tsx, in the map setup section where other hover handlers are registered (look for `mouseenter`/`mouseleave` on parcel or alert layers), add:

```typescript
// ── Production dot hover ────────────────────────────────────────────────
import { productionDotPopupHTML } from './ProductionPopup';
import { PRODUCTION_LAYER_IDS } from './ProductionGlow';

map.on('mouseenter', PRODUCTION_LAYER_IDS.dots, (e) => {
  map.getCanvas().style.cursor = 'pointer';
  if (!e.features?.[0]) return;

  const props = e.features[0].properties ?? {};
  const coords = (e.features[0].geometry as GeoJSON.Point).coordinates.slice() as [number, number];

  // Remove existing popup
  popupRef.current?.remove();

  popupRef.current = new mapboxgl.Popup({
    closeButton: false,
    closeOnClick: false,
    maxWidth: '280px',
    className: 'wellfi-popup',
    offset: 10,
  })
    .setLngLat(coords)
    .setHTML(productionDotPopupHTML(props))
    .addTo(map);
});

map.on('mouseleave', PRODUCTION_LAYER_IDS.dots, () => {
  map.getCanvas().style.cursor = '';
  popupRef.current?.remove();
  popupRef.current = null;
});
```

**Step 3: Test hover interaction**

Run dev server, zoom to ~13+, hover over dots. Verify:
- Tooltip appears with UWI, operator, formation, production values
- Tooltip disappears on mouse leave
- No conflicts with existing parcel/alert hover handlers

**Step 4: Commit**

```bash
git add wellfi-app/src/components/map/ProductionPopup.ts wellfi-app/src/components/map/WellMap.tsx
git commit -m "feat: add hover tooltip for production well dots"
```

---

## Task 5: Formation Toggle Controls

**Files:**
- Modify: `wellfi-app/src/components/map/WellMap.tsx`

**Step 1: Add toggle state**

In WellMap.tsx, alongside existing `showLand`, `showProduction` state variables, add:

```typescript
const [showClearwater, setShowClearwater] = useState(true);
const [showBluesky, setShowBluesky] = useState(true);
```

**Step 2: Add toggle buttons to the map control bar**

In the control buttons section (look for the `Land`, `Glow`, `LSD` buttons around lines 843-923), add two new buttons:

```typescript
{/* Formation heatmap toggles */}
<button
  onClick={() => {
    const next = !showClearwater;
    setShowClearwater(next);
    if (mapRef.current) {
      setFormationHeatmapVisibility(mapRef.current, 'Clearwater', next);
    }
  }}
  className={`px-2 py-1 rounded text-xs font-medium transition-colors ${
    showClearwater
      ? 'bg-green-500/20 text-green-400 border border-green-500/30'
      : 'bg-gray-800/50 text-gray-500 border border-gray-700/30'
  }`}
  title="Toggle Clearwater production heatmap"
>
  CW
</button>
<button
  onClick={() => {
    const next = !showBluesky;
    setShowBluesky(next);
    if (mapRef.current) {
      setFormationHeatmapVisibility(mapRef.current, 'Bluesky', next);
    }
  }}
  className={`px-2 py-1 rounded text-xs font-medium transition-colors ${
    showBluesky
      ? 'bg-amber-500/20 text-amber-400 border border-amber-500/30'
      : 'bg-gray-800/50 text-gray-500 border border-gray-700/30'
  }`}
  title="Toggle Bluesky production heatmap"
>
  BS
</button>
```

**Step 3: Add import for setFormationHeatmapVisibility**

```typescript
import {
  addProductionGlow,
  setFormationHeatmapVisibility,
  PRODUCTION_LAYER_IDS,
} from './ProductionGlow';
```

**Step 4: Test toggles**

Run dev server, verify:
- CW button toggles Clearwater green heatmap on/off
- BS button toggles Bluesky amber heatmap on/off
- Dots remain visible when heatmaps are off
- Buttons show active/inactive state visually

**Step 5: Commit**

```bash
git add wellfi-app/src/components/map/WellMap.tsx
git commit -m "feat: add CW/BS formation toggle buttons for production heatmaps"
```

---

## Task 6: Visual Tuning & Final Polish

**Files:**
- Modify: `wellfi-app/src/components/map/ProductionGlow.ts` (tuning constants)

**Step 1: Test at multiple zoom levels**

Open the map and check each zoom range:
- **Zoom 5-8:** Both heatmaps visible, broad glow, no dots
- **Zoom 9-11:** Heatmaps more defined, dots just starting to appear
- **Zoom 12-13:** Crossfade zone — both visible, dots becoming solid
- **Zoom 14+:** Heatmaps gone, only dots visible

Adjust these constants if the crossfade feels wrong:
- `heatmap-opacity` zoom stops (currently 7→0.7, 14→0)
- `circle-opacity` zoom stops (currently 11→0, 13→0.9)
- `heatmap-radius` zoom stops (currently 0→4, 9→40, 13→60)
- `circle-radius` zoom stops (currently 10→2, 13→4, 16→6)

**Step 2: Test overlap zones**

Navigate to the geographic overlap area (~55.8-56.4°N, ~-117 to -116°W). Verify:
- Both colors are distinguishable when both toggles are on
- Turning off one formation isolates the other cleanly
- No muddy brown artifacts

**Step 3: Test dot colors**

Since `op_status` defaults to "normal" for all CSV wells, all dots should show formation colors (green/amber) with no stroke. When Supabase integration is added later, watch/warning/down will activate automatically through the `op_status` property.

**Step 4: Commit final tuning**

```bash
git add wellfi-app/src/components/map/ProductionGlow.ts
git commit -m "style: tune production glow heatmap radius, opacity, and crossfade"
```

---

## Summary of Files

| Action | File | Purpose |
|--------|------|---------|
| Create | `scripts/build-production-geojson.js` | CSV → GeoJSON converter |
| Create | `public/data/bluesky-clearwater-production.geojson` | Static production data |
| Create | `src/components/map/ProductionGlow.ts` | Heatmap + dots layer module |
| Create | `src/components/map/ProductionPopup.ts` | Dot hover tooltip |
| Modify | `src/components/map/WellMap.tsx` | Integration + toggles + hover |

**Total new code:** ~350 lines across 3 new files + ~50 lines of modifications to WellMap.tsx

**Dependencies added:** None (all native Mapbox GL JS)
