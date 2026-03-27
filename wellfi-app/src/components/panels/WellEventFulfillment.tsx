import { useMemo, useState } from 'react';
import { toast } from 'sonner';

import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { Textarea } from '@/components/ui/textarea';
import {
  useToolInventory,
  useUpdateWellEventFulfillment,
} from '@/hooks/useWellEvents';
import type { WellEnriched } from '@/types/operationalStatus';
import {
  TOOL_INVENTORY_STATUS_CONFIG,
  WELL_EVENT_FULFILLMENT_STATUS_CONFIG,
  type ToolInventoryItem,
  type WellEventFulfillmentStatus,
} from '@/types/wellEvents';

interface WellEventFulfillmentProps {
  well: WellEnriched;
  canManage?: boolean;
}

const ACTIVE_TOOL_STATUSES: WellEventFulfillmentStatus[] = [
  'tool_reserved',
  'scheduled',
  'dispatched',
  'on_site',
];

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

function formatNumberLabel(value: number | null | undefined, suffix: string): string {
  if (value == null) return 'Not set';
  return `${value}${suffix}`;
}

function formatToolOptionLabel(tool: ToolInventoryItem): string {
  const statusLabel = TOOL_INVENTORY_STATUS_CONFIG[tool.status].label;
  return `${tool.serial_number} | ${tool.tool_type} | ${statusLabel}`;
}

