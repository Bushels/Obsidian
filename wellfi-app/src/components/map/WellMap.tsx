import 'mapbox-gl/dist/mapbox-gl.css';

import { useRef, useEffect, useState, useCallback } from 'react';
import mapboxgl from 'mapbox-gl';
import type { Well, MapFilters } from '@/types';
import {
  wellsToGeoJSON,
  WELL_COLOR_EXPRESSION,
  WELL_SIZE_EXPRESSION,
  WELL_STROKE_EXPRESSION,
} from '@/lib/mapUtils';
import { wellPopupHTML } from '@/components/map/WellPopup';
import { generateDLSGrid } from '@/lib/dlsGrid';
import {
  addFormationLayers,
  setFormationVisibility,
} from '@/components/map/FormationOverlay';

interface WellMapProps {
  wells: Well[];
  onWellClick: (well: Well) => void;
  filters: MapFilters;
  flyToCoords?: { lng: number; lat: number } | null;
}

const STYLES = {
  satellite: 'mapbox://styles/mapbox/satellite-streets-v12',
  dark: 'mapbox://styles/mapbox/dark-v11',
} as const;

type MapStyle = keyof typeof STYLES;

// Well layer IDs
const SOURCE_ID = 'wells-source';
const LAYER_DOTS = 'wells-dots';
const LAYER_STROKES = 'wells-strokes';
const LAYER_HALO = 'wells-wellfi-halo';

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

