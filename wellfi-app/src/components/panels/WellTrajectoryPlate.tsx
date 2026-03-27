import type { Well } from '@/types';
import {
  componentLengthM,
  getCurrentCompletionSnapshot,
  getHighlightAnchorPoint,
  type CompletionComponent,
  type TrajectoryPoint,
  type WellGeometryAsset,
} from '@/lib/wellGeometry';

interface WellTrajectoryPlateProps {
  well: Well;
  asset: WellGeometryAsset;
  heightClassName: string;
}

const SECTION_WIDTH = 760;
const SECTION_HEIGHT = 420;
const PLAN_WIDTH = 320;
const PLAN_HEIGHT = 240;
const STRIP_WIDTH = 920;
const STRIP_HEIGHT = 150;

function accentColor(componentId: CompletionComponent['id']): string {
  switch (componentId) {
    case 'pump':
      return '#d4a017';
    case 'slotted_tag_bar':
      return '#4ec3ff';
    case 'wellfi_tool':
      return '#1ecad3';
    case 'no_turn_tool':
      return '#5b7fff';
    case 'collar':
      return '#d7dde8';
    default:
      return '#d7dde8';
  }
}

function badgeClassName(componentId: CompletionComponent['id']): string {
  switch (componentId) {
    case 'pump':
      return 'border-amber-300/35 bg-amber-300/12 text-amber-100';
    case 'slotted_tag_bar':
      return 'border-sky-300/35 bg-sky-300/12 text-sky-100';
    case 'wellfi_tool':
      return 'border-cyan-300/35 bg-cyan-300/12 text-cyan-100';
    case 'no_turn_tool':
      return 'border-indigo-300/35 bg-indigo-300/12 text-indigo-100';
    case 'collar':
      return 'border-slate-200/25 bg-slate-200/10 text-slate-100';
    default:
      return 'border-slate-200/25 bg-slate-200/10 text-slate-100';
  }
}

function formatSignedDepth(value: number): string {
  const sign = value >= 0 ? '+' : '-';
  return `${sign}${Math.abs(value).toFixed(2)} m`;
}

function formatDate(date: string): string {
  return date;
}

function mapRange(value: number, domainMin: number, domainMax: number, rangeMin: number, rangeMax: number): number {
  if (domainMax - domainMin === 0) return (rangeMin + rangeMax) / 2;
  return rangeMin + ((value - domainMin) / (domainMax - domainMin)) * (rangeMax - rangeMin);
}

function buildSvgPath(
  points: readonly TrajectoryPoint[],
  xSelector: (point: TrajectoryPoint) => number,
  ySelector: (point: TrajectoryPoint) => number,
  xDomain: [number, number],
  yDomain: [number, number],
  width: number,
  height: number,
  padding: { left: number; right: number; top: number; bottom: number },
): string {
  return points
    .map((point, index) => {
      const x = mapRange(
        xSelector(point),
        xDomain[0],
        xDomain[1],
        padding.left,
        width - padding.right,
      );
      const y = mapRange(
        ySelector(point),
        yDomain[0],
        yDomain[1],
        padding.top,
        height - padding.bottom,
      );
      return `${index === 0 ? 'M' : 'L'}${x.toFixed(2)} ${y.toFixed(2)}`;
    })
    .join(' ');
}

