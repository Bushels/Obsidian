#!/usr/bin/env npx tsx
/**
 * generate-synthetic-parcels.ts — Session 7, Agent: Data Engine
 *
 * Reads mineral rights GeoJSON and well seed data, runs point-in-polygon
 * to identify orphan wells, generates synthetic square parcels for each,
 * and writes the result to public/data/synthetic-parcels.geojson.
 *
 * Run:  npx tsx scripts/generate-synthetic-parcels.ts
 */

import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const repoRoot = path.resolve(__dirname, '..');

// ─── Types (minimal, just for this script) ─────────────────

interface SeedWell {
  well_id: string;
  name: string | null;
  lat: number;
  lon: number;
  well_status: string;
  formation: string | null;
}

interface GeoJSONFeature {
  type: 'Feature';
  geometry: {
    type: 'MultiPolygon';
    coordinates: number[][][][];
  };
  properties: Record<string, unknown>;
}

interface GeoJSONCollection {
  type: 'FeatureCollection';
  features: GeoJSONFeature[];
}

// ─── Geometry helpers (ported from validate-wells-spatial.js) ──

function pointInRing(point: [number, number], ring: number[][]): boolean {
  const [px, py] = point;
  let inside = false;
  for (let i = 0, j = ring.length - 1; i < ring.length; j = i++) {
    const xi = ring[i][0];
    const yi = ring[i][1];
    const xj = ring[j][0];
    const yj = ring[j][1];
    if (
      (yi > py) !== (yj > py) &&
      px < ((xj - xi) * (py - yi)) / (yj - yi) + xi
    ) {
      inside = !inside;
    }
  }
  return inside;
}

function pointInMultiPolygon(
  point: [number, number],
  multiPolygon: number[][][][],
): boolean {
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

// ─── Synthetic parcel generation ───────────────────────────

// At ~56°N: 1.6 km ≈ 0.0144° lat, 0.0288° lng
const HALF_LAT = 0.0072;
const HALF_LNG = 0.0144;

function generateSyntheticParcel(well: SeedWell) {
  const { lon: lng, lat } = well;
  const ring = [
    [lng - HALF_LNG, lat - HALF_LAT],
    [lng + HALF_LNG, lat - HALF_LAT],
    [lng + HALF_LNG, lat + HALF_LAT],
    [lng - HALF_LNG, lat + HALF_LAT],
    [lng - HALF_LNG, lat - HALF_LAT], // close ring
  ];

  return {
    type: 'Feature' as const,
    properties: {
      agreement_type: 'SYNTHETIC',
      synthetic: true,
      zone_description: 'Auto-generated',
      land_ids: '',
      well_id: well.well_id,
      well_name: well.name,
    },
    geometry: {
      type: 'Polygon' as const,
      coordinates: [ring],
    },
  };
}

// ─── Main ──────────────────────────────────────────────────

function main() {
  // Load wells (excluding Abandoned)
  const wellsPath = path.join(repoRoot, 'supabase', 'seed_rows.json');
  const allWells: SeedWell[] = JSON.parse(fs.readFileSync(wellsPath, 'utf8'));
  const wells = allWells.filter((w) => w.well_status !== 'Abandoned');
  console.log(
    `Loaded ${allWells.length} wells, ${wells.length} active (${allWells.length - wells.length} abandoned filtered)`,
  );

  // Load mineral rights parcels
  const geoPath = path.join(
    repoRoot,
    'public',
    'data',
    'obsidian-mineral-rights.geojson',
  );
  const geo: GeoJSONCollection = JSON.parse(fs.readFileSync(geoPath, 'utf8'));
  console.log(`Loaded ${geo.features.length} mineral-rights parcels`);

  // Pre-compute bounding boxes
  const parcels = geo.features.map((f) => {
    const coords = f.geometry.coordinates;
    let minLon = Infinity;
    let maxLon = -Infinity;
    let minLat = Infinity;
    let maxLat = -Infinity;
    for (const polygon of coords) {
      for (const [lon, lat] of polygon[0]) {
        if (lon < minLon) minLon = lon;
        if (lon > maxLon) maxLon = lon;
        if (lat < minLat) minLat = lat;
        if (lat > maxLat) maxLat = lat;
      }
    }
    return { coords, bbox: { minLon, maxLon, minLat, maxLat } };
  });

  // Find orphan wells
  const orphanWells: SeedWell[] = [];
  let insideCount = 0;

  const t0 = performance.now();
  for (const well of wells) {
    const pt: [number, number] = [well.lon, well.lat];
    let found = false;

    for (const parcel of parcels) {
      const bb = parcel.bbox;
      if (
        pt[0] < bb.minLon ||
        pt[0] > bb.maxLon ||
        pt[1] < bb.minLat ||
        pt[1] > bb.maxLat
      ) {
        continue;
      }
      if (pointInMultiPolygon(pt, parcel.coords)) {
        found = true;
        break;
      }
    }

    if (found) {
      insideCount++;
    } else {
      orphanWells.push(well);
    }
  }
  const elapsed = (performance.now() - t0).toFixed(1);

  console.log(`\nPoint-in-polygon completed in ${elapsed}ms`);
  console.log(`  Inside parcels:  ${insideCount}`);
  console.log(`  Orphan wells:    ${orphanWells.length}`);

  // Generate synthetic parcels
  const syntheticFeatures = orphanWells.map(generateSyntheticParcel);

  const syntheticCollection = {
    type: 'FeatureCollection' as const,
    features: syntheticFeatures,
  };

  // Write output
  const outPath = path.join(
    repoRoot,
    'public',
    'data',
    'synthetic-parcels.geojson',
  );
  fs.writeFileSync(outPath, JSON.stringify(syntheticCollection, null, 2), 'utf8');
  console.log(`\nWrote ${syntheticFeatures.length} synthetic parcels to ${outPath}`);

  // Summary
  console.log('\n=== SYNTHETIC PARCEL GENERATION COMPLETE ===');
  console.log(`  Total active wells:    ${wells.length}`);
  console.log(`  Wells in parcels:      ${insideCount}`);
  console.log(`  Orphan wells:          ${orphanWells.length}`);
  console.log(`  Synthetic parcels:     ${syntheticFeatures.length}`);
  console.log(
    `  Coverage after synth:  ${(((insideCount + orphanWells.length) / wells.length) * 100).toFixed(1)}%`,
  );
}

main();
