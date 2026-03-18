import { Badge } from '@/components/ui/badge';
import type { WellEnriched } from '@/types/operationalStatus';

interface OperatorOverviewCardProps {
  wells: WellEnriched[];
  operatorName: string;
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
  operatorName,
  basinScope,
  filteredCount,
  hasActiveFilters,
}: OperatorOverviewCardProps) {
  const clearwaterCount = wells.filter((well) => well.formation === 'Clearwater').length;
  const blueskyCount = wells.filter((well) => well.formation === 'Bluesky').length;
  const activeFieldCount = new Set(
    wells.map((well) => well.field).filter((field): field is string => Boolean(field)),
  ).size;

  return (
    <div className="bg-[#080D16]/80 backdrop-blur-xl border border-white/[0.06] rounded-lg px-4 py-3 space-y-3">
      <div className="space-y-1">
        <div className="flex items-center justify-between gap-2">
          <h3 className="text-[10px] font-semibold tracking-[0.12em] text-white/40 uppercase">
            Operator Overview
          </h3>
          <Badge variant="outline" className="text-[10px] uppercase tracking-wide text-white/60">
            Viewer
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
          <div className="text-[10px] uppercase tracking-wide text-white/35">Active Fields</div>
          <div className="mt-1 text-lg font-semibold text-white tabular-nums">{activeFieldCount}</div>
        </div>
        <div className="rounded-lg border border-white/[0.06] bg-white/[0.02] px-3 py-2">
          <div className="text-[10px] uppercase tracking-wide text-white/35">Clearwater</div>
          <div className="mt-1 text-lg font-semibold text-white tabular-nums">{clearwaterCount}</div>
        </div>
        <div className="rounded-lg border border-white/[0.06] bg-white/[0.02] px-3 py-2">
          <div className="text-[10px] uppercase tracking-wide text-white/35">Bluesky</div>
          <div className="mt-1 text-lg font-semibold text-white tabular-nums">{blueskyCount}</div>
        </div>
      </div>

      <p className="text-[11px] text-white/45">
        {hasActiveFilters
          ? `${filteredCount} wells match the current filters.`
          : 'Map results are already scoped to your company account.'}
      </p>
    </div>
  );
}
