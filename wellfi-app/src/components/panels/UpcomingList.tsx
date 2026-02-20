import { useMemo } from 'react';
import { formatDistanceToNow, isPast, parseISO } from 'date-fns';

import type { PumpChange, PumpChangeStatus } from '@/types';
import { usePumpChanges } from '@/hooks/usePumpChanges';
import { useWells } from '@/hooks/useWells';
import { OP_STATUS_CONFIG } from '@/types/operationalStatus';
import type { WellEnriched, OperationalStatusType } from '@/types/operationalStatus';

import { Badge } from '@/components/ui/badge';
import {
  Card,
  CardHeader,
  CardTitle,
  CardContent,
} from '@/components/ui/card';

interface UpcomingListProps {
  onWellClick?: (wellId: string) => void;
}

interface GroupedChanges {
  label: string;
  status: PumpChangeStatus;
  items: PumpChange[];
}

const STATUS_DISPLAY: Record<string, { label: string; badgeClass: string }> = {
  warning: { label: 'Warnings', badgeClass: 'bg-amber-500 text-white border-amber-500' },
  scheduled: { label: 'Scheduled', badgeClass: 'bg-blue-500 text-white border-blue-500' },
  in_progress: { label: 'In Progress', badgeClass: 'bg-purple-600 text-white border-purple-600' },
};

const OP_STATUS_ORDER: OperationalStatusType[] = ['well_down', 'warning', 'watch'];

function getChecklistProgress(pc: PumpChange): number {
  let count = 0;
  if (pc.device_sourced) count++;
  if (pc.program_configured) count++;
  if (pc.installation_scheduled) count++;
  return count;
}

function formatScheduledDate(dateStr: string | null): { text: string; isOverdue: boolean } {
  if (!dateStr) return { text: 'No date set', isOverdue: false };
  const date = parseISO(dateStr);
  const overdue = isPast(date);
  if (overdue) {
    return { text: 'overdue', isOverdue: true };
  }
  return { text: 'in ' + formatDistanceToNow(date), isOverdue: false };
}