export default function WellMap({ wells, onWellClick, filters, flyToCoords }: WellMapProps) {
  const containerRef = useRef<HTMLDivElement>(null);
  const mapRef = useRef<mapboxgl.Map | null>(null);
  const popupRef = useRef<mapboxgl.Popup | null>(null);
  const [mapStyle, setMapStyle] = useState<MapStyle>('satellite');
  const [mapLoaded, setMapLoaded] = useState(false);
  const [showGrid, setShowGrid] = useState(true);
  const [showFormations, setShowFormations] = useState(true);

  // Stable reference to wells for use in click handler
  const wellsRef = useRef<Well[]>(wells);
  wellsRef.current = wells;

  // Stable reference to onWellClick
  const onWellClickRef = useRef(onWellClick);
  onWellClickRef.current = onWellClick;

  // Initialize map
  useEffect(() => {
    if (!containerRef.current) return;

    mapboxgl.accessToken = import.meta.env.VITE_MAPBOX_TOKEN as string;

    const map = new mapboxgl.Map({
      container: containerRef.current,
      style: STYLES[mapStyle],
      center: [-116.63, 56.16],
      zoom: 9,
      attributionControl: false,
    });

    map.addControl(new mapboxgl.NavigationControl(), 'top-left');
    map.addControl(new mapboxgl.AttributionControl({ compact: true }), 'bottom-right');

    map.on('load', () => {
      addHillshade(map);
      addDarkOverlay(map);
      addFormationLayers(map);
      addDLSGridLayers(map);
      addSourceAndLayers(map);
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
      map.remove();
      mapRef.current = null;
    };
    // Re-create map when style changes
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [mapStyle]);

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

  // Formation + dark overlay visibility toggle
  useEffect(() => {
    const map = mapRef.current;
    if (!map || !mapLoaded) return;

    setFormationVisibility(map, showFormations);

    if (map.getLayer(DARK_OVERLAY_LAYER)) {
      map.setPaintProperty(DARK_OVERLAY_LAYER, 'fill-opacity', showFormations ? 0.35 : 0);
    }
  }, [showFormations, mapLoaded]);

  // Add source + layers helper
  const addSourceAndLayers = useCallback((map: mapboxgl.Map) => {
    const geojson = wellsToGeoJSON(wellsRef.current);

    map.addSource(SOURCE_ID, {
      type: 'geojson',
      data: geojson,
    });

    // WellFi halo ring (static cyan stroke, behind dots)
    map.addLayer({
      id: LAYER_HALO,
      type: 'circle',
      source: SOURCE_ID,
      filter: ['==', ['get', 'has_wellfi'], true],
      paint: {
        'circle-radius': ['+', WELL_SIZE_EXPRESSION, 4] as mapboxgl.Expression,
        'circle-color': 'transparent',
        'circle-stroke-width': 2,
        'circle-stroke-color': '#00D4FF',
        'circle-stroke-opacity': 0.7,
      },
    });

    // Stroke layer
    map.addLayer({
      id: LAYER_STROKES,
      type: 'circle',
      source: SOURCE_ID,
      paint: {
        'circle-radius': ['+', WELL_SIZE_EXPRESSION, 1.5] as mapboxgl.Expression,
        'circle-color': WELL_STROKE_EXPRESSION,
        'circle-opacity': 0.4,
      },
    });

    // Main dots
    map.addLayer({
      id: LAYER_DOTS,
      type: 'circle',
      source: SOURCE_ID,
      paint: {
        'circle-radius': WELL_SIZE_EXPRESSION,
        'circle-color': WELL_COLOR_EXPRESSION,
        'circle-stroke-width': 1.5,
        'circle-stroke-color': '#111827',
      },
    });

    // Click handler
    map.on('click', LAYER_DOTS, (e) => {
      if (!e.features?.length) return;
      const feature = e.features[0];
      const props = feature.properties;
      if (!props) return;

      // Parse any stringified JSON values
      const parsedProps: Record<string, unknown> = {};
      for (const [key, val] of Object.entries(props)) {
        if (typeof val === 'string') {
          try {
            parsedProps[key] = JSON.parse(val);
          } catch {
            parsedProps[key] = val;
          }
        } else {
          parsedProps[key] = val;
        }
      }

      // Show popup
      const coordinates = (feature.geometry as GeoJSON.Point).coordinates.slice() as [number, number];

      // Adjust for map wrapping
      while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
        coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
      }

      popupRef.current?.remove();

      const popup = new mapboxgl.Popup({
        closeButton: true,
        closeOnClick: true,
        maxWidth: '280px',
        className: 'wellfi-popup',
      })
        .setLngLat(coordinates)
        .setHTML(wellPopupHTML(parsedProps))
        .addTo(map);

      popupRef.current = popup;

      // Wire up View Details button
      const popupEl = popup.getElement();
      const btn = popupEl?.querySelector('[data-well-id]');
      if (btn) {
        btn.addEventListener('click', () => {
          const wellId = btn.getAttribute('data-well-id');
          const well = wellsRef.current.find((w) => w.id === wellId);
          if (well) {
            onWellClickRef.current(well);
          }
          popup.remove();
        });
      }
    });

    // Hover cursor
    map.on('mouseenter', LAYER_DOTS, () => {
      map.getCanvas().style.cursor = 'pointer';
    });
    map.on('mouseleave', LAYER_DOTS, () => {
      map.getCanvas().style.cursor = '';
    });
  }, []);

  // Update source data when wells change
  useEffect(() => {
    const map = mapRef.current;
    if (!map || !mapLoaded) return;

    const source = map.getSource(SOURCE_ID) as mapboxgl.GeoJSONSource | undefined;
    if (source) {
      source.setData(wellsToGeoJSON(wells));
    }
  }, [wells, mapLoaded]);

  // Apply filters when filters change
  useEffect(() => {
    const map = mapRef.current;
    if (!map || !mapLoaded) return;

    const conditions: mapboxgl.Expression[] = [];

    // Risk level filter
    if (filters.riskLevels.length > 0) {
      conditions.push(['in', ['get', 'risk_level'], ['literal', filters.riskLevels]]);
    }

    // Formation filter
    if (filters.formations.length > 0) {
      conditions.push(['in', ['get', 'formation'], ['literal', filters.formations]]);
    }

    // Field filter
    if (filters.fields.length > 0) {
      conditions.push(['in', ['get', 'field'], ['literal', filters.fields]]);
    }

    // WellFi only
    if (filters.showWellFiOnly) {
      conditions.push(['==', ['get', 'has_wellfi'], true]);
    }

    // Upcoming pump changes only
    if (filters.showUpcomingOnly) {
      conditions.push(['==', ['get', 'has_upcoming_change'], true]);
    }

    // Minimum rate
    if (filters.minRateBblD > 0) {
      conditions.push(['>=', ['get', 'dec_rate_bbl_d'], filters.minRateBblD]);
    }

    const filterExpr: mapboxgl.Expression | null =
      conditions.length === 0
        ? null
        : conditions.length === 1
          ? conditions[0]
          : ['all', ...conditions];

    // Apply to all well layers
    for (const layerId of [LAYER_DOTS, LAYER_STROKES]) {
      map.setFilter(layerId, filterExpr);
    }

    // Halo layer always also needs has_wellfi=true
    if (filterExpr) {
      map.setFilter(LAYER_HALO, ['all', ['==', ['get', 'has_wellfi'], true], filterExpr]);
    } else {
      map.setFilter(LAYER_HALO, ['==', ['get', 'has_wellfi'], true]);
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

  // Toggle map style
  const toggleStyle = useCallback(() => {
    setMapStyle((s) => (s === 'satellite' ? 'dark' : 'satellite'));
  }, []);

  // Toggle grid
  const toggleGrid = useCallback(() => {
    setShowGrid((s) => !s);
  }, []);

  // Toggle subsurface formations
  const toggleFormations = useCallback(() => {
    setShowFormations((s) => !s);
  }, []);

  return (
    <div className="relative w-full h-full">
      {/* Map container */}
      <div ref={containerRef} className="absolute inset-0" />

      {/* Top-right controls */}
      <div className="absolute top-3 right-3 z-10 flex gap-2">
        {/* Subsurface formations toggle */}
        <button
          onClick={toggleFormations}
          className={`px-3 py-1.5 rounded-md text-xs font-medium border backdrop-blur-sm transition-colors ${
            showFormations
              ? 'bg-wellfi-cyan/20 text-wellfi-cyan border-wellfi-cyan/40 hover:bg-wellfi-cyan/30'
              : 'bg-gray-900/80 text-gray-400 border-gray-700 hover:bg-gray-800 hover:text-gray-200'
          }`}
          title="Toggle subsurface formation overlay"
        >
          <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="inline-block mr-1 -mt-0.5">
            <path d="M12 2L2 7l10 5 10-5-10-5z" />
            <path d="M2 17l10 5 10-5" />
            <path d="M2 12l10 5 10-5" />
          </svg>
          Subsurface
        </button>

        {/* Grid toggle */}
        <button
          onClick={toggleGrid}
          className={`px-3 py-1.5 rounded-md text-xs font-medium border backdrop-blur-sm transition-colors ${
            showGrid
              ? 'bg-wellfi-cyan/20 text-wellfi-cyan border-wellfi-cyan/40 hover:bg-wellfi-cyan/30'
              : 'bg-gray-900/80 text-gray-400 border-gray-700 hover:bg-gray-800 hover:text-gray-200'
          }`}
          title="Toggle LSD grid overlay"
        >
          <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="inline-block mr-1 -mt-0.5">
            <rect x="3" y="3" width="18" height="18" rx="2" />
            <line x1="3" x2="21" y1="9" y2="9" />
            <line x1="3" x2="21" y1="15" y2="15" />
            <line x1="9" x2="9" y1="3" y2="21" />
            <line x1="15" x2="15" y1="3" y2="21" />
          </svg>
          LSD
        </button>

        {/* Style toggle */}
        <button
          onClick={toggleStyle}
          className="px-3 py-1.5 rounded-md text-xs font-medium bg-gray-900/80 text-gray-200 border border-gray-700 backdrop-blur-sm hover:bg-gray-800 transition-colors"
        >
          {mapStyle === 'satellite' ? 'Dark' : 'Satellite'}
        </button>
      </div>

      {/* Legend — bottom left */}
      <div className="absolute bottom-6 left-3 z-10 bg-gray-900/90 backdrop-blur-sm border border-gray-700 rounded-lg p-3 text-xs">
        <div className="text-gray-400 font-semibold mb-2 text-[10px] uppercase tracking-wider">
          Pump Life
        </div>
        <div className="flex flex-col gap-1.5">
          {LEGEND_ITEMS.map((item) => (
            <div key={item.label} className="flex items-center gap-2">
              <span
                className="inline-block w-2.5 h-2.5 rounded-full shrink-0"
                style={{ background: item.color }}
              />
              <span className="text-gray-300">{item.label}</span>
            </div>
          ))}
        </div>
      </div>

      {/* Popup dark theme override */}
      <style>{POPUP_CSS}</style>
    </div>
  );
}

// Legend config
const LEGEND_ITEMS: { color: string; label: string }[] = [
  { color: '#A855F7', label: 'Upcoming Change' },
  { color: '#EF4444', label: '17+ months (Due)' },
  { color: '#F97316', label: '14-16 months' },
  { color: '#EAB308', label: '9-13 months' },
  { color: '#22C55E', label: '< 9 months' },
  { color: '#6B7280', label: 'No data' },
];

// Force dark styling on Mapbox popups
const POPUP_CSS = `
  .wellfi-popup .mapboxgl-popup-content {
    background: #1f2937 !important;
    border: 1px solid #374151 !important;
    border-radius: 10px !important;
    padding: 14px !important;
    box-shadow: 0 8px 32px rgba(0,0,0,0.5) !important;
  }
  .wellfi-popup .mapboxgl-popup-tip {
    border-top-color: #1f2937 !important;
    border-bottom-color: #1f2937 !important;
  }
  .wellfi-popup .mapboxgl-popup-close-button {
    color: #9ca3af !important;
    font-size: 18px !important;
    right: 6px !important;
    top: 4px !important;
  }
  .wellfi-popup .mapboxgl-popup-close-button:hover {
    color: #f9fafb !important;
    background: transparent !important;
  }
`;
