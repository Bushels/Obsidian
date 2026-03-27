import { useMemo } from 'react';
import { useQuery } from '@tanstack/react-query';

export interface ProductionFeatureProperties {
  uwi: string;
  operator: string;
  formation: string;
  field_name: string;
  well_fluid_type: string;
  fluid_type: 'oil' | 'gas';
  well_status: string;
  recent_oil: number;
  cumulative_oil: number;
  recent_gas: number;
  recent_water: number;
  recent_steam_injection: number;
  last_production_date: string;
  spud_date: string;
  op_status: string;
}

export interface ProductionFeature {
  type: 'Feature';
  geometry: {
    type: 'Point';
    coordinates: [number, number];
  };
  properties: ProductionFeatureProperties;
}

interface ProductionCollection {
  type: 'FeatureCollection';
  features: ProductionFeature[];
}

function normalizeText(value: unknown): string {
  return String(value ?? '').trim();
}

function toNumber(value: unknown): number {
  const parsed = Number(value);
  return Number.isFinite(parsed) ? parsed : 0;
}

function normalizeFeature(feature: Partial<ProductionFeature>): ProductionFeature | null {
  const properties = feature.properties;
  if (!properties) return null;

  const operator = normalizeText(properties.operator);
  const uwi = normalizeText(properties.uwi);
  const fluidType = normalizeText(properties.fluid_type).toLowerCase() === 'gas' ? 'gas' : 'oil';

  if (!operator || !uwi) return null;

  const coordinates = Array.isArray(feature.geometry?.coordinates)
    ? feature.geometry.coordinates
    : [0, 0];

  return {
    type: 'Feature',
    geometry: {
      type: 'Point',
      coordinates: [toNumber(coordinates[0]), toNumber(coordinates[1])],
    },
    properties: {
      uwi,
      operator,
      formation: normalizeText(properties.formation) || 'Unknown',
      field_name: normalizeText(properties.field_name),
      well_fluid_type: normalizeText(properties.well_fluid_type),
      fluid_type: fluidType,
      well_status: normalizeText(properties.well_status),
      recent_oil: toNumber(properties.recent_oil),
      cumulative_oil: toNumber(properties.cumulative_oil),
      recent_gas: toNumber(properties.recent_gas),
      recent_water: toNumber(properties.recent_water),
      recent_steam_injection: toNumber(properties.recent_steam_injection),
      last_production_date: normalizeText(properties.last_production_date),
      spud_date: normalizeText(properties.spud_date),
      op_status: normalizeText(properties.op_status),
    },
  };
}

export function normalizeProductionUwi(value: string | null | undefined): string {
  return normalizeText(value).toUpperCase().replace(/[^A-Z0-9]/g, '');
}

export function useProductionSnapshot(enabled: boolean, allowedOperators: string[]) {
  const normalizedOperators = useMemo(
    () => [...new Set(allowedOperators.map(normalizeText).filter(Boolean))].sort(),
    [allowedOperators],
  );

  return useQuery({
    queryKey: ['production-snapshot', normalizedOperators.join('|')],
    enabled,
    staleTime: 5 * 60 * 1000,
    queryFn: async (): Promise<ProductionFeature[]> => {
      const response = await fetch('/data/operators/_all/production.geojson');
      if (!response.ok) {
        throw new Error(`Failed to load production snapshot (${response.status})`);
      }

      const geojson = (await response.json()) as Partial<ProductionCollection>;
      const rawFeatures = Array.isArray(geojson.features) ? geojson.features : [];
      const allowedOperatorSet = new Set(normalizedOperators);

      return rawFeatures
        .map(normalizeFeature)
        .filter((feature): feature is ProductionFeature => feature !== null)
        .filter((feature) =>
          allowedOperatorSet.size === 0 || allowedOperatorSet.has(feature.properties.operator),
        );
    },
  });
}
