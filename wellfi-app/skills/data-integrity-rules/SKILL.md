---
name: data-integrity-rules
description: WellFi-specific data integrity rules and gotchas. Use this skill when working with well data, Supabase queries, GeoJSON processing, production normalization, CSV parsing, or spatial validation. Also use when debugging data mismatches, unexpected NaN values, missing wells, or incorrect map rendering.
---

# WellFi Data Integrity Rules

Reference guide for common data pitfalls in the WellFi codebase. Check these rules before shipping any data-related change.

## Rule 1: Zero-Production Filter
Oil wells with `recent_oil <= 0` and gas wells with `recent_gas <= 0` are excluded from the production GeoJSON at build time. If well counts don't match expectations, check this filter first.
- Build script: `scripts/build-production-geojson.js`
- Current counts: 5,501 oil + 1,431 gas = 6,932 total

## Rule 2: Independent Normalization Per Formation Per Fluid Type
Each of the 4 heatmap layers has its own `SQRT_MAX` normalization constant derived from actual data:
- CW Oil: sqrt(5000) = 70.7
- BS Oil: sqrt(1500) = 38.7
- CW Gas: sqrt(331) = 18.2
- BS Gas: sqrt(6948) = 83.4

**If the CSV data changes, re-derive these constants.** Run:
```bash
node -e "const d=JSON.parse(require('fs').readFileSync('wellfi-app/public/data/bluesky-clearwater-production.geojson','utf8'));['Clearwater','Bluesky'].forEach(f=>['oil','gas'].forEach(t=>{const w=d.features.filter(x=>x.properties.formation===f&&x.properties.fluid_type===t);const field=t==='oil'?'recent_oil':'recent_gas';const max=Math.max(...w.map(x=>x.properties[field]));console.log(f,t,': count='+w.length+', max='+max+', sqrt='+Math.sqrt(max).toFixed(1))}))"
```

## Rule 3: CSV Line Endings
Always split CSV on `/\r?\n/` (not just `\n`). Windows-origin CSVs from StackDX have CRLF line endings. A bare `\n` split leaves `\r` on the last field, corrupting values.

## Rule 4: CSV Quoted Fields
Operator names and formation names can contain commas inside quotes (e.g., `"Bluesky, Gething, Cadomin"`). The custom `parseCSVLine()` handles this but does NOT handle escaped quotes (`""`). If you encounter `""` in CSV data, switch to `csv-parse` library.

## Rule 5: Formation Canonicalization
CSV `producing_formation` values vary: "Clearwater", "Clearwater A", "Clearwater B", etc. The build script uses `.includes('Clearwater')` and `.includes('Bluesky')` to catch all variants. Do NOT use strict equality.

## Rule 6: Frozen Supabase Types
`src/types.ts` and `src/lib/supabase.ts` are FROZEN. When querying tables not in the generated types:
```typescript
supabase.from('table_name' as never).select('*')
```

## Rule 7: Spatial Validation
28% of Obsidian wells (59 of 210) fall outside mineral rights polygons. This is expected — the GeoJSON is incomplete for townships T084R19W5, T083R18/17/16W5, T078-T080. Do NOT treat "outside parcel" as an error.

## Rule 8: op_status Default
All production GeoJSON wells have `op_status: 'normal'` hardcoded. This field is NOT yet wired to the Supabase `operational_statuses` table. Do not assume op_status reflects real operational state for production glow wells.

## Rule 9: Mapbox Expression Type Casts
Mapbox GL JS expressions don't match TypeScript types. Always cast:
```typescript
'heatmap-weight': [...expression...] as unknown as number,
'heatmap-color': [...expression...] as unknown as string,
```

## Rule 10: HTML Escaping in Popups
All string fields interpolated into popup HTML MUST be escaped with `escapeHTML()` (in `ProductionPopup.ts`). Operator names contain `&` characters. Never use raw string interpolation for user-facing HTML.

## Rule 11: Abandoned Well Filter
The Supabase `useWells` hook filters out abandoned wells at query level (`well_status != 'Abandoned'`). Current count: 211 total seed → 210 active. If a well count is off by 1, check this filter.

## Rule 12: GeoJSON Coordinate Depth
- `Polygon.coordinates` = `Position[][]` (2 levels)
- `MultiPolygon.coordinates` = `Position[][][]` (3 levels, NOT 4)
This has caused 14+ TypeScript errors in the past. Always verify depth.

## Rule 13: Fluid Type Property
The GeoJSON `fluid_type` property is `'oil'` or `'gas'` (lowercase). The `well_fluid_type` property is the raw CSV value (`'Crude Oil'`, `'Crude Bitumen'`, `'Gas'`). Use `fluid_type` for layer filters, `well_fluid_type` for display.

## Rule 14: Heatmap Layer Ordering
Gas heatmaps MUST render below oil heatmaps. In `ProductionGlow.ts`, gas layers are added BEFORE oil layers. With Mapbox `addLayer(layer, beforeId)`, sequential calls with the same `beforeId` stack in insertion order (first added = lowest).

## Rule 15: Toggle Scope
CW/BS toggle buttons control BOTH oil AND gas layers for that formation. The `setFormationHeatmapVisibility()` function toggles 2 layers per call. If adding new layer types per formation, update this function.
