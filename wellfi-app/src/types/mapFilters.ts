import type { MapFilters } from '@/types';

export interface DashboardFilters extends MapFilters {
  showFlaggedOnly: boolean;
  showNeedsToolOnly: boolean;
  showScheduledSupportOnly: boolean;
  showDownNowOnly: boolean;
}

export const DEFAULT_DASHBOARD_FILTERS: DashboardFilters = {
  riskLevels: [],
  formations: [],
  fields: [],
  showWellFiOnly: false,
  showUpcomingOnly: false,
  showFlaggedOnly: false,
  showNeedsToolOnly: false,
  showScheduledSupportOnly: false,
  showDownNowOnly: false,
  minRateBblD: 0,
};
