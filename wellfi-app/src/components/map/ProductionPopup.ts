/**
 * ProductionPopup — Hover tooltip for production well dots
 */

export function productionDotPopupHTML(
  properties: Record<string, unknown>,
): string {
  const uwi = String(properties.uwi ?? '');
  const operator = String(properties.operator ?? '');
  const formation = String(properties.formation ?? '');
  const fluidType = String(properties.fluid_type ?? 'oil');
  const recentOil = Number(properties.recent_oil) || 0;
  const recentGas = Number(properties.recent_gas) || 0;
  const recentWater = Number(properties.recent_water) || 0;
  const fieldName = String(properties.field_name ?? '');
  const opStatus = String(properties.op_status ?? 'normal');

  const isGas = fluidType === 'gas';
  const formationColor = formation === 'Clearwater'
    ? (isGas ? '#86EFAC' : '#22C55E')
    : (isGas ? '#FCD34D' : '#F59E0B');

  const fluidBadge = `<span style="
      display:inline-block; padding:1px 6px; border-radius:4px; font-size:10px;
      background:${isGas ? 'rgba(134,239,172,0.15)' : 'rgba(34,197,94,0.15)'};
      color:${formationColor};
      margin-left:6px;
    ">${isGas ? 'GAS' : 'OIL'}</span>`;

  const statusBadge = opStatus !== 'normal'
    ? `<span style="
        display:inline-block; padding:1px 6px; border-radius:4px; font-size:10px;
        background:${opStatus === 'watch' ? 'rgba(59,130,246,0.2)' : 'rgba(239,68,68,0.2)'};
        color:${opStatus === 'watch' ? '#60A5FA' : '#F87171'};
        margin-left:6px;
      ">${opStatus.toUpperCase()}</span>`
    : '';

  const primaryLabel = isGas ? 'Gas' : 'Oil';
  const primaryValue = isGas ? recentGas : recentOil;
  const secondaryLabel = isGas ? 'Oil' : 'Gas';
  const secondaryValue = isGas ? recentOil : recentGas;

  return `
    <div style="font-family:Inter,system-ui,sans-serif; color:#E5E7EB; min-width:200px;">
      <div style="font-size:11px; color:#9CA3AF; margin-bottom:4px;">
        ${uwi}${fluidBadge}${statusBadge}
      </div>
      <div style="font-size:13px; font-weight:600; margin-bottom:2px;">
        ${operator}
      </div>
      <div style="font-size:11px; margin-bottom:8px;">
        <span style="color:${formationColor}; font-weight:500;">${formation}</span>
        <span style="color:#6B7280; margin-left:4px;">${fieldName}</span>
      </div>
      <div style="display:grid; grid-template-columns:1fr 1fr 1fr; gap:4px; font-size:11px;">
        <div>
          <div style="color:#9CA3AF;">${primaryLabel}</div>
          <div style="font-weight:600; color:${formationColor};">${primaryValue.toFixed(1)}</div>
        </div>
        <div>
          <div style="color:#9CA3AF;">${secondaryLabel}</div>
          <div style="font-weight:500;">${secondaryValue.toFixed(1)}</div>
        </div>
        <div>
          <div style="color:#9CA3AF;">Water</div>
          <div style="font-weight:500;">${recentWater.toFixed(1)}</div>
        </div>
      </div>
    </div>
  `;
}
