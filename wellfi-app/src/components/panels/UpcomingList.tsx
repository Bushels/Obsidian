import { useMemo } from 'react';
import { formatDistanceToNow, isPast, parseISO } from 'date-fns';

import type { PumpChange, PumpChangeStatus } from '@/types';
import { usePumpChanges } from '@/hooks/usePumpChanges';
import { useWells } from '@/hooks/useWells';

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

  const grouped = useMemo(() => {
    if (!pumpChanges) return [];

    // Filter to only active statuses
    const active = pumpChanges.filter(
      (pc) => pc.status === 'warning' || pc.status === 'scheduled' || pc.status === 'in_progress',
    );

    // Sort by scheduled_date ascending (nulls at bottom)
    const sorted = [...active].sort((a, b) => {
      if (!a.scheduled_date && !b.scheduled_date) return 0;
      if (!a.scheduled_date) return 1;
      if (!b.scheduled_date) return -1;
      return a.scheduled_date.localeCompare(b.scheduled_date);
    });

    // Group by status
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
  const isEmpty = grouped.length === 0;

  return (
    <Card className="w-full">
      <CardHeader className="pb-3">
        <CardTitle className="text-base">Upcoming Pump Changes</CardTitle>
      </CardHeader>

      <CardContent>
        {isLoading && (
          <div className="flex items-center justify-center py-8 text-sm text-muted-foreground">
            Loading pump changes...
          </div>
        )}

        {!isLoading && isEmpty && (
          <div className="flex items-center justify-center py-8 text-sm text-muted-foreground">
            No upcoming pump changes
          </div>
        )}

        {!isLoading && !isEmpty && (
          <div className="space-y-6">
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
