#!/usr/bin/env node
/**
 * Spatial Validator — WellFi Session 6
 *
 * Validates that every well in seed_rows.json falls inside at least one
 * Obsidian Energy mineral-rights parcel from obsidian-mineral-rights.geojson.
 *
 * Uses a pure-JS ray-casting point-in-polygon algorithm (no dependencies).
 *
 * Run:  node scripts/validate-wells-spatial.js
 * (Project uses "type": "module" in package.json so this is ESM.)
 */

import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// ──────────────────────── Geometry helpers ────────────────────────

/** Ray-casting test: is `point` [lon, lat] inside a single ring? */
function pointInRing(point, ring) {
  const [px, py] = point;
  let inside = false;
  for (let i = 0, j = ring.length - 1; i < ring.length; j = i++) {
    const [xi, yi] = ring[i];
    const [xj, yj] = ring[j];
    if (
      (yi > py) !== (yj > py) &&
      px < ((xj - xi) * (py - yi)) / (yj - yi) + xi
    ) {
      inside = !inside;
    }
  }
  return inside;
}

/**
 * Is `point` inside a MultiPolygon?
 *
 * MultiPolygon coordinates: [polygon][ring][point]
 *   - polygon[0] = exterior ring
 *   - polygon[1..n] = holes
 *
 * A point is inside the MultiPolygon if it falls inside any exterior ring
 * AND is not inside any of that polygon's holes.
 */
function pointInMultiPolygon(point, multiPolygon) {
  for (const polygon of multiPolygon) {
    const exterior = polygon[0];
    if (pointInRing(point, exterior)) {
      let inHole = false;
      for (let h = 1; h < polygon.length; h++) {
        if (pointInRing(point, polygon[h])) {
          inHole = true;
          break;
        }
      }
      if (!inHole) return true;
    }
  }
  return false;
}

/** Euclidean distance in degrees (approximate, fine for nearest-neighbor ranking). */
function degreeDist(lon1, lat1, lon2, lat2) {
  return Math.sqrt((lon1 - lon2) ** 2 + (lat1 - lat2) ** 2);
}

/**
 * Haversine distance in kilometres between two (lon, lat) points.
 * Used for the orphan-well nearest-parcel report.
 */
function haversineKm(lon1, lat1, lon2, lat2) {
  const R = 6371;
  const toRad = (d) => (d * Math.PI) / 180;
  const dLat = toRad(lat2 - lat1);
  const dLon = toRad(lon2 - lon1);
  const a =
    Math.sin(dLat / 2) ** 2 +
    Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) * Math.sin(dLon / 2) ** 2;
  return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
}

// ──────────────────────── Pre-compute parcel centroids ────────────────────────

function computeCentroid(multiPolygon) {
  let sumLon = 0;
  let sumLat = 0;
  let count = 0;
  for (const polygon of multiPolygon) {
    // Use only exterior ring for centroid
    for (const [lon, lat] of polygon[0]) {
      sumLon += lon;
      sumLat += lat;
      count++;
    }
  }
  return [sumLon / count, sumLat / count];
}

// ──────────────────────── Main ────────────────────────

