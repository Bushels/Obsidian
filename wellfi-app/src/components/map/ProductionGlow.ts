/**
 * ProductionGlow - formation-colored production overlay.
 *
 * Basin-scale view uses heatmaps.
 * Close-range view hands off to production dots in the same formation/fluid colors.
 * Base well dots still come from the live WellFi well source in WellMap.
 */
import type { Map as MapboxMap } from 'mapbox-gl';

const SOURCE_ID = 'bluesky-clearwater-production-source';

const LAYER_CW_HEATMAP = 'clearwater-production-heatmap';
const LAYER_BS_HEATMAP = 'bluesky-production-heatmap';
const LAYER_CW_GAS_HEATMAP = 'clearwater-gas-heatmap';
const LAYER_BS_GAS_HEATMAP = 'bluesky-gas-heatmap';
const LAYER_CW_DOT_GLOW = 'clearwater-production-dot-glow';
const LAYER_CW_DOTS = 'clearwater-production-dots';
const LAYER_BS_DOT_GLOW = 'bluesky-production-dot-glow';
const LAYER_BS_DOTS = 'bluesky-production-dots';

export const PRODUCTION_DOT_LAYER_IDS = [
  LAYER_CW_DOT_GLOW,
  LAYER_CW_DOTS,
  LAYER_BS_DOT_GLOW,
  LAYER_BS_DOTS,
] as const;

// Normalization: sqrt(max_production) per formation
const CW_SQRT_MAX = 70.7; // sqrt(5000)
const BS_SQRT_MAX = 38.7; // sqrt(1500)
const CW_GAS_SQRT_MAX = 18.2; // sqrt(331)
const BS_GAS_SQRT_MAX = 83.4; // sqrt(6948)

const CLEARWATER_RAMP = [
  'interpolate', ['linear'], ['heatmap-density'],
  0, 'rgba(74, 222, 128, 0)',
  0.15, 'rgba(74, 222, 128, 0.15)',
  0.35, 'rgba(34, 197, 94, 0.25)',
  0.55, 'rgba(22, 163, 74, 0.40)',
  0.75, 'rgba(21, 128, 61, 0.55)',
  1.0, 'rgba(20, 83, 45, 0.70)',
] as const;

const BLUESKY_RAMP = [
  'interpolate', ['linear'], ['heatmap-density'],
  0, 'rgba(253, 224, 71, 0)',
  0.15, 'rgba(253, 224, 71, 0.15)',
  0.35, 'rgba(250, 204, 21, 0.25)',
  0.55, 'rgba(234, 179, 8, 0.40)',
  0.75, 'rgba(202, 138, 4, 0.55)',
  1.0, 'rgba(161, 98, 7, 0.70)',
] as const;

const CLEARWATER_GAS_RAMP = [
  'interpolate', ['linear'], ['heatmap-density'],
  0, 'rgba(134, 239, 172, 0)',
  0.15, 'rgba(134, 239, 172, 0.10)',
  0.35, 'rgba(134, 239, 172, 0.18)',
  0.55, 'rgba(74, 222, 128, 0.28)',
  0.75, 'rgba(34, 197, 94, 0.38)',
  1.0, 'rgba(22, 163, 74, 0.50)',
] as const;

const BLUESKY_GAS_RAMP = [
  'interpolate', ['linear'], ['heatmap-density'],
  0, 'rgba(253, 224, 71, 0)',
  0.15, 'rgba(253, 224, 71, 0.10)',
  0.35, 'rgba(252, 211, 77, 0.18)',
  0.55, 'rgba(250, 204, 21, 0.28)',
  0.75, 'rgba(234, 179, 8, 0.38)',
  1.0, 'rgba(202, 138, 4, 0.50)',
] as const;

const CLEARWATER_DOT_COLOR = [
  'case',
  ['==', ['get', 'fluid_type'], 'gas'], '#86EFAC',
  '#22C55E',
] as const;

const BLUESKY_DOT_COLOR = [
  'case',
  ['==', ['get', 'fluid_type'], 'gas'], '#FCD34D',
  '#F59E0B',
] as const;

const PRODUCTION_DOT_MAGNITUDE = [
  'sqrt',
  [
    'case',
    ['==', ['get', 'fluid_type'], 'gas'],
    ['/', ['coalesce', ['get', 'recent_gas'], 0], 6],
    ['coalesce', ['get', 'recent_oil'], 0],
  ],
] as const;

const PRODUCTION_DOT_RADIUS = [
  'interpolate', ['linear'], PRODUCTION_DOT_MAGNITUDE,
  0, 3,
  6, 4.5,
  12, 6,
  24, 7.5,
  40, 9,
] as const;

const PRODUCTION_DOT_GLOW_RADIUS = [
  'interpolate', ['linear'], PRODUCTION_DOT_MAGNITUDE,
  0, 6,
  6, 7.5,
  12, 9,
  24, 11,
  40, 13,
] as const;

const PRODUCTION_DOT_OPACITY = [
  'interpolate', ['linear'], ['zoom'],
  10, 0,
  11.5, 0.2,
  13, 0.68,
  15, 0.92,
] as const;

const PRODUCTION_DOT_GLOW_OPACITY = [
  'interpolate', ['linear'], ['zoom'],
  10, 0,
  11.5, 0.08,
  13, 0.22,
  15, 0.34,
] as const;

const PRODUCTION_DOT_STROKE_WIDTH = [
  'interpolate', ['linear'], ['zoom'],
  10, 0,
  12, 0.8,
  15, 1.2,
] as const;

