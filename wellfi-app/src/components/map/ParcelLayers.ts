/**
 * ParcelLayers — Health-colored parcel visualization layers
 *
 * Central module for all parcel health visualization on the map.
 * Uses feature-state driven colors so health updates are instant
 * (no GeoJSON reload required — just setFeatureState calls).
 *
 * Layers (bottom to top):
 *   1. Glow — wide blurred line for ambient color bleed
 *   2. Fill — translucent health-colored polygon fill
 *   2b. Op Status Fill — semi-transparent operational status overlay
 *   3. Line — crisp stroke border (prioritizes op_status when present)
 *   4. Labels — symbol layer on centroids showing well count + avg months
 */
import mapboxgl from 'mapbox-gl';
import { GLASS_COLORS } from '@/components/map/glassmorphicStyle';
import { parcelPopupHTML } from '@/components/map/ParcelPopup';
import type { ParcelHealth } from '@/lib/parcelHealth';

export type { ParcelHealth } from '@/lib/parcelHealth';

// ─── Layer & Source IDs ───────────────────────────────────────────────────

const PARCEL_SOURCE = 'parcel-health-source';
const PARCEL_CENTROIDS_SOURCE = 'parcel-centroids-source';
const PARCEL_GLOW = 'parcel-health-glow';
const PARCEL_FILL = 'parcel-health-fill';
const PARCEL_OP_STATUS_FILL = 'parcel-op-status-fill';
const PARCEL_LINE = 'parcel-health-line';
const PARCEL_LABELS = 'parcel-labels';

const ALL_LAYERS = [PARCEL_LABELS, PARCEL_LINE, PARCEL_OP_STATUS_FILL, PARCEL_FILL, PARCEL_GLOW];
const ALL_SOURCES = [PARCEL_CENTROIDS_SOURCE, PARCEL_SOURCE];

// ─── Health Level Classification ──────────────────────────────────────────

/**
 * Classify a parcel's health into a numeric level (0-6).
 *   0 = empty (no wells in parcel)
 *   1 = green (< 9 months)
 *   2 = yellow (9-13 months)
 *   3 = orange (14-16 months)
 *   4 = red (17+ months — due)
 *   5 = purple (upcoming pump change)
 *   6 = gray (no data / unknown)
 */
export function healthLevel(h: ParcelHealth): number {
  if (h.wellCount === 0) return 0;  // empty
  if (h.hasUpcomingChange) return 5; // purple
  if (h.avgMonthsRunning >= 17) return 4; // red
  if (h.avgMonthsRunning >= 14) return 3; // orange
  if (h.avgMonthsRunning >= 9) return 2;  // yellow
  if (h.avgMonthsRunning > 0) return 1;   // green
  return 6; // gray / no data
}

// ─── Color expressions (feature-state driven) ────────────────────────────

/**
 * Build a match expression that reads feature-state health_level
 * and returns the corresponding color from GLASS_COLORS.
 *
 * Uses coalesce to handle null feature-state (before it's set).
 */
function healthFillColorExpr(): unknown[] {
  return [
    'match',
    ['coalesce', ['feature-state', 'health_level'], 0],
    0, GLASS_COLORS.healthEmptyFill,
    1, GLASS_COLORS.healthGreenFill,
    2, GLASS_COLORS.healthYellowFill,
    3, GLASS_COLORS.healthOrangeFill,
    4, GLASS_COLORS.healthRedFill,
    5, GLASS_COLORS.healthPurpleFill,
    6, GLASS_COLORS.healthGrayFill,
    GLASS_COLORS.healthEmptyFill, // fallback
  ];
}

function healthFillHoverColorExpr(): unknown[] {
  return [
    'match',
    ['coalesce', ['feature-state', 'health_level'], 0],
    0, GLASS_COLORS.healthEmptyFillHover,
    1, GLASS_COLORS.healthGreenFillHover,
    2, GLASS_COLORS.healthYellowFillHover,
    3, GLASS_COLORS.healthOrangeFillHover,
    4, GLASS_COLORS.healthRedFillHover,
    5, GLASS_COLORS.healthPurpleFillHover,
    6, GLASS_COLORS.healthGrayFillHover,
    GLASS_COLORS.healthEmptyFillHover, // fallback
  ];
}

