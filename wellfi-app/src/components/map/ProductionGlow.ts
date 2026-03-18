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

  // Guard: map may have been destroyed while fetch was in-flight
  try { map.getStyle(); } catch { return; }
  if (map.getSource(SOURCE_ID)) return; // re-check after async gap

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
      filter: ['!=', ['get', 'op_status'], 'well_down'],
      paint: {
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
        'circle-opacity': [
          'interpolate', ['linear'], ['zoom'],
          11, 0,
          13, 0.9,
        ] as unknown as number,
        'circle-stroke-color': [
          'case',
          ['==', ['get', 'op_status'], 'watch'], WATCH_STROKE,
          ['==', ['get', 'op_status'], 'warning'], WARNING_STROKE,
          'rgba(0, 0, 0, 0)',
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
