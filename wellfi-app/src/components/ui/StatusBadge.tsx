import type { OperationalStatusType } from '@/types/operationalStatus';
import { OP_STATUS_CONFIG } from '@/types/operationalStatus';

interface StatusBadgeProps {
  status: OperationalStatusType;
  size?: 'sm' | 'md';
}

/**
 * StatusBadge — glassmorphic pill badge for operational status.
 * Displays a colored dot + label with frosted background tinted by status color.
 */
export function StatusBadge({ status, size = 'md' }: StatusBadgeProps) {
  const config = OP_STATUS_CONFIG[status];

  const sizeClasses =
    size === 'sm'
      ? 'text-[10px] px-1.5 py-0.5 gap-1'
      : 'text-xs px-2 py-1 gap-1.5';

  const dotSize = size === 'sm' ? 'h-1.5 w-1.5' : 'h-2 w-2';

  return (
    <span
      className={`inline-flex items-center rounded-full font-medium backdrop-blur-sm border transition-all duration-200 ${sizeClasses}`}
      style={{
        backgroundColor: `${config.color}18`,
        borderColor: `${config.color}30`,
        color: config.color,
      }}
    >
      <span
        className={`${dotSize} rounded-full shrink-0`}
        style={{
          backgroundColor: config.color,
          boxShadow: `0 0 6px ${config.color}60`,
        }}
      />
      {config.label}
    </span>
  );
}