function healthStrokeColorExpr(): unknown[] {
  return [
    'match',
    ['coalesce', ['feature-state', 'health_level'], 0],
    0, GLASS_COLORS.healthEmptyStroke,
    1, GLASS_COLORS.healthGreenStroke,
    2, GLASS_COLORS.healthYellowStroke,
    3, GLASS_COLORS.healthOrangeStroke,
    4, GLASS_COLORS.healthRedStroke,
    5, GLASS_COLORS.healthPurpleStroke,
    6, GLASS_COLORS.healthGrayStroke,
    GLASS_COLORS.healthEmptyStroke, // fallback
  ];
}

function healthStrokeHoverColorExpr(): unknown[] {
  return [
    'match',
    ['coalesce', ['feature-state', 'health_level'], 0],
    0, GLASS_COLORS.healthEmptyStrokeHover,
    1, GLASS_COLORS.healthGreenStrokeHover,
    2, GLASS_COLORS.healthYellowStrokeHover,
    3, GLASS_COLORS.healthOrangeStrokeHover,
    4, GLASS_COLORS.healthRedStrokeHover,
    5, GLASS_COLORS.healthPurpleStrokeHover,
    6, GLASS_COLORS.healthGrayStrokeHover,
    GLASS_COLORS.healthEmptyStrokeHover, // fallback
  ];
}

function healthGlowColorExpr(): unknown[] {
  return [
    'match',
    ['coalesce', ['feature-state', 'health_level'], 0],
    0, GLASS_COLORS.healthEmptyGlow,
    1, GLASS_COLORS.healthGreenGlow,
    2, GLASS_COLORS.healthYellowGlow,
    3, GLASS_COLORS.healthOrangeGlow,
    4, GLASS_COLORS.healthRedGlow,
    5, GLASS_COLORS.healthPurpleGlow,
    6, GLASS_COLORS.healthGrayGlow,
    GLASS_COLORS.healthEmptyGlow, // fallback
  ];
}

// ─── Operational status color expressions (feature-state driven) ─────────

/**
 * Op status fill color: transparent when no status, colored overlay otherwise.
 * Reads feature-state `op_status` (0=none, 1=watch, 2=warning, 3=well_down).
 */
function opStatusFillColorExpr(): unknown[] {
  return [
    'match',
    ['coalesce', ['feature-state', 'op_status'], 0],
    1, GLASS_COLORS.opWatchFill,
    2, GLASS_COLORS.opWarningFill,
    3, GLASS_COLORS.opWellDownFill,
    'rgba(0,0,0,0)', // fallback — transparent (no status)
  ];
}

function opStatusFillHoverColorExpr(): unknown[] {
  return [
    'match',
    ['coalesce', ['feature-state', 'op_status'], 0],
    1, GLASS_COLORS.opWatchFillHover,
    2, GLASS_COLORS.opWarningFillHover,
    3, GLASS_COLORS.opWellDownFillHover,
    'rgba(0,0,0,0)', // fallback — transparent
  ];
}

function opStatusStrokeColorExpr(): unknown[] {
  return [
    'match',
    ['coalesce', ['feature-state', 'op_status'], 0],
    1, GLASS_COLORS.opWatchStroke,
    2, GLASS_COLORS.opWarningStroke,
    3, GLASS_COLORS.opWellDownStroke,
    'rgba(0,0,0,0)', // fallback
  ];
}

function opStatusStrokeHoverColorExpr(): unknown[] {
  return [
    'match',
    ['coalesce', ['feature-state', 'op_status'], 0],
    1, GLASS_COLORS.opWatchStrokeHover,
    2, GLASS_COLORS.opWarningStrokeHover,
    3, GLASS_COLORS.opWellDownStrokeHover,
    'rgba(0,0,0,0)', // fallback
  ];
}

