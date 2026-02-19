import type { RiskLevel } from '@/types';
import { riskColor } from '@/lib/mapUtils';

interface RiskBadgeProps {
  risk: RiskLevel | null;
  size?: 'sm' | 'md';
}

export function RiskBadge({ risk, size = 'sm' }: RiskBadgeProps) {
  const color = riskColor(risk);
  const label = risk ?? 'UNKNOWN';

  const sizeClasses =
    size === 'sm'
      ? 'text-xs px-1.5 py-0.5'
      : 'text-sm px-2 py-1';

  return (
    <span
      className={`inline-flex items-center rounded-full font-medium ${sizeClasses}`}
      style={{
        backgroundColor: `${color}20`,
        color: color,
      }}
    >
      {label}
    </span>
  );
}
