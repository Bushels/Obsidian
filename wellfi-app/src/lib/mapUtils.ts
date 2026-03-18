import type { Well } from '@/types';
import type { OperationalStatus } from '@/types/operationalStatus';
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
  formatted_id: string | null;
  name: string | null;
  formation: string | null;
  field: string | null;
  well_status: string | null;
  risk_level: string | null;
  months_running: number;
  dec_rate_bbl_d: number;
  cumulative_oil: number;
  annual_uptime_pct: number | null;
  total_downtime_days: number | null;
  operating_days_12mo: number | null;
  has_wellfi: boolean;
  has_upcoming_change: boolean;
  show_monitoring_alert: boolean;
  op_status: string | null;
  pump_change_status: string | null;
  pump_change_date: string | null;
  pump_change_notes: string | null;
}

// Health level legend labels — monochromatic green palette
export const HEALTH_LEVEL_LABELS: { level: number; color: string; label: string }[] = [
  { level: 1, color: '#4ADE80', label: '< 9 months' },
  { level: 2, color: '#22C55E', label: '9-13 months' },
  { level: 3, color: '#16A34A', label: '14-16 months' },
  { level: 4, color: '#15803D', label: '17+ months (Due)' },
  { level: 5, color: '#34D399', label: 'Upcoming Change' },
  { level: 6, color: '#6B7280', label: 'No data' },
  // Operational status overlays
  { level: 10, color: '#3B82F6', label: 'Watch (operational)' },
  { level: 11, color: '#EAB308', label: 'Warning (operational)' },
  { level: 12, color: '#EF4444', label: 'Well Down (operational)' },
];

type MappableWell = Well & {
  operational_status?: OperationalStatus | null;
};

// Convert Well[] to GeoJSON FeatureCollection
export function wellsToGeoJSON(wells: MappableWell[]): FeatureCollection<Point, WellFeatureProperties> {
  const features: Feature<Point, WellFeatureProperties>[] = wells.map((w) => ({
    type: 'Feature' as const,
    geometry: { type: 'Point' as const, coordinates: [w.lon, w.lat] },
    properties: {
      id: w.id,
      well_id: w.well_id,
      formatted_id: w.formatted_id,
      name: w.name,
      formation: w.formation,
      field: w.field,
      well_status: w.well_status,
      risk_level: w.risk_level,
      months_running: w.months_running ?? 0,
      dec_rate_bbl_d: w.dec_rate_bbl_d ?? 0,
      cumulative_oil: w.cumulative_oil ?? 0,
      annual_uptime_pct: w.annual_uptime_pct ?? null,
      total_downtime_days: w.total_downtime_days ?? null,
      operating_days_12mo:
        w.total_downtime_days != null ? Math.max(0, 365 - w.total_downtime_days) : null,
      has_wellfi: !!w.wellfi_device?.is_active,
      has_upcoming_change: !!(
        w.active_pump_change &&
        ['warning', 'scheduled', 'in_progress'].includes(w.active_pump_change.status)
      ),
      show_monitoring_alert:
        !!w.wellfi_device?.is_active && !!(w.operational_status?.is_active || w.active_pump_change),
      op_status:
        w.operational_status?.is_active && w.operational_status.status
          ? w.operational_status.status
          : null,
      pump_change_status: w.active_pump_change?.status ?? null,
      pump_change_date:
        w.active_pump_change?.scheduled_date ?? w.active_pump_change?.actual_date ?? null,
      pump_change_notes: w.active_pump_change?.notes ?? null,
    },
  }));

  return {
    type: 'FeatureCollection',
    features,
  };
}
