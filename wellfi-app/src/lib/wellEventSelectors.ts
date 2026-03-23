import type { OperationalStatusType, WellEnriched } from '@/types/operationalStatus';

export function getWellEventOperationalStatus(well: WellEnriched): OperationalStatusType | null {
  const eventState = well.active_well_event?.is_active ? well.active_well_event.state : null;

  if (eventState === 'down') return 'well_down';
  if (eventState === 'warning') return 'warning';
  if (eventState === 'watch') return 'watch';

  return well.operational_status?.is_active ? well.operational_status.status : null;
}

export function isWellFlagged(well: WellEnriched): boolean {
  return Boolean(getWellEventOperationalStatus(well));
}

export function isWellDownNow(well: WellEnriched): boolean {
  return getWellEventOperationalStatus(well) === 'well_down';
}

export function needsToolAssignment(well: WellEnriched): boolean {
  const fulfillmentStatus = well.well_event_fulfillment?.status ?? 'unassigned';

  return Boolean(
    well.active_well_event?.is_active
    && well.active_well_event.support_requested
    && !well.well_event_fulfillment?.assigned_tool_id
    && !['completed', 'cancelled'].includes(fulfillmentStatus),
  );
}

export function hasScheduledSupport(well: WellEnriched): boolean {
  const fulfillmentStatus = well.well_event_fulfillment?.status ?? 'unassigned';

  if (!well.active_well_event?.is_active || ['completed', 'cancelled'].includes(fulfillmentStatus)) {
    return false;
  }

  return Boolean(
    well.well_event_fulfillment?.planned_service_date
    || ['scheduled', 'dispatched', 'on_site'].includes(fulfillmentStatus),
  );
}

export function getRequestedOrAssignedToolSummary(well: WellEnriched): string | null {
  if (well.assigned_tool) {
    return `${well.assigned_tool.serial_number} | ${well.assigned_tool.tool_type}`;
  }

  if (well.active_well_event?.requested_tool_type) {
    return `Requested ${well.active_well_event.requested_tool_type}`;
  }

  return null;
}
