/**
 * ParcelPopup — Glassmorphic popup HTML for health-colored parcels
 *
 * Generates a rich popup showing:
 *   - Parcel header with agreement type + health color bar
 *   - Summary grid: well count, WellFi count, avg run, risk level
 *   - Scrollable well list with individual health indicators
 *
 * Follows the same HTML-string pattern as WellPopup.tsx but for parcel context.
 * No React dependency — pure HTML string generation.
 */
import type { ParcelHealth, ParcelWellSummary } from '@/lib/parcelHealth';

// ─── Health color mapping ─────────────────────────────────────────────────

const HEALTH_BAR_COLORS: Record<number, string> = {
  0: '#22C55E', // empty — faint green
  1: '#4ADE80', // lightest green (< 9 mo)
  2: '#22C55E', // medium green (9-13 mo)
  3: '#16A34A', // dark green (14-16 mo)
  4: '#15803D', // deepest green (17+ mo)
  5: '#34D399', // emerald (upcoming change)
  6: '#6B7280', // gray (no data)
};

const HEALTH_LABELS: Record<number, string> = {
  0: 'No Wells',
  1: 'Healthy',
  2: 'Watch',
  3: 'Caution',
  4: 'Due',
  5: 'Upcoming Change',
  6: 'No Data',
};

// ─── Operational status display ───────────────────────────────────────────

const OP_STATUS_DOT_COLORS: Record<string, string> = {
  watch: '#3B82F6',     // blue
  warning: '#EAB308',   // yellow
  well_down: '#EF4444', // red
};

const OP_STATUS_DOT_LABELS: Record<string, string> = {
  watch: 'Watch',
  warning: 'Warning',
  well_down: 'Well Down',
};

function riskColorForMonths(months: number, hasUpcoming: boolean): string {
  if (hasUpcoming) return '#A855F7';
  if (months >= 17) return '#EF4444';
  if (months >= 14) return '#F97316';
  if (months >= 9) return '#EAB308';
  if (months > 0) return '#22C55E';
  return '#6B7280';
}

function healthLevelFromHealth(h: ParcelHealth): number {
  if (h.wellCount === 0) return 0;
  if (h.hasUpcomingChange) return 5;
  if (h.avgMonthsRunning >= 17) return 4;
  if (h.avgMonthsRunning >= 14) return 3;
  if (h.avgMonthsRunning >= 9) return 2;
  if (h.avgMonthsRunning > 0) return 1;
  return 6;
}

// ─── Public API ───────────────────────────────────────────────────────────

/**
 * Generate glassmorphic popup HTML for a parcel.
 *
 * @param parcelProps      - Raw GeoJSON feature properties from the parcel
 * @param health           - Computed parcel health data
 * @param opStatusByWellId - Optional map of well UUID -> status type ('watch' | 'warning' | 'well_down')
 * @returns HTML string for use with mapboxgl.Popup.setHTML()
 */