export default function UpcomingList({ onWellClick }: UpcomingListProps) {
  const { data: pumpChanges, isLoading: loadingChanges } = usePumpChanges();
  const { data: wells, isLoading: loadingWells } = useWells();

  const wellNameMap = useMemo(() => {
    const map = new Map<string, string>();
    if (wells) {
      for (const w of wells) {
        map.set(w.id, w.name ?? w.well_id);
      }
    }
    return map;
  }, [wells]);

  // Wells with active operational statuses, sorted by severity
  const flaggedWells = useMemo(() => {
    if (!wells) return [];
    const flagged = wells.filter(
      (w): w is WellEnriched & { operational_status: NonNullable<WellEnriched['operational_status']> } =>
        !!w.operational_status?.is_active,
    );

    // Sort by severity (well_down first, then warning, then watch)
    return flagged.sort((a, b) => {
      const aIdx = OP_STATUS_ORDER.indexOf(a.operational_status.status);
      const bIdx = OP_STATUS_ORDER.indexOf(b.operational_status.status);
      return aIdx - bIdx;
    });
  }, [wells]);

  const grouped = useMemo(() => {
    if (!pumpChanges) return [];

    const active = pumpChanges.filter(
      (pc) => pc.status === 'warning' || pc.status === 'scheduled' || pc.status === 'in_progress',
    );

    const sorted = [...active].sort((a, b) => {
      if (!a.scheduled_date && !b.scheduled_date) return 0;
      if (!a.scheduled_date) return 1;
      if (!b.scheduled_date) return -1;
      return a.scheduled_date.localeCompare(b.scheduled_date);
    });

    const groups: GroupedChanges[] = [];
    const statusOrder: PumpChangeStatus[] = ['warning', 'scheduled', 'in_progress'];

    for (const status of statusOrder) {
      const items = sorted.filter((pc) => pc.status === status);
      if (items.length > 0) {
        const display = STATUS_DISPLAY[status];
        groups.push({
          label: display?.label ?? status,
          status,
          items,
        });
      }
    }

    return groups;
  }, [pumpChanges]);

  const isLoading = loadingChanges || loadingWells;
  const isEmpty = grouped.length === 0 && flaggedWells.length === 0;

  return (
    <Card className="w-full">
      <CardHeader className="pb-3">
        <CardTitle className="text-base">Action Items</CardTitle>
      </CardHeader>

      <CardContent>
        {isLoading && (
          <div className="flex items-center justify-center py-8 text-sm text-muted-foreground">
            Loading...
          </div>
        )}

        {!isLoading && isEmpty && (
          <div className="flex items-center justify-center py-8 text-sm text-muted-foreground">
            No flagged wells or pump changes
          </div>
        )}

        {!isLoading && !isEmpty && (
          <div className="space-y-6">
            {/* Flagged wells (operational statuses) */}
            {flaggedWells.length > 0 && (
              <div className="space-y-2">
                <div className="flex items-center gap-2">
                  <span className="text-xs font-semibold uppercase tracking-wide text-muted-foreground">
                    Flagged Wells
                  </span>
                  <span className="text-xs text-muted-foreground">
                    ({flaggedWells.length})
                  </span>
                </div>

                <div className="space-y-1">
                  {flaggedWells.map((well) => {
                    const config = OP_STATUS_CONFIG[well.operational_status.status];
                    const notes = well.operational_status.notes;

                    return (
                      <button
                        key={well.id}
                        type="button"
                        className="flex w-full items-center gap-3 rounded-md border p-3 text-left transition-colors hover:bg-accent"
                        onClick={() => onWellClick?.(well.id)}
                      >
                        <span
                          className="h-2.5 w-2.5 rounded-full shrink-0"
                          style={{
                            backgroundColor: config.color,
                            boxShadow: `0 0 6px ${config.color}60`,
                          }}
                        />
                        <div className="flex-1 min-w-0">
                          <p className="truncate text-sm font-medium">
                            {well.name ?? well.well_id}
                          </p>
                          {notes && (
                            <p className="truncate text-xs text-muted-foreground">
                              {notes}
                            </p>
                          )}
                        </div>
                        <Badge
                          variant="outline"
                          className="text-xs shrink-0"
                          style={{ borderColor: config.color, color: config.color }}
                        >
                          {config.label}
                        </Badge>
                      </button>
                    );
                  })}
                </div>
              </div>
            )}

            {/* Pump changes */}
            {grouped.map((group) => {
              const display = STATUS_DISPLAY[group.status];
              return (
                <div key={group.status} className="space-y-2">
                  <div className="flex items-center gap-2">
                    <Badge className={display?.badgeClass ?? ''}>
                      {group.label}
                    </Badge>
                    <span className="text-xs text-muted-foreground">
                      ({group.items.length})
                    </span>
                  </div>

                  <div className="space-y-1">
                    {group.items.map((pc) => {
                      const wellName = wellNameMap.get(pc.well_id) ?? 'Unknown Well';
                      const schedule = formatScheduledDate(pc.scheduled_date);
                      const checklistDone = getChecklistProgress(pc);

                      return (
                        <button
                          key={pc.id}
                          type="button"
                          className="flex w-full items-center gap-3 rounded-md border p-3 text-left transition-colors hover:bg-accent"
                          onClick={() => onWellClick?.(pc.well_id)}
                        >
                          <div className="flex-1 min-w-0">
                            <p className="truncate text-sm font-medium">{wellName}</p>
                            <p
                              className={
                                'text-xs ' +
                                (schedule.isOverdue
                                  ? 'text-red-600 font-semibold'
                                  : 'text-muted-foreground')
                              }
                            >
                              {schedule.text}
                            </p>
                          </div>
                          <div className="flex items-center gap-2 shrink-0">
                            <span className="text-xs text-muted-foreground">
                              {checklistDone}/3
                            </span>
                            <Badge
                              variant="outline"
                              className="text-xs"
                            >
                              {STATUS_DISPLAY[pc.status]?.label ?? pc.status}
                            </Badge>
                          </div>
                        </button>
                      );
                    })}
                  </div>
                </div>
              );
            })}
          </div>
        )}
      </CardContent>
    </Card>
  );
}
