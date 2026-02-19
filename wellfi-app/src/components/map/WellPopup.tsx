import { riskColor } from '@/lib/mapUtils';

/**
 * Generates an HTML string for a mapboxgl.Popup.
 * Receives the GeoJSON feature properties (not a full Well object).
 */
export function wellPopupHTML(properties: Record<string, unknown>): string {
  const name = (properties.name as string) ?? 'Unnamed Well';
  const wellId = (properties.well_id as string) ?? '';
  const riskLevel = (properties.risk_level as string) ?? 'UNKNOWN';
  const formation = (properties.formation as string) ?? '—';
  const field = (properties.field as string) ?? '—';
  const monthsRunning = (properties.months_running as number) ?? 0;
  const decRate = (properties.dec_rate_bbl_d as number) ?? 0;
  const cumulativeOil = (properties.cumulative_oil as number) ?? 0;
  const hasWellfi = properties.has_wellfi === true;
  const id = (properties.id as string) ?? '';

  const badgeColor = riskColor(riskLevel);

  return `
<div style="font-family: system-ui, -apple-system, sans-serif; min-width: 220px; color: #e5e7eb;">
  <div style="display: flex; align-items: center; gap: 8px; margin-bottom: 8px;">
    <div style="font-size: 14px; font-weight: 700; color: #f9fafb; flex: 1; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
      ${escapeHtml(name)}
    </div>
    ${hasWellfi ? '<div style="width: 8px; height: 8px; border-radius: 50%; background: #00D4FF; flex-shrink: 0;" title="WellFi Device"></div>' : ''}
  </div>

  <div style="font-size: 11px; color: #9ca3af; margin-bottom: 8px;">${escapeHtml(wellId)}</div>

  <div style="display: inline-block; padding: 2px 8px; border-radius: 9999px; font-size: 11px; font-weight: 600; color: #fff; background: ${badgeColor}; margin-bottom: 10px;">
    ${escapeHtml(riskLevel)}
  </div>

  <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 6px 12px; font-size: 12px; margin-bottom: 10px;">
    <div>
      <div style="color: #6b7280; font-size: 10px; text-transform: uppercase; letter-spacing: 0.05em;">Formation</div>
      <div style="color: #d1d5db; font-weight: 500;">${escapeHtml(formation)}</div>
    </div>
    <div>
      <div style="color: #6b7280; font-size: 10px; text-transform: uppercase; letter-spacing: 0.05em;">Field</div>
      <div style="color: #d1d5db; font-weight: 500;">${escapeHtml(field)}</div>
    </div>
    <div>
      <div style="color: #6b7280; font-size: 10px; text-transform: uppercase; letter-spacing: 0.05em;">Months Running</div>
      <div style="color: #d1d5db; font-weight: 500;">${monthsRunning}</div>
    </div>
    <div>
      <div style="color: #6b7280; font-size: 10px; text-transform: uppercase; letter-spacing: 0.05em;">Dec Rate</div>
      <div style="color: #d1d5db; font-weight: 500;">${decRate.toFixed(1)} bbl/d</div>
    </div>
    <div style="grid-column: span 2;">
      <div style="color: #6b7280; font-size: 10px; text-transform: uppercase; letter-spacing: 0.05em;">Cumulative Oil</div>
      <div style="color: #d1d5db; font-weight: 500;">${cumulativeOil.toLocaleString()} bbl</div>
    </div>
  </div>

  <button
    data-well-id="${escapeHtml(id)}"
    style="width: 100%; padding: 6px 0; border: 1px solid #374151; border-radius: 6px; background: #1f2937; color: #00D4FF; font-size: 12px; font-weight: 600; cursor: pointer; transition: background 0.15s;"
    onmouseover="this.style.background='#374151'"
    onmouseout="this.style.background='#1f2937'"
  >
    View Details
  </button>
</div>`;
}

function escapeHtml(str: string): string {
  return str
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}
