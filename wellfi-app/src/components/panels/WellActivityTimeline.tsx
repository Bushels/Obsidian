import { Badge } from '@/components/ui/badge';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { useWellActivityLog } from '@/hooks/useWellActivityLog';
import type { WellEnriched } from '@/types/operationalStatus';
import type { Json, WellActivityLogEntry } from '@/types/wellEvents';

interface WellActivityTimelineProps {
  well: WellEnriched;
}

function parseJsonObject(value: Json): Record<string, Json> | null {
  if (!value || typeof value !== 'object' || Array.isArray(value)) {
    return null;
  }

  return value as Record<string, Json>;
}

function readString(value: Json, key: string): string | null {
  const parsed = parseJsonObject(value);
  const nextValue = parsed?.[key];
  return typeof nextValue === 'string' && nextValue.trim() ? nextValue : null;
}

function readScalarAsString(value: Json, key: string): string | null {
  const parsed = parseJsonObject(value);
  const nextValue = parsed?.[key];

  if (typeof nextValue === 'string' && nextValue.trim()) {
    return nextValue;
  }

  if (typeof nextValue === 'number' && Number.isFinite(nextValue)) {
    return String(nextValue);
  }

  return null;
}

function formatDateLabel(value: string | null | undefined): string {
  if (!value) return 'Unknown';

  const trimmed = value.trim();
  const dateOnlyMatch = trimmed.match(/^(\d{4})-(\d{2})-(\d{2})$/);
  if (dateOnlyMatch) {
    const [, year, month, day] = dateOnlyMatch;
    return new Date(Number(year), Number(month) - 1, Number(day)).toLocaleDateString('en-CA', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
    });
  }

  const parsed = new Date(trimmed);
  if (Number.isNaN(parsed.getTime())) {
    return value;
  }

  return parsed.toLocaleString('en-CA', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
    hour: 'numeric',
    minute: '2-digit',
  });
}

function formatActivityTypeLabel(activityType: string): string {
  return activityType
    .replace(/^well_event_/, '')
    .replace(/^wellfi_/, 'wellfi ')
    .replace(/_/g, ' ')
    .replace(/\b\w/g, (char) => char.toUpperCase());
}

function formatStateLabel(value: string | null): string | null {
  if (!value) return null;
  if (value === 'down') return 'Down';
  return value.charAt(0).toUpperCase() + value.slice(1);
}

function formatFulfillmentStatusLabel(value: string | null): string | null {
  if (!value) return null;

  return value
    .replace(/_/g, ' ')
    .replace(/\b\w/g, (char) => char.toUpperCase());
}

function buildActivitySummary(entry: WellActivityLogEntry): string | null {
  const payload = entry.payload;
  const state = formatStateLabel(readString(payload, 'state'));
  const fulfillmentStatus = formatFulfillmentStatusLabel(readString(payload, 'fulfillment_status'));
  const serialNumber = readString(payload, 'serial_number');
  const assignedToolSerial = readString(payload, 'assigned_tool_serial');
  const requestedToolType = readString(payload, 'requested_tool_type');
  const expectedDownDate = readString(payload, 'expected_down_date');
  const expectedStartDate = readString(payload, 'expected_start_date');
  const expectedEndDate = readString(payload, 'expected_end_date');
  const plannedServiceDate = readString(payload, 'planned_service_date');
  const assignedTechName = readString(payload, 'assigned_tech_name');
  const expectedDowntimeHours = readScalarAsString(payload, 'expected_downtime_hours');
  const estimatedProductionLossBbl = readScalarAsString(payload, 'estimated_production_loss_bbl');
  const notes = readString(payload, 'notes');
  const details: string[] = [];

  if (state) {
    details.push(state);
  }

  if (fulfillmentStatus) {
    details.push(fulfillmentStatus);
  }

  if (serialNumber) {
    details.push(`Serial ${serialNumber}`);
  }

  if (assignedToolSerial) {
    details.push(`Assigned ${assignedToolSerial}`);
  }

  if (requestedToolType) {
    details.push(`Tool ${requestedToolType}`);
  }

  if (expectedDownDate) {
    details.push(`Expected ${formatDateLabel(expectedDownDate)}`);
  } else if (expectedStartDate || expectedEndDate) {
    details.push(`Window ${formatDateLabel(expectedStartDate)} to ${formatDateLabel(expectedEndDate)}`);
  }

  if (plannedServiceDate) {
    details.push(`Service ${formatDateLabel(plannedServiceDate)}`);
  }

  if (assignedTechName) {
    details.push(`Tech ${assignedTechName}`);
  }

  if (expectedDowntimeHours) {
    details.push(`Downtime ${expectedDowntimeHours} hr`);
  }

  if (estimatedProductionLossBbl) {
    details.push(`Loss ${estimatedProductionLossBbl} bbl`);
  }

  if (details.length > 0) {
    return notes ? `${details.join(' | ')} | ${notes}` : details.join(' | ');
  }

  return notes;
}

