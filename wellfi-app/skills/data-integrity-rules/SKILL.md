---
name: data-integrity-rules
description: WellFi-specific data integrity rules and gotchas. Use this skill when working with well data, Supabase queries, GeoJSON processing, production normalization, CSV parsing, or spatial validation. Also use when debugging data mismatches, unexpected NaN values, missing wells, or incorrect map rendering.
---

# WellFi Data Integrity Rules

Reference guide for common data pitfalls in the WellFi codebase. Check these rules before shipping any data-related change.

## Rule 1: Zero-Production Filter
The monthly production snapshot is not a destructive full-replacement well-master source.

- `scripts/build_operator_geojson.ts` excludes rows only when both `recent_oil` and `recent_gas` are `0`.
- `scripts/refresh_monthly_production.ts` rebuilds overlay output only. It does not delete wells from Supabase.
- `scripts/sync_monthly_production.ts` can insert missing active wells and safely sync a limited set of well fields into Supabase, but it still does not delete wells missing from the latest snapshot.
- Missing-from-snapshot wells should lose the cloud after overlay rebuild, not disappear from the base well map.
- If counts look low, check the zero-production filter before assuming tenant leakage or map bugs.

## Rule 2: Independent Normalization Per Formation Per Fluid Type
Each of the 4 heatmap layers has its own `SQRT_MAX` normalization constant derived from actual data:
- CW Oil: sqrt(5000) = 70.7
- BS Oil: sqrt(1500) = 38.7
- CW Gas: sqrt(331) = 18.2
- BS Gas: sqrt(6948) = 83.4

**If the CSV data changes, re-derive these constants.** Run:
```bash
node -e "const d=JSON.parse(require('fs').readFileSync('wellfi-app/public/data/operators/_all/production.geojson','utf8'));['Clearwater','Bluesky'].forEach(f=>['oil','gas'].forEach(t=>{const w=d.features.filter(x=>x.properties.formation===f&&x.properties.fluid_type===t);const field=t==='oil'?'recent_oil':'recent_gas';const max=Math.max(...w.map(x=>x.properties[field]));console.log(f,t,': count='+w.length+', max='+max+', sqrt='+Math.sqrt(max).toFixed(1))}))"
```

## Rule 3: Prefer XLSX Parsing For Monthly Snapshots
Use `xlsx` for the monthly basin snapshot. Do not hand-roll CSV parsing for this workflow unless the source format changes and you intentionally replace the parser.

## Rule 4: Validate Required Snapshot Columns
Before rebuilding overlays, validate the snapshot includes:

- `uwi`
- `operator_licensee`
- `producing_formation`
- `well_fluid_type`
- `surface_latitude`
- `surface_longitude`
- `recent_oil`
- `recent_gas`

Use `scripts/refresh_monthly_production.ts` for the standard validation path.

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
All string fields interpolated into popup HTML MUST be escaped with `escapeHtml()` in the popup helper that renders them, for example `src/components/map/WellPopup.tsx`. Operator names contain `&` characters. Never use raw string interpolation for user-facing HTML.

## Rule 11: Abandoned Well Filter
The Supabase `useWells` hook filters out abandoned wells at query level (`well_status != 'Abandoned'`). Current count: 211 total seed → 210 active. If a well count is off by 1, check this filter.

## Rule 12: GeoJSON Coordinate Depth
- `Polygon.coordinates` = `Position[][]` (2 levels)
- `MultiPolygon.coordinates` = `Position[][][]` (3 levels, NOT 4)
This has caused 14+ TypeScript errors in the past. Always verify depth.

## Rule 13: Fluid Type Property
The GeoJSON `fluid_type` property is `'oil'` or `'gas'` (lowercase). The `well_fluid_type` property is the raw CSV value (`'Crude Oil'`, `'Crude Bitumen'`, `'Gas'`). Use `fluid_type` for layer filters, `well_fluid_type` for display.

## Rule 14: Overlay Layer Ordering
Gas heatmaps MUST render below oil heatmaps. Live base-well dots from `WellMap.tsx` must sit above the heatmap layers but below the close-range production handoff dots. Close-range production dot glow MUST render below production dots, and monitored alert layers must remain above all of them.

## Rule 15: Toggle Scope
CW/BS toggle buttons control BOTH oil AND gas layers for that formation across BOTH handoff states. The `setFormationHeatmapVisibility()` function must toggle the heatmap layer, gas heatmap layer, production dot glow, and production dots for that formation together.

## Rule 16: Handoff Color Match
Close-range production dots MUST use the same formation/fluid palette as the production heatmap:
- Clearwater oil -> green
- Clearwater gas -> light green
- Bluesky oil -> amber
- Bluesky gas -> yellow

This is intentional so users can visually track a production area from basin-scale heatmap into well-scale dots without re-learning the legend at close zoom.
