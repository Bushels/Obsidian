import 'mapbox-gl/dist/mapbox-gl.css';

import { useRef, useEffect, useState, useCallback, useMemo } from 'react';
import mapboxgl from 'mapbox-gl';
import type { WellEnriched } from '@/types/operationalStatus';
import {
  WELL_COLOR_EXPRESSION,
  WELL_SIZE_EXPRESSION,
  WELL_STROKE_EXPRESSION,
  wellsToGeoJSON,
} from '@/lib/mapUtils';
import { generateDLSGrid } from '@/lib/dlsGrid';
import {
  hasScheduledSupport,
  isWellDownNow,
  isWellFlagged,
  needsToolAssignment,
} from '@/lib/wellEventSelectors';
import type { DashboardFilters } from '@/types/mapFilters';
import { applyGlassmorphicStyle, GLASS_COLORS } from './glassmorphicStyle';
import { wellPopupHTML } from './WellPopup';
import {
  addProductionGlow,
  PRODUCTION_DOT_LAYER_IDS,
  removeProductionGlow,
  setFormationHeatmapVisibility,
} from './ProductionGlow';

interface WellMapProps {
  wells: WellEnriched[];
  onWellClick: (well: WellEnriched) => void;
  filters: DashboardFilters;
  flyToCoords?: { lng: number; lat: number } | null;
  operatorSlug: string | null;
  showProductionOverlay?: boolean;
  allowedProductionOperators?: string[];
}

const STYLES = {
  satellite: 'mapbox://styles/mapbox/satellite-streets-v12',
  glass: 'mapbox://styles/mapbox/dark-v11',
} as const;

type MapStyle = keyof typeof STYLES;

// Well source ID (used for monitored alert layers)
const SOURCE_ID = 'wells-source';
const BASE_WELL_HALO_LAYER = 'wells-wellfi-halo';
const BASE_WELL_POINTS_LAYER = 'wells-points';
const BASE_WELL_LAYER_IDS = [BASE_WELL_HALO_LAYER, BASE_WELL_POINTS_LAYER] as const;

// DLS grid layer IDs
const DLS_TWP_LINES = 'dls-township-lines';
const DLS_TWP_LABELS = 'dls-township-labels';
const DLS_SEC_LINES = 'dls-section-lines';
const DLS_SEC_LABELS = 'dls-section-labels';
const DLS_LSD_LINES = 'dls-lsd-lines';
const DLS_LSD_LABELS = 'dls-lsd-labels';

const DLS_TWP_LINES_SRC = 'dls-township-lines-src';
const DLS_TWP_LABELS_SRC = 'dls-township-labels-src';
const DLS_SEC_LINES_SRC = 'dls-section-lines-src';
const DLS_SEC_LABELS_SRC = 'dls-section-labels-src';
const DLS_LSD_LINES_SRC = 'dls-lsd-lines-src';
const DLS_LSD_LABELS_SRC = 'dls-lsd-labels-src';

// Subsurface dark overlay — dims satellite imagery when formations are visible
const DARK_OVERLAY_SRC = 'subsurface-dark-src';
const DARK_OVERLAY_LAYER = 'subsurface-dark';

const MONITORED_ALERT_GLOW_LAYER = 'monitored-alert-glow';
const MONITORED_ALERT_POINTS_LAYER = 'monitored-alert-points';
const MONITORED_ALERT_LAYER_IDS = [MONITORED_ALERT_GLOW_LAYER, MONITORED_ALERT_POINTS_LAYER] as const;
const MONITORED_ALERT_BASE_FILTER: mapboxgl.Expression = ['==', ['get', 'show_monitoring_alert'], true];
const MONITORED_ALERT_COLOR: mapboxgl.Expression = [
  'case',
  ['==', ['get', 'op_status'], 'well_down'], '#EF4444',
  ['==', ['get', 'op_status'], 'warning'], '#EAB308',
  ['==', ['get', 'op_status'], 'watch'], '#3B82F6',
  ['==', ['get', 'pump_change_status'], 'in_progress'], '#8B5CF6',
  ['==', ['get', 'pump_change_status'], 'scheduled'], '#06B6D4',
  ['==', ['get', 'pump_change_status'], 'warning'], '#F97316',
  '#94A3B8',
];
const MONITORED_ALERT_RADIUS: mapboxgl.Expression = [
  'case',
  ['==', ['get', 'op_status'], 'well_down'], 11,
  ['==', ['get', 'op_status'], 'warning'], 9,
  ['==', ['get', 'op_status'], 'watch'], 8,
  ['==', ['get', 'pump_change_status'], 'in_progress'], 9,
  ['==', ['get', 'pump_change_status'], 'scheduled'], 8,
  7,
];

