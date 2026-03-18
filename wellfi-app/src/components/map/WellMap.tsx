import 'mapbox-gl/dist/mapbox-gl.css';

import { useRef, useEffect, useState, useCallback, useMemo } from 'react';
import mapboxgl from 'mapbox-gl';
import type { MapFilters } from '@/types';
import type { WellEnriched } from '@/types/operationalStatus';
import { wellsToGeoJSON, HEALTH_LEVEL_LABELS } from '@/lib/mapUtils';
import { generateDLSGrid } from '@/lib/dlsGrid';
import { addHealthHeatmap, setHealthHeatmapVisibility } from './HealthHeatmap';
import { applyGlassmorphicStyle, GLASS_COLORS } from './glassmorphicStyle';
import { assignWellsToParcels, computeParcelCentroids, generateSyntheticParcels } from '@/lib/parcelHealth';
import type { ParcelHealth } from '@/lib/parcelHealth';
import { addParcelLayers, updateParcelHealth, updateParcelData, setupParcelInteraction, setParcelVisibility } from './ParcelLayers';
import { wellPopupHTML } from './WellPopup';
import { addProductionGlow, setFormationHeatmapVisibility, PRODUCTION_LAYER_IDS } from './ProductionGlow';
import { productionDotPopupHTML } from './ProductionPopup';

interface WellMapProps {
  wells: WellEnriched[];
  onWellClick: (well: WellEnriched) => void;
  filters: MapFilters;
  flyToCoords?: { lng: number; lat: number } | null;
}

const STYLES = {
  satellite: 'mapbox://styles/mapbox/satellite-streets-v12',
  glass: 'mapbox://styles/mapbox/dark-v11',
} as const;

type MapStyle = keyof typeof STYLES;

// Well source ID (kept for heatmap)
const SOURCE_ID = 'wells-source';

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

// Health heatmap layer ID (must match HealthHeatmap.ts)
const HEALTH_HEATMAP_LAYER = 'health-heatmap';
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

function buildBaseWellFilter(filters: MapFilters): mapboxgl.Expression | null {
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

  if (filters.showUpcomingOnly) {
    conditions.push(['==', ['get', 'has_upcoming_change'], true]);
  }

  if (filters.minRateBblD > 0) {
    conditions.push(['>=', ['get', 'dec_rate_bbl_d'], filters.minRateBblD]);
  }

  if (conditions.length === 0) {
    return null;
  }

  return conditions.length === 1 ? conditions[0] : ['all', ...conditions];
}

function buildMonitoredAlertFilter(filters: MapFilters): mapboxgl.Expression {
  const baseFilter = buildBaseWellFilter(filters);
  return baseFilter ? ['all', MONITORED_ALERT_BASE_FILTER, baseFilter] : MONITORED_ALERT_BASE_FILTER;
}

