import { useEffect, useMemo, useRef, useState } from 'react';
import {
  BarChart3,
  Factory,
  Flame,
  Layers3,
  ShieldCheck,
  Waves,
} from 'lucide-react';
import {
  Bar,
  BarChart,
  CartesianGrid,
  Tooltip,
  XAxis,
  YAxis,
} from 'recharts';

import { Badge } from '@/components/ui/badge';
import type { ProductionFeature } from '@/hooks/useProductionSnapshot';
import { normalizeProductionUwi } from '@/hooks/useProductionSnapshot';

type BreakdownMode = 'formation' | 'operator';
type FluidMode = 'oil' | 'gas';
type CohortMode = 'all' | 'wellfi';

interface AdminProductionDeckProps {
  features: ProductionFeature[];
  isLoading: boolean;
  selectedOperatorName?: string | null;
  loadedOperatorCount: number;
  provisionedOperatorCount: number;
  activeWellFiUwis: string[];
}

interface SummaryStats {
  producingWells: number;
  recentOil: number;
  recentGas: number;
  oilWells: number;
  gasWells: number;
}

interface ChartRow {
  groupKey: string;
  label: string;
  fullLabel: string;
  oil: number;
  gas: number;
}

const FORMATION_ORDER = ['Clearwater', 'Bluesky'];
const OIL_COLOR = '#F59E0B';
const GAS_COLOR = '#6EE7B7';

function formatCompactNumber(value: number): string {
  const abs = Math.abs(value);
  if (abs >= 1_000_000) return `${(value / 1_000_000).toFixed(abs >= 10_000_000 ? 0 : 1)}M`;
  if (abs >= 1_000) return `${(value / 1_000).toFixed(abs >= 10_000 ? 0 : 1)}k`;
  if (abs >= 100) return value.toFixed(0);
  if (abs >= 10) return value.toFixed(1);
  return value.toFixed(2);
}

function compactOperatorLabel(label: string): string {
  const shortened = label
    .replace('Resources', 'Res.')
    .replace('Energy', 'En.')
    .replace('Exploration', 'Expl.')
    .replace('Development', 'Dev.')
    .replace('Corporation', 'Corp.')
    .replace('Limited', 'Ltd.');

  return shortened.length > 20 ? `${shortened.slice(0, 17)}...` : shortened;
}

function summarizeFeatures(features: ProductionFeature[]): SummaryStats {
  return features.reduce<SummaryStats>(
    (summary, feature) => {
      summary.producingWells += 1;
      summary.recentOil += feature.properties.recent_oil;
      summary.recentGas += feature.properties.recent_gas;
      if (feature.properties.fluid_type === 'gas') {
        summary.gasWells += 1;
      } else {
        summary.oilWells += 1;
      }
      return summary;
    },
    {
      producingWells: 0,
      recentOil: 0,
      recentGas: 0,
      oilWells: 0,
      gasWells: 0,
    },
  );
}

function ToggleGroup<T extends string>({
  label,
  value,
  onChange,
  options,
}: {
  label: string;
  value: T;
  onChange: (next: T) => void;
  options: Array<{ value: T; label: string }>;
}) {
  return (
    <div className="space-y-1.5">
      <div className="text-[10px] uppercase tracking-[0.16em] text-white/35">{label}</div>
      <div className="inline-flex rounded-xl border border-white/[0.08] bg-black/20 p-1">
        {options.map((option) => {
          const active = option.value === value;
          return (
            <button
              key={option.value}
              type="button"
              onClick={() => onChange(option.value)}
              className={`rounded-lg px-2.5 py-1.5 text-[11px] font-medium transition-all duration-200 ${
                active
                  ? 'bg-white/[0.08] text-white shadow-[0_0_12px_rgba(255,255,255,0.04)]'
                  : 'text-white/45 hover:text-white/80'
              }`}
            >
              {option.label}
            </button>
          );
        })}
      </div>
    </div>
  );
}

function StatCard({
  label,
  value,
  hint,
  accent,
  icon: Icon,
}: {
  label: string;
  value: string;
  hint: string;
  accent: string;
  icon: typeof Flame;
}) {
  return (
    <div className="rounded-xl border border-white/[0.06] bg-white/[0.02] px-3 py-3">
      <div className="flex items-center justify-between gap-2">
        <div className="text-[10px] uppercase tracking-[0.14em] text-white/35">{label}</div>
        <Icon className="h-3.5 w-3.5" style={{ color: accent }} />
      </div>
      <div className="mt-2 text-xl font-semibold text-white tabular-nums">{value}</div>
      <div className="mt-1 text-[11px] text-white/45">{hint}</div>
    </div>
  );
}