function buildBaseWellFilter(filters: DashboardFilters): mapboxgl.Expression | null {
  const conditions: mapboxgl.Expression[] = [];

  if (filters.riskLevels.length > 0) {
    conditions.push(['in', ['get', 'risk_level'], ['literal', filters.riskLevels]]);
  }

  if (filters.formations.length > 0) {
    conditions.push(['in', ['get', 'formation'], ['literal', filters.formations]]);
  }

  if (filters.fields.length > 0) {
    conditions.push(['in', ['get', 'field'], ['literal', filters.fields]]);
  }

  if (filters.showWellFiOnly) {
    conditions.push(['==', ['get', 'has_wellfi'], true]);
  }

  if (filters.showFlaggedOnly) {
    conditions.push(['==', ['get', 'has_active_event'], true]);
  }

  if (filters.showNeedsToolOnly) {
    conditions.push(['==', ['get', 'needs_tool_assignment'], true]);
  }

  if (filters.showScheduledSupportOnly) {
    conditions.push(['==', ['get', 'scheduled_support'], true]);
  }

  if (filters.showDownNowOnly) {
    conditions.push(['==', ['get', 'is_down_now'], true]);
  }

  if (filters.minRateBblD > 0) {
    conditions.push(['>=', ['get', 'dec_rate_bbl_d'], filters.minRateBblD]);
  }

  if (conditions.length === 0) {
    return null;
  }

  return conditions.length === 1 ? conditions[0] : ['all', ...conditions];
}

function buildMonitoredAlertFilter(filters: DashboardFilters): mapboxgl.Expression {
  const baseFilter = buildBaseWellFilter(filters);
  return baseFilter ? ['all', MONITORED_ALERT_BASE_FILTER, baseFilter] : MONITORED_ALERT_BASE_FILTER;
}

function buildWellFiHaloFilter(filters: DashboardFilters): mapboxgl.Expression {
  const baseFilter = buildBaseWellFilter(filters);
  const haloFilter: mapboxgl.Expression = ['==', ['get', 'has_wellfi'], true];
  return baseFilter ? ['all', haloFilter, baseFilter] : haloFilter;
}

function matchesBaseWellFilters(well: WellEnriched, filters: DashboardFilters): boolean {
  if (
    filters.riskLevels.length > 0 &&
    !filters.riskLevels.includes(well.risk_level ?? 'UNKNOWN')
  ) {
    return false;
  }

  if (
    filters.formations.length > 0 &&
    (!well.formation || !filters.formations.includes(well.formation))
  ) {
    return false;
  }

  if (filters.fields.length > 0 && (!well.field || !filters.fields.includes(well.field))) {
    return false;
  }

  if (filters.showWellFiOnly && !well.wellfi_device?.is_active) {
    return false;
  }

  if (filters.showFlaggedOnly && !isWellFlagged(well)) {
    return false;
  }

  if (filters.showNeedsToolOnly && !needsToolAssignment(well)) {
    return false;
  }

  if (filters.showScheduledSupportOnly && !hasScheduledSupport(well)) {
    return false;
  }

  if (filters.showDownNowOnly && !isWellDownNow(well)) {
    return false;
  }

  if (
    filters.minRateBblD > 0 &&
    (well.dec_rate_bbl_d == null || well.dec_rate_bbl_d < filters.minRateBblD)
  ) {
    return false;
  }

  return true;
}

