import { useForm } from 'react-hook-form';
import { z } from 'zod';
import { zodResolver } from '@hookform/resolvers/zod';
import { format } from 'date-fns';
import { CalendarIcon } from 'lucide-react';
import { toast } from 'sonner';

import type { Well } from '@/types';
import { useCreatePumpChange } from '@/hooks/usePumpChanges';
import { cn } from '@/lib/utils';

import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Badge } from '@/components/ui/badge';
import { Calendar } from '@/components/ui/calendar';
import { Popover, PopoverContent, PopoverTrigger } from '@/components/ui/popover';
import {
  Card,
  CardHeader,
  CardTitle,
  CardDescription,
  CardContent,
  CardFooter,
} from '@/components/ui/card';

const pumpChangeSchema = z.object({
  flagged_by: z.string().min(2, 'Name must be at least 2 characters'),
  scheduled_date: z.date({ error: 'Scheduled date is required' }).refine(
    (date) => {
      const today = new Date();
      today.setHours(0, 0, 0, 0);
      return date >= today;
    },
    { message: 'Scheduled date must be today or in the future' },
  ),
  formation_pressure_kpa: z
    .number({ error: 'Formation pressure is required' })
    .positive('Formation pressure must be positive'),
  pump_pressure_kpa: z
    .number({ error: 'Pump pressure is required' })
    .positive('Pump pressure must be positive'),
  pump_speed_rpm: z
    .number()
    .positive('Pump speed must be positive')
    .nullable()
    .optional(),
  notes: z.string().optional(),
});

type PumpChangeFormValues = z.infer<typeof pumpChangeSchema>;

interface PumpChangeFormProps {
  well: Well;
  onSuccess: () => void;
  onCancel: () => void;
}

function getRiskBadgeClasses(riskLevel: string | null): string {
  switch (riskLevel) {
    case 'HIGH \u2014 DUE':
      return 'bg-red-600 text-white border-red-600';
    case 'WATCH':
      return 'bg-amber-500 text-white border-amber-500';
    case 'DOWN NOW':
      return 'bg-gray-700 text-white border-gray-700';
    case 'RECENTLY CHANGED':
      return 'bg-green-600 text-white border-green-600';
    case 'LOW':
      return 'bg-blue-500 text-white border-blue-500';
    default:
      return 'bg-gray-400 text-white border-gray-400';
  }
}

