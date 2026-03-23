import { useMemo } from 'react';
import { formatDistanceToNow, isPast, parseISO } from 'date-fns';

import type { PumpChangeStatus } from '@/types';
import { OP_STATUS_CONFIG } from '@/types/operationalStatus';
import type { OperationalStatusType, WellEnriched } from '@/types/operationalStatus';
import { WELL_EVENT_FULFILLMENT_STATUS_CONFIG } from '@/types/wellEvents';
import {
  getRequestedOrAssignedToolSummary,
  getWellEventOperationalStatus,
  hasScheduledSupport,
  needsToolAssignment as wellNeedsToolAssignment,
} from '@/lib/wellEventSelectors';

import { Badge } from '@/components/ui/badge';
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';

interface UpcomingListProps {
  wells: WellEnriched[];
  onWellClick?: (wellId: string) => void;
}

interface QueueItem {
  wellId: string;
  wellName: string;
  state: OperationalStatusType;
  summary: string | null;
  toolSummary: string | null;
  fulfillmentLabel: string | null;
  schedule: {
    text: string;
    isOverdue: boolean;
    rawDate: string | null;
  } | null;
}

interface QueueGroup {
  key: string;
  label: string;
  badgeClass: string;
  items: QueueItem[];
}

interface GroupedChanges {
  label: string;
  status: PumpChangeStatus;
  items: {
    wellId: string;
    wellName: string;
    scheduledDate: string | null;
    checklistProgress: number;
  }[];
}

const PUMP_CHANGE_STATUS_DISPLAY: Record<string, { label: string; badgeClass: string }> = {
  warning: { label: 'Warnings', badgeClass: 'bg-amber-500 text-white border-amber-500' },
  scheduled: { label: 'Scheduled', badgeClass: 'bg-blue-500 text-white border-blue-500' },
  in_progress: { label: 'In Progress', badgeClass: 'bg-purple-600 text-white border-purple-600' },
};

const EVENT_QUEUE_META: Record<string, { label: string; badgeClass: string }> = {
  down_now: { label: 'Down Now', badgeClass: 'bg-red-500 text-white border-red-500' },
  warnings: { label: 'Warnings', badgeClass: 'bg-yellow-500 text-black border-yellow-500' },
  watch: { label: 'Watch', badgeClass: 'bg-blue-500 text-white border-blue-500' },
  needs_tool: { label: 'Needs Tool Assignment', badgeClass: 'bg-cyan-500 text-black border-cyan-500' },
  scheduled_support: { label: 'Scheduled Support', badgeClass: 'bg-emerald-500 text-black border-emerald-500' },
};

const EVENT_STATE_ORDER: OperationalStatusType[] = ['well_down', 'warning', 'watch'];

