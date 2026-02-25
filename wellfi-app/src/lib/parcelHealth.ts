// ============================================================
// parcelHealth.ts — Session 7, Agent: Data Engine
//
// Runtime utility for assigning wells to mineral rights parcels,
// computing per-parcel health aggregates, and generating
// synthetic parcels for orphan wells.
//
// Zero external dependencies. Pure TypeScript geometry + aggregation.
// ============================================================

import type { Well } from '@/types';
import type {
  Feature,
  FeatureCollection,
  MultiPolygon,
  Point,
  Polygon,
  Position,
} from 'geojson';

// ─── Exported interfaces ───────────────────────────────────

export interface ParcelWellSummary {
  id: string;
  name: string | null;
  wellId: string;
  monthsRunning: number;
  hasWellfi: boolean;
  riskLevel: string | null;
  formation: string | null;
  wellStatus: string | null;
}

export interface ParcelHealth {
  wellCount: number;
  wellFiCount: number;
  avgMonthsRunning: number;
  maxMonthsRunning: number;
  hasUpcomingChange: boolean;
  pumpingRatio: number; // 0-1: fraction of wells actively pumping (field health indicator)
  wells: ParcelWellSummary[];
}

// ─── Geometry helpers ──────────────────────────────────────

/**
 * Ray-casting point-in-polygon test.
 * @param point  [lng, lat]
 * @param ring   Array of [lng, lat] forming a closed ring
 */
export function pointInPolygon(
  point: [number, number],
  ring: Position[],
): boolean {
  const [px, py] = point;
  let inside = false;
  for (let i = 0, j = ring.length - 1; i < ring.length; j = i++) {
    const xi = ring[i][0];
    const yi = ring[i][1];
    const xj = ring[j][0];
    const yj = ring[j][1];
    if (
      yi > py !== yj > py &&
      px < ((xj - xi) * (py - yi)) / (yj - yi) + xi
    ) {
      inside = !inside;
    }
  }
  return inside;
}

/**
 * Test if a point lies inside a MultiPolygon geometry.
 *
 * MultiPolygon coordinates: [polygon][ring][point]
 *   polygon[0] = exterior ring, polygon[1..n] = holes
 *
 * Returns true if the point is inside any exterior ring
 * and NOT inside any of that polygon's holes.
 */
export function pointInMultiPolygon(
  point: [number, number],
  multiPolygon: Position[][][],
): boolean {
  for (const polygon of multiPolygon) {
    const exterior = polygon[0];
    if (pointInPolygon(point, exterior)) {
      let inHole = false;
      for (let h = 1; h < polygon.length; h++) {
        if (pointInPolygon(point, polygon[h])) {
          inHole = true;
          break;
        }
      }
      if (!inHole) return true;
    }
  }
  return false;
}

/**
 * Compute the axis-aligned bounding box of a MultiPolygon.
 * Used for fast pre-filtering before the full PIP test.
 */
export function getBoundingBox(coordinates: Position[][][]): {
  minLng: number;
  minLat: number;
  maxLng: number;
  maxLat: number;
} {
  let minLng = Infinity;
  let maxLng = -Infinity;
  let minLat = Infinity;
  let maxLat = -Infinity;

  for (const polygon of coordinates) {
    // Only need exterior ring for bounding box
    for (const coord of polygon[0]) {
      const lng = coord[0];
      const lat = coord[1];
      if (lng < minLng) minLng = lng;
      if (lng > maxLng) maxLng = lng;
      if (lat < minLat) minLat = lat;
      if (lat > maxLat) maxLat = lat;
    }
  }

  return { minLng, minLat, maxLng, maxLat };
}

// ─── Internal: pre-computed parcel metadata for fast PIP ───

interface ParcelMeta {
  featureIndex: number;
  coords: Position[][][];
  bbox: { minLng: number; minLat: number; maxLng: number; maxLat: number };
}

function buildParcelMeta(parcels: FeatureCollection): ParcelMeta[] {
  return parcels.features.map((f, idx) => {
    const geom = f.geometry as MultiPolygon;
    const coords = geom.coordinates;
    return {
      featureIndex: idx,
      coords,
      bbox: getBoundingBox(coords),
    };
  });
}

// ─── Core: assign wells to parcels & compute health ────────

/**
 * Assign each well to the mineral rights parcel that contains it.
 * Returns a health map keyed by feature index (matches Mapbox generateId)
 * and a list of orphan wells (not inside any parcel).
 *
 * Performance: uses bounding-box pre-filter for O(N*M) with early exit.
 * Target: <20ms for 210 wells x 900 parcels.
 */
