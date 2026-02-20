import { useMemo } from 'react';
import { RISK_COLORS } from '@/lib/mapUtils';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';
import { Input } from '@/components/ui/input';
import type { Well, MapFilters, RiskLevel, Formation } from '@/types';

interface FilterBarProps {
  filters: MapFilters;
  onChange: (filters: MapFilters) => void;
  wells: Well[];
}

const ALL_RISK_LEVELS: RiskLevel[] = [
  'HIGH \u2014 DUE',
  'WATCH',
  'LOW',
  'RECENTLY CHANGED',
  'DOWN NOW',
  'NO DATA',
  'UNKNOWN',
];

const ALL_FORMATIONS: (Formation | 'All')[] = ['All', 'Bluesky', 'Clearwater'];

const DEFAULT_FILTERS: MapFilters = {
  riskLevels: [],
  formations: [],
  fields: [],
  showWellFiOnly: false,
  showUpcomingOnly: false,
  minRateBblD: 0,
};

export default function FilterBar({ filters, onChange, wells }: FilterBarProps) {
  // Compute dynamic counts
  const { riskCounts, uniqueFields, fieldCounts, wellfiCount, upcomingCount } =
    useMemo(() => {
      const rc: Record<string, number> = {};
      const fc: Record<string, number> = {};
      const fieldsSet = new Set<string>();
      let wfi = 0;
      let upcoming = 0;

      for (const w of wells) {
        // Risk counts
        const risk = w.risk_level ?? 'UNKNOWN';
        rc[risk] = (rc[risk] ?? 0) + 1;

        // Field counts
        if (w.field) {
          fieldsSet.add(w.field);
          fc[w.field] = (fc[w.field] ?? 0) + 1;
        }

        // WellFi counts
        if (w.wellfi_device) {
          wfi++;
        }

        // Upcoming changes
        if (
          w.active_pump_change &&
          ['warning', 'scheduled', 'in_progress'].includes(w.active_pump_change.status)
        ) {
          upcoming++;
        }
      }

      return {
        riskCounts: rc,
        uniqueFields: Array.from(fieldsSet).sort(),
        fieldCounts: fc,
        wellfiCount: wfi,
        upcomingCount: upcoming,
      };
    }, [wells]);

  const toggleRiskLevel = (level: RiskLevel) => {
    const current = filters.riskLevels;
    const next = current.includes(level)
      ? current.filter((r) => r !== level)
      : [...current, level];
    onChange({ ...filters, riskLevels: next });
  };

  const setFormation = (f: Formation | 'All') => {
    if (f === 'All') {
      onChange({ ...filters, formations: [] });
    } else {
      onChange({ ...filters, formations: [f] });
    }
  };

  const toggleField = (field: string) => {
    const current = filters.fields;
    const next = current.includes(field)
      ? current.filter((f) => f !== field)
      : [...current, field];
    onChange({ ...filters, fields: next });
  };

  const activeFormation: Formation | 'All' =
    filters.formations.length === 1 ? filters.formations[0] : 'All';

  // WellFi toggle: showWellFiOnly maps to 'all' vs 'wellfi'
  // MapFilters only supports a boolean; three-state display is purely UI convenience
  const wellfiActive = filters.showWellFiOnly;

  const setWellfiFilter = (showWellFi: boolean) => {
    onChange({ ...filters, showWellFiOnly: showWellFi });
  };

  const resetFilters = () => {
    onChange({ ...DEFAULT_FILTERS });
  };

  const hasActiveFilters =
    filters.riskLevels.length > 0 ||
    filters.formations.length > 0 ||
    filters.fields.length > 0 ||
    filters.showWellFiOnly ||
    filters.showUpcomingOnly ||
    filters.minRateBblD > 0;

  return (
    <div className="flex h-full flex-col overflow-y-auto">
      <div className="flex items-center justify-between border-b px-4 py-3">
        <span className="text-xs font-medium uppercase tracking-wide text-muted-foreground">
          Filters
        </span>
        {hasActiveFilters && (
          <Button variant="ghost" size="sm" className="h-6 text-xs" onClick={resetFilters}>
            Reset
          </Button>
        )}
      </div>

      <div className="space-y-5 p-4">
        {/* Risk Level Toggles */}
        <div>
          <Label className="text-xs font-semibold uppercase tracking-wide text-muted-foreground">
            Risk Level
          </Label>
          <div className="mt-2 space-y-1">
            {ALL_RISK_LEVELS.map((level) => {
              const count = riskCounts[level] ?? 0;
              const isActive = filters.riskLevels.includes(level);
              const color = RISK_COLORS[level] ?? '#6B7280';
              return (
                <label
                  key={level}
                  className="flex cursor-pointer items-center gap-2 rounded px-2 py-2 lg:py-1 text-sm hover:bg-accent"
                >
                  <input
                    type="checkbox"
                    checked={isActive}
                    onChange={() => toggleRiskLevel(level)}
                    className="sr-only"
                  />
                  <span
                    className="h-2.5 w-2.5 shrink-0 rounded-full"
                    style={{ backgroundColor: color }}
                  />
                  <span className={`flex-1 ${isActive ? 'font-medium' : ''}`}>{level}</span>
                  <Badge variant="secondary" className="text-xs px-1.5 py-0">
                    {count}
                  </Badge>
                  {isActive && (
                    <span className="text-xs text-wellfi-cyan">&#10003;</span>
                  )}
                </label>
              );
            })}
          </div>
        </div>

        {/* Formation Radio */}
        <div>
          <Label className="text-xs font-semibold uppercase tracking-wide text-muted-foreground">
            Formation
          </Label>
          <div className="mt-2 flex gap-1">
            {ALL_FORMATIONS.map((f) => (
              <Button
                key={f}
                variant="ghost"
                size="sm"
                className={`flex-1 text-xs h-9 lg:h-8 border ${
                  activeFormation === f 
                    ? 'bg-wellfi-cyan/20 text-wellfi-cyan border-wellfi-cyan/50 hover:bg-wellfi-cyan/30' 
                    : 'bg-white/5 text-gray-400 border-white/10 hover:bg-white/10 hover:text-white'
                }`}
                onClick={() => setFormation(f)}
              >
                {f}
              </Button>
            ))}
          </div>
        </div>

        {/* Field Multi-select */}
        <div>
          <Label className="text-xs font-semibold uppercase tracking-wide text-muted-foreground">
            Field
          </Label>
          <div className="mt-2 max-h-32 space-y-1 overflow-y-auto">
            {uniqueFields.map((field) => {
              const isActive = filters.fields.includes(field);
              return (
                <label
                  key={field}
                  className="flex cursor-pointer items-center gap-2 rounded px-2 py-2 lg:py-1 text-sm hover:bg-accent"
                >
                  <input
                    type="checkbox"
                    checked={isActive}
                    onChange={() => toggleField(field)}
                    className="h-3 w-3 rounded border-input"
                  />
                  <span className={`flex-1 ${isActive ? 'font-medium' : ''}`}>{field}</span>
                  <Badge variant="secondary" className="text-xs px-1.5 py-0">
                    {fieldCounts[field] ?? 0}
                  </Badge>
                </label>
              );
            })}
            {uniqueFields.length === 0 && (
              <p className="text-xs text-muted-foreground italic px-2">No fields available</p>
            )}
          </div>
        </div>

        {/* WellFi Toggle */}
        <div>
          <Label className="text-xs font-semibold uppercase tracking-wide text-muted-foreground">
            WellFi Status
          </Label>
          <div className="mt-2 flex gap-1">
            <Button
              variant="ghost"
              size="sm"
              className={`flex-1 text-xs border ${
                !wellfiActive
                  ? 'bg-wellfi-cyan/20 text-wellfi-cyan border-wellfi-cyan/50 hover:bg-wellfi-cyan/30'
                  : 'bg-white/5 text-gray-400 border-white/10 hover:bg-white/10 hover:text-white'
              }`}
              onClick={() => setWellfiFilter(false)}
            >
              All ({wells.length})
            </Button>
            <Button
              variant="ghost"
              size="sm"
              className={`flex-1 text-xs border ${
                wellfiActive
                  ? 'bg-wellfi-cyan/20 text-wellfi-cyan border-wellfi-cyan/50 hover:bg-wellfi-cyan/30'
                  : 'bg-white/5 text-gray-400 border-white/10 hover:bg-white/10 hover:text-white'
              }`}
              onClick={() => setWellfiFilter(true)}
            >
              WellFi ({wellfiCount})
            </Button>
          </div>
        </div>

        {/* Upcoming Changes Toggle */}
        <div>
          <label className="flex cursor-pointer items-center gap-2">
            <input
              type="checkbox"
              checked={filters.showUpcomingOnly}
              onChange={(e) => onChange({ ...filters, showUpcomingOnly: e.target.checked })}
              className="h-3.5 w-3.5 rounded border-input"
            />
            <span className="text-sm">
              Upcoming changes only
            </span>
            <Badge variant="secondary" className="text-xs px-1.5 py-0">
              {upcomingCount}
            </Badge>
          </label>
        </div>

        {/* Rate Slider */}
        <div>
          <Label className="text-xs font-semibold uppercase tracking-wide text-muted-foreground">
            Min Production Rate
          </Label>
          <div className="mt-2 flex items-center gap-3">
            <Input
              type="range"
              min={0}
              max={50}
              step={1}
              value={filters.minRateBblD}
              onChange={(e) => onChange({ ...filters, minRateBblD: Number(e.target.value) })}
              className="h-2 flex-1 cursor-pointer p-0"
            />
            <span className="w-16 text-right text-sm font-medium">
              {filters.minRateBblD} bbl/d
            </span>
          </div>
        </div>

        {/* Reset */}
        {hasActiveFilters && (
          <Button variant="outline" className="w-full" onClick={resetFilters}>
            Reset All Filters
          </Button>
        )}

        {/* Mobile safe area spacer */}
        <div className="h-6 lg:hidden" />
      </div>
    </div>
  );
}
