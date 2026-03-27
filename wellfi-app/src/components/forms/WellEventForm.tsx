import { useState } from 'react';
import { toast } from 'sonner';

import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Badge } from '@/components/ui/badge';
import { useAuth } from '@/lib/auth-context';
import { cn } from '@/lib/utils';
import { useClearWellEvent, useSetWellEvent } from '@/hooks/useWellEvents';
import { useClearOperationalStatus } from '@/hooks/useOperationalStatuses';
import type { WellEnriched } from '@/types/operationalStatus';
import type { WellEventState } from '@/types/wellEvents';

interface WellEventFormProps {
  well: WellEnriched;
  canManage?: boolean;
}

interface ActionConfig {
  value: WellEventState;
  label: string;
  color: string;
  helper: string;
}

const ACTIONS: ActionConfig[] = [
  {
    value: 'watch',
    label: 'Watch',
    color: '#3B82F6',
    helper: 'Monitor closely and give MPS an early heads-up.',
  },
  {
    value: 'warning',
    label: 'Warning',
    color: '#EAB308',
    helper: 'Action is likely needed soon.',
  },
  {
    value: 'down',
    label: 'Down',
    color: '#EF4444',
    helper: 'Well is down now or expected to stop abruptly.',
  },
];

function formatEventState(value: WellEventState | null | undefined): string {
  if (!value) return 'Clear';
  if (value === 'down') return 'Down';
  return value.charAt(0).toUpperCase() + value.slice(1);
}

function formatDateLabel(value: string | null | undefined): string {
  if (!value) return 'Not set';

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

  return parsed.toLocaleDateString('en-CA', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
  });
}

function mapOperationalStatusToEventState(
  value: WellEnriched['operational_status'] extends { status: infer T } ? T : string | null | undefined,
): WellEventState | null {
  if (value === 'watch' || value === 'warning') return value;
  if (value === 'well_down') return 'down';
  return null;
}