export function assignWellsToParcels(
  wells: Well[],
  parcels: FeatureCollection,
): { healthMap: Map<number, ParcelHealth>; orphanWells: Well[] } {
  const meta = buildParcelMeta(parcels);
  const healthMap = new Map<number, ParcelHealth>();
  const orphanWells: Well[] = [];

  for (const well of wells) {
    const pt: [number, number] = [well.lon, well.lat];
    let matchedIndex = -1;

    for (const parcel of meta) {
      // Quick bbox reject
      if (
        pt[0] < parcel.bbox.minLng ||
        pt[0] > parcel.bbox.maxLng ||
        pt[1] < parcel.bbox.minLat ||
        pt[1] > parcel.bbox.maxLat
      ) {
        continue;
      }
      // Full PIP test
      if (pointInMultiPolygon(pt, parcel.coords)) {
        matchedIndex = parcel.featureIndex;
        break;
      }
    }

    if (matchedIndex === -1) {
      orphanWells.push(well);
      continue;
    }

    // Build well summary
    const summary: ParcelWellSummary = {
      id: well.id,
      name: well.name,
      wellId: well.well_id,
      monthsRunning: well.months_running ?? 0,
      hasWellfi: well.wellfi_device != null && well.wellfi_device.is_active,
      riskLevel: well.risk_level,
      formation: well.formation,
      wellStatus: well.well_status,
    };

    const existing = healthMap.get(matchedIndex);
    if (existing) {
      existing.wells.push(summary);
    } else {
      healthMap.set(matchedIndex, {
        wellCount: 0,
        wellFiCount: 0,
        avgMonthsRunning: 0,
        maxMonthsRunning: 0,
        hasUpcomingChange: false,
        pumpingRatio: 0,
        wells: [summary],
      });
    }
  }

  // Compute aggregates for each parcel
  for (const [, health] of healthMap) {
    const { wells: parcelWells } = health;
    health.wellCount = parcelWells.length;
    health.wellFiCount = parcelWells.filter((w) => w.hasWellfi).length;

    const monthValues = parcelWells.map((w) => w.monthsRunning);
    const totalMonths = monthValues.reduce((a, b) => a + b, 0);
    health.avgMonthsRunning =
      parcelWells.length > 0
        ? Math.round(totalMonths / parcelWells.length)
        : 0;
    health.maxMonthsRunning = Math.max(...monthValues);

    health.hasUpcomingChange = parcelWells.some((w) => {
      // Check the original well for active_pump_change
      const originalWell = wells.find((ow) => ow.id === w.id);
      return originalWell?.active_pump_change != null;
    });

    // Pumping ratio: fraction of wells actively pumping (field health indicator)
    const pumpingCount = parcelWells.filter(
      (w) => w.wellStatus === 'Pumping' || w.wellStatus === 'Operating',
    ).length;
    health.pumpingRatio =
      parcelWells.length > 0 ? pumpingCount / parcelWells.length : 0;
  }

  return { healthMap, orphanWells };
}

// ─── Synthetic parcel generation ───────────────────────────

/**
 * At ~56°N latitude (Alberta Clearwater/Bluesky region):
 *   1° lat ≈ 111 km → 1.6 km ≈ 0.0144°
 *   1° lng ≈ 62 km  → 1.6 km ≈ 0.0258° (cos(56°) ≈ 0.559)
 *
 * We use a slightly wider longitude to make a visually square parcel.
 */
const HALF_LAT = 0.0072; // half of 0.0144°
const HALF_LNG = 0.0144; // half of 0.0288°

/**
 * Generate small square polygons for orphan wells so they can still
 * be visualised as parcel overlays on the map.
 */
export function generateSyntheticParcels(
  orphanWells: Well[],
): FeatureCollection<Polygon> {
  const features: Feature<Polygon>[] = orphanWells.map((well) => {
    const lng = well.lon;
    const lat = well.lat;

    // Clockwise ring (GeoJSON spec: exterior ring = counterclockwise, but
    // Mapbox GL accepts either direction and normalises internally).
    // We follow right-hand rule (counterclockwise exterior).
    const ring: Position[] = [
      [lng - HALF_LNG, lat - HALF_LAT],
      [lng + HALF_LNG, lat - HALF_LAT],
      [lng + HALF_LNG, lat + HALF_LAT],
      [lng - HALF_LNG, lat + HALF_LAT],
      [lng - HALF_LNG, lat - HALF_LAT], // close the ring
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
  });

  return {
    type: 'FeatureCollection' as const,
    features,
  };
}

// ─── Centroid computation ──────────────────────────────────

/**
 * Compute centroids for each parcel (average of exterior ring vertices).
 * Returns a FeatureCollection of Points for map label placement.
 * The feature index is preserved as `featureIndex` in properties.
 */
export function computeParcelCentroids(
  parcels: FeatureCollection,
): FeatureCollection<Point> {
  const features: Feature<Point>[] = parcels.features.map((f, idx) => {
    const geom = f.geometry as MultiPolygon;
    let sumLng = 0;
    let sumLat = 0;
    let count = 0;

    for (const polygon of geom.coordinates) {
      // Use only exterior ring for centroid
      for (const coord of polygon[0]) {
        sumLng += coord[0];
        sumLat += coord[1];
        count++;
      }
    }

    const centroidLng = count > 0 ? sumLng / count : 0;
    const centroidLat = count > 0 ? sumLat / count : 0;

    return {
      type: 'Feature' as const,
      properties: {
        featureIndex: idx,
        ...f.properties,
      },
      geometry: {
        type: 'Point' as const,
        coordinates: [centroidLng, centroidLat],
      },
    };
  });

  return {
    type: 'FeatureCollection' as const,
    features,
  };
}
