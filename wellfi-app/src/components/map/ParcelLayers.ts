/**
 * ParcelLayers — 3D extruded parcel health visualization
 *
 * Central module for all parcel health visualization on the map.
 * Uses feature-state driven colors so health updates are instant
 * (no GeoJSON reload required — just setFeatureState calls).
 *
 * 3D extrusion: height = max pump run time in block,
 * green hue = pumping ratio (field health), op status overrides to blue/yellow/red.
 *
 * Layers (bottom to top):
 *   1. Glow — wide blurred line for ambient color bleed at ground level
 *   2. Extrusion — 3D fill-extrusion with health color + height
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
const PARCEL_EXTRUSION = 'parcel-health-extrusion';
const PARCEL_LINE = 'parcel-health-line';
const PARCEL_LABELS = 'parcel-labels';

const ALL_LAYERS = [PARCEL_LABELS, PARCEL_LINE, PARCEL_EXTRUSION, PARCEL_GLOW];
const ALL_SOURCES = [PARCEL_CENTROIDS_SOURCE, PARCEL_SOURCE];

// ─── 3D Extrusion constants ─────────────────────────────────────────────
/** Meters of extrusion height per month of pump run time */
const METERS_PER_MONTH = 300;
/** Minimum extrusion height (meters) for parcels with wells but 0 months */
const MIN_EXTRUSION_HEIGHT = 50;

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

// ─── 3D Extrusion color expressions (feature-state driven) ──────────────

/**
 * Extrusion color: green hue based on pumping_ratio (field health),
 * overridden by operational status colors (blue/yellow/red) when present.
 *
 * pumping_ratio 1.0 = bright emerald (all wells pumping, healthy)
 * pumping_ratio 0.5 = muted green (half pumping)
 * pumping_ratio 0.0 = dim gray (all down)
 *
 * Op status overrides: watch=blue, warning=yellow, well_down=red
 */
function extrusionColorExpr(): unknown[] {
  return [
    'case',
    // Op status overrides (highest priority)
    ['==', ['coalesce', ['feature-state', 'op_status'], 0], 3],
    GLASS_COLORS.opWellDownExtrusion,     // red
    ['==', ['coalesce', ['feature-state', 'op_status'], 0], 2],
    GLASS_COLORS.opWarningExtrusion,      // yellow
    ['==', ['coalesce', ['feature-state', 'op_status'], 0], 1],
    GLASS_COLORS.opWatchExtrusion,        // blue
    // Default: green hue interpolated by pumping ratio
    [
      'interpolate', ['linear'],
      ['coalesce', ['feature-state', 'pumping_ratio'], 0],
      0,   GLASS_COLORS.extrusionDown,    // dim gray (all down)
      0.5, GLASS_COLORS.extrusionMid,     // muted green (half pumping)
      1.0, GLASS_COLORS.extrusionHealthy, // bright emerald (all pumping)
    ],
  ];
}

/**
 * Hover variant of extrusion color: brighter versions.
 */
function extrusionColorHoverExpr(): unknown[] {
  return [
    'case',
    ['==', ['coalesce', ['feature-state', 'op_status'], 0], 3],
    GLASS_COLORS.opWellDownExtrusionHover,
    ['==', ['coalesce', ['feature-state', 'op_status'], 0], 2],
    GLASS_COLORS.opWarningExtrusionHover,
    ['==', ['coalesce', ['feature-state', 'op_status'], 0], 1],
    GLASS_COLORS.opWatchExtrusionHover,
    [
      'interpolate', ['linear'],
      ['coalesce', ['feature-state', 'pumping_ratio'], 0],
      0,   GLASS_COLORS.extrusionDownHover,
      0.5, GLASS_COLORS.extrusionMidHover,
      1.0, GLASS_COLORS.extrusionHealthyHover,
    ],
  ];
}

/**
 * Extrusion height: driven by max_months feature-state.
 * Returns meters — scaled by METERS_PER_MONTH.
 */
function extrusionHeightExpr(): unknown[] {
  return [
    'max',
    ['*', ['coalesce', ['feature-state', 'max_months'], 0], METERS_PER_MONTH],
    // Parcels with wells get minimum height so they're visible
    [
      'case',
      ['>', ['coalesce', ['feature-state', 'well_count'], 0], 0],
      MIN_EXTRUSION_HEIGHT,
      0,
    ],
  ];
}

// ─── Stroke color expressions (ground-level border lines) ───────────────

function healthStrokeColorExpr(): unknown[] {
  return [
    'case',
    // Op status stroke takes priority
    ['==', ['coalesce', ['feature-state', 'op_status'], 0], 3],
    GLASS_COLORS.opWellDownStroke,
    ['==', ['coalesce', ['feature-state', 'op_status'], 0], 2],
    GLASS_COLORS.opWarningStroke,
    ['==', ['coalesce', ['feature-state', 'op_status'], 0], 1],
    GLASS_COLORS.opWatchStroke,
    // Default: subtle white stroke scaled by pumping ratio
    [
      'interpolate', ['linear'],
      ['coalesce', ['feature-state', 'pumping_ratio'], 0],
      0,   'rgba(255, 255, 255, 0.06)',
      0.5, 'rgba(255, 255, 255, 0.12)',
      1.0, 'rgba(255, 255, 255, 0.20)',
    ],
  ];
}

