import type { ReactNode } from 'react';

interface EmptyStateProps {
  icon: ReactNode;
  title: string;
  description: string;
  action?: ReactNode;
}

export function EmptyState({ icon, title, description, action }: EmptyStateProps) {
  return (
    <div className="flex flex-col items-center justify-center gap-3 px-6 py-12 text-center">
      <div className="text-gray-500">{icon}</div>
      <h3 className="text-lg font-semibold text-gray-200">{title}</h3>
      <p className="max-w-sm text-sm text-gray-400">{description}</p>
      {action && <div className="mt-2">{action}</div>}
    </div>
  );
}
