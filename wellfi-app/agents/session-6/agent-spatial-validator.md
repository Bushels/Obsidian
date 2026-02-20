# Agent: Spatial Validator — Session 6

## Mission
Validate that every active well on the WellFi map falls inside an Obsidian Energy mineral rights parcel. Identify any orphaned wells (wells outside all parcels) and document findings.

## Scope
- **Creates**: `scripts/validate-wells-spatial.js` (validation script), `agents/session-6/spatial-report.md`
- **Reads**: `supabase/seed_rows.json`, `public/data/obsidian-mineral-rights.geojson`
- **Must not touch**: Any existing source files

## Tasks

### 1. Write Point-in-Polygon Validation Script
Create `scripts/validate-wells-spatial.js` that:
- Loads all well coordinates from `supabase/seed_rows.json`
- Loads all mineral rights polygons from `public/data/obsidian-mineral-rights.geojson`
- Uses ray-casting algorithm (no external deps) to check if each well point is inside any mineral rights polygon
- Handles MultiPolygon geometries correctly
- Reports:
  - Total wells checked
  - Wells INSIDE a parcel (with which parcel/agreement_id)
  - Wells OUTSIDE all parcels (orphaned — with name, coordinates, nearest parcel distance)

### 2. Run the Script and Analyze Results
- Execute the script
- If wells are outside parcels, investigate:
  - Are they near a parcel boundary? (within ~1km = possible GPS error)
  - Are they in a region with no Obsidian mineral rights at all?
  - Are they abandoned/suspended wells that should be filtered anyway?

### 3. Document Findings
Write `agents/session-6/spatial-report.md` with:
- Full results table
- Map of orphaned wells (coordinates + description)
- Recommendations (filter, adjust coordinates, expand mineral rights data)
- Lessons learned for future spatial validation

## Ray-Casting Algorithm Reference

```javascript
function pointInPolygon(point, polygon) {
  const [x, y] = point;
  let inside = false;
  for (let i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
    const [xi, yi] = polygon[i];
    const [xj, yj] = polygon[j];
    if ((yi > y) !== (yj > y) && x < ((xj - xi) * (y - yi)) / (yj - yi) + xi) {
      inside = !inside;
    }
  }
  return inside;
}
```

For MultiPolygon: check each polygon (first ring = exterior, remaining rings = holes).

## Completion Criteria
- Script runs without errors
- Spatial report written with full results
- All orphaned wells identified and classified