export function WellTrajectoryPlate({ well, asset, heightClassName }: WellTrajectoryPlateProps) {
  const snapshot = getCurrentCompletionSnapshot(asset);
  const highlight = getHighlightAnchorPoint(asset);
  const avgPumpRuntime = asset.summary_metrics?.find((metric) => metric.id === 'avg_pump_runtime_pre_wellfi') ?? null;

  const sectionPadding = { left: 64, right: 28, top: 32, bottom: 54 };
  const planPadding = { left: 36, right: 18, top: 22, bottom: 38 };
  const stripPadding = { left: 28, right: 28, top: 24, bottom: 34 };

  const sectionMaxVs = Math.max(...asset.survey_points.map((point) => point.vertical_section_m), highlight?.trajectory?.vertical_section_m ?? 0);
  const sectionMaxTvd = Math.max(...asset.survey_points.map((point) => point.tvd_m), highlight?.trajectory?.tvd_m ?? 0);
  const sectionXDomain: [number, number] = [0, Math.max(sectionMaxVs + 18, 60)];
  const sectionYDomain: [number, number] = [0, Math.max(sectionMaxTvd + 20, 80)];
  const sectionMetrics = {
    xDomain: sectionXDomain,
    yDomain: sectionYDomain,
    path: buildSvgPath(
      asset.survey_points,
      (point) => point.vertical_section_m,
      (point) => point.tvd_m,
      sectionXDomain,
      sectionYDomain,
      SECTION_WIDTH,
      SECTION_HEIGHT,
      sectionPadding,
    ),
  };

  const eastValues = asset.survey_points.map((point) => point.easting_offset_m);
  const northValues = asset.survey_points.map((point) => point.northing_offset_m);
  const highlightEast = highlight?.trajectory?.easting_offset_m ?? 0;
  const highlightNorth = highlight?.trajectory?.northing_offset_m ?? 0;
  const planXDomain: [number, number] = [
    Math.min(...eastValues, highlightEast) - 24,
    Math.max(...eastValues, highlightEast) + 24,
  ];
  const planYDomain: [number, number] = [
    Math.max(...northValues, highlightNorth) + 18,
    Math.min(...northValues, highlightNorth) - 18,
  ];
  const planMetrics = {
    xDomain: planXDomain,
    yDomain: planYDomain,
    path: buildSvgPath(
      asset.survey_points,
      (point) => point.easting_offset_m,
      (point) => point.northing_offset_m,
      planXDomain,
      planYDomain,
      PLAN_WIDTH,
      PLAN_HEIGHT,
      planPadding,
    ),
  };

  const components = snapshot?.components ?? [];
  const stripTop = components.length > 0 ? Math.min(...components.map((component) => component.top_mkb)) : 0;
  const stripBottom = components.length > 0 ? Math.max(...components.map((component) => component.bottom_mkb)) : 1;
  const stripMetrics = {
    focusMin: Math.max(0, stripTop - 0.65),
    focusMax: stripBottom + 0.4,
  };

  if (!snapshot || !highlight || !highlight.trajectory) {
    return (
      <div className={`flex items-center justify-center rounded-xl border border-slate-700/70 bg-slate-950/80 ${heightClassName}`}>
        <p className="px-6 text-center text-sm text-slate-400">
          Survey geometry is not available for this well yet.
        </p>
      </div>
    );
  }

  const sectionAnchorX = mapRange(
    highlight.trajectory.vertical_section_m,
    sectionMetrics.xDomain[0],
    sectionMetrics.xDomain[1],
    sectionPadding.left,
    SECTION_WIDTH - sectionPadding.right,
  );
  const sectionAnchorY = mapRange(
    highlight.trajectory.tvd_m,
    sectionMetrics.yDomain[0],
    sectionMetrics.yDomain[1],
    sectionPadding.top,
    SECTION_HEIGHT - sectionPadding.bottom,
  );

  const planAnchorX = mapRange(
    highlight.trajectory.easting_offset_m,
    planMetrics.xDomain[0],
    planMetrics.xDomain[1],
    planPadding.left,
    PLAN_WIDTH - planPadding.right,
  );
  const planAnchorY = mapRange(
    highlight.trajectory.northing_offset_m,
    planMetrics.yDomain[0],
    planMetrics.yDomain[1],
    planPadding.top,
    PLAN_HEIGHT - planPadding.bottom,
  );

  const focusWidth = STRIP_WIDTH - stripPadding.left - stripPadding.right;
  const highlightStripX = mapRange(
    highlight.anchor_md_m,
    stripMetrics.focusMin,
    stripMetrics.focusMax,
    stripPadding.left,
    STRIP_WIDTH - stripPadding.right,
  );

  const sectionXticks = Array.from({ length: 5 }, (_, index) => roundTick(sectionMetrics.xDomain[1], index, 4));
  const sectionYticks = Array.from({ length: 5 }, (_, index) => roundTick(sectionMetrics.yDomain[1], index, 4));
  const stripTicks = Array.from({ length: 6 }, (_, index) => {
    const value = stripMetrics.focusMin + ((stripMetrics.focusMax - stripMetrics.focusMin) * index) / 5;
    return Number(value.toFixed(2));
  });

  return (
    <div className={`relative overflow-hidden rounded-xl border border-slate-700/70 ${heightClassName}`}>
      <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_left,rgba(92,172,223,0.20),transparent_38%),radial-gradient(circle_at_bottom_right,rgba(212,160,23,0.12),transparent_32%),linear-gradient(180deg,#08111f_0%,#020617_100%)]" />
      <div className="relative flex h-full flex-col gap-4 p-4">
        <div className="flex flex-wrap gap-2">
          <span className="rounded-full border border-slate-600/70 bg-slate-950/70 px-3 py-1 text-[10px] uppercase tracking-[0.18em] text-slate-200">
            Trajectory Plate
          </span>
          <span className="rounded-full border border-slate-600/70 bg-slate-950/70 px-3 py-1 text-[10px] uppercase tracking-[0.18em] text-slate-300">
            {asset.source_uwi}
          </span>
          <span className={`rounded-full border px-3 py-1 text-[10px] uppercase tracking-[0.18em] ${badgeClassName(highlight.component.id)}`}>
            {highlight.label}
          </span>
          <span className="rounded-full border border-slate-600/70 bg-slate-950/70 px-3 py-1 text-[10px] uppercase tracking-[0.18em] text-slate-300">
            Snapshot {formatDate(snapshot.run_date)}
          </span>
        </div>

        {avgPumpRuntime ? (
          <div className="grid gap-3 rounded-xl border border-amber-300/20 bg-slate-950/45 p-3 shadow-[inset_0_1px_0_rgba(255,255,255,0.03)] md:grid-cols-[220px_minmax(0,1fr)]">
            <div>
              <div className="text-[10px] font-semibold uppercase tracking-[0.22em] text-amber-200/80">
                {avgPumpRuntime.label}
              </div>
              <div className="mt-1 text-2xl font-semibold text-amber-100">
                {avgPumpRuntime.value.toFixed(1)}{' '}
                <span className="text-sm font-medium text-amber-200/75">{avgPumpRuntime.unit}</span>
              </div>
            </div>
            <div className="flex items-center text-sm text-slate-300">
              {avgPumpRuntime.context}
            </div>
          </div>
        ) : null}

        <div className="grid min-h-0 flex-1 gap-4 xl:grid-cols-[minmax(0,1fr)_280px]">
          <div className="min-h-0 rounded-xl border border-slate-700/70 bg-slate-950/45 p-3 shadow-[inset_0_1px_0_rgba(255,255,255,0.03)]">
            <div className="mb-3 flex flex-wrap items-end justify-between gap-3">
              <div>
                <div className="text-[11px] font-semibold uppercase tracking-[0.22em] text-slate-400">Section View</div>
                <div className="mt-1 text-sm font-semibold text-slate-100">Actual well deviation from the final survey</div>
              </div>
              <div className="text-right text-[11px] text-slate-400">
                <div>{well.name ?? asset.well_name}</div>
                <div>Licence {asset.licence}</div>
              </div>
            </div>
            <svg viewBox={`0 0 ${SECTION_WIDTH} ${SECTION_HEIGHT}`} className="h-full min-h-[260px] w-full">
              <defs>
                <linearGradient id="trajectory-section-line" x1="0%" y1="0%" x2="100%" y2="0%">
                  <stop offset="0%" stopColor="#7dd3fc" />
                  <stop offset="100%" stopColor="#facc15" />
                </linearGradient>
              </defs>

              <rect
                x={sectionPadding.left}
                y={sectionPadding.top}
                width={SECTION_WIDTH - sectionPadding.left - sectionPadding.right}
                height={SECTION_HEIGHT - sectionPadding.top - sectionPadding.bottom}
                rx="18"
                fill="rgba(15,23,42,0.55)"
                stroke="rgba(148,163,184,0.18)"
              />

              {sectionYticks.map((tick) => {
                const y = mapRange(
                  tick,
                  sectionMetrics.yDomain[0],
                  sectionMetrics.yDomain[1],
                  sectionPadding.top,
                  SECTION_HEIGHT - sectionPadding.bottom,
                );
                return (
                  <g key={`section-y-${tick}`}>
                    <line
                      x1={sectionPadding.left}
                      x2={SECTION_WIDTH - sectionPadding.right}
                      y1={y}
                      y2={y}
                      stroke="rgba(148,163,184,0.14)"
                      strokeDasharray="4 8"
                    />
                    <text x={16} y={y + 4} fill="#94a3b8" fontSize="10">
                      {Math.round(tick)} m TVD
                    </text>
                  </g>
                );
              })}

              {sectionXticks.map((tick) => {
                const x = mapRange(
                  tick,
                  sectionMetrics.xDomain[0],
                  sectionMetrics.xDomain[1],
                  sectionPadding.left,
                  SECTION_WIDTH - sectionPadding.right,
                );
                return (
                  <g key={`section-x-${tick}`}>
                    <line
                      x1={x}
                      x2={x}
                      y1={sectionPadding.top}
                      y2={SECTION_HEIGHT - sectionPadding.bottom}
                      stroke="rgba(148,163,184,0.12)"
                      strokeDasharray="4 8"
                    />
                    <text x={x} y={SECTION_HEIGHT - 16} textAnchor="middle" fill="#94a3b8" fontSize="10">
                      {Math.round(tick)}
                    </text>
                  </g>
                );
              })}

              <path
                d={sectionMetrics.path}
                fill="none"
                stroke="url(#trajectory-section-line)"
                strokeWidth="6"
                strokeLinecap="round"
                strokeLinejoin="round"
                opacity="0.18"
              />
              <path
                d={sectionMetrics.path}
                fill="none"
                stroke="url(#trajectory-section-line)"
                strokeWidth="3.2"
                strokeLinecap="round"
                strokeLinejoin="round"
              />

              <line
                x1={sectionAnchorX}
                x2={sectionAnchorX}
                y1={sectionPadding.top}
                y2={SECTION_HEIGHT - sectionPadding.bottom}
                stroke="rgba(78,195,255,0.7)"
                strokeDasharray="6 8"
              />
              <line
                x1={sectionPadding.left}
                x2={sectionAnchorX}
                y1={sectionAnchorY}
                y2={sectionAnchorY}
                stroke="rgba(78,195,255,0.7)"
                strokeDasharray="6 8"
              />
              <circle cx={sectionAnchorX} cy={sectionAnchorY} r="9" fill="rgba(78,195,255,0.16)" />
              <circle cx={sectionAnchorX} cy={sectionAnchorY} r="4.5" fill="#4ec3ff" />

              <g transform={`translate(${Math.min(sectionAnchorX + 14, SECTION_WIDTH - 220)} ${Math.max(sectionAnchorY - 72, 44)})`}>
                <rect
                  width="202"
                  height="64"
                  rx="14"
                  fill="rgba(2,6,23,0.86)"
                  stroke="rgba(78,195,255,0.35)"
                />
                <text x="14" y="22" fill="#f8fafc" fontSize="12" fontWeight="700">
                  {highlight.label}
                </text>
                <text x="14" y="40" fill="#94a3b8" fontSize="11">
                  MD {highlight.anchor_md_m.toFixed(2)} mKB
                </text>
                <text x="14" y="55" fill="#94a3b8" fontSize="11">
                  TVD {highlight.trajectory.tvd_m.toFixed(2)} m
                </text>
              </g>

              <text
                x={(sectionPadding.left + SECTION_WIDTH - sectionPadding.right) / 2}
                y={SECTION_HEIGHT - 6}
                textAnchor="middle"
                fill="#cbd5e1"
                fontSize="11"
                letterSpacing="2"
              >
                VERTICAL SECTION (m)
              </text>
            </svg>
          </div>

          <div className="grid min-h-0 gap-4">
            <div className="rounded-xl border border-slate-700/70 bg-slate-950/45 p-3 shadow-[inset_0_1px_0_rgba(255,255,255,0.03)]">
              <div className="text-[11px] font-semibold uppercase tracking-[0.22em] text-slate-400">Anchor Callout</div>
              <div className="mt-2 text-base font-semibold text-slate-100">{highlight.label}</div>
              <div className="mt-1 text-sm text-slate-400">{highlight.component.note ?? snapshot.label}</div>

              <div className="mt-4 grid grid-cols-2 gap-3 text-sm">
                <Metric label="OD" value={highlight.component.od_mm ? `${highlight.component.od_mm.toFixed(1)} mm` : 'N/A'} />
                <Metric label="Run Date" value={formatDate(snapshot.run_date)} />
                <Metric label="MD" value={`${highlight.anchor_md_m.toFixed(2)} mKB`} />
                <Metric label="TVD" value={`${highlight.trajectory.tvd_m.toFixed(2)} m`} />
                <Metric label="Inclination" value={`${highlight.trajectory.inclination_deg.toFixed(2)}°`} />
                <Metric label="Azimuth" value={`${highlight.trajectory.azimuth_deg.toFixed(2)}°`} />
                <Metric label="Northing" value={formatSignedDepth(highlight.trajectory.northing_offset_m)} />
                <Metric label="Easting" value={formatSignedDepth(highlight.trajectory.easting_offset_m)} />
              </div>

              <div className="mt-4 rounded-lg border border-slate-700/70 bg-slate-900/70 p-3 text-[11px] leading-relaxed text-slate-300">
                The marker is interpolated directly from the final survey CSV at the bottom of the current slotted tag bar.
              </div>
            </div>

            <div className="rounded-xl border border-slate-700/70 bg-slate-950/45 p-3 shadow-[inset_0_1px_0_rgba(255,255,255,0.03)]">
              <div className="mb-2 text-[11px] font-semibold uppercase tracking-[0.22em] text-slate-400">Plan View</div>
              <svg viewBox={`0 0 ${PLAN_WIDTH} ${PLAN_HEIGHT}`} className="h-full min-h-[180px] w-full">
                <rect
                  x={planPadding.left}
                  y={planPadding.top}
                  width={PLAN_WIDTH - planPadding.left - planPadding.right}
                  height={PLAN_HEIGHT - planPadding.top - planPadding.bottom}
                  rx="16"
                  fill="rgba(15,23,42,0.55)"
                  stroke="rgba(148,163,184,0.18)"
                />
                <path
                  d={planMetrics.path}
                  fill="none"
                  stroke="rgba(78,195,255,0.9)"
                  strokeWidth="3"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
                <circle
                  cx={mapRange(0, planMetrics.xDomain[0], planMetrics.xDomain[1], planPadding.left, PLAN_WIDTH - planPadding.right)}
                  cy={mapRange(0, planMetrics.yDomain[0], planMetrics.yDomain[1], planPadding.top, PLAN_HEIGHT - planPadding.bottom)}
                  r="4"
                  fill="#f8fafc"
                />
                <circle cx={planAnchorX} cy={planAnchorY} r="7" fill="rgba(78,195,255,0.18)" />
                <circle cx={planAnchorX} cy={planAnchorY} r="3.8" fill="#4ec3ff" />
                <text x={planPadding.left} y={16} fill="#94a3b8" fontSize="10">N +</text>
                <text x={PLAN_WIDTH - planPadding.right} y={PLAN_HEIGHT - 8} textAnchor="end" fill="#94a3b8" fontSize="10">
                  E / W offset
                </text>
              </svg>
            </div>
          </div>
        </div>

        <div className="rounded-xl border border-slate-700/70 bg-slate-950/45 p-3 shadow-[inset_0_1px_0_rgba(255,255,255,0.03)]">
          <div className="mb-3 flex flex-wrap items-end justify-between gap-3">
            <div>
              <div className="text-[11px] font-semibold uppercase tracking-[0.22em] text-slate-400">Current Completion Strip</div>
              <div className="mt-1 text-sm font-semibold text-slate-100">Focused interval around the current tool stack</div>
            </div>
            <div className="text-right text-[11px] text-slate-400">
              <div>{stripMetrics.focusMin.toFixed(2)} - {stripMetrics.focusMax.toFixed(2)} mKB</div>
            </div>
          </div>

          <svg viewBox={`0 0 ${STRIP_WIDTH} ${STRIP_HEIGHT}`} className="w-full">
            <line
              x1={stripPadding.left}
              x2={STRIP_WIDTH - stripPadding.right}
              y1={STRIP_HEIGHT - stripPadding.bottom}
              y2={STRIP_HEIGHT - stripPadding.bottom}
              stroke="rgba(148,163,184,0.35)"
            />
            {stripTicks.map((tick) => {
              const x = mapRange(
                tick,
                stripMetrics.focusMin,
                stripMetrics.focusMax,
                stripPadding.left,
                STRIP_WIDTH - stripPadding.right,
              );
              return (
                <g key={`strip-tick-${tick}`}>
                  <line
                    x1={x}
                    x2={x}
                    y1={STRIP_HEIGHT - stripPadding.bottom}
                    y2={stripPadding.top}
                    stroke="rgba(148,163,184,0.12)"
                    strokeDasharray="4 6"
                  />
                  <text
                    x={x}
                    y={STRIP_HEIGHT - 10}
                    textAnchor="middle"
                    fill="#94a3b8"
                    fontSize="10"
                  >
                    {tick.toFixed(2)}
                  </text>
                </g>
              );
            })}

            {snapshot.components.map((component, index) => {
              const x = mapRange(
                component.top_mkb,
                stripMetrics.focusMin,
                stripMetrics.focusMax,
                stripPadding.left,
                STRIP_WIDTH - stripPadding.right,
              );
              const width = (componentLengthM(component) / (stripMetrics.focusMax - stripMetrics.focusMin)) * focusWidth;
              const y = 42 + index * 18;
              const color = accentColor(component.id);
              return (
                <g key={component.id}>
                  <rect
                    x={x}
                    y={y}
                    width={Math.max(width, 10)}
                    height="14"
                    rx="7"
                    fill={color}
                    opacity="0.82"
                  />
                  <text x={x + 8} y={y - 6} fill="#e2e8f0" fontSize="11" fontWeight="600">
                    {component.label}
                  </text>
                </g>
              );
            })}

            <line
              x1={highlightStripX}
              x2={highlightStripX}
              y1={stripPadding.top}
              y2={STRIP_HEIGHT - stripPadding.bottom}
              stroke="rgba(78,195,255,0.85)"
              strokeDasharray="6 6"
            />
            <circle cx={highlightStripX} cy={36} r="5" fill="#4ec3ff" />
            <text x={highlightStripX} y={22} textAnchor="middle" fill="#7dd3fc" fontSize="11" fontWeight="700">
              {highlight.anchor_md_m.toFixed(2)} mKB
            </text>
          </svg>
          <div className="mt-3 text-[11px] text-slate-400">{snapshot.source_note}</div>
        </div>
      </div>
    </div>
  );
}

function roundTick(maxValue: number, index: number, steps: number): number {
  return Number(((maxValue * index) / steps).toFixed(0));
}

function Metric({ label, value }: { label: string; value: string }) {
  return (
    <div className="rounded-lg border border-slate-700/70 bg-slate-900/70 p-2">
      <div className="text-[10px] uppercase tracking-[0.18em] text-slate-400">{label}</div>
      <div className="mt-1 text-sm font-medium text-slate-100">{value}</div>
    </div>
  );
}

export default WellTrajectoryPlate;
