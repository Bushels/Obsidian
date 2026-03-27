import { Badge } from '@/components/ui/badge';
import { hasScheduledSupport, isWellFlagged, needsToolAssignment } from '@/lib/wellEventSelectors';
import type { WellEnriched } from '@/types/operationalStatus';

interface OperatorOverviewCardProps {
  wells: WellEnriched[];
  heading: string;
  badgeLabel: string;
  operatorName: string;
  scopeDescription: string;
  contextMetricLabel: string;
  contextMetricValue: number;
  basinScope?: string | null;
  filteredCount: number;
  hasActiveFilters: boolean;
}

function formatBasinScope(basinScope?: string | null): string {
  if (!basinScope) return 'Clearwater / Bluesky';
  return basinScope.replace(/\|/g, ' / ');
}

export function OperatorOverviewCard({
  wells,
  heading,
  badgeLabel,
  operatorName,
  scopeDescription,
  contextMetricLabel,
  contextMetricValue,
  basinScope,
  filteredCount,
  hasActiveFilters,
}: OperatorOverviewCardProps) {
  const clearwaterCount = wells.filter((well) => well.formation === 'Clearwater').length;
  const blueskyCount = wells.filter((well) => well.formation === 'Bluesky').length;
  const flaggedCount = wells.filter((well) => isWellFlagged(well)).length;
  const needsToolCount = wells.filter((well) => needsToolAssignment(well)).length;
  const scheduledSupportCount = wells.filter((well) => hasScheduledSupport(well)).length;

  return (
    <div className="bg-[#080D16]/80 backdrop-blur-xl border border-white/[0.06] rounded-lg px-4 py-3 space-y-3">
      <div className="space-y-1">
        <div className="flex items-center justify-between gap-2">
          <h3 className="text-[10px] font-semibold tracking-[0.12em] text-white/40 uppercase">
            {heading}
          </h3>
          <Badge variant="outline" className="text-[10px] uppercase tracking-wide text-white/60">
            {badgeLabel}
          </Badge>
        </div>
        <p className="text-sm font-semibold text-white">{operatorName}</p>
        <p className="text-[11px] text-white/45">{formatBasinScope(basinScope)}</p>
      </div>

      <div className="grid grid-cols-2 gap-2">
        <div className="rounded-lg border border-white/[0.06] bg-white/[0.02] px-3 py-2">
          <div className="text-[10px] uppercase tracking-wide text-white/35">Total Wells</div>
          <div className="mt-1 text-lg font-semibold text-white tabular-nums">{wells.length}</div>
        </div>
        <div className="rounded-lg border border-white/[0.06] bg-white/[0.02] px-3 py-2">
          <div className="text-[10px] uppercase tracking-wide text-white/35">{contextMetricLabel}</div>
          <div className="mt-1 text-lg font-semibold text-white tabular-nums">{contextMetricValue}</div>
        </div>
        <div className="rounded-lg border border-white/[0.06] bg-white/[0.02] px-3 py-2">
          <div className="text-[10px] uppercase tracking-wide text-white/35">Clearwater</div>
          <div className="mt-1 text-lg font-semibold text-white tabular-nums">{clearwaterCount}</div>
        </div>
        <div className="rounded-lg border border-white/[0.06] bg-white/[0.02] px-3 py-2">
          <div className="text-[10px] uppercase tracking-wide text-white/35">Bluesky</div>
          <div className="mt-1 text-lg font-semibold text-white tabular-nums">{blueskyCount}</div>
        </div>
        <div className="rounded-lg border border-white/[0.06] bg-white/[0.02] px-3 py-2">
          <div className="text-[10px] uppercase tracking-wide text-white/35">Flagged</div>
          <div className="mt-1 text-lg font-semibold text-white tabular-nums">{flaggedCount}</div>
        </div>
        <div className="rounded-lg border border-white/[0.06] bg-white/[0.02] px-3 py-2">
          <div className="text-[10px] uppercase tracking-wide text-white/35">Needs Tool</div>
          <div className="mt-1 text-lg font-semibold text-white tabular-nums">{needsToolCount}</div>
        </div>
      </div>

      <p className="text-[11px] text-white/45">
        {wells.length === 0
          ? 'No wells are available in this dashboard scope yet.'
          : hasActiveFilters
            ? `${filteredCount} wells match the current filters.`
            : `${scopeDescription} Scheduled support: ${scheduledSupportCount}.`}
      </p>
    </div>
  );
}
