/**
 * glassmorphicStyle.ts — "Frost" map style overlay
 *
 * Transforms Mapbox dark-v11 into a refined glassmorphic aesthetic
 * with ultra-dark backgrounds, frosted glass mineral rights parcels,
 * and subtle atmospheric depth. WellFi brand identity, reimagined.
 */
import type { Map as MapboxMap, FogSpecification } from 'mapbox-gl';

// ─── Color Palette ──────────────────────────────────────────────────────────

export const GLASS_COLORS = {
  // Base map
  bg: '#06090F',
  water: '#040710',
  land: '#080D16',
  parks: '#071014',
  buildings: '#0C1320',

  // Roads — near-invisible, structural only
  roadMajor: 'rgba(160, 190, 240, 0.12)',
  roadMinor: 'rgba(140, 170, 220, 0.05)',
  roadLabel: 'rgba(160, 190, 240, 0.3)',

  // Mineral rights parcels — frosted glass
  mineralFill: 'rgba(0, 212, 255, 0.035)',
  mineralFillHover: 'rgba(0, 212, 255, 0.12)',
  mineralStroke: 'rgba(0, 212, 255, 0.22)',
  mineralStrokeHover: 'rgba(0, 212, 255, 0.5)',
  mineralGlow: 'rgba(0, 212, 255, 0.06)',

  // DLS grid overlay
  gridTownship: 'rgba(255, 255, 255, 0.08)',
  gridSection: 'rgba(255, 255, 255, 0.05)',
  gridLsd: 'rgba(255, 255, 255, 0.03)',
  gridTownshipLabel: 'rgba(255, 255, 255, 0.4)',
  gridSectionLabel: 'rgba(255, 255, 255, 0.25)',
  gridLsdLabel: 'rgba(255, 255, 255, 0.15)',
  gridHalo: 'rgba(6, 9, 15, 0.9)',

  // Health-based parcel colors — monochromatic green palette
  // Property names map to health levels (not literal colors):
  //   Green  = Level 1 (< 9 mo, lightest green)
  //   Yellow = Level 2 (9-13 mo, medium green)
  //   Orange = Level 3 (14-16 mo, dark green)
  //   Red    = Level 4 (17+ mo, deepest green with sharp glow)
  //   Purple = Level 5 (upcoming change, emerald accent)
  //   Gray   = Level 6 (no data, neutral)
  //   Empty  = Level 0 (no wells, faintest green)
  healthGreenFill: 'rgba(74, 222, 128, 0.08)',
  healthGreenStroke: 'rgba(255, 255, 255, 0.18)',
  healthGreenGlow: 'rgba(74, 222, 128, 0.08)',
  healthYellowFill: 'rgba(34, 197, 94, 0.10)',
  healthYellowStroke: 'rgba(255, 255, 255, 0.18)',
  healthYellowGlow: 'rgba(34, 197, 94, 0.10)',
  healthOrangeFill: 'rgba(22, 163, 74, 0.12)',
  healthOrangeStroke: 'rgba(255, 255, 255, 0.20)',
  healthOrangeGlow: 'rgba(22, 163, 74, 0.14)',
  healthRedFill: 'rgba(21, 128, 61, 0.14)',
  healthRedStroke: 'rgba(255, 255, 255, 0.22)',
  healthRedGlow: 'rgba(21, 128, 61, 0.20)',
  healthPurpleFill: 'rgba(52, 211, 153, 0.10)',
  healthPurpleStroke: 'rgba(255, 255, 255, 0.18)',
  healthPurpleGlow: 'rgba(52, 211, 153, 0.10)',
  healthGrayFill: 'rgba(107, 114, 128, 0.06)',
  healthGrayStroke: 'rgba(255, 255, 255, 0.08)',
  healthGrayGlow: 'rgba(107, 114, 128, 0.06)',
  healthEmptyFill: 'rgba(34, 197, 94, 0.025)',
  healthEmptyStroke: 'rgba(255, 255, 255, 0.04)',
  healthEmptyGlow: 'rgba(34, 197, 94, 0.04)',

  // Health hover variants (~2x opacity)
  healthGreenFillHover: 'rgba(74, 222, 128, 0.16)',
  healthGreenStrokeHover: 'rgba(255, 255, 255, 0.40)',
  healthYellowFillHover: 'rgba(34, 197, 94, 0.20)',
  healthYellowStrokeHover: 'rgba(255, 255, 255, 0.40)',
  healthOrangeFillHover: 'rgba(22, 163, 74, 0.24)',
  healthOrangeStrokeHover: 'rgba(255, 255, 255, 0.45)',
  healthRedFillHover: 'rgba(21, 128, 61, 0.28)',
  healthRedStrokeHover: 'rgba(255, 255, 255, 0.50)',
  healthPurpleFillHover: 'rgba(52, 211, 153, 0.20)',
  healthPurpleStrokeHover: 'rgba(255, 255, 255, 0.40)',
  healthGrayFillHover: 'rgba(107, 114, 128, 0.12)',
  healthGrayStrokeHover: 'rgba(255, 255, 255, 0.20)',
  healthEmptyFillHover: 'rgba(34, 197, 94, 0.05)',
  healthEmptyStrokeHover: 'rgba(255, 255, 255, 0.12)',

  // Operational status overlay colors (flat fill — legacy)
  opWatchFill: 'rgba(59, 130, 246, 0.12)',
  opWatchStroke: 'rgba(59, 130, 246, 0.45)',
  opWatchGlow: 'rgba(59, 130, 246, 0.18)',
  opWatchFillHover: 'rgba(59, 130, 246, 0.22)',
  opWatchStrokeHover: 'rgba(59, 130, 246, 0.70)',
  opWarningFill: 'rgba(234, 179, 8, 0.12)',
  opWarningStroke: 'rgba(234, 179, 8, 0.45)',
  opWarningGlow: 'rgba(234, 179, 8, 0.18)',
  opWarningFillHover: 'rgba(234, 179, 8, 0.22)',
  opWarningStrokeHover: 'rgba(234, 179, 8, 0.70)',
  opWellDownFill: 'rgba(239, 68, 68, 0.15)',
  opWellDownStroke: 'rgba(239, 68, 68, 0.50)',
  opWellDownGlow: 'rgba(239, 68, 68, 0.22)',
  opWellDownFillHover: 'rgba(239, 68, 68, 0.28)',
  opWellDownStrokeHover: 'rgba(239, 68, 68, 0.80)',

  // 3D Extrusion colors — green hue based on pumping ratio (field health)
  extrusionHealthy: '#4ADE80',   // bright emerald — all wells pumping
  extrusionMid: '#166534',       // muted green — half pumping
  extrusionDown: '#374151',      // gray-700 — all wells down
  extrusionHealthyHover: '#86EFAC', // brighter on hover
  extrusionMidHover: '#22C55E',
  extrusionDownHover: '#4B5563',

  // Op status extrusion overrides (solid colors for 3D blocks)
  opWatchExtrusion: '#3B82F6',          // blue — watch
  opWarningExtrusion: '#EAB308',        // yellow — warning
  opWellDownExtrusion: '#EF4444',       // red — well down
  opWatchExtrusionHover: '#60A5FA',     // lighter blue
  opWarningExtrusionHover: '#FACC15',   // lighter yellow
  opWellDownExtrusionHover: '#F87171',  // lighter red
} as const;