function main() {
  const repoRoot = path.resolve(__dirname, "..");

  // Load wells
  const wellsPath = path.join(repoRoot, "supabase", "seed_rows.json");
  const wells = JSON.parse(fs.readFileSync(wellsPath, "utf8"));
  console.log(`Loaded ${wells.length} wells from seed_rows.json\n`);

  // Load mineral rights
  const geoPath = path.join(
    repoRoot,
    "public",
    "data",
    "obsidian-mineral-rights.geojson"
  );
  const geo = JSON.parse(fs.readFileSync(geoPath, "utf8"));
  const features = geo.features;
  console.log(`Loaded ${features.length} mineral-rights parcels\n`);

  // Pre-compute bounding boxes + centroids for each feature (speed optimisation)
  const parcels = features.map((f) => {
    const coords = f.geometry.coordinates;
    let minLon = Infinity,
      maxLon = -Infinity,
      minLat = Infinity,
      maxLat = -Infinity;
    for (const polygon of coords) {
      for (const [lon, lat] of polygon[0]) {
        if (lon < minLon) minLon = lon;
        if (lon > maxLon) maxLon = lon;
        if (lat < minLat) minLat = lat;
        if (lat > maxLat) maxLat = lat;
      }
    }
    const centroid = computeCentroid(coords);
    return {
      coords,
      bbox: { minLon, maxLon, minLat, maxLat },
      centroid,
      agreementId: f.properties.agreement_id,
      agreementType: f.properties.agreement_type,
      zoneDescription: f.properties.zone_description,
      landIds: f.properties.land_ids,
      status: f.properties.status,
      designatedRep: f.properties.designated_rep,
    };
  });

  // ── Validate each well ──

  const insideWells = [];
  const outsideWells = [];

  for (const well of wells) {
    const pt = [well.lon, well.lat];
    let matched = null;

    for (const parcel of parcels) {
      // Quick bbox reject
      const bb = parcel.bbox;
      if (
        pt[0] < bb.minLon ||
        pt[0] > bb.maxLon ||
        pt[1] < bb.minLat ||
        pt[1] > bb.maxLat
      ) {
        continue;
      }
      // Full point-in-polygon test
      if (pointInMultiPolygon(pt, parcel.coords)) {
        matched = parcel;
        break;
      }
    }

    if (matched) {
      insideWells.push({
        well_id: well.well_id,
        name: well.name,
        lat: well.lat,
        lon: well.lon,
        well_status: well.well_status,
        agreement_id: matched.agreementId,
        agreement_type: matched.agreementType,
        zone_description: matched.zoneDescription,
        land_ids: matched.landIds,
      });
    } else {
      // Find nearest parcel centroid
      let bestDist = Infinity;
      let nearest = null;
      for (const parcel of parcels) {
        const d = degreeDist(
          pt[0],
          pt[1],
          parcel.centroid[0],
          parcel.centroid[1]
        );
        if (d < bestDist) {
          bestDist = d;
          nearest = parcel;
        }
      }
      const distKm = nearest
        ? haversineKm(
            pt[0],
            pt[1],
            nearest.centroid[0],
            nearest.centroid[1]
          )
        : null;

      outsideWells.push({
        well_id: well.well_id,
        name: well.name,
        lat: well.lat,
        lon: well.lon,
        well_status: well.well_status,
        nearest_agreement_id: nearest ? nearest.agreementId : null,
        nearest_land_ids: nearest ? nearest.landIds : null,
        nearest_distance_km: distKm !== null ? Math.round(distKm * 100) / 100 : null,
      });
    }
  }

  // ──────────────────────── Report ────────────────────────

  console.log("=======================================================");
  console.log("  SPATIAL VALIDATION REPORT");
  console.log("=======================================================\n");

  console.log(`Total wells checked:   ${wells.length}`);
  console.log(`Wells INSIDE parcels:  ${insideWells.length}`);
  console.log(`Wells OUTSIDE parcels: ${outsideWells.length}`);
  console.log(
    `Coverage:              ${((insideWells.length / wells.length) * 100).toFixed(1)}%\n`
  );

  // Inside wells summary
  if (insideWells.length > 0) {
    console.log("-------------------------------------------------------");
    console.log("  WELLS INSIDE PARCELS");
    console.log("-------------------------------------------------------\n");
    for (const w of insideWells) {
      console.log(
        `  [OK]  ${w.well_id}  ${w.name}`
      );
      console.log(
        `        Agreement: ${w.agreement_id}  |  Zone: ${w.zone_description}`
      );
      console.log(
        `        Land IDs: ${w.land_ids}`
      );
      console.log();
    }
  }

  // Outside wells detail
  if (outsideWells.length > 0) {
    console.log("-------------------------------------------------------");
    console.log("  ORPHANED WELLS (OUTSIDE ALL PARCELS)");
    console.log("-------------------------------------------------------\n");
    for (const w of outsideWells) {
      console.log(
        `  [!!]  ${w.well_id}  ${w.name}`
      );
      console.log(
        `        Lat: ${w.lat}  Lon: ${w.lon}  Status: ${w.well_status}`
      );
      console.log(
        `        Nearest parcel: ${w.nearest_agreement_id} (${w.nearest_land_ids})  ~${w.nearest_distance_km} km away`
      );
      console.log();
    }
  }

  console.log("=======================================================");
  console.log("  VALIDATION COMPLETE");
  console.log("=======================================================\n");

  // ── Write JSON results for downstream consumption ──
  const resultsPath = path.join(__dirname, "spatial-validation-results.json");
  fs.writeFileSync(
    resultsPath,
    JSON.stringify({ insideWells, outsideWells }, null, 2),
    "utf8"
  );
  console.log(`Full results written to ${resultsPath}\n`);
}

main();
