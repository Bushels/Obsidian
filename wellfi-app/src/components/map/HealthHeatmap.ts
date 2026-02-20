/**
 * HealthHeatmap — Ambient health-based heatmap glow
 *
 * Visualizes pump life health intensity using a Mapbox GL 'heatmap' layer.
 * Weight is driven by `months_running` (longer = hotter) instead of production rate.
 * Color ramp uses monochromatic green shades: light green -> deep green.
 * Larger radius (30-60px) for atmospheric blending beneath parcel layers.
 *
 * Replaces ProductionHeatmap.ts for the Session 7 parcel health visualization.
 */
import type { Map as MapboxMap } from 'mapbox-gl';

// ─── Constants ─────────────────────────────────────────────────────────────

const SOURCE_ID = 'wells-source'; // Must match WellMap.tsx source ID
const LAYER_HEATMAP = 'health-heatmap';

// ─── Public API ────────────────────────────────────────────────────────────

/**
 * Add the health heatmap layer.
 * Assumes 'wells-source' already exists in the map.
 * Insert BEFORE mineral rights layers so it renders underneath parcels.
 */
export function addHealthHeatmap(map: MapboxMap): void {
  // If layer already exists, just ensure visibility
  if (map.getLayer(LAYER_HEATMAP)) {
    map.setLayoutProperty(LAYER_HEATMAP, 'visibility', 'visible');
    return;
  }

  // Determine the best "before" layer for z-ordering
  // Insert before mineral rights glow so heatmap sits beneath parcels
  const beforeLayer =
    map.getLayer('mineral-rights-glow') ? 'mineral-rights-glow' :
    map.getLayer('wells-wellfi-halo') ? 'wells-wellfi-halo' :
    undefined;

  map.addLayer(
    {
      id: LAYER_HEATMAP,
      type: 'heatmap',
      source: SOURCE_ID,
      maxzoom: 15,
      paint: {
        // Weight based on months_running — longer pump life = higher weight
        'heatmap-weight': [
          'interpolate',
          ['linear'],
          ['get', 'months_running'],
          0, 0.1,     // new pumps barely register
          9, 0.3,     // green threshold
          14, 0.6,    // orange threshold
          17, 0.85,   // red threshold
          24, 1.0,    // max weight
        ] as unknown as number,
        // Intensity multiplier by zoom level
        'heatmap-intensity': [
          'interpolate', ['linear'], ['zoom'],
          0, 1,
          9, 3,
        ] as unknown as number,
        // Health color ramp: monochromatic green (light → dark)
        'heatmap-color': [
          'interpolate',
          ['linear'],
          ['heatmap-density'],
          0,    'rgba(74, 222, 128, 0)',
          0.15, 'rgba(74, 222, 128, 0.20)',
          0.35, 'rgba(34, 197, 94, 0.30)',
          0.55, 'rgba(22, 163, 74, 0.40)',
          0.75, 'rgba(21, 128, 61, 0.55)',
          1.0,  'rgba(20, 83, 45, 0.70)',
        ] as unknown as string,
        // Larger radius for atmospheric blending (30-60px range)
        'heatmap-radius': [
          'interpolate', ['linear'], ['zoom'],
          0, 4,
          9, 40,
          13, 60,
        ] as unknown as number,
        // Subtler peak opacity so parcels remain legible on top
        'heatmap-opacity': [
          'interpolate', ['linear'], ['zoom'],
          7, 0.7,
          15, 0,
        ] as unknown as number,
      },
    },
    beforeLayer,
  );
}

/**
 * Remove the health heatmap layer.
 */
export function removeHealthHeatmap(map: MapboxMap): void {
  if (map.getLayer(LAYER_HEATMAP)) {
    map.removeLayer(LAYER_HEATMAP);
  }
}

/**
 * Toggle visibility of the health heatmap layer.
 */
export function setHealthHeatmapVisibility(
  map: MapboxMap,
  visible: boolean,
): void {
  if (map.getLayer(LAYER_HEATMAP)) {
    map.setLayoutProperty(
      LAYER_HEATMAP,
      'visibility',
      visible ? 'visible' : 'none',
    );
    // Fade opacity for smoother transition
    map.setPaintProperty(
      LAYER_HEATMAP,
      'heatmap-opacity',
      visible
        ? (['interpolate', ['linear'], ['zoom'], 7, 0.7, 15, 0] as unknown as number)
        : 0,
    );
  }
}