// ─── Fog + Atmosphere ────────────────────────────────────────────────────────

export const GLASS_FOG_CONFIG: FogSpecification = {
  color: '#060910',
  'high-color': '#081020',
  'horizon-blend': 0.12,       // increased for atmospheric depth cues
  'space-color': '#030508',
  'star-intensity': 0.15,
};

// ─── Well layer overrides for glass mode ─────────────────────────────────────

export const GLASS_WELL_OVERRIDES = {
  haloOpacity: 0.8,
  strokeOpacity: 0.5,
  dotStrokeWidth: 1.5,
  dotStrokeColor: '#080D16',
} as const;

// ─── Apply glassmorphic style ─────────────────────────────────────────────────

/**
 * Transform dark-v11 base map into the Frost glassmorphic style.
 * Idempotent — safe to call multiple times.
 */
export function applyGlassmorphicStyle(map: MapboxMap): void {
  // 1. Atmosphere — deep void + faint stars
  map.setFog(GLASS_FOG_CONFIG);

  // 2. Terrain — increased exaggeration for 3D block context
  if (map.getSource('mapbox-dem')) {
    map.setTerrain({ source: 'mapbox-dem', exaggeration: 1.5 });
  }

  // 3. 3D lighting for fill-extrusion layers
  map.setLight({
    anchor: 'viewport',
    color: '#ffffff',
    intensity: 0.25,
    position: [1.5, 210, 30],
  });

  // 4. Override base layer colors
  overrideBaseLayers(map);
}

