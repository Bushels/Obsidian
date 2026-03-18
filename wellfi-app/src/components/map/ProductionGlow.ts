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

const LAYER_CW_HEATMAP = 'clearwater-production-heatmap';
const LAYER_BS_HEATMAP = 'bluesky-production-heatmap';
const LAYER_DOTS = 'production-well-dots';
const LAYER_CW_GAS_HEATMAP = 'clearwater-gas-heatmap';
const LAYER_BS_GAS_HEATMAP = 'bluesky-gas-heatmap';

// Normalization: sqrt(max_production) per formation
const CW_SQRT_MAX = 70.7;  // sqrt(5000)
const BS_SQRT_MAX = 38.7;  // sqrt(1500)
const CW_GAS_SQRT_MAX = 18.2;  // sqrt(331)
const BS_GAS_SQRT_MAX = 83.4;  // sqrt(6948)

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
  0,    'rgba(253, 224, 71, 0)',         // transparent
  0.15, 'rgba(253, 224, 71, 0.15)',      // faint gold
  0.35, 'rgba(250, 204, 21, 0.25)',      // gold
  0.55, 'rgba(234, 179, 8, 0.40)',       // deep gold
  0.75, 'rgba(202, 138, 4, 0.55)',       // dark gold
  1.0,  'rgba(161, 98, 7, 0.70)',        // rich amber
];

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

// ─── Dot Colors ────────────────────────────────────────────────────────────

const CW_DOT_COLOR = '#22C55E';  // green-500
const BS_DOT_COLOR = '#F59E0B';  // amber-500
const WATCH_STROKE = '#3B82F6';  // blue-500
const WARNING_STROKE = '#EF4444'; // red-500
const CW_GAS_DOT_COLOR = '#86EFAC';  // green-300
const BS_GAS_DOT_COLOR = '#FCD34D';  // amber-300

// ─── Public API ────────────────────────────────────────────────────────────

/**
 * Fetch production GeoJSON and add all three layers.
 * Call after map 'load' event, after base layers are set up.
 */
export async function addProductionGlow(
  map: MapboxMap,
  operatorSlug: string | null,
  isAdmin: boolean,
  beforeLayerId?: string,
  signal?: AbortSignal,
): Promise<void> {
  // Skip if source already exists (idempotent)
  if (map.getSource(SOURCE_ID)) return;

  // Derive operator-scoped GeoJSON URL
  const geojsonUrl = isAdmin || !operatorSlug
    ? '/data/operators/_all/production.geojson'
    : `/data/operators/${operatorSlug}/production.geojson`;

  // Fetch pre-processed GeoJSON (abortable for rapid operator switching)
  const response = await fetch(geojsonUrl, { signal });
  if (!response.ok) {
    console.warn(`ProductionGlow: failed to load ${geojsonUrl} (${response.status})`);
    return;
  }
  const geojson = await response.json();

  // Bail if this request was superseded by a newer operator switch
  if (signal?.aborted) return;

  // Guard: map may have been destroyed while fetch was in-flight
  try { map.getStyle(); } catch { return; }
  if (map.getSource(SOURCE_ID)) return; // re-check after async gap

  // Add source
  map.addSource(SOURCE_ID, {
    type: 'geojson',
    data: geojson,
    generateId: true,
  });

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

  // ── Clearwater heatmap ──────────────────────────────────────────────────

  map.addLayer(
    {
      id: LAYER_CW_HEATMAP,
      type: 'heatmap',
      source: SOURCE_ID,
      maxzoom: 15,
      filter: ['all', ['==', ['get', 'formation'], 'Clearwater'], ['==', ['get', 'fluid_type'], 'oil']],
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
      filter: ['all', ['==', ['get', 'formation'], 'Bluesky'], ['==', ['get', 'fluid_type'], 'oil']],
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
          ['all', ['==', ['get', 'formation'], 'Clearwater'], ['==', ['get', 'fluid_type'], 'gas']],
          CW_GAS_DOT_COLOR,
          ['all', ['==', ['get', 'formation'], 'Bluesky'], ['==', ['get', 'fluid_type'], 'gas']],
          BS_GAS_DOT_COLOR,
          ['==', ['get', 'formation'], 'Bluesky'],
          BS_DOT_COLOR,
          CW_DOT_COLOR,
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
  for (const id of [LAYER_DOTS, LAYER_BS_HEATMAP, LAYER_CW_HEATMAP, LAYER_BS_GAS_HEATMAP, LAYER_CW_GAS_HEATMAP]) {
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
  const oilLayer = formation === 'Clearwater' ? LAYER_CW_HEATMAP : LAYER_BS_HEATMAP;
  const gasLayer = formation === 'Clearwater' ? LAYER_CW_GAS_HEATMAP : LAYER_BS_GAS_HEATMAP;
  const vis = visible ? 'visible' : 'none';
  if (map.getLayer(oilLayer)) map.setLayoutProperty(oilLayer, 'visibility', vis);
  if (map.getLayer(gasLayer)) map.setLayoutProperty(gasLayer, 'visibility', vis);
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
  clearwaterGasHeatmap: LAYER_CW_GAS_HEATMAP,
  blueskyGasHeatmap: LAYER_BS_GAS_HEATMAP,
  dots: LAYER_DOTS,
  source: SOURCE_ID,
} as const;
