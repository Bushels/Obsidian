import { riskColor } from '@/lib/mapUtils';
import { SERVICE_WELL_COLOR } from '@/lib/wellClassification';

interface WellPopupOptions {
  showViewDetails?: boolean;
}

const MONITOR_STAGE_LABELS: Record<string, { label: string; color: string }> = {
  watch: { label: 'Watch', color: '#3B82F6' },
  warning: { label: 'Warning', color: '#EAB308' },
  well_down: { label: 'Well Down', color: '#EF4444' },
};

const PUMP_CHANGE_LABELS: Record<string, { label: string; color: string }> = {
  warning: { label: 'Pump Change Warning', color: '#F97316' },
  scheduled: { label: 'Pump Change Scheduled', color: '#06B6D4' },
  in_progress: { label: 'Pump Change In Progress', color: '#8B5CF6' },
  completed: { label: 'Pump Changed', color: '#22C55E' },
  cancelled: { label: 'Pump Change Cancelled', color: '#64748B' },
};

const FULFILLMENT_LABELS: Record<string, { label: string; color: string }> = {
  unassigned: { label: 'Unassigned', color: '#94A3B8' },
  tool_reserved: { label: 'Tool Reserved', color: '#22C55E' },
  scheduled: { label: 'Scheduled', color: '#0EA5E9' },
  dispatched: { label: 'Dispatched', color: '#8B5CF6' },
  on_site: { label: 'On Site', color: '#F97316' },
  completed: { label: 'Completed', color: '#14B8A6' },
  cancelled: { label: 'Cancelled', color: '#64748B' },
};

/**
 * Generates an HTML string for a mapboxgl.Popup.
 * Receives the GeoJSON feature properties (not a full Well object).
 */