/** Override dark-v11 layers to match Frost palette */
function overrideBaseLayers(map: MapboxMap): void {
  const style = map.getStyle();
  if (!style?.layers) return;

  for (const layer of style.layers) {
    const id = layer.id.toLowerCase();

    // Background
    if (layer.type === 'background') {
      map.setPaintProperty(layer.id, 'background-color', GLASS_COLORS.bg);
      continue;
    }

    // Water fills
    if (layer.type === 'fill' && id.includes('water')) {
      map.setPaintProperty(layer.id, 'fill-color', GLASS_COLORS.water);
      continue;
    }

    // Land / landuse
    if (
      layer.type === 'fill' &&
      (id.includes('land') || id.includes('landuse')) &&
      !id.includes('water')
    ) {
      if (id.includes('park') || id.includes('green') || id.includes('vegetation')) {
        map.setPaintProperty(layer.id, 'fill-color', GLASS_COLORS.parks);
      } else {
        map.setPaintProperty(layer.id, 'fill-color', GLASS_COLORS.land);
      }
      continue;
    }

    // Buildings
    if (layer.type === 'fill' && id.includes('building')) {
      map.setPaintProperty(layer.id, 'fill-color', GLASS_COLORS.buildings);
      map.setPaintProperty(layer.id, 'fill-opacity', 0.3);
      continue;
    }

    // Roads — dim to near-invisible
    if (layer.type === 'line' && id.match(/^(road-|bridge-|tunnel-)/)) {
      const isMajor =
        id.includes('motorway') || id.includes('trunk') || id.includes('primary');
      map.setPaintProperty(
        layer.id,
        'line-color',
        isMajor ? GLASS_COLORS.roadMajor : GLASS_COLORS.roadMinor,
      );
      map.setPaintProperty(layer.id, 'line-opacity', isMajor ? 0.8 : 0.5);
      continue;
    }

    // Road labels
    if (layer.type === 'symbol' && id.includes('road-label')) {
      map.setPaintProperty(layer.id, 'text-color', GLASS_COLORS.roadLabel);
      map.setPaintProperty(layer.id, 'text-halo-color', GLASS_COLORS.bg);
      map.setPaintProperty(layer.id, 'text-halo-width', 1);
      continue;
    }

    // Place labels — dim to match
    if (layer.type === 'symbol' && (id.includes('place') || id.includes('label'))) {
      map.setPaintProperty(layer.id, 'text-color', 'rgba(200, 215, 240, 0.45)');
      map.setPaintProperty(layer.id, 'text-halo-color', GLASS_COLORS.bg);
      continue;
    }
  }
}

// ─── Remove glassmorphic style ───────────────────────────────────────────────

export function removeGlassmorphicStyle(map: MapboxMap): void {
  map.setFog(null as unknown as FogSpecification);
  if (map.getSource('mapbox-dem')) {
    map.setTerrain({ source: 'mapbox-dem', exaggeration: 0.5 });
  }
}
