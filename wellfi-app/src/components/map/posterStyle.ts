/**
 * posterStyle.ts — "Neon Atlas" map style overlay
 *
 * Transforms Mapbox dark-v11 into a stunning cyberpunk poster aesthetic
 * with neon road glow effects, dramatic terrain, and atmospheric fog.
 * Inspired by maptoposter's neon_cyberpunk theme, merged with WellFi brand.
 */
import type { Map as MapboxMap, FogSpecification, LineLayerSpecification, LayerSpecification, ExpressionSpecification } from 'mapbox-gl';

// ─── Color Palette ─────────────────────────────────────────────────────────

export const POSTER_COLORS = {
  bg: '#080C14',
  water: '#040810',
  land: '#0D1117',
  parks: '#0A1520',
  buildings: '#151E2A',
  buildingStroke: '#1A2535',

  // Road hierarchy — neon glow
  roadMotorway: '#FF00FF',
  roadPrimary: '#00D4FF',
  roadSecondary: '#00A8CC',
  roadTertiary: '#007799',
  roadResidential: '#003D50',

  // DLS grid overlay
  gridTownship: 'rgba(0, 212, 255, 0.25)',
  gridSection: 'rgba(0, 168, 204, 0.2)',
  gridLsd: 'rgba(0, 119, 153, 0.15)',

  // Grid labels
  gridTownshipLabel: '#00D4FF',
  gridSectionLabel: '#00A8CC',
  gridLsdLabel: '#007799',
  gridHalo: 'rgba(8, 12, 20, 0.9)',
} as const;

// ─── Fog + Terrain ─────────────────────────────────────────────────────────

export const POSTER_FOG_CONFIG: FogSpecification = {
  color: '#080C14',
  'high-color': '#0A1628',
  'horizon-blend': 0.08,
  'space-color': '#050810',
  'star-intensity': 0.3,
};

// ─── Well layer overrides for poster mode ──────────────────────────────────

export const POSTER_WELL_OVERRIDES = {
  haloRadius: 6,
  haloOpacity: 0.9,
  strokeOpacity: 0.6,
  dotStrokeWidth: 2,
  dotStrokeColor: '#0D1117',
} as const;

// ─── Road tier classification ──────────────────────────────────────────────

interface RoadTier {
  color: string;
  glowOpacity: number;
  glowWidthMultiplier: number;
}

const ROAD_TIERS: Record<string, RoadTier> = {
  motorway: { color: POSTER_COLORS.roadMotorway, glowOpacity: 0.18, glowWidthMultiplier: 4 },
  primary: { color: POSTER_COLORS.roadPrimary, glowOpacity: 0.15, glowWidthMultiplier: 3.5 },
  secondary: { color: POSTER_COLORS.roadSecondary, glowOpacity: 0.12, glowWidthMultiplier: 3 },
  tertiary: { color: POSTER_COLORS.roadTertiary, glowOpacity: 0.10, glowWidthMultiplier: 3 },
};

/** Classify a Mapbox layer ID into a road tier */
function classifyRoadLayer(layerId: string): string | null {
  const id = layerId.toLowerCase();
  if (id.includes('motorway') || id.includes('trunk')) return 'motorway';
  if (id.includes('primary')) return 'primary';
  if (id.includes('secondary') || id.includes('tertiary')) return 'secondary';
  if (id.includes('street') || id.includes('minor') || id.includes('service') || id.includes('link')) return 'tertiary';
  return null;
}

// ─── Glow layer prefix (for cleanup) ──────────────────────────────────────

const GLOW_PREFIX = 'poster-glow-';
const POSTER_HILLSHADE_ID = 'poster-hillshade';

// ─── Apply poster style ────────────────────────────────────────────────────

/**
 * Transform the dark-v11 base map into Neon Atlas poster style.
 * Idempotent — safe to call multiple times.
 */
export function applyPosterStyle(map: MapboxMap): void {
  // 1. Atmosphere — star field + deep fog
  map.setFog(POSTER_FOG_CONFIG);

  // 2. Terrain exaggeration for dramatic hillshade
  if (map.getSource('mapbox-dem')) {
    map.setTerrain({ source: 'mapbox-dem', exaggeration: 1.5 });
  }

  // 3. Override base layer colors
  overrideBaseLayers(map);

  // 4. Add neon road glow layers
  addRoadGlowLayers(map);

  // 5. Enhanced hillshade
  addPosterHillshade(map);
}

/** Override dark-v11 base map colors to match poster palette */
function overrideBaseLayers(map: MapboxMap): void {
  const style = map.getStyle();
  if (!style?.layers) return;

  for (const layer of style.layers) {
    const id = layer.id.toLowerCase();

    // Background
    if (layer.type === 'background') {
      map.setPaintProperty(layer.id, 'background-color', POSTER_COLORS.bg);
      continue;
    }

    // Water fills
    if (layer.type === 'fill' && id.includes('water')) {
      map.setPaintProperty(layer.id, 'fill-color', POSTER_COLORS.water);
      continue;
    }

    // Land / landuse
    if (layer.type === 'fill' && (id.includes('land') || id.includes('landuse')) && !id.includes('water')) {
      if (id.includes('park') || id.includes('green') || id.includes('vegetation')) {
        map.setPaintProperty(layer.id, 'fill-color', POSTER_COLORS.parks);
      } else {
        map.setPaintProperty(layer.id, 'fill-color', POSTER_COLORS.land);
      }
      continue;
    }

    // Buildings
    if (layer.type === 'fill' && id.includes('building')) {
      map.setPaintProperty(layer.id, 'fill-color', POSTER_COLORS.buildings);
      map.setPaintProperty(layer.id, 'fill-opacity', 0.4);
      continue;
    }

    // Road labels — make them dim but visible
    if (layer.type === 'symbol' && id.includes('road-label')) {
      map.setPaintProperty(layer.id, 'text-color', 'rgba(0, 212, 255, 0.5)');
      map.setPaintProperty(layer.id, 'text-halo-color', 'rgba(8, 12, 20, 0.8)');
      continue;
    }
  }
}