export function wellPopupHTML(
  properties: Record<string, unknown>,
  options: WellPopupOptions = {},
): string {
  const showViewDetails = options.showViewDetails ?? true;
  const name = asString(properties.name, 'Unnamed Well');
  const formattedId = asNullableString(properties.formatted_id);
  const wellId = asNullableString(properties.well_id);
  const displayId = formattedId ?? wellId ?? 'Unknown well';
  const riskLevel = asString(properties.risk_level, 'UNKNOWN');
  const formation = asString(properties.formation, '-');
  const field = asString(properties.field, '-');
  const wellType = asNullableString(properties.well_type);
  const wellFluid = asNullableString(properties.well_fluid);
  const isServiceWell = properties.is_service_well === true;
  const operatingDays = asNumber(properties.operating_days_12mo);
  const annualUptime = asNumber(properties.annual_uptime_pct);
  const decRate = asNumber(properties.dec_rate_bbl_d);
  const cumulativeOil = asNumber(properties.cumulative_oil);
  const hasWellfi = properties.has_wellfi === true;
  const opStatus = asNullableString(properties.op_status);
  const eventExpectedDownDate = asNullableString(properties.event_expected_down_date);
  const eventExpectedStartDate = asNullableString(properties.event_expected_start_date);
  const eventExpectedEndDate = asNullableString(properties.event_expected_end_date);
  const eventSupportRequested = properties.event_support_requested === true;
  const requestedOrAssignedTool = asNullableString(properties.requested_or_assigned_tool);
  const fulfillmentStatus = asNullableString(properties.fulfillment_status);
  const plannedServiceDate = asNullableString(properties.planned_service_date);
  const assignedTechName = asNullableString(properties.assigned_tech_name);
  const pumpChangeStatus = asNullableString(properties.pump_change_status);
  const pumpChangeDate = asNullableString(properties.pump_change_date);
  const pumpChangeNotes = asNullableString(properties.pump_change_notes);
  const latestSnapshotMonth = asNullableString(properties.latest_production_snapshot_month);
  const latestSnapshotStatus = asNullableString(properties.latest_production_snapshot_status);
  const id = asString(properties.id, '');

  const riskBadgeColor = riskColor(riskLevel);
  const monitorStage = opStatus ? MONITOR_STAGE_LABELS[opStatus] : null;
  const fulfillmentStage = fulfillmentStatus ? FULFILLMENT_LABELS[fulfillmentStatus] : null;
  const pumpChangeStage = pumpChangeStatus ? PUMP_CHANGE_LABELS[pumpChangeStatus] : null;
  const snapshotStatusLabel =
    latestSnapshotStatus === 'present'
      ? 'Present in latest snapshot'
      : latestSnapshotStatus === 'missing'
        ? 'Missing from latest snapshot'
        : latestSnapshotStatus === 'unknown'
          ? 'Unknown'
          : null;
  const detailRows = [
    wellType ? renderDetailRow('Well type', wellType) : '',
    wellFluid ? renderDetailRow('Fluid', wellFluid) : '',
    latestSnapshotMonth ? renderDetailRow('Snapshot month', formatMonth(latestSnapshotMonth)) : '',
    snapshotStatusLabel ? renderDetailRow('Snapshot status', snapshotStatusLabel) : '',
    renderDetailRow('Stage', monitorStage?.label ?? '-'),
    requestedOrAssignedTool ? renderDetailRow('Tool', requestedOrAssignedTool) : '',
    plannedServiceDate ? renderDetailRow('Planned service', formatDate(plannedServiceDate)) : '',
    assignedTechName ? renderDetailRow('Assigned tech', assignedTechName) : '',
    eventExpectedDownDate ? renderDetailRow('Expected down', formatDate(eventExpectedDownDate)) : '',
    eventExpectedStartDate || eventExpectedEndDate
      ? renderDetailRow(
        'Expected window',
        `${formatDate(eventExpectedStartDate ?? 'Not set')} to ${formatDate(eventExpectedEndDate ?? 'Not set')}`,
      )
      : '',
    eventSupportRequested ? renderDetailRow('Support', 'Requested') : '',
    fulfillmentStage ? renderDetailRow('Fulfillment', fulfillmentStage.label) : '',
    pumpChangeStage ? renderDetailRow('Pump change', pumpChangeStage.label) : '',
    pumpChangeDate ? renderDetailRow('Pump change date', formatDate(pumpChangeDate)) : '',
  ].filter(Boolean).join('');

  return `
<div style="font-family: system-ui, -apple-system, sans-serif; min-width: 250px; color: #e5e7eb;">
  <div style="display: flex; align-items: center; gap: 8px; margin-bottom: 8px;">
    <div style="font-size: 14px; font-weight: 700; color: #f9fafb; flex: 1; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
      ${escapeHtml(name)}
    </div>
    ${hasWellfi ? '<div style="width: 8px; height: 8px; border-radius: 9999px; background: #00D4FF; box-shadow: 0 0 10px rgba(0, 212, 255, 0.55); flex-shrink: 0;" title="Active WellFi Device"></div>' : ''}
  </div>

  <div style="font-size: 11px; color: #94a3b8; margin-bottom: 10px;">${escapeHtml(displayId)}</div>

  <div style="display: flex; flex-wrap: wrap; gap: 6px; margin-bottom: 12px;">
    ${renderBadge(riskLevel, riskBadgeColor)}
    ${isServiceWell && wellType
      ? renderBadge(wellType, SERVICE_WELL_COLOR, '#07293A', '#7DD3FC')
      : ''}
    ${monitorStage ? renderBadge(monitorStage.label, monitorStage.color) : ''}
    ${fulfillmentStage ? renderBadge(fulfillmentStage.label, fulfillmentStage.color, `${fulfillmentStage.color}20`, fulfillmentStage.color) : ''}
    ${pumpChangeStage ? renderBadge(pumpChangeStage.label, pumpChangeStage.color) : ''}
    ${hasWellfi ? renderBadge('WellFi Monitored', '#00D4FF', '#03141C', '#67E8F9') : ''}
  </div>

  <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 8px 12px; font-size: 12px; margin-bottom: 12px;">
    ${renderMetric('Formation', formation)}
    ${renderMetric('Field', field)}
    ${renderMetric('Days Operating (12mo)', isServiceWell ? 'Service well' : operatingDays != null ? formatInteger(operatingDays) : 'N/A')}
    ${renderMetric('Uptime', isServiceWell ? 'N/A' : annualUptime != null ? `${formatNumber(annualUptime, 1)}%` : 'N/A')}
    ${renderMetric('Latest Oil Rate', decRate != null ? `${formatNumber(decRate, 1)} bbl/d` : 'N/A')}
    ${renderMetric('Cumulative Oil', cumulativeOil != null ? `${formatInteger(cumulativeOil)} bbl` : 'N/A')}
  </div>

  ${detailRows ? `
  <div style="margin-bottom: 12px; padding-top: 10px; border-top: 1px solid rgba(148, 163, 184, 0.16);">
    ${detailRows}
    ${pumpChangeNotes ? `
      <div style="margin-top: 8px;">
        <div style="color: #64748b; font-size: 10px; text-transform: uppercase; letter-spacing: 0.05em;">Notes</div>
        <div style="color: #cbd5e1; font-size: 12px; line-height: 1.45;">${escapeHtml(truncate(pumpChangeNotes, 140))}</div>
      </div>
    ` : ''}
  </div>` : ''}

  ${showViewDetails ? `
  <button
    data-well-id="${escapeHtml(id)}"
    style="width: 100%; padding: 7px 0; border: 1px solid #334155; border-radius: 8px; background: #0f172a; color: #67E8F9; font-size: 12px; font-weight: 600; cursor: pointer; transition: background 0.15s;"
    onmouseover="this.style.background='#1e293b'"
    onmouseout="this.style.background='#0f172a'"
  >
    View Details
  </button>` : ''}
</div>`;
}