export function AdminProductionDeck({
  features,
  isLoading,
  selectedOperatorName,
  loadedOperatorCount,
  provisionedOperatorCount,
  activeWellFiUwis,
}: AdminProductionDeckProps) {
  const [breakdown, setBreakdown] = useState<BreakdownMode>('operator');
  const [fluidMode, setFluidMode] = useState<FluidMode>('oil');
  const [cohortMode, setCohortMode] = useState<CohortMode>('all');
  const chartContainerRef = useRef<HTMLDivElement>(null);
  const [chartDimensions, setChartDimensions] = useState({ width: 0, height: 0 });

  const activeWellFiSet = useMemo(
    () => new Set(activeWellFiUwis.map((uwi) => normalizeProductionUwi(uwi)).filter(Boolean)),
    [activeWellFiUwis],
  );

  useEffect(() => {
    const node = chartContainerRef.current;
    if (!node || typeof ResizeObserver === 'undefined') {
      return;
    }

    const updateDimensions = () => {
      setChartDimensions({
        width: node.clientWidth,
        height: node.clientHeight,
      });
    };

    updateDimensions();

    const observer = new ResizeObserver(() => {
      updateDimensions();
    });

    observer.observe(node);

    return () => {
      observer.disconnect();
    };
  }, []);

  const scopedFeatures = useMemo(() => {
    const operatorScoped = selectedOperatorName
      ? features.filter((feature) => feature.properties.operator === selectedOperatorName)
      : features;

    if (cohortMode === 'wellfi') {
      return operatorScoped.filter((feature) =>
        activeWellFiSet.has(normalizeProductionUwi(feature.properties.uwi)),
      );
    }

    return operatorScoped;
  }, [activeWellFiSet, cohortMode, features, selectedOperatorName]);

  const wellFiFeatures = useMemo(
    () =>
      features.filter((feature) =>
        activeWellFiSet.has(normalizeProductionUwi(feature.properties.uwi)),
      ),
    [activeWellFiSet, features],
  );

  const summary = useMemo(() => summarizeFeatures(scopedFeatures), [scopedFeatures]);
  const wellFiSummary = useMemo(() => summarizeFeatures(wellFiFeatures), [wellFiFeatures]);

  const chartRows = useMemo(() => {
    const groups = new Map<string, ChartRow>();

    for (const feature of scopedFeatures) {
      const groupKey =
        breakdown === 'formation'
          ? feature.properties.formation || 'Unknown'
          : feature.properties.operator;
      const displayLabel =
        breakdown === 'formation' ? groupKey : compactOperatorLabel(groupKey);

      const existing = groups.get(groupKey) ?? {
        groupKey,
        label: displayLabel,
        fullLabel: groupKey,
        oil: 0,
        gas: 0,
      };

      existing.oil += feature.properties.recent_oil;
      existing.gas += feature.properties.recent_gas;
      groups.set(groupKey, existing);
    }

    const rows = [...groups.values()];

    if (breakdown === 'formation') {
      return rows.sort(
        (left, right) =>
          FORMATION_ORDER.indexOf(left.label) - FORMATION_ORDER.indexOf(right.label),
      );
    }

    const sortMetric = fluidMode === 'oil'
      ? (row: ChartRow) => row.oil
      : (row: ChartRow) => row.gas;

    return rows
      .sort((left, right) => sortMetric(right) - sortMetric(left))
      .slice(0, 6);
  }, [breakdown, fluidMode, scopedFeatures]);

  const commodityLabel = fluidMode === 'oil' ? 'Oil' : 'Gas';
  const chartReady = chartDimensions.width > 0 && chartDimensions.height > 0;
  const chartTitle =
    breakdown === 'operator'
      ? `${commodityLabel} production by operator`
      : `${commodityLabel} production by formation`;
  const chartDescription = breakdown === 'operator'
    ? selectedOperatorName
      ? 'Single-operator scope. Switch to formation for reservoir view.'
      : `Top 6 loaded operators by current ${commodityLabel.toLowerCase()} snapshot`
    : 'Clearwater vs Bluesky comparison';
  const scopeLabel = selectedOperatorName ? selectedOperatorName : 'Loaded operator universe';
  const deckLabel =
    cohortMode === 'wellfi' ? 'Active WellFi installs only' : 'Latest monthly production snapshot';

  if (isLoading) {
    return (
      <div className="rounded-xl border border-white/[0.06] bg-[#08111F]/90 px-4 py-4">
        <div className="animate-pulse space-y-3">
          <div className="h-3 w-32 rounded bg-white/[0.08]" />
          <div className="h-6 w-48 rounded bg-white/[0.08]" />
          <div className="grid grid-cols-2 gap-2">
            <div className="h-20 rounded-xl bg-white/[0.06]" />
            <div className="h-20 rounded-xl bg-white/[0.06]" />
            <div className="h-20 rounded-xl bg-white/[0.06]" />
            <div className="h-20 rounded-xl bg-white/[0.06]" />
          </div>
          <div className="h-40 rounded-xl bg-white/[0.06]" />
        </div>
      </div>
    );
  }

  return (
    <div className="relative overflow-hidden rounded-xl border border-white/[0.06] bg-gradient-to-b from-[#0A1322] to-[#08101D] px-4 py-4 shadow-[0_20px_60px_rgba(0,0,0,0.25)]">
      <div className="pointer-events-none absolute inset-x-8 top-0 h-px bg-gradient-to-r from-transparent via-white/20 to-transparent" />
      <div className="pointer-events-none absolute -top-16 right-0 h-40 w-40 rounded-full bg-emerald-400/6 blur-3xl" />
      <div className="pointer-events-none absolute -bottom-10 left-0 h-32 w-32 rounded-full bg-amber-400/6 blur-3xl" />

      <div className="relative space-y-4">
        <div className="flex items-start justify-between gap-3">
          <div className="space-y-2">
            <div className="flex items-center gap-2">
              <span className="inline-flex h-6 w-6 items-center justify-center rounded-full border border-white/[0.08] bg-white/[0.04]">
                <BarChart3 className="h-3.5 w-3.5 text-cyan-300" />
              </span>
              <div className="text-[10px] uppercase tracking-[0.16em] text-cyan-200/70">
                MPS Production Deck
              </div>
            </div>
            <div className="text-base font-semibold text-white">Current Monthly Snapshot</div>
            <div className="text-[11px] text-white/45">
              {scopeLabel} | {deckLabel}
            </div>
          </div>

          <div className="flex flex-col items-end gap-2">
            <Badge variant="outline" className="border-cyan-300/20 bg-cyan-300/5 text-[10px] uppercase tracking-wide text-cyan-200/75">
              Admin Only
            </Badge>
            <div className="text-right text-[11px] text-white/45">
              {loadedOperatorCount} loaded | {provisionedOperatorCount} provisioned
            </div>
          </div>
        </div>

        <div className="flex flex-wrap gap-3">
          <ToggleGroup
            label="Breakdown"
            value={breakdown}
            onChange={setBreakdown}
            options={[
              { value: 'operator', label: 'Operator' },
              { value: 'formation', label: 'Formation' },
            ]}
          />
          <ToggleGroup
            label="Fluid"
            value={fluidMode}
            onChange={setFluidMode}
            options={[
              { value: 'oil', label: 'Oil' },
              { value: 'gas', label: 'Gas' },
            ]}
          />
          <ToggleGroup
            label="Cohort"
            value={cohortMode}
            onChange={setCohortMode}
            options={[
              { value: 'all', label: 'All Wells' },
              { value: 'wellfi', label: 'Active WellFi' },
            ]}
          />
        </div>

        <div className="grid grid-cols-2 gap-2">
          <StatCard
            label="Recent Oil"
            value={formatCompactNumber(summary.recentOil)}
            hint={`${summary.oilWells} oil wells`}
            accent={OIL_COLOR}
            icon={Flame}
          />
          <StatCard
            label="Recent Gas"
            value={formatCompactNumber(summary.recentGas)}
            hint={`${summary.gasWells} gas wells`}
            accent={GAS_COLOR}
            icon={Waves}
          />
          <StatCard
            label="Producing Wells"
            value={summary.producingWells.toString()}
            hint="Latest snapshot rows"
            accent="#7DD3FC"
            icon={Layers3}
          />
          <StatCard
            label="Active WellFi Installs"
            value={wellFiSummary.producingWells.toString()}
            hint={
              wellFiSummary.producingWells > 0
                ? `${formatCompactNumber(wellFiSummary.recentOil)} oil | ${formatCompactNumber(wellFiSummary.recentGas)} gas`
                : 'No active WellFi installs'
            }
            accent="#A78BFA"
            icon={ShieldCheck}
          />
        </div>

          <div className="rounded-xl border border-white/[0.06] bg-black/20 px-3 py-3">
          <div className="flex items-center justify-between gap-2">
            <div>
              <div className="text-[10px] uppercase tracking-[0.14em] text-white/35">
                {chartTitle}
              </div>
              <div className="mt-1 text-sm font-medium text-white/90">
                {chartDescription}
              </div>
            </div>
            <div className="inline-flex items-center gap-1 rounded-full border border-white/[0.08] bg-white/[0.04] px-2 py-1 text-[11px] text-white/55">
              <span
                className="h-2.5 w-2.5 rounded-full"
                style={{ backgroundColor: fluidMode === 'oil' ? OIL_COLOR : GAS_COLOR }}
              />
              {commodityLabel}
            </div>
          </div>

          {chartRows.length > 0 ? (
            <div ref={chartContainerRef} className="mt-3 h-48">
              {chartReady && (
                <BarChart
                  width={chartDimensions.width}
                  height={chartDimensions.height}
                  data={chartRows}
                  margin={{ top: 8, right: 8, left: -16, bottom: 0 }}
                >
                  <CartesianGrid stroke="rgba(255,255,255,0.05)" vertical={false} />
                  <XAxis
                    dataKey="label"
                    tick={{ fill: 'rgba(255,255,255,0.55)', fontSize: 10 }}
                    tickLine={false}
                    axisLine={false}
                    interval={0}
                    angle={breakdown === 'operator' ? -18 : 0}
                    textAnchor={breakdown === 'operator' ? 'end' : 'middle'}
                    height={breakdown === 'operator' ? 44 : 24}
                  />
                  <YAxis
                    tick={{ fill: 'rgba(255,255,255,0.45)', fontSize: 10 }}
                    tickLine={false}
                    axisLine={false}
                    width={44}
                  />
                  <Tooltip
                    cursor={{ fill: 'rgba(255,255,255,0.04)' }}
                    contentStyle={{
                      backgroundColor: '#08111F',
                      border: '1px solid rgba(255,255,255,0.08)',
                      borderRadius: '12px',
                      color: '#fff',
                    }}
                    formatter={(value: number | string | undefined, name: string | undefined) => [
                      formatCompactNumber(Number(value ?? 0)),
                      name === 'oil' ? 'Recent Oil' : 'Recent Gas',
                    ]}
                    labelFormatter={(label, payload) => {
                      const row = payload?.[0]?.payload as ChartRow | undefined;
                      return row?.fullLabel ?? String(label);
                    }}
                    labelStyle={{ color: 'rgba(255,255,255,0.65)' }}
                  />
                  <Bar
                    dataKey={fluidMode}
                    fill={fluidMode === 'oil' ? OIL_COLOR : GAS_COLOR}
                    radius={[6, 6, 0, 0]}
                  />
                </BarChart>
              )}
            </div>
          ) : (
            <div className="mt-3 rounded-xl border border-dashed border-white/[0.08] px-3 py-8 text-center text-sm text-white/45">
              No production rows match this scope yet.
            </div>
          )}
        </div>

        <div className="grid grid-cols-2 gap-2">
          <div className="rounded-xl border border-white/[0.06] bg-white/[0.02] px-3 py-3">
            <div className="flex items-center gap-2 text-[10px] uppercase tracking-[0.14em] text-white/35">
              <Factory className="h-3.5 w-3.5 text-cyan-300" />
              Live Coverage
            </div>
            <div className="mt-2 text-sm font-medium text-white">
              {loadedOperatorCount} operators have live wells loaded today.
            </div>
            <div className="mt-1 text-[11px] text-white/45">
              Provisioned tenants can outnumber loaded operating datasets.
            </div>
          </div>
          <div className="rounded-xl border border-white/[0.06] bg-white/[0.02] px-3 py-3">
            <div className="flex items-center gap-2 text-[10px] uppercase tracking-[0.14em] text-white/35">
              <ShieldCheck className="h-3.5 w-3.5 text-emerald-300" />
              Data Rule
            </div>
            <div className="mt-2 text-sm font-medium text-white">
              Admin sees production. Operators stay exception-driven.
            </div>
            <div className="mt-1 text-[11px] text-white/45">
              Full multi-operator trend history still needs a dedicated production table.
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