export function parcelPopupHTML(
  parcelProps: Record<string, unknown>,
  health: ParcelHealth,
  opStatusByWellId?: Map<string, string>,
): string {
  const agreementType = String(parcelProps.petro_ninja_agreement_type || 'Lease');
  const zone = String(parcelProps.zone_description || '\u2014');
  const level = healthLevelFromHealth(health);
  const barColor = HEALTH_BAR_COLORS[level] ?? '#6B7280';
  const riskLabel = HEALTH_LABELS[level] ?? 'Unknown';

  // Summary grid values
  const wellCount = health.wellCount;
  const wellfiCount = health.wellFiCount;
  const avgRun = health.avgMonthsRunning > 0 ? health.avgMonthsRunning.toFixed(1) : '\u2014';
  const dominantRisk = riskLabel;

  // Well list HTML
  const wellListHTML = buildWellListHTML(health.wells, opStatusByWellId);

  return `
<div style="font-family: system-ui, -apple-system, sans-serif; min-width: 220px; max-width: min(300px, calc(100vw - 40px)); color: #e5e7eb;">
  <!-- Header -->
  <div style="margin-bottom: 10px;">
    <div style="display: flex; align-items: center; gap: 8px; margin-bottom: 4px;">
      <div style="font-size: 14px; font-weight: 700; color: #f9fafb; flex: 1; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
        ${escapeHtml(agreementType)}
      </div>
    </div>
    <div style="font-size: 11px; color: #9ca3af; margin-bottom: 6px;">${escapeHtml(zone)}</div>
    <!-- Health color bar -->
    <div style="height: 3px; border-radius: 2px; background: ${barColor}; opacity: 0.8;"></div>
  </div>

  <!-- Summary Grid (2x2) -->
  <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 6px 12px; font-size: 13px; margin-bottom: 10px;">
    <div>
      <div style="color: #6b7280; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em;">Wells</div>
      <div style="color: #d1d5db; font-weight: 500;">${wellCount}</div>
    </div>
    <div>
      <div style="color: #6b7280; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em;">WellFi</div>
      <div style="display: flex; align-items: center; gap: 4px;">
        <span style="color: #d1d5db; font-weight: 500;">${wellfiCount}</span>
        ${wellfiCount > 0 ? '<span style="width: 6px; height: 6px; border-radius: 50%; background: #00D4FF; display: inline-block;"></span>' : ''}
      </div>
    </div>
    <div>
      <div style="color: #6b7280; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em;">Avg Run</div>
      <div style="color: #d1d5db; font-weight: 500;">${avgRun}${health.avgMonthsRunning > 0 ? ' mo' : ''}</div>
    </div>
    <div>
      <div style="color: #6b7280; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em;">Risk</div>
      <div style="display: inline-block; padding: 1px 6px; border-radius: 9999px; font-size: 11px; font-weight: 600; color: #fff; background: ${barColor};">
        ${escapeHtml(dominantRisk)}
      </div>
    </div>
  </div>

  <!-- Well List -->
  ${wellListHTML}
</div>`;
}

// ─── Helpers ──────────────────────────────────────────────────────────────

function buildWellListHTML(
  wells: ParcelWellSummary[],
  opStatusByWellId?: Map<string, string>,
): string {
  if (wells.length === 0) {
    return `
    <div style="font-size: 11px; color: #6b7280; text-align: center; padding: 8px 0;">
      No wells in this parcel
    </div>`;
  }

  const rows = wells.map((w) => {
    const monthColor = riskColorForMonths(w.monthsRunning, false);
    const displayName = w.name ?? 'Unnamed Well';
    const truncName = displayName.length > 24 ? displayName.slice(0, 22) + '\u2026' : displayName;

    // Operational status dot (if any)
    const opStatus = opStatusByWellId?.get(w.id);
    const opDotColor = opStatus ? OP_STATUS_DOT_COLORS[opStatus] : null;
    const opDotLabel = opStatus ? OP_STATUS_DOT_LABELS[opStatus] ?? opStatus : '';
    const opDotHTML = opDotColor
      ? `<div style="width: 6px; height: 6px; border-radius: 50%; background: ${opDotColor}; flex-shrink: 0;" title="${escapeHtml(opDotLabel)}"></div>`
      : '';

    return `
      <div
        data-well-id="${escapeHtml(w.id)}"
        style="display: flex; align-items: center; gap: 6px; padding: 5px 6px; border-radius: 4px; cursor: pointer; min-height: 36px; transition: background 0.15s;"
        onmouseover="this.style.background='rgba(255,255,255,0.04)'"
        onmouseout="this.style.background='transparent'"
      >
        ${opDotHTML}
        <div style="flex: 1; font-size: 12px; color: #d1d5db; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
          ${escapeHtml(truncName)}
        </div>
        <div style="font-size: 11px; font-weight: 600; color: ${monthColor}; white-space: nowrap;">
          ${w.monthsRunning}mo
        </div>
        ${w.hasWellfi ? '<div style="width: 5px; height: 5px; border-radius: 50%; background: #00D4FF; flex-shrink: 0;" title="WellFi"></div>' : '<div style="width: 5px; flex-shrink: 0;"></div>'}
      </div>`;
  }).join('');

  return `
  <div style="border-top: 1px solid rgba(255, 255, 255, 0.06); padding-top: 8px;">
    <div style="font-size: 10px; color: #6b7280; text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 4px;">
      Wells (${wells.length})
    </div>
    <div style="max-height: 200px; overflow-y: auto; scrollbar-width: thin; scrollbar-color: rgba(255,255,255,0.1) transparent;">
      ${rows}
    </div>
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