export default function PumpChangeForm({ well, onSuccess, onCancel }: PumpChangeFormProps) {
  const createPumpChange = useCreatePumpChange();

  const {
    register,
    handleSubmit,
    setValue,
    watch,
    formState: { errors, isSubmitting },
  } = useForm<PumpChangeFormValues>({
    resolver: zodResolver(pumpChangeSchema),
    defaultValues: {
      flagged_by: localStorage.getItem('wellfi_engineer_name') ?? '',
      notes: '',
      pump_speed_rpm: null,
    },
  });

  const selectedDate = watch('scheduled_date');

  function onSubmit(data: PumpChangeFormValues) {
    // Save engineer name for next time
    localStorage.setItem('wellfi_engineer_name', data.flagged_by);

    createPumpChange.mutate(
      {
        well_id: well.id,
        status: 'warning',
        flagged_by: data.flagged_by,
        flagged_at: new Date().toISOString(),
        scheduled_date: format(data.scheduled_date, 'yyyy-MM-dd'),
        formation_pressure_kpa: data.formation_pressure_kpa,
        pump_pressure_kpa: data.pump_pressure_kpa,
        pump_speed_rpm: data.pump_speed_rpm ?? null,
        notes: data.notes ?? null,
        device_sourced: false,
        program_configured: false,
        installation_scheduled: false,
        actual_date: null,
        completed_by: null,
        wellfi_installed_after: false,
        notification_sent: false,
      },
      {
        onSuccess: () => {
          toast.success('Pump change flagged for ' + (well.name ?? well.well_id));
          onSuccess();
        },
        onError: (error) => {
          toast.error('Failed to flag pump change: ' + error.message);
        },
      },
    );
  }

  return (
    <Card className="w-full max-w-lg">
      <CardHeader>
        <div className="flex items-center gap-3">
          <div className="flex-1">
            <CardTitle className="text-lg">{well.name ?? well.well_id}</CardTitle>
            {well.formatted_id && (
              <CardDescription className="font-mono text-xs">
                {well.formatted_id}
              </CardDescription>
            )}
          </div>
          {well.risk_level && (
            <Badge className={getRiskBadgeClasses(well.risk_level)}>
              {well.risk_level}
            </Badge>
          )}
        </div>
      </CardHeader>

      <form onSubmit={handleSubmit(onSubmit)}>
        <CardContent className="space-y-4">
          {/* Flagged By */}
          <div className="space-y-2">
            <Label htmlFor="flagged_by">Flagged By *</Label>
            <Input
              id="flagged_by"
              placeholder="Engineer name"
              {...register('flagged_by')}
            />
            {errors.flagged_by && (
              <p className="text-sm text-red-500">{errors.flagged_by.message}</p>
            )}
          </div>

          {/* Scheduled Date */}
          <div className="space-y-2">
            <Label>Scheduled Date *</Label>
            <Popover>
              <PopoverTrigger asChild>
                <Button
                  type="button"
                  variant="outline"
                  className={cn(
                    'w-full justify-start text-left font-normal',
                    !selectedDate && 'text-muted-foreground',
                  )}
                >
                  <CalendarIcon className="mr-2 h-4 w-4" />
                  {selectedDate ? format(selectedDate, 'PPP') : 'Pick a date'}
                </Button>
              </PopoverTrigger>
              <PopoverContent className="w-auto p-0" align="start">
                <Calendar
                  mode="single"
                  selected={selectedDate}
                  onSelect={(date) => {
                    if (date) {
                      setValue('scheduled_date', date, { shouldValidate: true });
                    }
                  }}
                  disabled={(date) => {
                    const today = new Date();
                    today.setHours(0, 0, 0, 0);
                    return date < today;
                  }}
                />
              </PopoverContent>
            </Popover>
            {errors.scheduled_date && (
              <p className="text-sm text-red-500">{errors.scheduled_date.message}</p>
            )}
          </div>

          {/* Pressures Row */}
          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label htmlFor="formation_pressure_kpa">Formation Pressure (kPa) *</Label>
              <Input
                id="formation_pressure_kpa"
                type="number"
                step="any"
                placeholder="e.g. 2500"
                {...register('formation_pressure_kpa', { valueAsNumber: true })}
              />
              {errors.formation_pressure_kpa && (
                <p className="text-sm text-red-500">
                  {errors.formation_pressure_kpa.message}
                </p>
              )}
            </div>
            <div className="space-y-2">
              <Label htmlFor="pump_pressure_kpa">Pump Pressure (kPa) *</Label>
              <Input
                id="pump_pressure_kpa"
                type="number"
                step="any"
                placeholder="e.g. 1800"
                {...register('pump_pressure_kpa', { valueAsNumber: true })}
              />
              {errors.pump_pressure_kpa && (
                <p className="text-sm text-red-500">
                  {errors.pump_pressure_kpa.message}
                </p>
              )}
            </div>
          </div>

          {/* Pump Speed */}
          <div className="space-y-2">
            <Label htmlFor="pump_speed_rpm">Pump Speed (RPM)</Label>
            <Input
              id="pump_speed_rpm"
              type="number"
              step="any"
              placeholder="Optional"
              {...register('pump_speed_rpm', { valueAsNumber: true })}
            />
            {errors.pump_speed_rpm && (
              <p className="text-sm text-red-500">{errors.pump_speed_rpm.message}</p>
            )}
          </div>

          {/* Notes */}
          <div className="space-y-2">
            <Label htmlFor="notes">Notes</Label>
            <Textarea
              id="notes"
              placeholder="Additional notes (optional)"
              rows={3}
              {...register('notes')}
            />
          </div>
        </CardContent>

        <CardFooter className="flex gap-3">
          <Button
            type="button"
            variant="outline"
            onClick={onCancel}
            className="flex-1"
          >
            Cancel
          </Button>
          <Button
            type="submit"
            disabled={isSubmitting || createPumpChange.isPending}
            className="flex-1 bg-orange-600 text-white hover:bg-red-700"
          >
            {createPumpChange.isPending ? 'Flagging...' : 'Flag Pump Change'}
          </Button>
        </CardFooter>
      </form>
    </Card>
  );
}
