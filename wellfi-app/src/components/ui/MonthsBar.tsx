interface MonthsBarProps {
  months: number | null;
  showLabel?: boolean;
}

function barColor(months: number): string {
  if (months >= 17) return '#EF4444';
  if (months >= 14) return '#F97316';
  if (months >= 9) return '#EAB308';
  return '#22C55E';
}

export function MonthsBar({ months, showLabel = false }: MonthsBarProps) {
  if (months === null) return null;

  const color = barColor(months);
  const widthPct = Math.min((months / 20) * 100, 100);
  const isDanger = months >= 17;

  return (
    <div className="flex items-center gap-2">
      <div className="relative h-2 flex-1 rounded-full bg-gray-700 overflow-hidden">
        <div
          className={`absolute inset-y-0 left-0 rounded-full transition-all${isDanger ? ' wellfi-pulse' : ''}`}
          style={{
            width: `${widthPct}%`,
            backgroundColor: color,
            boxShadow: isDanger ? `0 0 8px ${color}` : undefined,
          }}
        />
      </div>
      {showLabel && (
        <span className="text-xs font-medium tabular-nums" style={{ color }}>
          {months} mo
        </span>
      )}
    </div>
  );
}