function getActivityTone(activityType: string): { border: string; badge: string } {
  if (activityType.includes('installed')) {
    return { border: 'border-[#00D4FF]/30', badge: 'text-[#86EEFF]' };
  }

  if (activityType.includes('fulfillment')) {
    return { border: 'border-emerald-400/30', badge: 'text-emerald-200' };
  }

  if (activityType.includes('cleared') || activityType.includes('deactivated')) {
    return { border: 'border-white/[0.08]', badge: 'text-white/65' };
  }

  if (activityType.includes('escalated') || activityType.includes('down')) {
    return { border: 'border-red-400/30', badge: 'text-red-200' };
  }

  if (activityType.includes('warning')) {
    return { border: 'border-yellow-400/30', badge: 'text-yellow-200' };
  }

  if (activityType.includes('watch')) {
    return { border: 'border-blue-400/30', badge: 'text-blue-200' };
  }

  return { border: 'border-white/[0.08]', badge: 'text-white/75' };
}

export function WellActivityTimeline({ well }: WellActivityTimelineProps) {
  const { data: activity = [], isLoading } = useWellActivityLog(well.id);
  const items = activity.slice(0, 12);

  return (
    <Card>
      <CardHeader className="pb-2 pt-3 px-4">
        <CardTitle className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">
          Activity
        </CardTitle>
      </CardHeader>
      <CardContent className="space-y-3 px-4 pb-3">
        {isLoading && (
          <p className="text-sm text-muted-foreground">
            Loading activity...
          </p>
        )}

        {!isLoading && items.length === 0 && (
          <p className="text-sm text-muted-foreground">
            Well events and WellFi install timestamps will appear here.
          </p>
        )}

        {!isLoading && items.length > 0 && (
          <div className="space-y-2">
            {items.map((entry) => {
              const tone = getActivityTone(entry.activity_type);
              const summary = buildActivitySummary(entry);

              return (
                <div
                  key={entry.id}
                  className={`rounded-lg border bg-background/30 p-3 ${tone.border}`}
                >
                  <div className="flex items-start justify-between gap-3">
                    <div className="min-w-0">
                      <p className="text-sm font-medium text-foreground">
                        {formatActivityTypeLabel(entry.activity_type)}
                      </p>
                      {summary && (
                        <p className="mt-1 text-xs leading-relaxed text-muted-foreground">
                          {summary}
                        </p>
                      )}
                    </div>
                    <Badge variant="outline" className={`shrink-0 border-white/[0.08] ${tone.badge}`}>
                      {entry.actor_name ?? 'System'}
                    </Badge>
                  </div>
                  <p className="mt-2 text-[11px] text-muted-foreground">
                    {formatDateLabel(entry.occurred_at)}
                  </p>
                </div>
              );
            })}
          </div>
        )}
      </CardContent>
    </Card>
  );
}