function healthStrokeHoverColorExpr(): unknown[] {
  return [
    'case',
    ['==', ['coalesce', ['feature-state', 'op_status'], 0], 3],
    GLASS_COLORS.opWellDownStrokeHover,
    ['==', ['coalesce', ['feature-state', 'op_status'], 0], 2],
    GLASS_COLORS.opWarningStrokeHover,
    ['==', ['coalesce', ['feature-state', 'op_status'], 0], 1],
    GLASS_COLORS.opWatchStrokeHover,
    [
      'interpolate', ['linear'],
      ['coalesce', ['feature-state', 'pumping_ratio'], 0],
      0,   'rgba(255, 255, 255, 0.15)',
      0.5, 'rgba(255, 255, 255, 0.30)',
      1.0, 'rgba(255, 255, 255, 0.45)',
    ],
  ];
}

/**
 * Glow color: green hue from pumping ratio, overridden by op status.
 */
function glowColorExpr(): unknown[] {
  return [
    'case',
    ['==', ['coalesce', ['feature-state', 'op_status'], 0], 3],
    GLASS_COLORS.opWellDownGlow,
    ['==', ['coalesce', ['feature-state', 'op_status'], 0], 2],
    GLASS_COLORS.opWarningGlow,
    ['==', ['coalesce', ['feature-state', 'op_status'], 0], 1],
    GLASS_COLORS.opWatchGlow,
    [
      'interpolate', ['linear'],
      ['coalesce', ['feature-state', 'pumping_ratio'], 0],
      0,   'rgba(107, 114, 128, 0.04)',
      0.5, 'rgba(34, 197, 94, 0.08)',
      1.0, 'rgba(74, 222, 128, 0.12)',
    ],
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

  // ── 1. Glow layer (wide blurred line for ambient color bleed at ground level) ──
  if (!map.getLayer(PARCEL_GLOW)) {
    map.addLayer(
      {
        id: PARCEL_GLOW,
        type: 'line',
        source: PARCEL_SOURCE,
        paint: {
          'line-color': glowColorExpr() as unknown as mapboxgl.Expression,
          'line-width': 8,
          'line-blur': 6,
          'line-opacity': 0.6,
          'line-opacity-transition': { duration: 300, delay: 0 },
        },
      },
      beforeLayerId,
    );
  }

  // ── 2. 3D Extrusion layer (height = max pump months, color = field health / op status) ──
  if (!map.getLayer(PARCEL_EXTRUSION)) {
    map.addLayer(
      {
        id: PARCEL_EXTRUSION,
        type: 'fill-extrusion',
        source: PARCEL_SOURCE,
        paint: {
          'fill-extrusion-color': [
            'case',
            ['boolean', ['feature-state', 'hover'], false],
            extrusionColorHoverExpr(),
            extrusionColorExpr(),
          ] as unknown as mapboxgl.Expression,
          'fill-extrusion-height': extrusionHeightExpr() as unknown as number,
          'fill-extrusion-base': 0,
          'fill-extrusion-opacity': 0.75,
          'fill-extrusion-opacity-transition': { duration: 300, delay: 0 },
        },
      },
      PARCEL_GLOW,
    );
  }

  // ── 3. Stroke layer (crisp ground-level border) ──
  if (!map.getLayer(PARCEL_LINE)) {
    map.addLayer(
      {
        id: PARCEL_LINE,
        type: 'line',
        source: PARCEL_SOURCE,
        paint: {
          'line-color': [
            'case',
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

    // Adjust pumping ratio: wells with well_down op status count as "not pumping"
    let adjustedPumpingRatio = health.pumpingRatio;
    if (opStatusByWellId && health.wellCount > 0) {
      const downFromOpStatus = health.wells.filter(
        (w) => opStatusByWellId.get(w.id) === 'well_down',
      ).length;
      const pumpingCount = health.wells.filter(
        (w) =>
          (w.wellStatus === 'Pumping' || w.wellStatus === 'Operating') &&
          opStatusByWellId.get(w.id) !== 'well_down',
      ).length;
      adjustedPumpingRatio = pumpingCount / health.wellCount;
    }

    map.setFeatureState(
      { source: PARCEL_SOURCE, id: featureId },
      {
        health_level: level,
        well_count: health.wellCount,
        avg_months: health.avgMonthsRunning,
        max_months: health.maxMonthsRunning,
        pumping_ratio: adjustedPumpingRatio,
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
  map.on('mousemove', PARCEL_EXTRUSION, (e) => {
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
  map.on('mouseleave', PARCEL_EXTRUSION, () => {
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
  map.on('click', PARCEL_EXTRUSION, (e) => {
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
