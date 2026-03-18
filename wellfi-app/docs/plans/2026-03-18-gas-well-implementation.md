# Gas Well Production Glow — Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add ~414 CW/BS gas wells as lighter-shaded heatmap layers beneath existing oil layers, with gas dots distinguished by color shade.

**Architecture:** Extend existing ProductionGlow module with 2 additional heatmap layers (gas below oil), update build script to include gas wells with non-zero production and add `fluid_type` property, update dot colors and popup to differentiate oil vs gas.

**Tech Stack:** Mapbox GL JS heatmap layers, Node.js build script, TypeScript, React

---

### Task 1: Update Build Script — Include Gas Wells + Filter Zero Production

**Files:**
- Modify: `scripts/build-production-geojson.js`

**Step 1: Update the fluid type filter and add production filter**

Replace lines 35 and add a `fluid_type` property. The new logic:
- Include `Crude Oil`, `Crude Bitumen`, AND `Gas` fluid types
- For oil/bitumen wells: skip if `recent_oil <= 0`
- For gas wells: skip if `recent_gas <= 0`
- Add `fluid_type` property: `'oil'` for Crude Oil/Bitumen, `'gas'` for Gas

```javascript
const fs = require('fs');
const path = require('path');

const CSV_PATH = path.resolve(__dirname, '../Data/active_clearwater_bluesky_recent_prod_ab_sk.csv');
const OUT_PATH = path.resolve(__dirname, '../wellfi-app/public/data/bluesky-clearwater-production.geojson');

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

const raw = fs.readFileSync(CSV_PATH, 'utf8');
const lines = raw.split('\n').filter(l => l.trim());
const header = parseCSVLine(lines[0]);
const idx = Object.fromEntries(header.map((h, i) => [h, i]));

const features = [];

for (let i = 1; i < lines.length; i++) {
  const row = parseCSVLine(lines[i]);
  const formation = row[idx['producing_formation']] || '';
  const fluidType = row[idx['well_fluid_type']] || '';

  const isClearwater = formation.includes('Clearwater');
  const isBluesky = formation.includes('Bluesky');
  if (!isClearwater && !isBluesky) continue;

  // Determine fluid category
  const isOil = fluidType === 'Crude Oil' || fluidType === 'Crude Bitumen';
  const isGas = fluidType === 'Gas';
  if (!isOil && !isGas) continue;

  // Filter out zero-production wells
  const recentOil = parseFloat(row[idx['recent_oil']]) || 0;
  const recentGas = parseFloat(row[idx['recent_gas']]) || 0;
  if (isOil && recentOil <= 0) continue;
  if (isGas && recentGas <= 0) continue;

  const lat = parseFloat(row[idx['surface_latitude']]);
  const lng = parseFloat(row[idx['surface_longitude']]);
  if (isNaN(lat) || isNaN(lng)) continue;

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
      fluid_type: isOil ? 'oil' : 'gas',
      well_status: row[idx['well_status']] || '',
      recent_oil: recentOil,
      cumulative_oil: parseFloat(row[idx['cumulative_oil']]) || 0,
      recent_gas: recentGas,
      recent_water: parseFloat(row[idx['recent_water']]) || 0,
      recent_steam_injection: parseFloat(row[idx['recent_steam_injection']]) || 0,
      last_production_date: row[idx['last_production_date']] || '',
      spud_date: row[idx['spud_date']] || '',
      op_status: 'normal',
    },
  });
}

const geojson = { type: 'FeatureCollection', features };
fs.writeFileSync(OUT_PATH, JSON.stringify(geojson));

const oilWells = features.filter(f => f.properties.fluid_type === 'oil');
const gasWells = features.filter(f => f.properties.fluid_type === 'gas');

console.log(`Written ${features.length} features to ${OUT_PATH}`);
console.log(`  Oil/Bitumen: ${oilWells.length}`);
console.log(`    Clearwater: ${oilWells.filter(f => f.properties.formation === 'Clearwater').length}`);
console.log(`    Bluesky: ${oilWells.filter(f => f.properties.formation === 'Bluesky').length}`);
console.log(`  Gas: ${gasWells.length}`);
console.log(`    Clearwater: ${gasWells.filter(f => f.properties.formation === 'Clearwater').length}`);
console.log(`    Bluesky: ${gasWells.filter(f => f.properties.formation === 'Bluesky').length}`);
console.log(`  File size: ${(fs.statSync(OUT_PATH).size / 1024 / 1024).toFixed(2)} MB`);
```

**Step 2: Run the build script**

Run: `node scripts/build-production-geojson.js`
Expected output: ~6,400+ features total with breakdown by oil/gas and formation.