export default function WellEventForm({
  well,
  canManage = false,
}: WellEventFormProps) {
  const { user } = useAuth();
  const setWellEvent = useSetWellEvent();
  const clearWellEvent = useClearWellEvent();
  const clearOperationalStatus = useClearOperationalStatus();
  const activeEvent = well.active_well_event ?? null;
  const legacyOperationalStatus = !activeEvent && well.operational_status?.is_active
    ? well.operational_status
    : null;
  const activeState = activeEvent?.is_active ? activeEvent.state : null;
  const legacyState = mapOperationalStatusToEventState(legacyOperationalStatus?.status);
  const displayedState = activeState ?? legacyState;
  const wellDisplayName = well.name ?? well.well_id;
  const legacyWindowStart = legacyOperationalStatus?.pump_change_start ?? '';
  const legacyWindowEnd = legacyOperationalStatus?.pump_change_end ?? '';
  const legacyExpectedDownDate = legacyWindowStart && !legacyWindowEnd ? legacyWindowStart : '';
  const [expectedDownDate, setExpectedDownDate] = useState(
    activeEvent?.expected_down_date ?? legacyExpectedDownDate,
  );
  const [expectedStartDate, setExpectedStartDate] = useState(
    activeEvent?.expected_start_date ?? (legacyWindowEnd ? legacyWindowStart : ''),
  );
  const [expectedEndDate, setExpectedEndDate] = useState(
    activeEvent?.expected_end_date ?? legacyWindowEnd,
  );
  const [isAbrupt, setIsAbrupt] = useState(activeEvent?.is_abrupt ?? false);
  const [supportRequested, setSupportRequested] = useState(activeEvent?.support_requested ?? true);
  const [requestedToolType, setRequestedToolType] = useState(activeEvent?.requested_tool_type ?? '');
  const [notes, setNotes] = useState(activeEvent?.notes ?? legacyOperationalStatus?.notes ?? '');

  const isPending = setWellEvent.isPending || clearWellEvent.isPending || clearOperationalStatus.isPending;
  const dateModeSummary = activeEvent?.expected_down_date
    ? `Expected ${formatDateLabel(activeEvent.expected_down_date)}`
    : activeEvent?.expected_start_date || activeEvent?.expected_end_date
      ? `Window ${formatDateLabel(activeEvent?.expected_start_date)} to ${formatDateLabel(activeEvent?.expected_end_date)}`
      : legacyWindowStart && legacyWindowEnd
        ? `Window ${formatDateLabel(legacyWindowStart)} to ${formatDateLabel(legacyWindowEnd)}`
        : legacyExpectedDownDate
          ? `Expected ${formatDateLabel(legacyExpectedDownDate)}`
          : 'No date or window set';
  const statusSourceLabel = activeEvent
    ? activeEvent.source_channel
    : legacyOperationalStatus
      ? 'legacy status'
      : 'No date or window set';

  function resetDraftState() {
    setExpectedDownDate('');
    setExpectedStartDate('');
    setExpectedEndDate('');
    setIsAbrupt(false);
    setSupportRequested(true);
    setRequestedToolType('');
    setNotes('');
  }

  function handleExpectedDownDateChange(value: string) {
    setExpectedDownDate(value);

    if (value) {
      setExpectedStartDate('');
      setExpectedEndDate('');
    }
  }

  function handleExpectedStartDateChange(value: string) {
    setExpectedStartDate(value);

    if (value) {
      setExpectedDownDate('');
    }
  }

  function handleExpectedEndDateChange(value: string) {
    setExpectedEndDate(value);

    if (value) {
      setExpectedDownDate('');
    }
  }

  function validateForm() {
    if (expectedDownDate && (expectedStartDate || expectedEndDate)) {
      toast.error('Use either a single expected down date or a start/end window');
      return false;
    }

    if ((expectedStartDate && !expectedEndDate) || (!expectedStartDate && expectedEndDate)) {
      toast.error('Both window start and window end are required when using a date window');
      return false;
    }

    if (expectedStartDate && expectedEndDate && expectedStartDate > expectedEndDate) {
      toast.error('Expected start date must be on or before expected end date');
      return false;
    }

    return true;
  }

  function submitStateAction(state: WellEventState) {
    setWellEvent.mutate(
      {
        wellId: well.id,
        state,
        isAbrupt,
        supportRequested,
        expectedDownDate: expectedDownDate || null,
        expectedStartDate: expectedStartDate || null,
        expectedEndDate: expectedEndDate || null,
        requestedToolType: requestedToolType.trim() || null,
        notes: notes.trim() || null,
        sourceChannel: 'app',
      },
      {
        onSuccess: () => {
          toast.success(`${formatEventState(state)} saved for ${wellDisplayName}`);
        },
      },
    );
  }

  function handleStateAction(state: WellEventState) {
    if (!canManage) return;

    if (!user) {
      toast.error('You must be signed in to update a well event');
      return;
    }

    if (!validateForm()) {
      return;
    }

    if (legacyOperationalStatus) {
      clearOperationalStatus.mutate(well.id, {
        onSuccess: () => {
          submitStateAction(state);
        },
      });
      return;
    }

    submitStateAction(state);
  }

  function handleClear() {
    if (!canManage) return;

    if (activeEvent) {
      clearWellEvent.mutate(well.id, {
        onSuccess: () => {
          toast.success(`Well event cleared for ${wellDisplayName}`);
          resetDraftState();
        },
      });
      return;
    }

    if (!legacyOperationalStatus) return;

    clearOperationalStatus.mutate(well.id, {
      onSuccess: () => {
        toast.success(`Legacy status cleared for ${wellDisplayName}`);
        resetDraftState();
      },
    });
  }

  return (
    <div className="bg-[#080D16]/90 backdrop-blur-xl border border-white/[0.06] rounded-xl p-4 space-y-4">
      <div className="flex items-start justify-between gap-3">
        <div>
          <h3 className="text-[10px] font-semibold tracking-[0.12em] text-white/40 uppercase mb-1">
            Well Event
          </h3>
          <p className="text-xs text-white/55 leading-snug">
            Raise a watch, warning, or down event for {wellDisplayName}. This stays on the dashboard and alerts MPS.
          </p>
        </div>
        <Badge
          variant="outline"
          className="shrink-0 border-white/[0.10] bg-white/[0.03] text-white/70"
        >
          {formatEventState(displayedState)}
        </Badge>
      </div>

      <div
        className="rounded-xl border px-3.5 py-3"
        style={{
          backgroundColor: displayedState
            ? `${ACTIONS.find((action) => action.value === displayedState)?.color ?? '#00D4FF'}14`
            : 'rgba(255,255,255,0.03)',
          borderColor: displayedState
            ? `${ACTIONS.find((action) => action.value === displayedState)?.color ?? '#00D4FF'}40`
            : 'rgba(255,255,255,0.06)',
        }}
      >
        <div className="flex flex-wrap items-center gap-2">
          {displayedState ? (
            <span
              className="inline-flex items-center gap-2 text-sm font-semibold"
              style={{ color: ACTIONS.find((action) => action.value === displayedState)?.color ?? '#00D4FF' }}
            >
              <span
                className="h-2.5 w-2.5 rounded-full"
                style={{
                  backgroundColor: ACTIONS.find((action) => action.value === displayedState)?.color ?? '#00D4FF',
                  boxShadow: `0 0 10px ${ACTIONS.find((action) => action.value === displayedState)?.color ?? '#00D4FF'}88`,
                }}
              />
              {formatEventState(displayedState)} active
            </span>
          ) : (
            <span className="text-sm font-semibold text-white/80">
              No active well event
            </span>
          )}
          {statusSourceLabel && (
            <Badge variant="outline" className="border-white/[0.08] text-[10px] uppercase tracking-wide text-white/45">
              {statusSourceLabel}
            </Badge>
          )}
        </div>

        {legacyOperationalStatus && !activeEvent && (
          <p className="mt-3 text-[11px] leading-relaxed text-amber-200/80">
            This flag is coming from the older operational status workflow. Clear it once here to remove it from the dashboard.
          </p>
        )}

        {displayedState && (
          <div className="mt-3 grid gap-2 text-[11px] text-white/55 sm:grid-cols-2">
            <div>
              <span className="block text-white/35 uppercase tracking-wide">Schedule</span>
              <span>{dateModeSummary}</span>
            </div>
            <div>
              <span className="block text-white/35 uppercase tracking-wide">Support</span>
              <span>
                {activeEvent
                  ? (activeEvent.support_requested ? 'MPS support requested' : 'No support requested yet')
                  : 'Legacy status workflow'}
              </span>
            </div>
            <div>
              <span className="block text-white/35 uppercase tracking-wide">Updated By</span>
              <span>
                {activeEvent?.updated_by_name
                  ?? activeEvent?.created_by_name
                  ?? legacyOperationalStatus?.set_by
                  ?? 'Not set'}
              </span>
            </div>
            <div>
              <span className="block text-white/35 uppercase tracking-wide">Last Updated</span>
              <span>{formatDateLabel(activeEvent?.updated_at ?? legacyOperationalStatus?.updated_at ?? null)}</span>
            </div>
          </div>
        )}
      </div>

      {!canManage ? (
        <div className="space-y-3 text-xs text-white/60">
          {activeEvent?.requested_tool_type && (
            <div>
              <span className="block text-[10px] font-semibold uppercase tracking-wide text-white/35">
                Requested Tool
              </span>
              <span>{activeEvent.requested_tool_type}</span>
            </div>
          )}
          {activeEvent?.notes && (
            <div>
              <span className="block text-[10px] font-semibold uppercase tracking-wide text-white/35">
                Notes
              </span>
              <p className="leading-relaxed text-white/70">{activeEvent.notes}</p>
            </div>
          )}
        </div>
      ) : (
        <>
          <div className="grid gap-3 sm:grid-cols-3">
            <div className="space-y-1.5">
              <label className="flex min-h-[1.5rem] items-end text-[10px] font-semibold uppercase tracking-[0.12em] text-white/35">
                Down Date
              </label>
              <Input
                type="date"
                value={expectedDownDate}
                onChange={(event) => handleExpectedDownDateChange(event.target.value)}
                disabled={isPending}
                className="h-10 border-white/[0.08] bg-white/[0.03] text-white [color-scheme:dark] placeholder:text-white/20 focus-visible:ring-[#00D4FF]/30 focus-visible:ring-offset-0"
              />
            </div>
            <div className="space-y-1.5">
              <label className="flex min-h-[1.5rem] items-end text-[10px] font-semibold uppercase tracking-[0.12em] text-white/35">
                Window Start
              </label>
              <Input
                type="date"
                value={expectedStartDate}
                onChange={(event) => handleExpectedStartDateChange(event.target.value)}
                disabled={isPending}
                className="h-10 border-white/[0.08] bg-white/[0.03] text-white [color-scheme:dark] placeholder:text-white/20 focus-visible:ring-[#00D4FF]/30 focus-visible:ring-offset-0"
              />
            </div>
            <div className="space-y-1.5">
              <label className="flex min-h-[1.5rem] items-end text-[10px] font-semibold uppercase tracking-[0.12em] text-white/35">
                Window End
              </label>
              <Input
                type="date"
                value={expectedEndDate}
                onChange={(event) => handleExpectedEndDateChange(event.target.value)}
                disabled={isPending}
                className="h-10 border-white/[0.08] bg-white/[0.03] text-white [color-scheme:dark] placeholder:text-white/20 focus-visible:ring-[#00D4FF]/30 focus-visible:ring-offset-0"
              />
            </div>
          </div>

          <p className="text-[11px] text-white/35">
            Use either one expected date or a start/end window.
          </p>

          <div className="grid gap-2 sm:grid-cols-2">
            <button
              type="button"
              disabled={isPending}
              onClick={() => setIsAbrupt((current) => !current)}
              className={cn(
                'rounded-lg border px-3 py-2 text-left transition-all duration-200 disabled:opacity-50',
                isAbrupt
                  ? 'border-red-400/40 bg-red-500/10 text-red-200'
                  : 'border-white/[0.06] bg-white/[0.03] text-white/65',
              )}
            >
              <span className="block text-xs font-semibold">Abrupt stop</span>
              <span className="mt-1 block text-[11px] text-white/45">
                Use when the well can skip straight to down.
              </span>
            </button>
            <button
              type="button"
              disabled={isPending}
              onClick={() => setSupportRequested((current) => !current)}
              className={cn(
                'rounded-lg border px-3 py-2 text-left transition-all duration-200 disabled:opacity-50',
                supportRequested
                  ? 'border-[#00D4FF]/35 bg-[#00D4FF]/10 text-[#86EEFF]'
                  : 'border-white/[0.06] bg-white/[0.03] text-white/65',
              )}
            >
              <span className="block text-xs font-semibold">Support requested</span>
              <span className="mt-1 block text-[11px] text-white/45">
                Keep this on when you want MPS to prepare support.
              </span>
            </button>
          </div>

          <div className="space-y-1.5">
            <label className="text-[10px] font-semibold uppercase tracking-[0.12em] text-white/35">
              Requested Tool Type
            </label>
            <Input
              value={requestedToolType}
              onChange={(event) => setRequestedToolType(event.target.value)}
              placeholder="Example: No-turn tool, pull-through, replacement assembly"
              disabled={isPending}
              className="h-10 border-white/[0.08] bg-white/[0.03] text-white placeholder:text-white/20 focus-visible:ring-[#00D4FF]/30 focus-visible:ring-offset-0"
            />
          </div>

          <div className="space-y-1.5">
            <label className="text-[10px] font-semibold uppercase tracking-[0.12em] text-white/35">
              Notes
            </label>
            <Textarea
              value={notes}
              onChange={(event) => setNotes(event.target.value)}
              rows={3}
              placeholder="Anything MPS should know about the well, timing, or expected impact."
              disabled={isPending}
              className="min-h-[96px] border-white/[0.08] bg-white/[0.03] text-white placeholder:text-white/20 focus-visible:ring-[#00D4FF]/30 focus-visible:ring-offset-0"
            />
          </div>

          <div className="sticky bottom-0 z-10 -mx-4 border-t border-white/[0.06] bg-[#080D16]/95 px-4 py-3 backdrop-blur-xl lg:static lg:mx-0 lg:border-0 lg:bg-transparent lg:px-0 lg:py-0">
            <div className="grid gap-2">
              {ACTIONS.map((action) => {
                const isCurrent = displayedState === action.value;

                return (
                  <Button
                    key={action.value}
                    type="button"
                    disabled={isPending}
                    onClick={() => handleStateAction(action.value)}
                    className="h-auto min-h-[72px] justify-start whitespace-normal border px-3 py-3 text-left"
                    style={{
                      backgroundColor: isCurrent ? `${action.color}26` : `${action.color}12`,
                      borderColor: `${action.color}${isCurrent ? '60' : '30'}`,
                      color: isCurrent ? action.color : '#F5F7FA',
                      boxShadow: isCurrent ? `0 0 18px ${action.color}22` : 'none',
                    }}
                  >
                    <span className="flex flex-col items-start">
                      <span className="text-sm font-semibold">{action.label}</span>
                      <span className="whitespace-normal text-[10px] text-white/55">
                        {isCurrent ? 'Update current event' : action.helper}
                      </span>
                    </span>
                  </Button>
                );
              })}
              <Button
                type="button"
                variant="outline"
                disabled={(!activeEvent && !legacyOperationalStatus) || isPending}
                onClick={handleClear}
                className="h-11 border-white/[0.10] bg-white/[0.02] text-white/75 hover:bg-white/[0.06] hover:text-white"
              >
                {clearWellEvent.isPending || clearOperationalStatus.isPending ? 'Clearing...' : 'Clear'}
              </Button>
            </div>
          </div>
        </>
      )}
    </div>
  );
}
