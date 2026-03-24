import { useQuery } from '@tanstack/react-query';
import {
  normalizeWellId,
  type WellClassificationOverride,
} from '@/lib/wellClassification';

type WellClassificationOverrideResponse = Record<string, WellClassificationOverride>;

export function useWellClassificationOverrides() {
  return useQuery({
    queryKey: ['well-classification-overrides'],
    staleTime: 60 * 60 * 1000,
    queryFn: async (): Promise<Map<string, WellClassificationOverride>> => {
      const response = await fetch('/data/well-classification-overrides.json');
      if (!response.ok) {
        throw new Error(`Failed to load well classification overrides (${response.status})`);
      }

      const payload = (await response.json()) as WellClassificationOverrideResponse;
      const rows = Object.entries(payload ?? {});

      return new Map(
        rows.map(([wellId, override]) => [
          normalizeWellId(wellId),
          {
            wellType: override?.wellType ?? null,
            wellFluid: override?.wellFluid ?? null,
            name: override?.name ?? null,
          },
        ]),
      );
    },
  });
}