// ─── Public API ───────────────────────────────────────────────────────────

/**
 * Add the parcel health source and all 5 visualization layers.
 *
 * @param map         - The Mapbox GL map instance
 * @param parcels     - GeoJSON FeatureCollection of parcel polygons (with numeric `id` on each feature)
 * @param centroids   - GeoJSON FeatureCollection of parcel centroid points (with `label` property)
 * @param beforeLayerId - Optional layer ID to insert layers before (for z-ordering)
 */
export function addParcelLayers(
  map: mapboxgl.Map,
  parcels: GeoJSON.FeatureCollection,
  centroids: GeoJSON.FeatureCollection,
  beforeLayerId?: string,
): void {
  // ── Add sources ──
  if (!map.getSource(PARCEL_SOURCE)) {
    map.addSource(PARCEL_SOURCE, {
      type: 'geojson',
      data: parcels,
      generateId: true,
    });
  }

  if (!map.getSource(PARCEL_CENTROIDS_SOURCE)) {
    map.addSource(PARCEL_CENTROIDS_SOURCE, {
      type: 'geojson',
      data: centroids,
    });
  }

  // ── 1. Glow layer (wide blurred line for ambient color bleed) ──
  if (!map.getLayer(PARCEL_GLOW)) {
    map.addLayer(
      {
        id: PARCEL_GLOW,
        type: 'line',
        source: PARCEL_SOURCE,
        paint: {
          'line-color': healthGlowColorExpr() as unknown as mapboxgl.Expression,
          'line-width': 8,
          'line-blur': 6,
          'line-opacity': 0.6,
          'line-opacity-transition': { duration: 300, delay: 0 },
        },
      },
      beforeLayerId,
    );
  }

  // ── 2. Fill layer (translucent health-colored fill) ──
  if (!map.getLayer(PARCEL_FILL)) {
    map.addLayer(
      {
        id: PARCEL_FILL,
        type: 'fill',
        source: PARCEL_SOURCE,
        paint: {
          'fill-color': [
            'case',
            ['boolean', ['feature-state', 'hover'], false],
            healthFillHoverColorExpr(),
            healthFillColorExpr(),
          ] as unknown as mapboxgl.Expression,
          'fill-opacity': 1,
          'fill-opacity-transition': { duration: 300, delay: 0 },
        },
      },
      PARCEL_GLOW,
    );
  }

  // ── 2b. Op status overlay fill (semi-transparent operational status) ──
  if (!map.getLayer(PARCEL_OP_STATUS_FILL)) {
    map.addLayer(
      {
        id: PARCEL_OP_STATUS_FILL,
        type: 'fill',
        source: PARCEL_SOURCE,
        paint: {
          'fill-color': [
            'case',
            ['boolean', ['feature-state', 'hover'], false],
            opStatusFillHoverColorExpr(),
            opStatusFillColorExpr(),
          ] as unknown as mapboxgl.Expression,
          'fill-opacity': 1,
          'fill-opacity-transition': { duration: 300, delay: 0 },
        },
      },
      PARCEL_GLOW,
    );
  }

  // ── 3. Stroke layer (crisp border line — prioritizes op_status when present) ──
  if (!map.getLayer(PARCEL_LINE)) {
    map.addLayer(
      {
        id: PARCEL_LINE,
        type: 'line',
        source: PARCEL_SOURCE,
        paint: {
          'line-color': [
            'case',
            // Op status hover takes priority when present
            ['all',
              ['boolean', ['feature-state', 'hover'], false],
              ['>', ['coalesce', ['feature-state', 'op_status'], 0], 0],
            ],
            opStatusStrokeHoverColorExpr(),
            // Op status normal takes priority when present
            ['>', ['coalesce', ['feature-state', 'op_status'], 0], 0],
            opStatusStrokeColorExpr(),
            // Otherwise fall back to health hover / normal
            ['boolean', ['feature-state', 'hover'], false],
            healthStrokeHoverColorExpr(),
            healthStrokeColorExpr(),
          ] as unknown as mapboxgl.Expression,
          'line-width': [
            'case',
            ['boolean', ['feature-state', 'hover'], false],
            1.5,
            0.8,
          ] as unknown as mapboxgl.Expression,
          'line-opacity-transition': { duration: 300, delay: 0 },
        },
      },
      beforeLayerId,
    );
  }

  // ── 4. Labels layer (symbol on centroids — well count + avg months) ──
  if (!map.getLayer(PARCEL_LABELS)) {
    map.addLayer(
      {
        id: PARCEL_LABELS,
        type: 'symbol',
        source: PARCEL_CENTROIDS_SOURCE,
        minzoom: 11,
        layout: {
          'text-field': ['format', ['get', 'label'], {}] as unknown as mapboxgl.Expression,
          'text-size': 11,
          'text-font': ['DIN Pro Medium', 'Arial Unicode MS Bold'],
          'text-anchor': 'center',
          'text-justify': 'center',
          'text-allow-overlap': false,
          'text-ignore-placement': false,
        },
        paint: {
          'text-color': 'rgba(255, 255, 255, 0.7)',
          'text-halo-color': 'rgba(6, 9, 15, 0.9)',
          'text-halo-width': 1.2,
          'text-opacity': 0.85,
          'text-opacity-transition': { duration: 300, delay: 0 },
        },
      },
      beforeLayerId,
    );
  }
}