function renderBadge(
  label: string,
  color: string,
  background = color,
  textColor = '#FFFFFF',
): string {
  return `<span style="display: inline-flex; align-items: center; padding: 2px 8px; border-radius: 9999px; font-size: 11px; font-weight: 600; color: ${textColor}; background: ${background};">${escapeHtml(label)}</span>`;
}

function renderMetric(label: string, value: string): string {
  return `
    <div>
      <div style="color: #64748b; font-size: 10px; text-transform: uppercase; letter-spacing: 0.05em;">${escapeHtml(label)}</div>
      <div style="color: #d1d5db; font-weight: 500;">${escapeHtml(value)}</div>
    </div>`;
}

function renderDetailRow(label: string, value: string): string {
  return `
    <div style="display: flex; align-items: baseline; justify-content: space-between; gap: 12px; font-size: 12px; margin-bottom: 4px;">
      <span style="color: #64748b;">${escapeHtml(label)}</span>
      <span style="color: #e2e8f0; font-weight: 600; text-align: right;">${escapeHtml(value)}</span>
    </div>`;
}

function asString(value: unknown, fallback: string): string {
  return typeof value === 'string' && value.trim().length > 0 ? value : fallback;
}

function asNullableString(value: unknown): string | null {
  return typeof value === 'string' && value.trim().length > 0 ? value : null;
}

function asNumber(value: unknown): number | null {
  if (typeof value === 'number' && Number.isFinite(value)) return value;
  if (typeof value === 'string' && value.trim().length > 0) {
    const parsed = Number(value);
    return Number.isFinite(parsed) ? parsed : null;
  }
  return null;
}

function formatNumber(value: number, digits: number): string {
  return value.toLocaleString('en-CA', {
    minimumFractionDigits: digits,
    maximumFractionDigits: digits,
  });
}

function formatInteger(value: number): string {
  return Math.round(value).toLocaleString('en-CA');
}

function formatDate(value: string): string {
  const parsed = parseDateInput(value);
  if (Number.isNaN(parsed.getTime())) {
    return value;
  }
  return parsed.toLocaleDateString('en-CA', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
  });
}

function formatMonth(value: string): string {
  const parsed = parseDateInput(value);
  if (Number.isNaN(parsed.getTime())) {
    return value;
  }
  return parsed.toLocaleDateString('en-CA', {
    year: 'numeric',
    month: 'short',
  });
}

function parseDateInput(value: string): Date {
  const trimmed = value.trim();
  const dateOnlyMatch = trimmed.match(/^(\d{4})-(\d{2})-(\d{2})$/);

  if (dateOnlyMatch) {
    const [, year, month, day] = dateOnlyMatch;
    return new Date(Number(year), Number(month) - 1, Number(day));
  }

  return new Date(trimmed);
}

function truncate(value: string, maxLength: number): string {
  return value.length > maxLength ? `${value.slice(0, maxLength - 1)}...` : value;
}

function escapeHtml(str: string): string {
  return str
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}