export default function WellMap({ wells, onWellClick, filters, flyToCoords }: WellMapProps) {
  const containerRef = useRef<HTMLDivElement>(null);
  const mapRef = useRef<mapboxgl.Map | null>(null);
  const popupRef = useRef<mapboxgl.Popup | null>(null);
  const [mapStyle, setMapStyle] = useState<MapStyle>('glass');
  const [mapLoaded, setMapLoaded] = useState(false);
  const [showGrid, setShowGrid] = useState(false);
  const [showProduction, setShowProduction] = useState(true);
  const [showLand, setShowLand] = useState(true);
  const [showClearwater, setShowClearwater] = useState(true);
  const [showBluesky, setShowBluesky] = useState(true);

  // Markers for highly recommended WellFi candidates
  const pulseMarkersRef = useRef<mapboxgl.Marker[]>([]);

  // Parcel data refs
  const mineralRightsRef = useRef<GeoJSON.FeatureCollection | null>(null);
  const parcelsRef = useRef<GeoJSON.FeatureCollection | null>(null);
  const healthMapRef = useRef<Map<number, ParcelHealth>>(new Map());

  // Stable reference to wells for use in click handler
  const wellsRef = useRef<WellEnriched[]>(wells);
  wellsRef.current = wells;

  // Stable reference to onWellClick
  const onWellClickRef = useRef(onWellClick);
  onWellClickRef.current = onWellClick;

  // Build operational status map: well UUID -> status type string
  const opStatusByWellId = useMemo(() => {
    const m = new Map<string, string>();
    for (const w of wells) {
      if (w.operational_status?.is_active && w.operational_status.status) {
        m.set(w.id, w.operational_status.status);
      }
    }
    return m;
  }, [wells]);

  const opStatusRef = useRef(opStatusByWellId);
  opStatusRef.current = opStatusByWellId;
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
      addHealthHeatmap(map);

      // Production glow for Clearwater/Bluesky wells (async, loads GeoJSON)
      const productionBeforeLayer =
        map.getLayer('parcel-health-glow') ? 'parcel-health-glow' :
        map.getLayer('mineral-rights-glow') ? 'mineral-rights-glow' :
        undefined;
      addProductionGlow(map, productionBeforeLayer)
        .then(() => {
          // ── Production dot hover ──────────────────────────────────────
          map.on('mouseenter', PRODUCTION_LAYER_IDS.dots, (e) => {
            map.getCanvas().style.cursor = 'pointer';
            if (!e.features?.[0]) return;

            const props = e.features[0].properties ?? {};
            const coords = (e.features[0].geometry as GeoJSON.Point).coordinates.slice() as [number, number];

            popupRef.current?.remove();

            popupRef.current = new mapboxgl.Popup({
              closeButton: false,
              closeOnClick: false,
              maxWidth: '280px',
              className: 'wellfi-popup',
              offset: 10,
            })
              .setLngLat(coords)
              .setHTML(productionDotPopupHTML(props))
              .addTo(map);
          });

          map.on('mouseleave', PRODUCTION_LAYER_IDS.dots, () => {
            map.getCanvas().style.cursor = '';
            popupRef.current?.remove();
            popupRef.current = null;
          });
        })
        .catch(console.error);

      addMonitoredAlertLayers(map);
      loadParcels(map);
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
      return !isDown && noWellFi && runningLong && hasCoords;
    });

    // Create markers (only if showProduction is active to reduce clutter)
    if (showProduction) {
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
    }

    return () => {
      // Cleanup handled on unmount and before recreating
    };
  }, [wells, mapLoaded, showProduction]);

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

  // Health Heatmap + dark overlay visibility toggle
  useEffect(() => {
    const map = mapRef.current;
    if (!map || !mapLoaded) return;

    setHealthHeatmapVisibility(map, showProduction);

    if (map.getLayer(DARK_OVERLAY_LAYER)) {
      map.setPaintProperty(DARK_OVERLAY_LAYER, 'fill-opacity', showProduction ? 0.5 : 0);
    }
  }, [showProduction, mapLoaded]);

  // Toggle parcel visibility
  useEffect(() => {
    const map = mapRef.current;
    if (!map || !mapLoaded) return;
    setParcelVisibility(map, showLand);
  }, [showLand, mapLoaded]);

  // Compute parcel health, generate synthetic parcels for orphans, update map
  const runHealthComputation = useCallback((map: mapboxgl.Map, currentWells: WellEnriched[], opStatusMap?: Map<string, string>) => {
    const mineralRights = mineralRightsRef.current;
    if (!mineralRights) return;

    // Step 1: Assign wells to real mineral rights parcels
    const { healthMap, orphanWells } = assignWellsToParcels(currentWells, mineralRights);

    // Step 2: Generate synthetic parcels at runtime for orphan wells
    const syntheticCollection = generateSyntheticParcels(orphanWells);
    const syntheticFeatures = syntheticCollection.features.map((f) => ({
      ...f,
      geometry: {
        type: 'MultiPolygon' as const,
        coordinates: [f.geometry.coordinates] as GeoJSON.Position[][][],
      },
    }));

    // Step 3: Merge mineral rights + synthetic parcels
    const merged: GeoJSON.FeatureCollection = {
      type: 'FeatureCollection',
      features: [...mineralRights.features, ...syntheticFeatures],
    };
    parcelsRef.current = merged;

    // Step 4: Update map source with merged data (Mapbox reassigns generateId IDs)
    updateParcelData(map, merged);

    // Step 5: Add health entries for orphan wells (each synthetic parcel has exactly 1 well)
    const baseIndex = mineralRights.features.length;
    for (let i = 0; i < orphanWells.length; i++) {
      const well = orphanWells[i];
      const featureId = baseIndex + i;
      healthMap.set(featureId, {
        wellCount: 1,
        wellFiCount: well.wellfi_device != null && well.wellfi_device.is_active ? 1 : 0,
        avgMonthsRunning: well.months_running ?? 0,
        maxMonthsRunning: well.months_running ?? 0,
        hasUpcomingChange: well.active_pump_change != null,
        wells: [{
          id: well.id,
          name: well.name,
          wellId: well.well_id,
          monthsRunning: well.months_running ?? 0,
          hasWellfi: well.wellfi_device != null && well.wellfi_device.is_active,
          riskLevel: well.risk_level,
          formation: well.formation,
        }],
      });
    }
    healthMapRef.current = healthMap;

    // Step 6: Compute centroids and enrich labels
    const centroids = computeParcelCentroids(merged);
    for (const feature of centroids.features) {
      const id = feature.properties?.featureIndex as number;
      const h = healthMap.get(id);
      if (h && h.wellCount > 0) {
        feature.properties = {
          ...feature.properties,
          label: `${h.wellCount} wells | ${h.avgMonthsRunning.toFixed(1)}mo${h.wellFiCount > 0 ? ` | ${h.wellFiCount} WF` : ''}`,
        };
      } else {
        feature.properties = { ...feature.properties, label: '' };
      }
    }

    updateParcelHealth(map, healthMap, centroids, opStatusMap);
  }, []);

  const hideMonitoringPopup = useCallback(() => {
    popupRef.current?.remove();
    popupRef.current = null;
  }, []);

  const showMonitoringPopup = useCallback(
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

  const moveMonitoredAlertLayersToTop = useCallback((map: mapboxgl.Map) => {
    for (const layerId of MONITORED_ALERT_LAYER_IDS) {
      if (map.getLayer(layerId)) {
        map.moveLayer(layerId);
      }
    }
  }, []);

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
        showMonitoringPopup(map, e.lngLat, feature.properties as Record<string, unknown>);
      });

      map.on('mousemove', MONITORED_ALERT_POINTS_LAYER, (e) => {
        const feature = e.features?.[0];
        if (!feature?.properties) {
          return;
        }
        showMonitoringPopup(map, e.lngLat, feature.properties as Record<string, unknown>);
      });

      map.on('mouseleave', MONITORED_ALERT_POINTS_LAYER, () => {
        map.getCanvas().style.cursor = '';
        hideMonitoringPopup();
      });

      map.on('click', MONITORED_ALERT_POINTS_LAYER, (e) => {
        const feature = e.features?.[0];
        const wellId = feature?.properties?.id;
        if (typeof wellId !== 'string') {
          return;
        }

        const well = wellsRef.current.find((candidate) => candidate.id === wellId);
        if (well) {
          hideMonitoringPopup();
          onWellClickRef.current(well);
        }
      });
    },
    [hideMonitoringPopup, moveMonitoredAlertLayersToTop, showMonitoringPopup],
  );

  // Load mineral rights and add parcel layers (synthetic parcels generated at runtime)
  const loadParcels = useCallback((map: mapboxgl.Map) => {
    fetch('/data/obsidian-mineral-rights.geojson')
      .then((r) => r.json())
      .then((mineralRights: GeoJSON.FeatureCollection) => {
        // Normalize all geometries to MultiPolygon for consistency
        for (const feature of mineralRights.features) {
          if (feature.geometry.type === 'Polygon') {
            feature.geometry = {
              type: 'MultiPolygon',
              coordinates: [(feature.geometry as GeoJSON.Polygon).coordinates],
            };
          }
        }

        // Store mineral rights (synthetic parcels added dynamically in runHealthComputation)
        mineralRightsRef.current = mineralRights;

        // Add parcel layers with mineral rights only initially
        const centroids = computeParcelCentroids(mineralRights);
        addParcelLayers(map, mineralRights, centroids, DLS_TWP_LINES);
        moveMonitoredAlertLayersToTop(map);

        // Set up parcel interaction (hover + click)
        setupParcelInteraction(map, {
          onWellClick: (wellId: string) => {
            const well = wellsRef.current.find((w) => w.id === wellId);
            if (well) onWellClickRef.current(well);
          },
          getParcelHealth: (featureId: number) => healthMapRef.current.get(featureId),
          getOpStatusByWellId: () => opStatusRef.current,
        });

        // Run initial health computation if wells are already available
        if (wellsRef.current.length > 0) {
          runHealthComputation(map, wellsRef.current, opStatusRef.current);
        }
      })
      .catch((err) => {
        console.warn('[WellFi] Failed to load parcels:', err);
      });
  }, [moveMonitoredAlertLayersToTop, runHealthComputation]);

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

  // Recompute parcel health when wells or operational statuses change
  useEffect(() => {
    const map = mapRef.current;
    if (!map || !mapLoaded || !mineralRightsRef.current || wells.length === 0) return;

    runHealthComputation(map, wells, opStatusByWellId);
  }, [wells, mapLoaded, opStatusByWellId, runHealthComputation]);

  // Apply filters when filters change
  useEffect(() => {
    const map = mapRef.current;
    if (!map || !mapLoaded) return;

    const filterExpr = buildBaseWellFilter(filters);
    const monitoredAlertFilter = buildMonitoredAlertFilter(filters);

    // Apply filter to health heatmap layer
    if (map.getLayer(HEALTH_HEATMAP_LAYER)) {
      map.setFilter(HEALTH_HEATMAP_LAYER, filterExpr);
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

  // Toggle health heatmap glow
  const toggleProduction = useCallback(() => {
    setShowProduction((s) => !s);
  }, []);

  // Toggle parcel land overlay
  const toggleLand = useCallback(() => {
    setShowLand((s) => !s);
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
        {/* Land (parcel health) toggle */}
        <button
          onClick={toggleLand}
          className={`min-h-[44px] min-w-[44px] sm:min-h-0 sm:min-w-0 px-2 sm:px-3 py-2 sm:py-1.5 rounded-lg text-xs font-medium border backdrop-blur-md transition-all duration-200 flex items-center justify-center ${
            showLand
              ? 'bg-wellfi-cyan/15 text-wellfi-cyan border-wellfi-cyan/25 shadow-[0_0_15px_-3px_rgba(0,212,255,0.15)]'
              : 'bg-white/[0.04] text-gray-500 border-white/[0.08] hover:bg-white/[0.06] hover:text-gray-300'
          }`}
          title="Toggle parcel health overlay"
        >
          <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="inline-block sm:mr-1 -mt-0.5">
            <path d="M12 22s-8-4.5-8-11.8A8 8 0 0 1 12 2a8 8 0 0 1 8 8.2c0 7.3-8 11.8-8 11.8z" />
            <circle cx="12" cy="10" r="3" />
          </svg>
          <span className="hidden sm:inline">Land</span>
        </button>

        {/* Health Heatmap Glow toggle */}
        <button
          onClick={toggleProduction}
          className={`min-h-[44px] min-w-[44px] sm:min-h-0 sm:min-w-0 px-2 sm:px-3 py-2 sm:py-1.5 rounded-lg text-xs font-medium border backdrop-blur-md transition-all duration-200 flex items-center justify-center ${
            showProduction
              ? 'bg-wellfi-cyan/15 text-wellfi-cyan border-wellfi-cyan/25 shadow-[0_0_15px_-3px_rgba(0,212,255,0.15)]'
              : 'bg-white/[0.04] text-gray-500 border-white/[0.08] hover:bg-white/[0.06] hover:text-gray-300'
          }`}
          title="Toggle health heatmap glow"
        >
          <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="inline-block sm:mr-1 -mt-0.5">
            <circle cx="12" cy="12" r="5" />
            <line x1="12" x2="12" y1="1" y2="3" />
            <line x1="12" x2="12" y1="21" y2="23" />
            <line x1="4.22" x2="5.64" y1="4.22" y2="5.64" />
            <line x1="18.36" x2="19.78" y1="18.36" y2="19.78" />
            <line x1="1" x2="3" y1="12" y2="12" />
            <line x1="21" x2="23" y1="12" y2="12" />
            <line x1="4.22" x2="5.64" y1="19.78" y2="18.36" />
            <line x1="18.36" x2="19.78" y1="5.64" y2="4.22" />
          </svg>
          <span className="hidden sm:inline">Glow</span>
        </button>

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

      {/* Legend — bottom left — glassmorphic (pushed up on mobile to avoid FAB overlap) */}
      <div className="absolute bottom-20 lg:bottom-6 left-3 z-10 bg-[#080D16]/90 backdrop-blur-xl border border-white/[0.06] rounded-xl p-3 text-xs shadow-2xl shadow-black/30">
        <div className="text-gray-500 font-semibold mb-2 text-[10px] uppercase tracking-wider">
          Health Zones
        </div>
        <div className="flex flex-col gap-1.5">
          {HEALTH_LEVEL_LABELS.filter(item => item.level < 10).map((item) => (
            <div key={item.label} className="flex items-center gap-2">
              <span
                className="inline-block w-2.5 h-2.5 rounded-sm shrink-0"
                style={{ background: item.color }}
              />
              <span className="text-gray-400">{item.label}</span>
            </div>
          ))}
        </div>
        {/* Operational status legend */}
        <div className="border-t border-white/[0.06] mt-2.5 pt-2.5">
          <div className="text-gray-500 font-semibold mb-2 text-[10px] uppercase tracking-wider">
            Operational
          </div>
          <div className="flex flex-col gap-1.5">
            {HEALTH_LEVEL_LABELS.filter(item => item.level >= 10).map((item) => (
              <div key={item.label} className="flex items-center gap-2">
                <span
                  className="inline-block w-2.5 h-2.5 rounded-full shrink-0"
                  style={{ background: item.color }}
                />
                <span className="text-gray-400">{item.label}</span>
              </div>
            ))}
          </div>
          <div className="mt-2 text-[10px] leading-relaxed text-gray-500">
            Alert dots appear only on wells with an active WellFi device.
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