const PRODUCTION_DOT_STROKE_OPACITY = [
  'interpolate', ['linear'], ['zoom'],
  10, 0,
  12, 0.45,
  15, 0.8,
] as const;

function addFormationDotLayers(
  map: MapboxMap,
  formation: 'Clearwater' | 'Bluesky',
  beforeLayerId?: string,
): void {
  const isClearwater = formation === 'Clearwater';
  const glowLayerId = isClearwater ? LAYER_CW_DOT_GLOW : LAYER_BS_DOT_GLOW;
  const dotLayerId = isClearwater ? LAYER_CW_DOTS : LAYER_BS_DOTS;
  const colorExpression = isClearwater ? CLEARWATER_DOT_COLOR : BLUESKY_DOT_COLOR;
  const filter = ['==', ['get', 'formation'], formation] as const;

  map.addLayer(
    {
      id: glowLayerId,
      type: 'circle',
      source: SOURCE_ID,
      minzoom: 10,
      filter: filter as unknown as string[],
      paint: {
        'circle-color': colorExpression as unknown as string,
        'circle-radius': PRODUCTION_DOT_GLOW_RADIUS as unknown as number,
        'circle-opacity': PRODUCTION_DOT_GLOW_OPACITY as unknown as number,
        'circle-blur': 0.8,
        'circle-stroke-width': 0,
      },
    },
    beforeLayerId,
  );

  map.addLayer(
    {
      id: dotLayerId,
      type: 'circle',
      source: SOURCE_ID,
      minzoom: 10,
      filter: filter as unknown as string[],
      paint: {
        'circle-color': colorExpression as unknown as string,
        'circle-radius': PRODUCTION_DOT_RADIUS as unknown as number,
        'circle-opacity': PRODUCTION_DOT_OPACITY as unknown as number,
        'circle-stroke-color': '#020617',
        'circle-stroke-width': PRODUCTION_DOT_STROKE_WIDTH as unknown as number,
        'circle-stroke-opacity': PRODUCTION_DOT_STROKE_OPACITY as unknown as number,
      },
    },
    beforeLayerId,
  );
}

/**
 * Fetch production GeoJSON and add production heatmap + dots.
 * Call after map 'load' event, after base layers are set up.
 */
export async function addProductionGlow(
  map: MapboxMap,
  operatorSlug: string | null,
  allowedOperators: string[] = [],
  beforeLayerId?: string,
  signal?: AbortSignal,
): Promise<void> {
  if (map.getSource(SOURCE_ID)) return;

  const geojsonUrl = operatorSlug
    ? `/data/operators/${operatorSlug}/production.geojson`
    : '/data/operators/_all/production.geojson';

  const response = await fetch(geojsonUrl, { signal });
  if (!response.ok) {
    console.warn(`ProductionGlow: failed to load ${geojsonUrl} (${response.status})`);
    return;
  }
  const geojson = await response.json();

  if (signal?.aborted) return;

  if (!operatorSlug && Array.isArray(geojson?.features) && allowedOperators.length > 0) {
    const allowedOperatorSet = new Set(allowedOperators);
    geojson.features = geojson.features.filter((feature: { properties?: { operator?: string } }) =>
      allowedOperatorSet.has(String(feature.properties?.operator ?? '').trim()),
    );
  }

  try {
    map.getStyle();
  } catch {
    return;
  }

  if (map.getSource(SOURCE_ID)) return;

  map.addSource(SOURCE_ID, {
    type: 'geojson',
    data: geojson,
    generateId: true,
  });

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

  addFormationDotLayers(map, 'Clearwater', beforeLayerId);
  addFormationDotLayers(map, 'Bluesky', beforeLayerId);
}

/**
 * Remove all production layers and source.
 */
export function removeProductionGlow(map: MapboxMap): void {
  for (const id of [
    LAYER_BS_DOTS,
    LAYER_BS_DOT_GLOW,
    LAYER_CW_DOTS,
    LAYER_CW_DOT_GLOW,
    LAYER_BS_HEATMAP,
    LAYER_CW_HEATMAP,
    LAYER_BS_GAS_HEATMAP,
    LAYER_CW_GAS_HEATMAP,
  ]) {
    if (map.getLayer(id)) map.removeLayer(id);
  }

  if (map.getSource(SOURCE_ID)) {
    map.removeSource(SOURCE_ID);
  }
}

/**
 * Toggle visibility of a formation's heatmap and dot layers together.
 */
export function setFormationHeatmapVisibility(
  map: MapboxMap,
  formation: 'Clearwater' | 'Bluesky',
  visible: boolean,
): void {
  const oilLayer = formation === 'Clearwater' ? LAYER_CW_HEATMAP : LAYER_BS_HEATMAP;
  const gasLayer = formation === 'Clearwater' ? LAYER_CW_GAS_HEATMAP : LAYER_BS_GAS_HEATMAP;
  const glowLayer = formation === 'Clearwater' ? LAYER_CW_DOT_GLOW : LAYER_BS_DOT_GLOW;
  const dotLayer = formation === 'Clearwater' ? LAYER_CW_DOTS : LAYER_BS_DOTS;
  const vis = visible ? 'visible' : 'none';

  if (map.getLayer(oilLayer)) map.setLayoutProperty(oilLayer, 'visibility', vis);
  if (map.getLayer(gasLayer)) map.setLayoutProperty(gasLayer, 'visibility', vis);
  if (map.getLayer(glowLayer)) map.setLayoutProperty(glowLayer, 'visibility', vis);
  if (map.getLayer(dotLayer)) map.setLayoutProperty(dotLayer, 'visibility', vis);
}