/** Add neon glow layers behind each road tier */
function addRoadGlowLayers(map: MapboxMap): void {
  const style = map.getStyle();
  if (!style?.layers) return;

  for (const layer of style.layers) {
    // Only process line layers that are roads/bridges/tunnels
    if (layer.type !== 'line') continue;
    const id = layer.id;
    if (!id.match(/^(road-|bridge-|tunnel-)/)) continue;

    const tier = classifyRoadLayer(id);
    if (!tier) continue;

    const tierConfig = ROAD_TIERS[tier];
    const glowId = `${GLOW_PREFIX}${id}`;

    // Recolor the original road layer
    map.setPaintProperty(id, 'line-color', tierConfig.color);
    map.setPaintProperty(id, 'line-opacity', 0.9);

    // Skip glow if already added (idempotent)
    if (map.getLayer(glowId)) continue;

    // Get original line-width for scaling
    const paint = (layer as LineLayerSpecification).paint;
    const originalWidth = paint?.['line-width'] ?? 1;

    // Create glow layer spec
    const glowSpec: LayerSpecification = {
      id: glowId,
      type: 'line',
      source: layer.source!,
      paint: {
        'line-color': tierConfig.color,
        'line-width': typeof originalWidth === 'number'
          ? originalWidth * tierConfig.glowWidthMultiplier
          : ['*', originalWidth as ExpressionSpecification, tierConfig.glowWidthMultiplier] as unknown as ExpressionSpecification,
        'line-opacity': tierConfig.glowOpacity,
        'line-blur': typeof originalWidth === 'number'
          ? originalWidth * tierConfig.glowWidthMultiplier
          : ['*', originalWidth as ExpressionSpecification, tierConfig.glowWidthMultiplier] as unknown as ExpressionSpecification,
      },
    };

    // Copy source-layer if present
    if ('source-layer' in layer && layer['source-layer']) {
      (glowSpec as Record<string, unknown>)['source-layer'] = layer['source-layer'];
    }

    // Copy filter if present
    if (layer.filter) {
      glowSpec.filter = layer.filter;
    }

    // Copy minzoom/maxzoom if present
    if (layer.minzoom !== undefined) glowSpec.minzoom = layer.minzoom;
    if (layer.maxzoom !== undefined) glowSpec.maxzoom = layer.maxzoom;

    // Insert glow BEHIND the road layer
    map.addLayer(glowSpec, id);
  }

  // Residential roads — just recolor, no glow (too dense)
  for (const layer of style.layers) {
    if (layer.type !== 'line') continue;
    const id = layer.id;
    if (!id.match(/^(road-|bridge-|tunnel-)/)) continue;
    if (classifyRoadLayer(id) !== null) continue; // Already handled above

    // Catch-all for unclassified roads
    map.setPaintProperty(id, 'line-color', POSTER_COLORS.roadResidential);
    map.setPaintProperty(id, 'line-opacity', 0.6);
  }
}

/** Add dramatic poster-themed hillshade */
function addPosterHillshade(map: MapboxMap): void {
  if (map.getLayer(POSTER_HILLSHADE_ID)) return;
  if (!map.getSource('terrain-dem')) return;

  map.addLayer({
    id: POSTER_HILLSHADE_ID,
    type: 'hillshade',
    source: 'terrain-dem',
    paint: {
      'hillshade-exaggeration': 0.8,
      'hillshade-shadow-color': '#000820',
      'hillshade-highlight-color': '#0D1A30',
      'hillshade-accent-color': '#0A1628',
      'hillshade-illumination-direction': 315,
    },
  }, 'road-label');  // Insert below road labels
}

// ─── Remove poster style ───────────────────────────────────────────────────

/**
 * Remove all poster glow layers, fog, and terrain overrides.
 * Does NOT restore original dark-v11 colors — the map will get a fresh style load.
 */
export function removePosterStyle(map: MapboxMap): void {
  const style = map.getStyle();
  if (!style?.layers) return;

  // Remove glow layers
  for (const layer of [...style.layers]) {
    if (layer.id.startsWith(GLOW_PREFIX)) {
      map.removeLayer(layer.id);
    }
  }

  // Remove poster hillshade
  if (map.getLayer(POSTER_HILLSHADE_ID)) {
    map.removeLayer(POSTER_HILLSHADE_ID);
  }

  // Reset fog
  map.setFog(null as unknown as FogSpecification);

  // Reset terrain to default
  if (map.getSource('mapbox-dem')) {
    map.setTerrain({ source: 'mapbox-dem', exaggeration: 0.5 });
  }
}
