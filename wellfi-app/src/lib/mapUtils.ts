import type { Well } from '@/types';
import type { FeatureCollection, Feature, Point } from 'geojson';

/** Mapbox GL expression type alias (avoids namespace import issues with verbatimModuleSyntax) */
// eslint-disable-next-line @typescript-eslint/no-explicit-any
type MapExpression = [string, ...any[]];

// Risk color mapping
export const RISK_COLORS: Record<string, string> = {
  'HIGH — DUE':       '#EF4444',
  'WATCH':            '#EAB308',
  'LOW':              '#22C55E',
  'RECENTLY CHANGED': '#22C55E',
  'DOWN NOW':         '#6B7280',
  'NO DATA':          '#6B7280',
  'UNKNOWN':          '#6B7280',
};

export const riskColor = (risk: string | null): string =>
  risk ? (RISK_COLORS[risk] ?? '#6B7280') : '#6B7280';

// Mapbox expressions for circle layer styling
export const WELL_COLOR_EXPRESSION: MapExpression = [
  'case',
  ['==', ['get', 'has_upcoming_change'], true], '#A855F7',
  ['>=', ['get', 'months_running'], 17],         '#EF4444',
  ['>=', ['get', 'months_running'], 14],         '#F97316',
  ['>=', ['get', 'months_running'], 9],          '#EAB308',
  ['>', ['get', 'months_running'], 0],           '#22C55E',
  '#6B7280',
];

export const WELL_SIZE_EXPRESSION: MapExpression = [
  'interpolate', ['linear'], ['coalesce', ['get', 'dec_rate_bbl_d'], 0],
  0, 6,  50, 10,  100, 14,  200, 18,
];

export const WELL_STROKE_EXPRESSION: MapExpression = [
  'case',
  ['==', ['get', 'has_wellfi'], true], '#00D4FF',
  '#ffffff',
];

// Well GeoJSON properties shape
export interface WellFeatureProperties {
  id: string;
  well_id: string;
  name: string | null;
  formation: string | null;
  field: string | null;
  well_status: string | null;
  risk_level: string | null;
  months_running: number;
  dec_rate_bbl_d: number;
  cumulative_oil: number;
  has_wellfi: boolean;
  has_upcoming_change: boolean;
}

// Convert Well[] to GeoJSON FeatureCollection
export function wellsToGeoJSON(wells: Well[]): FeatureCollection<Point, WellFeatureProperties> {
  const features: Feature<Point, WellFeatureProperties>[] = wells.map((w) => ({
    type: 'Feature' as const,
    geometry: { type: 'Point' as const, coordinates: [w.lon, w.lat] },
    properties: {
      id: w.id,
      well_id: w.well_id,
      name: w.name,
      formation: w.formation,
      field: w.field,
      well_status: w.well_status,
      risk_level: w.risk_level,
      months_running: w.months_running ?? 0,
      dec_rate_bbl_d: w.dec_rate_bbl_d ?? 0,
      cumulative_oil: w.cumulative_oil ?? 0,
      has_wellfi: !!w.wellfi_device,
      has_upcoming_change: !!(
        w.active_pump_change &&
        ['warning', 'scheduled', 'in_progress'].includes(w.active_pump_change.status)
      ),
    },
  }));

  return {
    type: 'FeatureCollection',
    features,
  };
}