// ─── Op status level mapping ─────────────────────────────────────────────

/** Map of operational status type strings to numeric levels for feature-state */
const OP_STATUS_LEVELS: Record<string, number> = {
  watch: 1,
  warning: 2,
  well_down: 3,
};

/**
 * Determine the worst (highest severity) op_status level for a parcel
 * by checking all its wells against the status map.
 *
 * Severity: well_down(3) > warning(2) > watch(1) > none(0)
 */
function parcelOpStatusLevel(
  wells: ParcelHealth['wells'],
  opStatusByWellId: Map<string, string>,
): number {
  let maxLevel = 0;
  for (const w of wells) {
    const status = opStatusByWellId.get(w.id);
    if (status) {
      const level = OP_STATUS_LEVELS[status] ?? 0;
      if (level > maxLevel) maxLevel = level;
    }
  }
  return maxLevel;
}

/**
 * Update parcel health coloring via feature-state.
 * Iterates the healthMap and calls setFeatureState for each parcel.
 * Also updates the centroids source with new label text.
 *
 * @param map              - The Mapbox GL map instance
 * @param healthMap        - Map of parcel feature ID -> ParcelHealth
 * @param centroids        - Optional updated centroids GeoJSON to replace the centroids source data
 * @param opStatusByWellId - Optional map of well UUID -> status type ('watch' | 'warning' | 'well_down')
 */
export function updateParcelHealth(
  map: mapboxgl.Map,
  healthMap: Map<number, ParcelHealth>,
  centroids?: GeoJSON.FeatureCollection,
  opStatusByWellId?: Map<string, string>,
): void {
  // Update feature states for each parcel
  for (const [featureId, health] of healthMap) {
    const level = healthLevel(health);

    // Compute op_status level for this parcel (max-severity of its wells)
    const opStatus = opStatusByWellId
      ? parcelOpStatusLevel(health.wells, opStatusByWellId)
      : 0;

    map.setFeatureState(
      { source: PARCEL_SOURCE, id: featureId },
      {
        health_level: level,
        well_count: health.wellCount,
        avg_months: health.avgMonthsRunning,
        op_status: opStatus,
        // Don't overwrite hover — preserve it separately
      },
    );
  }

  // Update centroids source if new data is provided
  if (centroids) {
    const centroidsSrc = map.getSource(PARCEL_CENTROIDS_SOURCE) as mapboxgl.GeoJSONSource | undefined;
    if (centroidsSrc) {
      centroidsSrc.setData(centroids);
    }
  }
}