**Step 3: Commit**

```bash
git add scripts/build-production-geojson.js wellfi-app/public/data/bluesky-clearwater-production.geojson
git commit -m "feat: include gas wells in production GeoJSON, filter zero production"
```

---

### Task 2: Add Gas Heatmap Layers to ProductionGlow.ts

**Files:**
- Modify: `wellfi-app/src/components/map/ProductionGlow.ts`

**Step 1: Add gas constants, color ramps, and layer IDs**

Add after existing constants (line 21):

```typescript
// Gas normalization constants
const CW_GAS_SQRT_MAX = 18.1;  // sqrt(328)
const BS_GAS_SQRT_MAX = 6.2;   // sqrt(38)
```

Add new layer ID constants after line 17:

```typescript
const LAYER_CW_GAS_HEATMAP = 'clearwater-gas-heatmap';
const LAYER_BS_GAS_HEATMAP = 'bluesky-gas-heatmap';
```

Add gas color ramps after the existing BLUESKY_RAMP (after line 43):

```typescript
const CLEARWATER_GAS_RAMP = [
  'interpolate', ['linear'], ['heatmap-density'],
  0,    'rgba(134, 239, 172, 0)',
  0.15, 'rgba(134, 239, 172, 0.10)',
  0.35, 'rgba(134, 239, 172, 0.18)',
  0.55, 'rgba(74, 222, 128, 0.28)',
  0.75, 'rgba(34, 197, 94, 0.38)',
  1.0,  'rgba(22, 163, 74, 0.50)',
];

const BLUESKY_GAS_RAMP = [
  'interpolate', ['linear'], ['heatmap-density'],
  0,    'rgba(253, 224, 71, 0)',
  0.15, 'rgba(253, 224, 71, 0.10)',
  0.35, 'rgba(252, 211, 77, 0.18)',
  0.55, 'rgba(250, 204, 21, 0.28)',
  0.75, 'rgba(234, 179, 8, 0.38)',
  1.0,  'rgba(202, 138, 4, 0.50)',
];
```

Add gas dot colors after existing dot colors (after line 48):

```typescript
const CW_GAS_DOT_COLOR = '#86EFAC';  // green-300
const BS_GAS_DOT_COLOR = '#FCD34D';  // amber-300
```

**Step 2: Update heatmap filters to include fluid_type**

Update existing CW heatmap filter (line 88) from:
```typescript
filter: ['==', ['get', 'formation'], 'Clearwater'],
```
to:
```typescript
filter: ['all', ['==', ['get', 'formation'], 'Clearwater'], ['==', ['get', 'fluid_type'], 'oil']],
```

Update existing BS heatmap filter (line 128) from:
```typescript
filter: ['==', ['get', 'formation'], 'Bluesky'],
```
to:
```typescript
filter: ['all', ['==', ['get', 'formation'], 'Bluesky'], ['==', ['get', 'fluid_type'], 'oil']],
```

**Step 3: Add gas heatmap layers BEFORE oil layers**

Insert the two gas heatmap layers inside `addProductionGlow()`, BEFORE the existing CW oil heatmap (before line 82). Gas renders below oil:

```typescript
  // ── Clearwater GAS heatmap (below oil) ──────────────────────────────────
  map.addLayer(
    {
      id: LAYER_CW_GAS_HEATMAP,
      type: 'heatmap',
      source: SOURCE_ID,
      maxzoom: 15,
      filter: ['all', ['==', ['get', 'formation'], 'Clearwater'], ['==', ['get', 'fluid_type'], 'gas']],
      paint: {
        'heatmap-weight': [
          'min', 1,
          ['interpolate', ['linear'],
            ['sqrt', ['get', 'recent_gas']],
            0, 0,
            CW_GAS_SQRT_MAX, 1,
          ],
        ] as unknown as number,
        'heatmap-intensity': [
          'interpolate', ['linear'], ['zoom'],
          0, 1,
          9, 3,
        ] as unknown as number,
        'heatmap-color': CLEARWATER_GAS_RAMP as unknown as string,
        'heatmap-radius': [
          'interpolate', ['linear'], ['zoom'],
          0, 4,
          9, 40,
          13, 60,
        ] as unknown as number,
        'heatmap-opacity': [
          'interpolate', ['linear'], ['zoom'],
          7, 0.5,
          14, 0,
        ] as unknown as number,
      },
    },
    beforeLayerId,
  );

  // ── Bluesky GAS heatmap (below oil) ─────────────────────────────────────
  map.addLayer(
    {
      id: LAYER_BS_GAS_HEATMAP,
      type: 'heatmap',
      source: SOURCE_ID,
      maxzoom: 15,
      filter: ['all', ['==', ['get', 'formation'], 'Bluesky'], ['==', ['get', 'fluid_type'], 'gas']],
      paint: {
        'heatmap-weight': [
          'min', 1,
          ['interpolate', ['linear'],
            ['sqrt', ['get', 'recent_gas']],
            0, 0,
            BS_GAS_SQRT_MAX, 1,
          ],
        ] as unknown as number,
        'heatmap-intensity': [
          'interpolate', ['linear'], ['zoom'],
          0, 1,
          9, 3,
        ] as unknown as number,
        'heatmap-color': BLUESKY_GAS_RAMP as unknown as string,
        'heatmap-radius': [
          'interpolate', ['linear'], ['zoom'],
          0, 4,
          9, 40,
          13, 60,
        ] as unknown as number,
        'heatmap-opacity': [
          'interpolate', ['linear'], ['zoom'],
          7, 0.5,
          14, 0,
        ] as unknown as number,
      },
    },
    beforeLayerId,
  );
```

