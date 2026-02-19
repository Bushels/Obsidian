import { CheckCircle2, Circle, ArrowRight } from 'lucide-react';
import { toast } from 'sonner';

import type { PumpChange, PumpChangeStatus } from '@/types';
import { useUpdatePumpChange } from '@/hooks/usePumpChanges';

import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import {
  Card,
  CardHeader,
  CardTitle,
  CardContent,
} from '@/components/ui/card';

interface PumpChecklistProps {
  pumpChange: PumpChange;
  canEdit?: boolean;
}

const CHECKLIST_ITEMS: { key: keyof Pick<PumpChange, 'device_sourced' | 'program_configured' | 'installation_scheduled'>; label: string }[] = [
  { key: 'device_sourced', label: 'Device Sourced' },
  { key: 'program_configured', label: 'Program Configured' },
  { key: 'installation_scheduled', label: 'Installation Scheduled' },
];

const STATUS_STEPS: PumpChangeStatus[] = ['warning', 'scheduled', 'in_progress', 'completed'];

const STATUS_LABELS: Record<PumpChangeStatus, string> = {
  warning: 'Warning',
  scheduled: 'Scheduled',
  in_progress: 'In Progress',
  completed: 'Completed',
  cancelled: 'Cancelled',
};

function getNextStatus(current: PumpChangeStatus): PumpChangeStatus | null {
  const idx = STATUS_STEPS.indexOf(current);
  if (idx === -1 || idx >= STATUS_STEPS.length - 1) return null;
  return STATUS_STEPS[idx + 1];
}

function getStatusBadgeClasses(status: PumpChangeStatus, isActive: boolean): string {
  if (!isActive) return 'bg-gray-200 text-gray-500 border-gray-200';
  switch (status) {
    case 'warning':
      return 'bg-amber-500 text-white border-amber-500';
    case 'scheduled':
      return 'bg-blue-500 text-white border-blue-500';
    case 'in_progress':
      return 'bg-purple-600 text-white border-purple-600';
    case 'completed':
      return 'bg-green-600 text-white border-green-600';
    default:
      return 'bg-gray-400 text-white border-gray-400';
  }
}

export default function PumpChecklist({ pumpChange, canEdit = false }: PumpChecklistProps) {
  const updatePumpChange = useUpdatePumpChange();

  const completedCount = CHECKLIST_ITEMS.filter(
    (item) => pumpChange[item.key],
  ).length;
  const totalCount = CHECKLIST_ITEMS.length;
  const allComplete = completedCount === totalCount;
  const progressPct = (completedCount / totalCount) * 100;

  const nextStatus = getNextStatus(pumpChange.status);

  function handleToggle(key: 'device_sourced' | 'program_configured' | 'installation_scheduled', currentValue: boolean) {
    updatePumpChange.mutate(
      { id: pumpChange.id, updates: { [key]: !currentValue } },
      {
        onError: (error) => {
          toast.error('Failed to update checklist: ' + error.message);
        },
      },
    );
  }

  function handleAdvanceStatus() {
    if (!nextStatus) return;
    updatePumpChange.mutate(
      { id: pumpChange.id, updates: { status: nextStatus } },
      {
        onSuccess: () => {
          toast.success('Status advanced to ' + STATUS_LABELS[nextStatus]);
        },
        onError: (error) => {
          toast.error('Failed to advance status: ' + error.message);
        },
      },
    );
  }

  return (
    <Card className="w-full">
      <CardHeader className="pb-3">
        <CardTitle className="text-base">Pump Change Checklist</CardTitle>
      </CardHeader>

      <CardContent className="space-y-4">
        {/* Progress Bar */}
        <div className="space-y-1">
          <div className="flex items-center justify-between text-sm">
            <span className="text-muted-foreground">Progress</span>
            <span className="font-medium">
              {completedCount}/{totalCount}
            </span>
          </div>
          <div className="h-2 w-full overflow-hidden rounded-full bg-gray-200">
            <div
              className="h-full rounded-full bg-blue-600 transition-all duration-300"
              style={{ width: `${progressPct}%` }}
            />
          </div>
        </div>

        {/* Ready Banner */}
        {allComplete && (
          <div className="rounded-md bg-green-50 p-3 text-center text-sm font-medium text-green-700 border border-green-200">
            Ready for installation
          </div>
        )}

        {/* Checklist Items */}
        <div className="space-y-2">
          {CHECKLIST_ITEMS.map((item) => {
            const checked = pumpChange[item.key];
            return (
              <button
                key={item.key}
                type="button"
                className={`flex w-full items-center gap-3 rounded-md border p-3 text-left transition-colors ${canEdit ? 'hover:bg-accent cursor-pointer' : 'cursor-default opacity-80'}`}
                onClick={canEdit ? () => handleToggle(item.key, checked) : undefined}
                disabled={!canEdit || updatePumpChange.isPending}
              >
                {checked ? (
                  <CheckCircle2 className="h-5 w-5 shrink-0 text-green-600" />
                ) : (
                  <Circle className="h-5 w-5 shrink-0 text-gray-400" />
                )}
                <span className={checked ? 'text-green-700 font-medium' : 'text-foreground'}>
                  {item.label}
                </span>
              </button>
            );
          })}
        </div>

        {/* Status Stepper */}
        <div className="space-y-2">
          <p className="text-sm font-medium text-muted-foreground">Status</p>
          <div className="flex items-center gap-1 flex-wrap">
            {STATUS_STEPS.map((step, idx) => {
              const stepIdx = STATUS_STEPS.indexOf(pumpChange.status);
              const isActive = idx <= stepIdx;
              return (
                <div key={step} className="flex items-center gap-1">
                  <Badge className={getStatusBadgeClasses(step, isActive)}>
                    {STATUS_LABELS[step]}
                  </Badge>
                  {idx < STATUS_STEPS.length - 1 && (
                    <ArrowRight className="h-3 w-3 text-muted-foreground" />
                  )}
                </div>
              );
            })}
          </div>
        </div>

        {/* Advance Status Button (admin only) */}
        {canEdit && nextStatus && pumpChange.status !== 'completed' && pumpChange.status !== 'cancelled' && (
          <Button
            onClick={handleAdvanceStatus}
            disabled={updatePumpChange.isPending}
            className="w-full"
          >
            Advance to {STATUS_LABELS[nextStatus]}
          </Button>
        )}
      </CardContent>
    </Card>
  );
}