/**
 * Set up parcel hover and click interactions.
 *
 * @param map       - The Mapbox GL map instance
 * @param callbacks - Callback handlers for user interaction
 */
export function setupParcelInteraction(
  map: mapboxgl.Map,
  callbacks: {
    onWellClick: (wellId: string) => void;
    getParcelHealth: (featureId: number) => ParcelHealth | undefined;
    getOpStatusByWellId?: () => Map<string, string> | undefined;
  },
): void {
  let hoveredParcelId: number | null = null;
  let activePopup: mapboxgl.Popup | null = null;

  // Hover: mousemove on fill layer → highlight parcel
  map.on('mousemove', PARCEL_FILL, (e) => {
    if (!e.features || e.features.length === 0) return;

    // Clear previous hover
    if (hoveredParcelId !== null) {
      map.setFeatureState(
        { source: PARCEL_SOURCE, id: hoveredParcelId },
        { hover: false },
      );
    }

    hoveredParcelId = e.features[0].id as number;
    map.setFeatureState(
      { source: PARCEL_SOURCE, id: hoveredParcelId },
      { hover: true },
    );

    map.getCanvas().style.cursor = 'pointer';
  });

  // Hover leave: reset hover state + cursor
  map.on('mouseleave', PARCEL_FILL, () => {
    if (hoveredParcelId !== null) {
      map.setFeatureState(
        { source: PARCEL_SOURCE, id: hoveredParcelId },
        { hover: false },
      );
    }
    hoveredParcelId = null;
    map.getCanvas().style.cursor = '';
  });

  // Click: show parcel popup with health details and well list
  map.on('click', PARCEL_FILL, (e) => {
    if (!e.features || e.features.length === 0) return;

    const feature = e.features[0];
    const featureId = feature.id as number;
    const props = feature.properties ?? {};

    // Get the full health data from the live healthMap
    const health = callbacks.getParcelHealth(featureId);
    if (!health) return;

    // Remove previous popup
    activePopup?.remove();

    activePopup = new mapboxgl.Popup({
      closeButton: true,
      closeOnClick: true,
      maxWidth: '320px',
      className: 'wellfi-popup',
    })
      .setLngLat(e.lngLat)
      .setHTML(parcelPopupHTML(props, health, callbacks.getOpStatusByWellId?.()))
      .addTo(map);

    // Wire up well click handlers in the popup
    const popupEl = activePopup.getElement();
    if (popupEl) {
      const wellButtons = popupEl.querySelectorAll('[data-well-id]');
      wellButtons.forEach((btn) => {
        btn.addEventListener('click', () => {
          const wellId = btn.getAttribute('data-well-id');
          if (wellId) {
            callbacks.onWellClick(wellId);
            activePopup?.remove();
          }
        });
      });
    }
  });
}

/**
 * Replace the parcel source data (e.g., when synthetic parcels are added at runtime).
 */
export function updateParcelData(map: mapboxgl.Map, parcels: GeoJSON.FeatureCollection): void {
  const src = map.getSource(PARCEL_SOURCE) as mapboxgl.GeoJSONSource | undefined;
  if (src) src.setData(parcels);
}

/**
 * Remove all parcel layers and sources from the map.
 */
export function removeParcelLayers(map: mapboxgl.Map): void {
  for (const id of ALL_LAYERS) {
    if (map.getLayer(id)) map.removeLayer(id);
  }
  for (const id of ALL_SOURCES) {
    if (map.getSource(id)) map.removeSource(id);
  }
}

/**
 * Toggle visibility of all parcel layers.
 */
export function setParcelVisibility(map: mapboxgl.Map, visible: boolean): void {
  const visibility = visible ? 'visible' : 'none';
  for (const id of ALL_LAYERS) {
    if (map.getLayer(id)) {
      map.setLayoutProperty(id, 'visibility', visibility);
    }
  }
}
