import { useMemo } from 'react';
import { OP_STATUS_CONFIG } from '@/types/operationalStatus';
import type { WellEnriched } from '@/types/operationalStatus';

// ─── Simplified time-based risk buckets ──────────────────────

const RISK_BUCKETS: { key: string; label: string; color: string; levels: string[] }[] = [
  { key: 'low', label: 'Low', color: '#22C55E', levels: ['LOW', 'RECENTLY CHANGED'] },
  { key: 'medium', label: 'Medium', color: '#EAB308', levels: ['WATCH'] },
  { key: 'high', label: 'High', color: '#EF4444', levels: ['HIGH \u2014 DUE', 'DOWN NOW'] },
];

// ─── Op status display order ──────────────────────────────────

const OP_DISPLAY_ORDER: { key: 'watch' | 'warning' | 'well_down'; label: string }[] = [
  { key: 'watch', label: 'Watch' },
  { key: 'warning', label: 'Warning' },
  { key: 'well_down', label: 'Well Down' },
];

// ─── Component ────────────────────────────────────────────────

interface RiskOverviewProps {
  wells: WellEnriched[];
}

/**
 * RiskOverview — compact at-a-glance risk + operational status summary.
 * Risk = time-based (Low/Medium/High from months_running).
 * Operational = user-set flags (Watch/Warning/Well Down).
 */
export function RiskOverview({ wells }: RiskOverviewProps) {
  const { bucketCounts, opCounts } = useMemo(() => {
    const buckets: Record<string, number> = { low: 0, medium: 0, high: 0 };
    const op: Record<string, number> = {};

    for (const well of wells) {
      const riskKey = well.risk_level ?? 'NO DATA';
      const bucket = RISK_BUCKETS.find((b) => b.levels.includes(riskKey));
      if (bucket) {
        buckets[bucket.key]++;
      }

      const opStatus = well.operational_status?.status;
      if (opStatus) {
        op[opStatus] = (op[opStatus] ?? 0) + 1;
      }
    }

    return { bucketCounts: buckets, opCounts: op };
  }, [wells]);

  const totalOpStatuses = OP_DISPLAY_ORDER.reduce(
    (sum, item) => sum + (opCounts[item.key] ?? 0),
    0,
  );

  return (
    <div className="bg-[#080D16]/80 backdrop-blur-xl border border-white/[0.06] rounded-lg px-3 py-2.5">
      {/* Header */}
      <h3 className="text-[10px] font-semibold tracking-[0.12em] text-white/40 uppercase mb-2">
        Risk Overview
      </h3>

      {/* Time-based risk buckets */}
      <div className="flex items-center gap-3 mb-1">
        {RISK_BUCKETS.map(({ key, label, color }) => {
          const count = bucketCounts[key] ?? 0;
          return (
            <div key={key} className="flex items-center gap-1.5 min-w-0">
              <span
                className="h-2 w-2 rounded-full shrink-0"
                style={{
                  backgroundColor: color,
                  boxShadow: `0 0 4px ${color}50`,
                }}
              />
              <span className="text-[11px] font-medium text-white/80 tabular-nums">
                {count}
              </span>
              <span className="text-[10px] text-white/40 truncate">
                {label}
              </span>
            </div>
          );
        })}
      </div>

      {/* Operational status section */}
      {totalOpStatuses > 0 && (
        <>
          <div className="border-t border-white/[0.06] my-1.5" />

          <div className="flex items-center gap-1 mb-1">
            <span className="text-[10px] font-semibold tracking-[0.08em] text-white/30 uppercase">
              Flagged
            </span>
          </div>
          <div className="flex items-center gap-3">
            {OP_DISPLAY_ORDER.map(({ key, label }) => {
              const count = opCounts[key] ?? 0;
              if (count === 0) return null;
              const config = OP_STATUS_CONFIG[key];

              return (
                <div key={key} className="flex items-center gap-1.5 min-w-0">
                  <span
                    className="h-2 w-2 rounded-full shrink-0"
                    style={{
                      backgroundColor: config.color,
                      boxShadow: `0 0 4px ${config.color}50`,
                    }}
                  />
                  <span className="text-[11px] font-medium text-white/80 tabular-nums">
                    {count}
                  </span>
                  <span className="text-[10px] text-white/40 truncate">
                    {label}
                  </span>
                </div>
              );
            })}
          </div>
        </>
      )}
    </div>
  );
}