export function WellEventFulfillment({
  well,
  canManage = false,
}: WellEventFulfillmentProps) {
  const updateFulfillment = useUpdateWellEventFulfillment();
  const { data: toolInventory = [] } = useToolInventory();
  const activeEvent = well.active_well_event ?? null;
  const fulfillment = well.well_event_fulfillment ?? null;
  const assignedTool = well.assigned_tool ?? null;
  const wellDisplayName = well.name ?? well.well_id;

  const [status, setStatus] = useState<WellEventFulfillmentStatus>(fulfillment?.status ?? 'unassigned');
  const [selectedToolId, setSelectedToolId] = useState(fulfillment?.assigned_tool_id ?? 'none');
  const [plannedServiceDate, setPlannedServiceDate] = useState(fulfillment?.planned_service_date ?? '');
  const [assignedTechName, setAssignedTechName] = useState(fulfillment?.assigned_tech_name ?? '');
  const [expectedDowntimeHours, setExpectedDowntimeHours] = useState(
    fulfillment?.expected_downtime_hours != null ? String(fulfillment.expected_downtime_hours) : '',
  );
  const [estimatedProductionLossBbl, setEstimatedProductionLossBbl] = useState(
    fulfillment?.estimated_production_loss_bbl != null ? String(fulfillment.estimated_production_loss_bbl) : '',
  );
  const [internalNotes, setInternalNotes] = useState(fulfillment?.internal_notes ?? '');

  const toolOptions = useMemo(() => {
    const requestedToolType = activeEvent?.requested_tool_type?.trim().toLowerCase() ?? '';

    return [...toolInventory]
      .filter((tool) => tool.status === 'in_stock' || tool.id === selectedToolId)
      .sort((left, right) => {
        const leftMatches = requestedToolType && left.tool_type.toLowerCase().includes(requestedToolType) ? 1 : 0;
        const rightMatches = requestedToolType && right.tool_type.toLowerCase().includes(requestedToolType) ? 1 : 0;

        if (leftMatches !== rightMatches) {
          return rightMatches - leftMatches;
        }

        return left.serial_number.localeCompare(right.serial_number);
      });
  }, [activeEvent?.requested_tool_type, selectedToolId, toolInventory]);

  const isPending = updateFulfillment.isPending;
  const statusConfig = WELL_EVENT_FULFILLMENT_STATUS_CONFIG[fulfillment?.status ?? 'unassigned'];
  const assignedToolStatusConfig = assignedTool
    ? TOOL_INVENTORY_STATUS_CONFIG[assignedTool.status]
    : null;

  function handleToolChange(value: string) {
    setSelectedToolId(value);

    if (value !== 'none' && status === 'unassigned') {
      setStatus('tool_reserved');
    }

    if (value === 'none' && ACTIVE_TOOL_STATUSES.includes(status)) {
      setStatus('unassigned');
    }
  }

  function handleSave() {
    if (!canManage || !fulfillment) {
      return;
    }

    const nextSelectedToolId = selectedToolId === 'none' ? null : selectedToolId;
    const nextExpectedDowntimeHours = expectedDowntimeHours.trim() ? Number(expectedDowntimeHours) : null;
    const nextEstimatedProductionLossBbl = estimatedProductionLossBbl.trim() ? Number(estimatedProductionLossBbl) : null;

    if (ACTIVE_TOOL_STATUSES.includes(status) && !nextSelectedToolId) {
      toast.error('Assign a tool before moving fulfillment into a reserved or deployed stage');
      return;
    }

    if (nextSelectedToolId && status === 'unassigned') {
      toast.error('Choose a reserved, scheduled, dispatched, or on-site stage when a tool is assigned');
      return;
    }

    if (
      (nextExpectedDowntimeHours != null && (Number.isNaN(nextExpectedDowntimeHours) || nextExpectedDowntimeHours < 0))
      || (
        nextEstimatedProductionLossBbl != null
        && (Number.isNaN(nextEstimatedProductionLossBbl) || nextEstimatedProductionLossBbl < 0)
      )
    ) {
      toast.error('Downtime hours and production loss must be non-negative numbers');
      return;
    }

    updateFulfillment.mutate(
      {
        id: fulfillment.id,
        updates: {
          status,
          assigned_tool_id: nextSelectedToolId,
          planned_service_date: plannedServiceDate || null,
          assigned_tech_name: assignedTechName.trim() || null,
          expected_downtime_hours: nextExpectedDowntimeHours,
          estimated_production_loss_bbl: nextEstimatedProductionLossBbl,
          internal_notes: internalNotes.trim() || null,
        },
      },
      {
        onSuccess: () => {
          toast.success(`Fulfillment updated for ${wellDisplayName}`);
        },
      },
    );
  }

  return (
    <div className="bg-[#080D16]/90 backdrop-blur-xl border border-white/[0.06] rounded-xl p-4 space-y-4">
      <div className="flex items-start justify-between gap-3">
        <div>
          <h3 className="text-[10px] font-semibold tracking-[0.12em] text-white/40 uppercase mb-1">
            MPS Fulfillment
          </h3>
          <p className="text-xs text-white/55 leading-snug">
            Reserve a tool, schedule support, and track field execution for this well.
          </p>
        </div>
        <Badge
          variant="outline"
          className="shrink-0"
          style={{
            borderColor: `${statusConfig.color}35`,
            color: statusConfig.color,
            backgroundColor: `${statusConfig.color}10`,
          }}
        >
          {statusConfig.label}
        </Badge>
      </div>

      {!activeEvent && (
        <div className="rounded-lg border border-white/[0.06] bg-white/[0.03] px-3 py-3 text-sm text-white/60">
          Raise a well event first. Fulfillment starts once a watch, warning, or down event is active.
        </div>
      )}

      {activeEvent && !fulfillment && (
        <div className="rounded-lg border border-yellow-400/20 bg-yellow-500/10 px-3 py-3 text-sm text-yellow-100">
          Fulfillment record is not available for this event yet.
        </div>
      )}

      {activeEvent && fulfillment && (
        <>
          <div className="rounded-xl border border-white/[0.06] bg-white/[0.03] px-3.5 py-3">
            <div className="grid gap-2 text-[11px] text-white/55 sm:grid-cols-2">
              <div>
                <span className="block text-white/35 uppercase tracking-wide">Requested Tool</span>
                <span>{activeEvent.requested_tool_type ?? 'Not requested'}</span>
              </div>
              <div>
                <span className="block text-white/35 uppercase tracking-wide">Assigned Tool</span>
                <span>{assignedTool ? `${assignedTool.serial_number} (${assignedTool.tool_type})` : 'Not assigned'}</span>
              </div>
              <div>
                <span className="block text-white/35 uppercase tracking-wide">Planned Service</span>
                <span>{formatDateLabel(fulfillment.planned_service_date)}</span>
              </div>
              <div>
                <span className="block text-white/35 uppercase tracking-wide">Assigned Tech</span>
                <span>{fulfillment.assigned_tech_name ?? 'Not assigned'}</span>
              </div>
              <div>
                <span className="block text-white/35 uppercase tracking-wide">Expected Downtime</span>
                <span>{formatNumberLabel(fulfillment.expected_downtime_hours, ' hr')}</span>
              </div>
              <div>
                <span className="block text-white/35 uppercase tracking-wide">Production Impact</span>
                <span>{formatNumberLabel(fulfillment.estimated_production_loss_bbl, ' bbl')}</span>
              </div>
            </div>

            {assignedTool && assignedToolStatusConfig && (
              <div className="mt-3 flex flex-wrap items-center gap-2">
                <Badge
                  variant="outline"
                  style={{
                    borderColor: `${assignedToolStatusConfig.color}35`,
                    color: assignedToolStatusConfig.color,
                    backgroundColor: `${assignedToolStatusConfig.color}10`,
                  }}
                >
                  Tool {assignedToolStatusConfig.label}
                </Badge>
                {fulfillment.last_updated_by_name && (
                  <span className="text-[11px] text-white/40">
                    Updated by {fulfillment.last_updated_by_name}
                  </span>
                )}
              </div>
            )}
          </div>

          {!canManage ? (
            <div className="space-y-3 text-xs text-white/60">
              <p className="text-[11px] text-white/40">
                MPS manages the tool assignment and service schedule. You can still see the assigned tool and planned date here.
              </p>
            </div>
          ) : (
            <>
              <div className="grid gap-3 sm:grid-cols-2">
                <div className="space-y-1.5">
                  <label className="text-[10px] font-semibold uppercase tracking-[0.12em] text-white/35">
                    Fulfillment Stage
                  </label>
                  <Select value={status} onValueChange={(value) => setStatus(value as WellEventFulfillmentStatus)}>
                    <SelectTrigger className="h-10 border-white/[0.08] bg-white/[0.03] text-white">
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      {Object.entries(WELL_EVENT_FULFILLMENT_STATUS_CONFIG).map(([value, config]) => (
                        <SelectItem key={value} value={value}>
                          {config.label}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                  <p className="text-[11px] text-white/35">
                    {WELL_EVENT_FULFILLMENT_STATUS_CONFIG[status].description}
                  </p>
                </div>

                <div className="space-y-1.5">
                  <label className="text-[10px] font-semibold uppercase tracking-[0.12em] text-white/35">
                    Planned Service Date
                  </label>
                  <Input
                    type="date"
                    value={plannedServiceDate}
                    onChange={(event) => setPlannedServiceDate(event.target.value)}
                    disabled={isPending}
                    className="h-10 border-white/[0.08] bg-white/[0.03] text-white [color-scheme:dark] focus-visible:ring-[#00D4FF]/30 focus-visible:ring-offset-0"
                  />
                </div>
              </div>

              <div className="grid gap-3 sm:grid-cols-2">
                <div className="space-y-1.5">
                  <label className="text-[10px] font-semibold uppercase tracking-[0.12em] text-white/35">
                    Assigned Tool
                  </label>
                  <Select value={selectedToolId} onValueChange={handleToolChange}>
                    <SelectTrigger className="h-10 border-white/[0.08] bg-white/[0.03] text-white">
                      <SelectValue placeholder="Select a tool" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="none">No tool assigned</SelectItem>
                      {toolOptions.map((tool) => (
                        <SelectItem key={tool.id} value={tool.id}>
                          {formatToolOptionLabel(tool)}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                  <p className="text-[11px] text-white/35">
                    {toolOptions.length > 0
                      ? 'Only in-stock tools, plus the currently assigned tool, are shown here.'
                      : 'Add tools in the Tool Inventory panel before assigning them here.'}
                  </p>
                </div>

                <div className="space-y-1.5">
                  <label className="text-[10px] font-semibold uppercase tracking-[0.12em] text-white/35">
                    Assigned Tech
                  </label>
                  <Input
                    value={assignedTechName}
                    onChange={(event) => setAssignedTechName(event.target.value)}
                    placeholder="Example: Tyler S."
                    disabled={isPending}
                    className="h-10 border-white/[0.08] bg-white/[0.03] text-white placeholder:text-white/20 focus-visible:ring-[#00D4FF]/30 focus-visible:ring-offset-0"
                  />
                </div>
              </div>

              <div className="grid gap-3 sm:grid-cols-2">
                <div className="space-y-1.5">
                  <label className="text-[10px] font-semibold uppercase tracking-[0.12em] text-white/35">
                    Expected Downtime Hours
                  </label>
                  <Input
                    type="number"
                    min="0"
                    step="0.5"
                    value={expectedDowntimeHours}
                    onChange={(event) => setExpectedDowntimeHours(event.target.value)}
                    placeholder="Example: 12"
                    disabled={isPending}
                    className="h-10 border-white/[0.08] bg-white/[0.03] text-white placeholder:text-white/20 focus-visible:ring-[#00D4FF]/30 focus-visible:ring-offset-0"
                  />
                </div>
                <div className="space-y-1.5">
                  <label className="text-[10px] font-semibold uppercase tracking-[0.12em] text-white/35">
                    Production Loss (bbl)
                  </label>
                  <Input
                    type="number"
                    min="0"
                    step="1"
                    value={estimatedProductionLossBbl}
                    onChange={(event) => setEstimatedProductionLossBbl(event.target.value)}
                    placeholder="Example: 180"
                    disabled={isPending}
                    className="h-10 border-white/[0.08] bg-white/[0.03] text-white placeholder:text-white/20 focus-visible:ring-[#00D4FF]/30 focus-visible:ring-offset-0"
                  />
                </div>
              </div>

              <div className="space-y-1.5">
                <label className="text-[10px] font-semibold uppercase tracking-[0.12em] text-white/35">
                  Internal Notes
                </label>
                <Textarea
                  value={internalNotes}
                  onChange={(event) => setInternalNotes(event.target.value)}
                  rows={3}
                  placeholder="Internal dispatch notes, tool prep, or field execution context."
                  disabled={isPending}
                  className="min-h-[96px] border-white/[0.08] bg-white/[0.03] text-white placeholder:text-white/20 focus-visible:ring-[#00D4FF]/30 focus-visible:ring-offset-0"
                />
              </div>

              <div className="flex items-center justify-end">
                <Button
                  type="button"
                  onClick={handleSave}
                  disabled={isPending}
                  className="bg-[#00D4FF] text-black hover:bg-[#00D4FF]/90"
                >
                  {isPending ? 'Saving...' : 'Save Fulfillment'}
                </Button>
              </div>
            </>
          )}
        </>
      )}
    </div>
  );
}