function getChecklistProgress(pumpChange: NonNullable<WellEnriched['active_pump_change']>): number {
  let count = 0;
  if (pumpChange.device_sourced) count++;
  if (pumpChange.program_configured) count++;
  if (pumpChange.installation_scheduled) count++;
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

function getEventState(well: WellEnriched): OperationalStatusType | null {
  return getWellEventOperationalStatus(well);
}

function buildToolSummary(well: WellEnriched): string | null {
  return getRequestedOrAssignedToolSummary(well);
}

function buildSchedule(well: WellEnriched): { text: string; isOverdue: boolean; rawDate: string | null } | null {
  if (well.well_event_fulfillment?.planned_service_date) {
    return {
      ...formatScheduledDate(well.well_event_fulfillment.planned_service_date),
      rawDate: well.well_event_fulfillment.planned_service_date,
    };
  }

  if (well.active_well_event?.expected_down_date) {
    return {
      ...formatScheduledDate(well.active_well_event.expected_down_date),
      rawDate: well.active_well_event.expected_down_date,
    };
  }

  if (well.active_well_event?.expected_start_date) {
    return {
      ...formatScheduledDate(well.active_well_event.expected_start_date),
      rawDate: well.active_well_event.expected_start_date,
    };
  }

  return null;
}

function buildQueueItem(well: WellEnriched): QueueItem | null {
  const state = getEventState(well);

  if (!state) {
    return null;
  }

  const fulfillmentStatus = well.well_event_fulfillment?.status;

  return {
    wellId: well.id,
    wellName: well.name ?? well.well_id,
    state,
    summary: well.active_well_event?.notes ?? well.operational_status?.notes ?? null,
    toolSummary: buildToolSummary(well),
    fulfillmentLabel: fulfillmentStatus ? WELL_EVENT_FULFILLMENT_STATUS_CONFIG[fulfillmentStatus].label : null,
    schedule: buildSchedule(well),
  };
}

function sortQueueItems(left: QueueItem, right: QueueItem): number {
  const leftStateIndex = EVENT_STATE_ORDER.indexOf(left.state);
  const rightStateIndex = EVENT_STATE_ORDER.indexOf(right.state);

  if (leftStateIndex !== rightStateIndex) {
    return leftStateIndex - rightStateIndex;
  }

  const leftDate = left.schedule?.text ? left.schedule : null;
  const rightDate = right.schedule?.text ? right.schedule : null;

  if (leftDate && !rightDate) return -1;
  if (!leftDate && rightDate) return 1;
  if (leftDate?.rawDate && rightDate?.rawDate) {
    return leftDate.rawDate.localeCompare(rightDate.rawDate);
  }

  return left.wellName.localeCompare(right.wellName);
}

function renderQueueCard(
  group: QueueGroup,
  onWellClick?: (wellId: string) => void,
) {
  return (
    <div key={group.key} className="space-y-2">
      <div className="flex items-center gap-2">
        <Badge className={group.badgeClass}>
          {group.label}
        </Badge>
        <span className="text-xs text-muted-foreground">
          ({group.items.length})
        </span>
      </div>

      <div className="space-y-1">
        {group.items.map((item) => {
          const config = OP_STATUS_CONFIG[item.state];

          return (
            <button
              key={item.wellId}
              type="button"
              className="flex w-full items-start gap-3 rounded-md border p-3 text-left transition-colors hover:bg-accent"
              onClick={() => onWellClick?.(item.wellId)}
            >
              <span
                className="mt-1 h-2.5 w-2.5 rounded-full shrink-0"
                style={{
                  backgroundColor: config.color,
                  boxShadow: `0 0 6px ${config.color}60`,
                }}
              />
              <div className="min-w-0 flex-1">
                <p className="truncate text-sm font-medium">
                  {item.wellName}
                </p>
                {item.summary && (
                  <p className="truncate text-xs text-muted-foreground">
                    {item.summary}
                  </p>
                )}
                <div className="mt-1 flex flex-wrap items-center gap-x-3 gap-y-1 text-[11px] text-muted-foreground">
                  {item.toolSummary && <span>{item.toolSummary}</span>}
                  {item.schedule && (
                    <span className={item.schedule.isOverdue ? 'font-semibold text-red-600' : ''}>
                      {item.schedule.text}
                    </span>
                  )}
                  {item.fulfillmentLabel && <span>{item.fulfillmentLabel}</span>}
                </div>
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
  );
}

export default function UpcomingList({ wells, onWellClick }: UpcomingListProps) {
  const eventQueueGroups = useMemo(() => {
    const wellsById = new Map(wells.map((well) => [well.id, well]));
    const queueItems = wells
      .filter((well) => well.active_well_event?.is_active)
      .map(buildQueueItem)
      .filter((item): item is QueueItem => Boolean(item))
      .sort(sortQueueItems);

    const downNow = queueItems.filter((item) => item.state === 'well_down');
    const warnings = queueItems.filter((item) => item.state === 'warning');
    const watch = queueItems.filter((item) => item.state === 'watch');
    const needsToolQueue = queueItems.filter((item) => {
      const well = wellsById.get(item.wellId);
      return well ? wellNeedsToolAssignment(well) : false;
    });
    const scheduledSupport = queueItems.filter((item) => {
      const well = wellsById.get(item.wellId);
      return well ? hasScheduledSupport(well) : false;
    });

    const groups: QueueGroup[] = [];

    if (downNow.length > 0) {
      groups.push({ key: 'down_now', items: downNow, ...EVENT_QUEUE_META.down_now });
    }

    if (warnings.length > 0) {
      groups.push({ key: 'warnings', items: warnings, ...EVENT_QUEUE_META.warnings });
    }

    if (watch.length > 0) {
      groups.push({ key: 'watch', items: watch, ...EVENT_QUEUE_META.watch });
    }

    if (needsToolQueue.length > 0) {
      groups.push({ key: 'needs_tool', items: needsToolQueue, ...EVENT_QUEUE_META.needs_tool });
    }

    if (scheduledSupport.length > 0) {
      groups.push({ key: 'scheduled_support', items: scheduledSupport, ...EVENT_QUEUE_META.scheduled_support });
    }

    return groups;
  }, [wells]);

  const groupedPumpChanges = useMemo(() => {
    const activePumpChanges = wells
      .filter(
        (well): well is WellEnriched & { active_pump_change: NonNullable<WellEnriched['active_pump_change']> } =>
          !!well.active_pump_change,
      )
      .map((well) => ({
        wellId: well.id,
        wellName: well.name ?? well.well_id,
        pumpChange: well.active_pump_change,
      }));

    const sorted = [...activePumpChanges].sort((left, right) => {
      if (!left.pumpChange.scheduled_date && !right.pumpChange.scheduled_date) return 0;
      if (!left.pumpChange.scheduled_date) return 1;
      if (!right.pumpChange.scheduled_date) return -1;
      return left.pumpChange.scheduled_date.localeCompare(right.pumpChange.scheduled_date);
    });

    const groups: GroupedChanges[] = [];
    const statusOrder: PumpChangeStatus[] = ['warning', 'scheduled', 'in_progress'];

    for (const status of statusOrder) {
      const items = sorted
        .filter(({ pumpChange }) => pumpChange.status === status)
        .map(({ wellId, wellName, pumpChange }) => ({
          wellId,
          wellName,
          scheduledDate: pumpChange.scheduled_date,
          checklistProgress: getChecklistProgress(pumpChange),
        }));

      if (items.length > 0) {
        groups.push({
          label: PUMP_CHANGE_STATUS_DISPLAY[status]?.label ?? status,
          status,
          items,
        });
      }
    }

    return groups;
  }, [wells]);

  const isEmpty = eventQueueGroups.length === 0 && groupedPumpChanges.length === 0;
  const hasWells = wells.length > 0;

  return (
    <Card className="w-full">
      <CardHeader className="pb-3">
        <CardTitle className="text-base">Action Items</CardTitle>
      </CardHeader>

      <CardContent>
        {!hasWells && (
          <div className="flex items-center justify-center py-8 text-sm text-muted-foreground">
            No wells are available in this dashboard scope
          </div>
        )}

        {hasWells && isEmpty && (
          <div className="flex items-center justify-center py-8 text-sm text-muted-foreground">
            No active well events or pump changes
          </div>
        )}

        {hasWells && !isEmpty && (
          <div className="space-y-6">
            {eventQueueGroups.map((group) => renderQueueCard(group, onWellClick))}

            {groupedPumpChanges.length > 0 && (
              <div className="space-y-3">
                <div className="text-xs font-semibold uppercase tracking-wide text-muted-foreground">
                  Pump Changes
                </div>

                {groupedPumpChanges.map((group) => {
                  const display = PUMP_CHANGE_STATUS_DISPLAY[group.status];

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
                        {group.items.map((item) => {
                          const schedule = formatScheduledDate(item.scheduledDate);

                          return (
                            <button
                              key={item.wellId}
                              type="button"
                              className="flex w-full items-center gap-3 rounded-md border p-3 text-left transition-colors hover:bg-accent"
                              onClick={() => onWellClick?.(item.wellId)}
                            >
                              <div className="flex-1 min-w-0">
                                <p className="truncate text-sm font-medium">{item.wellName}</p>
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
                                  {item.checklistProgress}/3
                                </span>
                                <Badge
                                  variant="outline"
                                  className="text-xs"
                                >
                                  {display?.label ?? group.status}
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
          </div>
        )}
      </CardContent>
    </Card>
  );
}