**Step 4: Update dot layer circle-color to differentiate gas vs oil**

Replace the existing `circle-color` paint property (lines 170-174) with:

```typescript
'circle-color': [
  'case',
  ['all', ['==', ['get', 'formation'], 'Clearwater'], ['==', ['get', 'fluid_type'], 'gas']],
  CW_GAS_DOT_COLOR,
  ['all', ['==', ['get', 'formation'], 'Bluesky'], ['==', ['get', 'fluid_type'], 'gas']],
  BS_GAS_DOT_COLOR,
  ['==', ['get', 'formation'], 'Bluesky'],
  BS_DOT_COLOR,
  CW_DOT_COLOR,
] as unknown as string,
```

**Step 5: Update removeProductionGlow to include gas layers**

Update the layer removal array (line 213) to:

```typescript
for (const id of [LAYER_DOTS, LAYER_BS_HEATMAP, LAYER_CW_HEATMAP, LAYER_BS_GAS_HEATMAP, LAYER_CW_GAS_HEATMAP]) {
```

**Step 6: Update setFormationHeatmapVisibility to toggle both oil + gas**

Replace the function (lines 222-231) with:

```typescript
export function setFormationHeatmapVisibility(
  map: MapboxMap,
  formation: 'Clearwater' | 'Bluesky',
  visible: boolean,
): void {
  const oilLayer = formation === 'Clearwater' ? LAYER_CW_HEATMAP : LAYER_BS_HEATMAP;
  const gasLayer = formation === 'Clearwater' ? LAYER_CW_GAS_HEATMAP : LAYER_BS_GAS_HEATMAP;
  const vis = visible ? 'visible' : 'none';
  if (map.getLayer(oilLayer)) map.setLayoutProperty(oilLayer, 'visibility', vis);
  if (map.getLayer(gasLayer)) map.setLayoutProperty(gasLayer, 'visibility', vis);
}
```

**Step 7: Update PRODUCTION_LAYER_IDS export**

Replace (lines 248-253) with:

```typescript
export const PRODUCTION_LAYER_IDS = {
  clearwaterHeatmap: LAYER_CW_HEATMAP,
  blueskyHeatmap: LAYER_BS_HEATMAP,
  clearwaterGasHeatmap: LAYER_CW_GAS_HEATMAP,
  blueskyGasHeatmap: LAYER_BS_GAS_HEATMAP,
  dots: LAYER_DOTS,
  source: SOURCE_ID,
} as const;
```

**Step 8: Commit**

```bash
git add wellfi-app/src/components/map/ProductionGlow.ts
git commit -m "feat: add gas heatmap layers below oil with lighter color ramps"
```

---

### Task 3: Update ProductionPopup for Gas Wells

**Files:**
- Modify: `wellfi-app/src/components/map/ProductionPopup.ts`

**Step 1: Add fluid type detection and conditional display**

Replace the full function body with:

```typescript
export function productionDotPopupHTML(
  properties: Record<string, unknown>,
): string {
  const uwi = String(properties.uwi ?? '');
  const operator = String(properties.operator ?? '');
  const formation = String(properties.formation ?? '');
  const fluidType = String(properties.fluid_type ?? 'oil');
  const recentOil = Number(properties.recent_oil) || 0;
  const recentGas = Number(properties.recent_gas) || 0;
  const recentWater = Number(properties.recent_water) || 0;
  const fieldName = String(properties.field_name ?? '');
  const opStatus = String(properties.op_status ?? 'normal');

  const isGas = fluidType === 'gas';
  const formationColor = formation === 'Clearwater'
    ? (isGas ? '#86EFAC' : '#22C55E')
    : (isGas ? '#FCD34D' : '#F59E0B');

  const fluidBadge = `<span style="
      display:inline-block; padding:1px 6px; border-radius:4px; font-size:10px;
      background:${isGas ? 'rgba(134,239,172,0.15)' : 'rgba(34,197,94,0.15)'};
      color:${formationColor};
      margin-left:6px;
    ">${isGas ? 'GAS' : 'OIL'}</span>`;

  const statusBadge = opStatus !== 'normal'
    ? `<span style="
        display:inline-block; padding:1px 6px; border-radius:4px; font-size:10px;
        background:${opStatus === 'watch' ? 'rgba(59,130,246,0.2)' : 'rgba(239,68,68,0.2)'};
        color:${opStatus === 'watch' ? '#60A5FA' : '#F87171'};
        margin-left:6px;
      ">${opStatus.toUpperCase()}</span>`
    : '';

  // Primary production metric differs by fluid type
  const primaryLabel = isGas ? 'Gas' : 'Oil';
  const primaryValue = isGas ? recentGas : recentOil;
  const secondaryLabel = isGas ? 'Oil' : 'Gas';
  const secondaryValue = isGas ? recentOil : recentGas;

  return `
    <div style="font-family:Inter,system-ui,sans-serif; color:#E5E7EB; min-width:200px;">
      <div style="font-size:11px; color:#9CA3AF; margin-bottom:4px;">
        ${uwi}${fluidBadge}${statusBadge}
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
          <div style="color:#9CA3AF;">${primaryLabel}</div>
          <div style="font-weight:600; color:${formationColor};">${primaryValue.toFixed(1)}</div>
        </div>
        <div>
          <div style="color:#9CA3AF;">${secondaryLabel}</div>
          <div style="font-weight:500;">${secondaryValue.toFixed(1)}</div>
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

**Step 2: Commit**

```bash
git add wellfi-app/src/components/map/ProductionPopup.ts
git commit -m "feat: popup shows gas/oil badge with fluid-type-aware colors and primary metric"
```

---

### Task 4: Update WellMap.tsx Legend

**Files:**
- Modify: `wellfi-app/src/components/map/WellMap.tsx`

**Step 1: Update the legend to show oil vs gas distinction**

Find the Production Glow legend section (around line 780) and replace the 2 formation entries with 4 entries:

```tsx
<div className="text-gray-500 font-semibold mb-2 text-[10px] uppercase tracking-wider">
  Production Glow
</div>
<div className="flex flex-col gap-1.5">
  <div className="flex items-center gap-2">
    <span className="inline-block w-2.5 h-2.5 rounded-sm shrink-0" style={{ background: '#22C55E' }} />
    <span className="text-gray-400">Clearwater Oil</span>
  </div>
  <div className="flex items-center gap-2">
    <span className="inline-block w-2.5 h-2.5 rounded-sm shrink-0" style={{ background: '#86EFAC' }} />
    <span className="text-gray-400">Clearwater Gas</span>
  </div>
  <div className="flex items-center gap-2">
    <span className="inline-block w-2.5 h-2.5 rounded-sm shrink-0" style={{ background: '#F59E0B' }} />
    <span className="text-gray-400">Bluesky Oil</span>
  </div>
  <div className="flex items-center gap-2">
    <span className="inline-block w-2.5 h-2.5 rounded-sm shrink-0" style={{ background: '#FCD34D' }} />
    <span className="text-gray-400">Bluesky Gas</span>
  </div>
</div>
```

**Step 2: Commit**

```bash
git add wellfi-app/src/components/map/WellMap.tsx
git commit -m "feat: update legend with oil/gas distinction per formation"
```

---

### Task 5: Rebuild GeoJSON and Verify

**Step 1: Run build script**

Run: `node scripts/build-production-geojson.js`
Verify: Output shows both oil and gas counts with zero-production wells filtered.

**Step 2: Start dev server and verify visually**

Run: `cd wellfi-app && npm run dev`
Verify:
- Gas heatmap glows appear as lighter shades beneath oil glows
- CW/BS toggles control both oil and gas for each formation
- Zooming in reveals dots with differentiated colors (lighter = gas)
- Hovering gas dots shows "GAS" badge, gas as primary production metric
- Hovering oil dots shows "OIL" badge, oil as primary production metric
- Legend shows 4 entries: CW Oil, CW Gas, BS Oil, BS Gas
- No console errors

**Step 3: Get Gemini quality audit**

Use Gemini to audit the completed implementation for correctness.

**Step 4: Final commit if any fixes needed**

```bash
git add -A
git commit -m "fix: address any issues found during verification"
```