export default function WellMap({
  wells,
  onWellClick,
  filters,
  flyToCoords,
  operatorSlug,
  showProductionOverlay = false,
  allowedProductionOperators = [],
}: WellMapProps) {
  const containerRef = useRef<HTMLDivElement>(null);
  const mapRef = useRef<mapboxgl.Map | null>(null);
  const popupRef = useRef<mapboxgl.Popup | null>(null);
  const [mapStyle, setMapStyle] = useState<MapStyle>('glass');
  const [mapLoaded, setMapLoaded] = useState(false);
  const [showGrid, setShowGrid] = useState(false);
  const [showClearwater, setShowClearwater] = useState(true);
  const [showBluesky, setShowBluesky] = useState(true);

  // Markers for highly recommended WellFi candidates
  const pulseMarkersRef = useRef<mapboxgl.Marker[]>([]);

  // Stable reference to wells for use in click handler
  const wellsRef = useRef<WellEnriched[]>(wells);
  wellsRef.current = wells;

  // Stable reference to onWellClick
  const onWellClickRef = useRef(onWellClick);
  onWellClickRef.current = onWellClick;

  const geojsonData = useMemo(() => wellsToGeoJSON(wells), [wells]);
  const geojsonRef = useRef(geojsonData);
  geojsonRef.current = geojsonData;

  // Initialize map
  useEffect(() => {
    if (!containerRef.current || mapRef.current) return;

    mapboxgl.accessToken = import.meta.env.VITE_MAPBOX_TOKEN as string;

    const map = new mapboxgl.Map({
      container: containerRef.current,
      style: STYLES[mapStyle],
      center: [-116.63, 56.16],
      zoom: 9,
      attributionControl: false,
    });

    map.addControl(new mapboxgl.NavigationControl(), 'bottom-right');
    map.addControl(new mapboxgl.AttributionControl({ compact: true }), 'bottom-right');

    map.on('load', () => {
      addHillshade(map);
      addDarkOverlay(map);
      addDLSGridLayers(map);
      addSourceAndLayers(map);
      addBaseWellLayers(map);

      // Production heatmap overlay (async, loads operator-scoped GeoJSON)
      const productionBeforeLayer =
        map.getLayer('parcel-health-glow') ? 'parcel-health-glow' :
        map.getLayer('mineral-rights-glow') ? 'mineral-rights-glow' :
        undefined;
      if (showProductionOverlay) {
        addProductionGlow(
          map,
          operatorSlug,
          allowedProductionOperators,
          productionBeforeLayer,
        )
        .then(() => {
          // ── Production dot hover ──────────────────────────────────────
          moveBaseWellLayersAboveHeatmap(map);
        })
        .catch(console.error);
      }

      addMonitoredAlertLayers(map);
      // Apply glassmorphic overlay in glass mode
      if (mapStyle === 'glass') {
        applyGlassmorphicStyle(map);
        applyGlassGridColors(map);
      }
      // Ensure map fills its container after initial render
      map.resize();
      setMapLoaded(true);
      // Initial grid update
      updateDLSGrid(map);
    });

    map.on('error', (e) => {
      console.error('[WellFi] Mapbox error:', e.error?.message ?? e);
    });

    // Update DLS grid on move/zoom
    map.on('moveend', () => {
      updateDLSGrid(map);
    });

    mapRef.current = map;

    return () => {
      setMapLoaded(false);
      popupRef.current?.remove();
      popupRef.current = null;
      pulseMarkersRef.current.forEach(m => m.remove());
      pulseMarkersRef.current = [];
      map.remove();
      mapRef.current = null;
    };
    // Re-create map when style changes
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [mapStyle]);

  // Sync candidate markers
  useEffect(() => {
    const map = mapRef.current;
    if (!map || !mapLoaded) return;

    // Clear existing
    pulseMarkersRef.current.forEach(m => m.remove());
    pulseMarkersRef.current = [];

    // Filter "highly recommended" candidates
    // e.g. running 14+ months, no wellfi device, not well_down
    const candidates = wells.filter(w => {
      const isDown = w.operational_status?.status === 'well_down';
      const noWellFi = !w.wellfi_device || !w.wellfi_device.is_active;
      const runningLong = (w.months_running ?? 0) >= 14;
      const hasCoords = typeof w.lon === 'number' && typeof w.lat === 'number' && w.lon !== 0 && w.lat !== 0;
      return matchesBaseWellFilters(w, filters) && !isDown && noWellFi && runningLong && hasCoords;
    });

    candidates.forEach(w => {
      const el = document.createElement('div');
      el.className = 'w-10 h-10 rounded-full border border-wellfi-cyan/50 bg-wellfi-cyan/20 wellfi-pulse pointer-events-none flex items-center justify-center';
      const inner = document.createElement('div');
      inner.className = 'w-2 h-2 rounded-full bg-wellfi-cyan shadow-[0_0_10px_rgba(0,212,255,0.8)]';
      el.appendChild(inner);

      const marker = new mapboxgl.Marker({ element: el })
        .setLngLat([w.lon, w.lat])
        .addTo(map);
      pulseMarkersRef.current.push(marker);
    });

    return () => {
      // Cleanup handled on unmount and before recreating
    };
  }, [filters, mapLoaded, wells]);

  // Add DLS grid sources and layers (empty initially)
  const addDLSGridLayers = useCallback((map: mapboxgl.Map) => {
    const emptyLines = { type: 'FeatureCollection' as const, features: [] };
    const emptyPoints = { type: 'FeatureCollection' as const, features: [] };

    // Township grid — bold lines
    map.addSource(DLS_TWP_LINES_SRC, { type: 'geojson', data: emptyLines });
    map.addLayer({
      id: DLS_TWP_LINES,
      type: 'line',
      source: DLS_TWP_LINES_SRC,
      paint: {
        'line-color': '#ffffff',
        'line-width': 1.5,
        'line-opacity': 0.5,
      },
    });

    map.addSource(DLS_TWP_LABELS_SRC, { type: 'geojson', data: emptyPoints });
    map.addLayer({
      id: DLS_TWP_LABELS,
      type: 'symbol',
      source: DLS_TWP_LABELS_SRC,
      layout: {
        'text-field': ['get', 'label'],
        'text-size': 13,
        'text-font': ['DIN Pro Medium', 'Arial Unicode MS Bold'],
        'text-allow-overlap': false,
        'text-ignore-placement': false,
      },
      paint: {
        'text-color': '#ffffff',
        'text-halo-color': '#000000',
        'text-halo-width': 1.5,
        'text-opacity': 0.8,
      },
    });

    // Section grid — medium lines
    map.addSource(DLS_SEC_LINES_SRC, { type: 'geojson', data: emptyLines });
    map.addLayer({
      id: DLS_SEC_LINES,
      type: 'line',
      source: DLS_SEC_LINES_SRC,
      paint: {
        'line-color': '#94a3b8',
        'line-width': 0.8,
        'line-opacity': 0.4,
      },
    });

    map.addSource(DLS_SEC_LABELS_SRC, { type: 'geojson', data: emptyPoints });
    map.addLayer({
      id: DLS_SEC_LABELS,
      type: 'symbol',
      source: DLS_SEC_LABELS_SRC,
      layout: {
        'text-field': ['get', 'label'],
        'text-size': 11,
        'text-font': ['DIN Pro Medium', 'Arial Unicode MS Bold'],
        'text-allow-overlap': false,
        'text-ignore-placement': false,
      },
      paint: {
        'text-color': '#cbd5e1',
        'text-halo-color': '#000000',
        'text-halo-width': 1,
        'text-opacity': 0.7,
      },
    });

    // LSD grid — thin lines
    map.addSource(DLS_LSD_LINES_SRC, { type: 'geojson', data: emptyLines });
    map.addLayer({
      id: DLS_LSD_LINES,
      type: 'line',
      source: DLS_LSD_LINES_SRC,
      paint: {
        'line-color': '#64748b',
        'line-width': 0.5,
        'line-opacity': 0.3,
        'line-dasharray': [3, 2],
      },
    });

    map.addSource(DLS_LSD_LABELS_SRC, { type: 'geojson', data: emptyPoints });
    map.addLayer({
      id: DLS_LSD_LABELS,
      type: 'symbol',
      source: DLS_LSD_LABELS_SRC,
      layout: {
        'text-field': ['get', 'label'],
        'text-size': 9,
        'text-font': ['DIN Pro Regular', 'Arial Unicode MS Regular'],
        'text-allow-overlap': false,
        'text-ignore-placement': false,
      },
      paint: {
        'text-color': '#94a3b8',
        'text-halo-color': '#000000',
        'text-halo-width': 0.8,
        'text-opacity': 0.6,
      },
    });
  }, []);

  // Update DLS grid data based on current map bounds and zoom
  const updateDLSGrid = useCallback((map: mapboxgl.Map) => {
    const bounds = map.getBounds();
    if (!bounds) return;

    const zoom = map.getZoom();
    const b = {
      west: bounds.getWest(),
      south: bounds.getSouth(),
      east: bounds.getEast(),
      north: bounds.getNorth(),
    };

    const grid = generateDLSGrid(b, zoom);

    // Update sources
    const setSource = (id: string, data: GeoJSON.FeatureCollection) => {
      const src = map.getSource(id) as mapboxgl.GeoJSONSource | undefined;
      if (src) src.setData(data);
    };

    setSource(DLS_TWP_LINES_SRC, grid.townshipLines);
    setSource(DLS_TWP_LABELS_SRC, grid.townshipLabels);
    setSource(DLS_SEC_LINES_SRC, grid.sectionLines);
    setSource(DLS_SEC_LABELS_SRC, grid.sectionLabels);
    setSource(DLS_LSD_LINES_SRC, grid.lsdLines);
    setSource(DLS_LSD_LABELS_SRC, grid.lsdLabels);
  }, []);

  // Toggle grid visibility
  useEffect(() => {
    const map = mapRef.current;
    if (!map || !mapLoaded) return;

    const visibility = showGrid ? 'visible' : 'none';
    const gridLayerIds = [
      DLS_TWP_LINES, DLS_TWP_LABELS,
      DLS_SEC_LINES, DLS_SEC_LABELS,
      DLS_LSD_LINES, DLS_LSD_LABELS,
    ];

    for (const id of gridLayerIds) {
      if (map.getLayer(id)) {
        map.setLayoutProperty(id, 'visibility', visibility);
      }
    }
  }, [showGrid, mapLoaded]);

  const hideMapPopup = useCallback(() => {
    popupRef.current?.remove();
    popupRef.current = null;
  }, []);

  const showWellFeaturePopup = useCallback(
    (map: mapboxgl.Map, lngLat: mapboxgl.LngLatLike, properties: Record<string, unknown>) => {
      const popup =
        popupRef.current ??
        new mapboxgl.Popup({
          closeButton: false,
          closeOnClick: false,
          closeOnMove: false,
          maxWidth: '320px',
          className: 'wellfi-popup',
          offset: 14,
        });

      popup
        .setLngLat(lngLat)
        .setHTML(wellPopupHTML(properties, { showViewDetails: false }))
        .addTo(map);

      popupRef.current = popup;
    },
    [],
  );

  const moveBaseWellLayersAboveHeatmap = useCallback((map: mapboxgl.Map) => {
    const firstProductionDotLayer = PRODUCTION_DOT_LAYER_IDS.find((layerId) => map.getLayer(layerId));

    for (const layerId of BASE_WELL_LAYER_IDS) {
      if (map.getLayer(layerId)) {
        if (firstProductionDotLayer) {
          map.moveLayer(layerId, firstProductionDotLayer);
        } else {
          map.moveLayer(layerId);
        }
      }
    }
  }, []);

  const moveMonitoredAlertLayersToTop = useCallback((map: mapboxgl.Map) => {
    for (const layerId of MONITORED_ALERT_LAYER_IDS) {
      if (map.getLayer(layerId)) {
        map.moveLayer(layerId);
      }
    }
  }, []);

  const addBaseWellLayers = useCallback(
    (map: mapboxgl.Map) => {
      if (!map.getSource(SOURCE_ID)) {
        return;
      }

      const baseFilter = buildBaseWellFilter(filters);
      const haloFilter = buildWellFiHaloFilter(filters);

      if (!map.getLayer(BASE_WELL_HALO_LAYER)) {
        map.addLayer({
          id: BASE_WELL_HALO_LAYER,
          type: 'circle',
          source: SOURCE_ID,
          filter: haloFilter,
          minzoom: 10,
          paint: {
            'circle-color': '#00D4FF',
            'circle-radius': [
              'interpolate',
              ['linear'],
              ['zoom'],
              10,
              5,
              13,
              8,
              16,
              11,
            ] as unknown as number,
            'circle-opacity': [
              'interpolate',
              ['linear'],
              ['zoom'],
              11,
              0,
              13,
              0.18,
            ] as unknown as number,
            'circle-blur': 0.7,
          },
        });
      }

      const addedBaseWellPoints = !map.getLayer(BASE_WELL_POINTS_LAYER);
      if (addedBaseWellPoints) {
        map.addLayer({
          id: BASE_WELL_POINTS_LAYER,
          type: 'circle',
          source: SOURCE_ID,
          ...(baseFilter ? { filter: baseFilter } : {}),
          minzoom: 10,
          paint: {
            'circle-color': WELL_COLOR_EXPRESSION as unknown as string,
            'circle-radius': WELL_SIZE_EXPRESSION as unknown as number,
            'circle-opacity': [
              'interpolate',
              ['linear'],
              ['zoom'],
              11,
              0,
              13,
              0.9,
            ] as unknown as number,
            'circle-stroke-color': WELL_STROKE_EXPRESSION as unknown as string,
            'circle-stroke-width': [
              'case',
              ['==', ['get', 'has_wellfi'], true],
              2,
              0.8,
            ] as unknown as number,
            'circle-stroke-opacity': [
              'interpolate',
              ['linear'],
              ['zoom'],
              11,
              0,
              13,
              1,
            ] as unknown as number,
          },
        });
      }

      moveBaseWellLayersAboveHeatmap(map);

      if (!addedBaseWellPoints) {
        return;
      }

      map.on('mouseenter', BASE_WELL_POINTS_LAYER, (e) => {
        map.getCanvas().style.cursor = 'pointer';
        const feature = e.features?.[0];
        if (!feature?.properties) {
          return;
        }
        showWellFeaturePopup(map, e.lngLat, feature.properties as Record<string, unknown>);
      });

      map.on('mousemove', BASE_WELL_POINTS_LAYER, (e) => {
        const feature = e.features?.[0];
        if (!feature?.properties) {
          return;
        }
        showWellFeaturePopup(map, e.lngLat, feature.properties as Record<string, unknown>);
      });

      map.on('mouseleave', BASE_WELL_POINTS_LAYER, () => {
        map.getCanvas().style.cursor = '';
        hideMapPopup();
      });

      map.on('click', BASE_WELL_POINTS_LAYER, (e) => {
        const feature = e.features?.[0];
        const wellId = feature?.properties?.id;
        if (typeof wellId !== 'string') {
          return;
        }

        const well = wellsRef.current.find((candidate) => candidate.id === wellId);
        if (well) {
          hideMapPopup();
          onWellClickRef.current(well);
        }
      });
    },
    [filters, hideMapPopup, moveBaseWellLayersAboveHeatmap, showWellFeaturePopup],
  );

  const addMonitoredAlertLayers = useCallback(
    (map: mapboxgl.Map) => {
      if (!map.getSource(SOURCE_ID)) {
        return;
      }

      if (!map.getLayer(MONITORED_ALERT_GLOW_LAYER)) {
        map.addLayer({
          id: MONITORED_ALERT_GLOW_LAYER,
          type: 'circle',
          source: SOURCE_ID,
          filter: MONITORED_ALERT_BASE_FILTER,
          paint: {
            'circle-color': MONITORED_ALERT_COLOR,
            'circle-radius': [
              'interpolate',
              ['linear'],
              ['zoom'],
              8,
              ['*', MONITORED_ALERT_RADIUS, 1.8],
              12,
              ['*', MONITORED_ALERT_RADIUS, 2.4],
            ],
            'circle-opacity': 0.22,
            'circle-blur': 0.8,
            'circle-stroke-width': 0,
          },
        });
      }

      const addedPointsLayer = !map.getLayer(MONITORED_ALERT_POINTS_LAYER);
      if (addedPointsLayer) {
        map.addLayer({
          id: MONITORED_ALERT_POINTS_LAYER,
          type: 'circle',
          source: SOURCE_ID,
          filter: MONITORED_ALERT_BASE_FILTER,
          paint: {
            'circle-color': MONITORED_ALERT_COLOR,
            'circle-radius': [
              'interpolate',
              ['linear'],
              ['zoom'],
              8,
              MONITORED_ALERT_RADIUS,
              12,
              ['*', MONITORED_ALERT_RADIUS, 1.2],
            ],
            'circle-stroke-color': '#020617',
            'circle-stroke-width': 2,
            'circle-opacity': 0.95,
          },
        });
      }

      moveMonitoredAlertLayersToTop(map);

      if (!addedPointsLayer) {
        return;
      }

      map.on('mouseenter', MONITORED_ALERT_POINTS_LAYER, (e) => {
        map.getCanvas().style.cursor = 'pointer';
        const feature = e.features?.[0];
        if (!feature?.properties) {
          return;
        }
        showWellFeaturePopup(map, e.lngLat, feature.properties as Record<string, unknown>);
      });

      map.on('mousemove', MONITORED_ALERT_POINTS_LAYER, (e) => {
        const feature = e.features?.[0];
        if (!feature?.properties) {
          return;
        }
        showWellFeaturePopup(map, e.lngLat, feature.properties as Record<string, unknown>);
      });

      map.on('mouseleave', MONITORED_ALERT_POINTS_LAYER, () => {
        map.getCanvas().style.cursor = '';
        hideMapPopup();
      });

      map.on('click', MONITORED_ALERT_POINTS_LAYER, (e) => {
        const feature = e.features?.[0];
        const wellId = feature?.properties?.id;
        if (typeof wellId !== 'string') {
          return;
        }

        const well = wellsRef.current.find((candidate) => candidate.id === wellId);
        if (well) {
          hideMapPopup();
          onWellClickRef.current(well);
        }
      });
    },
    [hideMapPopup, moveMonitoredAlertLayersToTop, showWellFeaturePopup],
  );


  // Add source helper (wells-source only, no dot layers)
  const addSourceAndLayers = useCallback((map: mapboxgl.Map) => {
    map.addSource(SOURCE_ID, {
      type: 'geojson',
      data: geojsonRef.current,
    });
  }, []);

  // Update source data when wells change
  useEffect(() => {
    const map = mapRef.current;
    if (!map || !mapLoaded) return;

    const source = map.getSource(SOURCE_ID) as mapboxgl.GeoJSONSource | undefined;
    if (source) {
      source.setData(geojsonData);
    }
  }, [geojsonData, mapLoaded]);

  // Apply filters when filters change
  useEffect(() => {
    const map = mapRef.current;
    if (!map || !mapLoaded) return;

    const baseFilter = buildBaseWellFilter(filters);
    const haloFilter = buildWellFiHaloFilter(filters);
    const monitoredAlertFilter = buildMonitoredAlertFilter(filters);

    if (map.getLayer(BASE_WELL_POINTS_LAYER)) {
      map.setFilter(BASE_WELL_POINTS_LAYER, baseFilter ?? null);
    }

    if (map.getLayer(BASE_WELL_HALO_LAYER)) {
      map.setFilter(BASE_WELL_HALO_LAYER, haloFilter);
    }

    for (const layerId of MONITORED_ALERT_LAYER_IDS) {
      if (map.getLayer(layerId)) {
        map.setFilter(layerId, monitoredAlertFilter);
      }
    }
  }, [filters, mapLoaded]);

  // Fly to coordinates when flyToCoords changes
  useEffect(() => {
    const map = mapRef.current;
    if (!map || !mapLoaded || !flyToCoords) return;

    map.flyTo({
      center: [flyToCoords.lng, flyToCoords.lat],
      zoom: 13,
      speed: 1.2,
      curve: 1.42,
    });
  }, [flyToCoords, mapLoaded]);

  // Reload production layers when operator context changes
  // AbortController prevents race conditions from rapid operator switching
  useEffect(() => {
    if (!mapRef.current || !mapLoaded) return;
    const map = mapRef.current;
    const abortController = new AbortController();

    removeProductionGlow(map);

    if (!showProductionOverlay) {
      return () => {
        abortController.abort();
      };
    }

    const beforeLayer = map.getLayer('parcel-health-glow') ? 'parcel-health-glow' :
      map.getLayer('mineral-rights-glow') ? 'mineral-rights-glow' :
      undefined;

    addProductionGlow(
      map,
      operatorSlug,
      allowedProductionOperators,
      beforeLayer,
      abortController.signal,
    )
      .then(() => {
        moveBaseWellLayersAboveHeatmap(map);
        moveMonitoredAlertLayersToTop(map);
      })
      .catch((err) => {
        if (err instanceof DOMException && err.name === 'AbortError') return;
        console.warn('ProductionGlow reload failed:', err);
      });

    return () => { abortController.abort(); };
  }, [
    allowedProductionOperators,
    mapLoaded,
    moveBaseWellLayersAboveHeatmap,
    moveMonitoredAlertLayersToTop,
    operatorSlug,
    showProductionOverlay,
  ]);

  // Add terrain DEM hillshade to reveal Peace River valley topography
  const addHillshade = useCallback((map: mapboxgl.Map) => {
    map.addSource('terrain-dem', {
      type: 'raster-dem',
      url: 'mapbox://mapbox.mapbox-terrain-dem-v1',
      tileSize: 512,
      maxzoom: 14,
    });

    map.addLayer({
      id: 'terrain-hillshade',
      type: 'hillshade',
      source: 'terrain-dem',
      paint: {
        'hillshade-exaggeration': 0.5,
        'hillshade-shadow-color': 'rgba(26, 35, 50, 0.4)',
        'hillshade-highlight-color': 'rgba(245, 240, 232, 0.2)',
        'hillshade-accent-color': '#1A2332',
        'hillshade-illumination-direction': 315,
      },
    });
  }, []);

  // Add dark overlay source + layer (dims base map for subsurface mode)
  const addDarkOverlay = useCallback((map: mapboxgl.Map) => {
    map.addSource(DARK_OVERLAY_SRC, {
      type: 'geojson',
      data: {
        type: 'Feature',
        geometry: {
          type: 'Polygon',
          coordinates: [[[-180, -90], [180, -90], [180, 90], [-180, 90], [-180, -90]]],
        },
        properties: {},
      },
    });

    map.addLayer({
      id: DARK_OVERLAY_LAYER,
      type: 'fill',
      source: DARK_OVERLAY_SRC,
      paint: {
        'fill-color': '#000812',
        'fill-opacity': 0.35,
        'fill-opacity-transition': { duration: 600, delay: 0 },
      },
    });
  }, []);

  // Switch map style
  const handleStyleChange = useCallback((style: MapStyle) => {
    setMapStyle(style);
  }, []);

  // Toggle grid
  const toggleGrid = useCallback(() => {
    setShowGrid((s) => !s);
  }, []);

  // Apply glass-themed colors to DLS grid layers
  const applyGlassGridColors = useCallback((map: mapboxgl.Map) => {
    if (map.getLayer(DLS_TWP_LINES)) {
      map.setPaintProperty(DLS_TWP_LINES, 'line-color', GLASS_COLORS.gridTownship);
    }
    if (map.getLayer(DLS_TWP_LABELS)) {
      map.setPaintProperty(DLS_TWP_LABELS, 'text-color', GLASS_COLORS.gridTownshipLabel);
      map.setPaintProperty(DLS_TWP_LABELS, 'text-halo-color', GLASS_COLORS.gridHalo);
    }
    if (map.getLayer(DLS_SEC_LINES)) {
      map.setPaintProperty(DLS_SEC_LINES, 'line-color', GLASS_COLORS.gridSection);
    }
    if (map.getLayer(DLS_SEC_LABELS)) {
      map.setPaintProperty(DLS_SEC_LABELS, 'text-color', GLASS_COLORS.gridSectionLabel);
      map.setPaintProperty(DLS_SEC_LABELS, 'text-halo-color', GLASS_COLORS.gridHalo);
    }
    if (map.getLayer(DLS_LSD_LINES)) {
      map.setPaintProperty(DLS_LSD_LINES, 'line-color', GLASS_COLORS.gridLsd);
    }
    if (map.getLayer(DLS_LSD_LABELS)) {
      map.setPaintProperty(DLS_LSD_LABELS, 'text-color', GLASS_COLORS.gridLsdLabel);
      map.setPaintProperty(DLS_LSD_LABELS, 'text-halo-color', GLASS_COLORS.gridHalo);
    }
  }, []);

  return (
    <div className="relative w-full h-full">
      {/* Map container */}
      <div ref={containerRef} className="absolute inset-0" />

      {/* Top-right controls — glassmorphic, responsive */}
      <div className="absolute top-3 right-3 z-10 flex gap-1 sm:gap-1.5">
        {/* Grid toggle */}
        <button
          onClick={toggleGrid}
          className={`min-h-[44px] min-w-[44px] sm:min-h-0 sm:min-w-0 px-2 sm:px-3 py-2 sm:py-1.5 rounded-lg text-xs font-medium border backdrop-blur-md transition-all duration-200 flex items-center justify-center ${
            showGrid
              ? 'bg-wellfi-cyan/15 text-wellfi-cyan border-wellfi-cyan/25 shadow-[0_0_15px_-3px_rgba(0,212,255,0.15)]'
              : 'bg-white/[0.04] text-gray-500 border-white/[0.08] hover:bg-white/[0.06] hover:text-gray-300'
          }`}
          title="Toggle LSD grid overlay"
        >
          <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="inline-block sm:mr-1 -mt-0.5">
            <rect x="3" y="3" width="18" height="18" rx="2" />
            <line x1="3" x2="21" y1="9" y2="9" />
            <line x1="3" x2="21" y1="15" y2="15" />
            <line x1="9" x2="9" y1="3" y2="21" />
            <line x1="15" x2="15" y1="3" y2="21" />
          </svg>
          <span className="hidden sm:inline">LSD</span>
        </button>

        {showProductionOverlay && (
          <>
            {/* Clearwater formation heatmap toggle */}
            <button
              onClick={() => {
                const next = !showClearwater;
                setShowClearwater(next);
                if (mapRef.current) {
                  setFormationHeatmapVisibility(mapRef.current, 'Clearwater', next);
                }
              }}
              className={`min-h-[44px] min-w-[44px] sm:min-h-0 sm:min-w-0 px-2 sm:px-3 py-2 sm:py-1.5 rounded-lg text-xs font-medium border backdrop-blur-md transition-all duration-200 flex items-center justify-center ${
                showClearwater
                  ? 'bg-green-500/15 text-green-400 border-green-500/25 shadow-[0_0_15px_-3px_rgba(34,197,94,0.15)]'
                  : 'bg-white/[0.04] text-gray-500 border-white/[0.08] hover:bg-white/[0.06] hover:text-gray-300'
              }`}
              title="Toggle Clearwater production heatmap"
            >
              CW
            </button>

            {/* Bluesky formation heatmap toggle */}
            <button
              onClick={() => {
                const next = !showBluesky;
                setShowBluesky(next);
                if (mapRef.current) {
                  setFormationHeatmapVisibility(mapRef.current, 'Bluesky', next);
                }
              }}
              className={`min-h-[44px] min-w-[44px] sm:min-h-0 sm:min-w-0 px-2 sm:px-3 py-2 sm:py-1.5 rounded-lg text-xs font-medium border backdrop-blur-md transition-all duration-200 flex items-center justify-center ${
                showBluesky
                  ? 'bg-amber-500/15 text-amber-400 border-amber-500/25 shadow-[0_0_15px_-3px_rgba(245,158,11,0.15)]'
                  : 'bg-white/[0.04] text-gray-500 border-white/[0.08] hover:bg-white/[0.06] hover:text-gray-300'
              }`}
              title="Toggle Bluesky production heatmap"
            >
              BS
            </button>
          </>
        )}

        {/* Style switcher — 2-way */}
        <div className="flex rounded-lg overflow-hidden border border-white/[0.08] shadow-lg backdrop-blur-md">
          {(['satellite', 'glass'] as const).map((style) => (
            <button
              key={style}
              onClick={() => handleStyleChange(style)}
              className={`min-h-[44px] sm:min-h-0 px-2 sm:px-3 py-2 sm:py-1.5 text-xs font-medium transition-all duration-200 ${
                mapStyle === style
                  ? 'bg-wellfi-cyan/15 text-wellfi-cyan'
                  : 'bg-white/[0.03] text-gray-500 hover:text-gray-300 hover:bg-white/[0.05]'
              } ${style === 'satellite' ? 'border-r border-white/[0.08]' : ''}`}
              title={style === 'glass' ? 'Glassmorphic dark map' : 'Satellite imagery'}
            >
              <span className="hidden sm:inline">{style === 'glass' ? 'Glass' : 'Satellite'}</span>
              <span className="sm:hidden">{style === 'glass' ? 'G' : 'S'}</span>
            </button>
          ))}
        </div>
      </div>

      {/* Legend — bottom left — glassmorphic */}
      <div className="absolute bottom-20 lg:bottom-6 left-3 z-10 bg-[#080D16]/90 backdrop-blur-xl border border-white/[0.06] rounded-xl p-3 text-xs shadow-2xl shadow-black/30">
        {showProductionOverlay && (
          <>
            <div className="text-gray-500 font-semibold mb-2 text-[10px] uppercase tracking-wider">
              Production Overlay
            </div>
            <div className="mb-2 text-[10px] text-gray-500">
              Heatmap at basin scale, matching colored dots at close zoom.
            </div>
            <div className="flex flex-col gap-1.5">
              <div className="flex items-center gap-2">
                <span className="inline-block w-2.5 h-2.5 rounded-sm shrink-0" style={{ background: '#22C55E' }} />
                <span className="text-gray-400">Clearwater Oil</span>
              </div>
              <div className="flex items-center gap-2">
                <span className="inline-block w-2.5 h-2.5 rounded-sm shrink-0" style={{ background: '#86EFAC' }} />
                <span className="text-gray-400">Clearwater Gas</span>
              </div>
              <div className="flex items-center gap-2">
                <span className="inline-block w-2.5 h-2.5 rounded-sm shrink-0" style={{ background: '#F59E0B' }} />
                <span className="text-gray-400">Bluesky Oil</span>
              </div>
              <div className="flex items-center gap-2">
                <span className="inline-block w-2.5 h-2.5 rounded-sm shrink-0" style={{ background: '#FCD34D' }} />
                <span className="text-gray-400">Bluesky Gas</span>
              </div>
            </div>
          </>
        )}
        <div className={showProductionOverlay ? 'border-t border-white/[0.06] mt-2.5 pt-2.5' : ''}>
          <div className="text-gray-500 font-semibold mb-2 text-[10px] uppercase tracking-wider">
            Base Wells
          </div>
          <div className="flex flex-col gap-1.5">
            <div className="flex items-center gap-2">
              <span className="inline-block w-2.5 h-2.5 rounded-full shrink-0 bg-amber-500" />
              <span className="text-gray-400">Dots come from live WellFi well data</span>
            </div>
            <div className="flex items-center gap-2">
              <span className="inline-block w-3 h-3 rounded-full shrink-0 border border-cyan-400/70" style={{ boxShadow: '0 0 8px rgba(0,212,255,0.35)' }} />
              <span className="text-gray-400">Cyan halo = active WellFi device</span>
            </div>
          </div>
        </div>
        <div className="border-t border-white/[0.06] mt-2.5 pt-2.5">
          <div className="text-gray-500 font-semibold mb-2 text-[10px] uppercase tracking-wider">
            Alert Overlay
          </div>
          <div className="flex flex-col gap-1.5">
            <div className="flex items-center gap-2">
              <span className="inline-block w-2.5 h-2.5 rounded-full shrink-0 border-2 border-blue-500" style={{ background: 'transparent' }} />
              <span className="text-gray-400">Watch</span>
            </div>
            <div className="flex items-center gap-2">
              <span className="inline-block w-2.5 h-2.5 rounded-full shrink-0 border-2 border-yellow-400" style={{ background: 'transparent' }} />
              <span className="text-gray-400">Warning</span>
            </div>
            <div className="flex items-center gap-2">
              <span className="inline-block w-2.5 h-2.5 rounded-full shrink-0 border-2 border-red-500" style={{ background: 'transparent' }} />
              <span className="text-gray-400">Well Down</span>
            </div>
          </div>
        </div>
      </div>

      {/* Popup dark theme override */}
      <style>{POPUP_CSS}</style>
    </div>
  );
}

// Glassmorphic popup styling
const POPUP_CSS = `
  .wellfi-popup .mapboxgl-popup-content {
    background: rgba(8, 13, 22, 0.92) !important;
    border: 1px solid rgba(255, 255, 255, 0.06) !important;
    border-radius: 12px !important;
    padding: 14px !important;
    box-shadow: 0 8px 40px rgba(0,0,0,0.5), 0 0 20px rgba(0,212,255,0.03) !important;
    backdrop-filter: blur(20px) !important;
    -webkit-backdrop-filter: blur(20px) !important;
  }
  .wellfi-popup .mapboxgl-popup-tip {
    border-top-color: rgba(8, 13, 22, 0.92) !important;
    border-bottom-color: rgba(8, 13, 22, 0.92) !important;
  }
  .wellfi-popup .mapboxgl-popup-close-button {
    color: #64748b !important;
    font-size: 18px !important;
    right: 6px !important;
    top: 4px !important;
  }
  .wellfi-popup .mapboxgl-popup-close-button:hover {
    color: #e2e8f0 !important;
    background: transparent !important;
  }
`;
