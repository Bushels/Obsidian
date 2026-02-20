# Agent: Data Engine — Session 7

## Mission
Build the data pipeline that assigns wells to mineral rights parcels, computes per-parcel health aggregates, and generates synthetic parcels for orphan wells.

## Scope
- **Creates**: `src/lib/parcelHealth.ts`, `scripts/generate-synthetic-parcels.ts`, `public/data/synthetic-parcels.geojson`
- **Reads**: `src/types.ts` (frozen), `scripts/validate-wells-spatial.js` (reference PIP algorithm), `public/data/obsidian-mineral-rights.geojson`, `scripts/spatial-validation-results.json`
- **Must not touch**: `src/types.ts`, `src/lib/supabase.ts`, any `src/components/` files

## Tasks

### 1. Create `src/lib/parcelHealth.ts`

This is the core runtime utility used by WellMap.tsx. It must be a TypeScript module with zero external dependencies.

**Functions to implement:**

#### `pointInPolygon(point: [number, number], polygon: number[][]): boolean`
- Ray-casting algorithm (port from `scripts/validate-wells-spatial.js`)
- `point` is `[lng, lat]`, `polygon` is array of `[lng, lat]` coordinate pairs (closed ring)

#### `pointInMultiPolygon(point: [number, number], multiPolygon: number[][][][]): boolean`
- Handles MultiPolygon geometry (first ring = exterior, remaining = holes)
- Returns true if point is inside any polygon and not inside a hole

#### `getBoundingBox(coordinates: number[][][][]): { minLng: number; minLat: number; maxLng: number; maxLat: number }`
- Compute bounding box of a MultiPolygon for fast pre-filtering

#### `assignWellsToParcels(wells: Well[], parcels: GeoJSON.FeatureCollection): { healthMap: Map<number, ParcelHealth>; orphanWells: Well[] }`
- For each well, check which parcel contains it (point-in-polygon with bbox pre-filter)
- Group wells by parcel feature ID (the auto-generated `id` from `generateId: true`)
- Compute `ParcelHealth` aggregates per parcel
- Return orphan wells (wells not inside any parcel)
- Performance target: <20ms for 210 wells × 900 parcels

#### `generateSyntheticParcels(orphanWells: Well[]): GeoJSON.FeatureCollection`
- For each orphan well, create a small square polygon (~1.6km × 1.6km ≈ 1 DLS section)
- Center the square on the well's lat/lon
- Properties: `{ agreement_type: "SYNTHETIC", synthetic: true, zone_description: "Auto-generated", land_ids: "" }`
- The synthetic parcels will be merged with real parcels at load time

#### `computeParcelCentroids(parcels: GeoJSON.FeatureCollection): GeoJSON.FeatureCollection<GeoJSON.Point>`
- For each parcel polygon, compute the centroid (average of exterior ring vertices)
- Return a FeatureCollection of Point features with the parcel's feature ID preserved
- Used by the symbol label layer

**ParcelHealth interface:**
```typescript
export interface ParcelHealth {
  wellCount: number;
  wellFiCount: number;
  avgMonthsRunning: number;
  maxMonthsRunning: number;
  hasUpcomingChange: boolean;
  wells: ParcelWellSummary[];
}

export interface ParcelWellSummary {
  id: string;
  name: string | null;
  wellId: string;
  monthsRunning: number;
  hasWellfi: boolean;
  riskLevel: string | null;
  formation: string | null;
}
```

### 2. Create `scripts/generate-synthetic-parcels.ts`

Node.js ESM script that:
1. Reads `public/data/obsidian-mineral-rights.geojson`
2. Reads `supabase/seed_rows.json` (well positions)
3. Runs point-in-polygon to find orphan wells
4. Generates synthetic square parcels for each orphan
5. Writes result to `public/data/synthetic-parcels.geojson`

Run with: `npx tsx scripts/generate-synthetic-parcels.ts`

### 3. Run the script and generate `public/data/synthetic-parcels.geojson`

Execute the script and verify:
- 59 synthetic parcels generated (matching Session 6 spatial validation)
- Each is a valid GeoJSON Polygon centered on the orphan well

## Completion Criteria
- `src/lib/parcelHealth.ts` exports all functions and types listed above
- `npx tsc --noEmit` passes with zero errors
- `public/data/synthetic-parcels.geojson` exists with ~59 features
- No frozen files modified
