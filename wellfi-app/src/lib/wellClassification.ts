export interface WellClassificationOverride {
  wellType: string | null;
  wellFluid: string | null;
  name: string | null;
}

export interface WellClassification extends WellClassificationOverride {
  isService: boolean;
}

export const SERVICE_WELL_TYPES = [
  'Injection',
  'Steam Injector',
  'Disposal',
  'Observation',
  'Source',
  'Storage',
] as const;

export const SERVICE_WELL_COLOR = '#38BDF8';

export function normalizeWellId(value: string | null | undefined): string {
  return String(value ?? '').trim().toUpperCase().replace(/[^A-Z0-9]/g, '');
}

export function isServiceWellType(value: string | null | undefined): boolean {
  return SERVICE_WELL_TYPES.includes(String(value ?? '').trim() as (typeof SERVICE_WELL_TYPES)[number]);
}

export function toWellClassification(
  override: WellClassificationOverride | null | undefined,
): WellClassification | null {
  if (!override) {
    return null;
  }

  return {
    wellType: override.wellType ?? null,
    wellFluid: override.wellFluid ?? null,
    name: override.name ?? null,
    isService: isServiceWellType(override.wellType),
  };
}
