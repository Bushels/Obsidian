import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { toast } from 'sonner';
import { useRegisterWellFiDevice } from '@/hooks/useWellFiDevices';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Button } from '@/components/ui/button';
import { Textarea } from '@/components/ui/textarea';
import type { Well } from '@/types';

interface WellFiInstallFormProps {
  well: Well;
  onSuccess: () => void;
  onCancel: () => void;
}

const optionalPositiveNumber = z.union([z.number().positive('Must be a positive number'), z.null()]).optional();

const installSchema = z.object({
  installed_by: z.string().min(2, 'Name must be at least 2 characters'),
  installed_at: z.string().min(1, 'Installation date is required'),
  serial_number: z.string().optional(),
  firmware_version: z.string().optional(),
  pump_speed_rpm: z.number({ error: 'Pump speed is required' }).positive('Must be a positive number'),
  formation_pressure_kpa: z.number({ error: 'Formation pressure is required' }).positive('Must be a positive number'),
  pump_intake_pressure_kpa: optionalPositiveNumber,
  target_surface_pressure_kpa: optionalPositiveNumber,
  total_depth_m: optionalPositiveNumber,
  pump_depth_m: optionalPositiveNumber,
  slotted_tag_bar_depth_m: optionalPositiveNumber,
  wellfi_depth_m: optionalPositiveNumber,
  no_turn_depth_m: optionalPositiveNumber,
  notes: z.string().optional(),
});

type InstallFormValues = z.infer<typeof installSchema>;

function formatDatetimeLocal(date: Date): string {
  const pad = (n: number) => String(n).padStart(2, '0');
  return `${date.getFullYear()}-${pad(date.getMonth() + 1)}-${pad(date.getDate())}T${pad(date.getHours())}:${pad(date.getMinutes())}`;
}

function formatDepthTagValue(value: number): string {
  return Number.isInteger(value) ? String(value) : value.toFixed(1);
}

function toNullableNumber(value: unknown): number | null {
  if (value === '' || value === null || value === undefined) return null;
  const parsed = typeof value === 'number' ? value : Number(value);
  if (!Number.isFinite(parsed)) return null;
  return parsed;
}

function buildDownholeTagBlock(data: InstallFormValues): string | null {
  const depthEntries: Array<[string, number | null | undefined]> = [
    ['total_depth_m', data.total_depth_m],
    ['pump_depth_m', data.pump_depth_m],
    ['slotted_tag_bar_depth_m', data.slotted_tag_bar_depth_m],
    ['wellfi_depth_m', data.wellfi_depth_m],
    ['no_turn_depth_m', data.no_turn_depth_m],
  ];

  const depthLines = depthEntries
    .filter(([, value]) => typeof value === 'number' && Number.isFinite(value))
    .map(([key, value]) => `${key}=${formatDepthTagValue(value as number)}`);

  if (depthLines.length === 0) return null;
  return ['[downhole]', ...depthLines].join('\n');
}

export default function WellFiInstallForm({ well, onSuccess, onCancel }: WellFiInstallFormProps) {
  const registerDevice = useRegisterWellFiDevice();

  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm<InstallFormValues>({
    resolver: zodResolver(installSchema),
    defaultValues: {
      installed_by: localStorage.getItem('wellfi_engineer_name') ?? '',
      installed_at: formatDatetimeLocal(new Date()),
      serial_number: '',
      firmware_version: '',
      notes: '',
      pump_intake_pressure_kpa: null,
      target_surface_pressure_kpa: null,
      total_depth_m: null,
      pump_depth_m: null,
      slotted_tag_bar_depth_m: null,
      wellfi_depth_m: null,
      no_turn_depth_m: null,
    },
  });

  function onSubmit(data: InstallFormValues) {
    // Persist engineer name for future use
    localStorage.setItem('wellfi_engineer_name', data.installed_by);
    const notesParts: string[] = [];
    const trimmedNotes = data.notes?.trim();
    if (trimmedNotes) notesParts.push(trimmedNotes);

    const downholeTagBlock = buildDownholeTagBlock(data);
    if (downholeTagBlock) notesParts.push(downholeTagBlock);

    const notesValue = notesParts.length > 0 ? notesParts.join('\n\n') : null;

    registerDevice.mutate(
      {
        well_id: well.id,
        installed_by: data.installed_by,
        installed_at: new Date(data.installed_at).toISOString(),
        serial_number: data.serial_number || null,
        firmware_version: data.firmware_version || null,
        pump_speed_rpm: data.pump_speed_rpm,
        formation_pressure_kpa: data.formation_pressure_kpa,
        pump_intake_pressure_kpa: data.pump_intake_pressure_kpa ?? null,
        target_surface_pressure_kpa: data.target_surface_pressure_kpa ?? null,
        notes: notesValue,
        is_active: true,
      },
      {
        onSuccess: () => {
          toast.success('WellFi installed on ' + (well.name ?? well.well_id));
          onSuccess();
        },
        onError: (err) => {
          toast.error('Installation failed: ' + err.message);
        },
      },
    );
  }

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-4 max-h-[70vh] overflow-y-auto pr-1">
      {well.wellfi_device && (
        <div className="rounded-md border border-risk-orange bg-risk-orange/10 p-3 text-sm text-risk-orange">
          This well already has an active WellFi device (SN: {well.wellfi_device.serial_number ?? 'N/A'}).
          Registering a new device will deactivate the existing one.
        </div>
      )}

      {/* Device Info Section */}
      <Card>
        <CardHeader className="pb-3 pt-4 px-4">
          <CardTitle className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">
            Device Info
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-3 px-4 pb-4">
          <div>
            <Label htmlFor="installed_by">Installed By *</Label>
            <Input
              id="installed_by"
              placeholder="Engineer name"
              {...register('installed_by')}
            />
            {errors.installed_by && (
              <p className="mt-1 text-xs text-risk-red">{errors.installed_by.message}</p>
            )}
          </div>

          <div>
            <Label htmlFor="installed_at">Installation Date *</Label>
            <Input
              id="installed_at"
              type="datetime-local"
              {...register('installed_at')}
            />
            {errors.installed_at && (
              <p className="mt-1 text-xs text-risk-red">{errors.installed_at.message}</p>
            )}
          </div>

          <div className="grid grid-cols-2 gap-3">
            <div>
              <Label htmlFor="serial_number">Serial Number</Label>
              <Input
                id="serial_number"
                placeholder="WF-XXXX"
                {...register('serial_number')}
              />
            </div>
            <div>
              <Label htmlFor="firmware_version">Firmware Version</Label>
              <Input
                id="firmware_version"
                placeholder="e.g. 2.1.0"
                {...register('firmware_version')}
              />
            </div>
          </div>
        </CardContent>
      </Card>

      {/* WellFi Parameters Section */}
      <Card>
        <CardHeader className="pb-3 pt-4 px-4">
          <CardTitle className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">
            WellFi Parameters
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-3 px-4 pb-4">
          <div className="grid grid-cols-2 gap-3">
            <div>
              <Label htmlFor="pump_speed_rpm">Pump Speed (RPM) *</Label>
              <Input
                id="pump_speed_rpm"
                type="number"
                step="any"
                placeholder="e.g. 120"
                {...register('pump_speed_rpm', { valueAsNumber: true })}
              />
              {errors.pump_speed_rpm && (
                <p className="mt-1 text-xs text-risk-red">{errors.pump_speed_rpm.message}</p>
              )}
            </div>
            <div>
              <Label htmlFor="formation_pressure_kpa">Formation Pressure (kPa) *</Label>
              <Input
                id="formation_pressure_kpa"
                type="number"
                step="any"
                placeholder="e.g. 3500"
                {...register('formation_pressure_kpa', { valueAsNumber: true })}
              />
              {errors.formation_pressure_kpa && (
                <p className="mt-1 text-xs text-risk-red">{errors.formation_pressure_kpa.message}</p>
              )}
            </div>
          </div>

          <div className="grid grid-cols-2 gap-3">
            <div>
              <Label htmlFor="pump_intake_pressure_kpa">Pump Intake (kPa)</Label>
              <Input
                id="pump_intake_pressure_kpa"
                type="number"
                step="any"
                placeholder="e.g. 2800"
                {...register('pump_intake_pressure_kpa', { setValueAs: toNullableNumber })}
              />
              {errors.pump_intake_pressure_kpa && (
                <p className="mt-1 text-xs text-risk-red">{errors.pump_intake_pressure_kpa.message}</p>
              )}
            </div>
            <div>
              <Label htmlFor="target_surface_pressure_kpa">Target Surface (kPa)</Label>
              <Input
                id="target_surface_pressure_kpa"
                type="number"
                step="any"
                placeholder="e.g. 200"
                {...register('target_surface_pressure_kpa', { setValueAs: toNullableNumber })}
              />
              {errors.target_surface_pressure_kpa && (
                <p className="mt-1 text-xs text-risk-red">{errors.target_surface_pressure_kpa.message}</p>
              )}
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Downhole Placement Section */}
      <Card>
        <CardHeader className="pb-3 pt-4 px-4">
          <CardTitle className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">
            Downhole Placement (Optional)
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-3 px-4 pb-4">
          <p className="text-xs text-muted-foreground">
            Enter measured depths to power the 3D downhole view. Order should be Pump, Slotted Tag Bar, WellFi Tool, then No-Turn Tool.
          </p>

          <div className="grid grid-cols-2 gap-3">
            <div>
              <Label htmlFor="total_depth_m">Total Depth (m)</Label>
              <Input
                id="total_depth_m"
                type="number"
                step="any"
                placeholder="e.g. 760"
                {...register('total_depth_m', { setValueAs: toNullableNumber })}
              />
              {errors.total_depth_m && (
                <p className="mt-1 text-xs text-risk-red">{errors.total_depth_m.message}</p>
              )}
            </div>
            <div>
              <Label htmlFor="pump_depth_m">Pump Depth (m)</Label>
              <Input
                id="pump_depth_m"
                type="number"
                step="any"
                placeholder="e.g. 640"
                {...register('pump_depth_m', { setValueAs: toNullableNumber })}
              />
              {errors.pump_depth_m && (
                <p className="mt-1 text-xs text-risk-red">{errors.pump_depth_m.message}</p>
              )}
            </div>
          </div>

          <div className="grid grid-cols-2 gap-3">
            <div>
              <Label htmlFor="slotted_tag_bar_depth_m">Slotted Tag Bar Depth (m)</Label>
              <Input
                id="slotted_tag_bar_depth_m"
                type="number"
                step="any"
                placeholder="e.g. 649"
                {...register('slotted_tag_bar_depth_m', { setValueAs: toNullableNumber })}
              />
              {errors.slotted_tag_bar_depth_m && (
                <p className="mt-1 text-xs text-risk-red">{errors.slotted_tag_bar_depth_m.message}</p>
              )}
            </div>
            <div>
              <Label htmlFor="wellfi_depth_m">WellFi Tool Depth (m)</Label>
              <Input
                id="wellfi_depth_m"
                type="number"
                step="any"
                placeholder="e.g. 655"
                {...register('wellfi_depth_m', { setValueAs: toNullableNumber })}
              />
              {errors.wellfi_depth_m && (
                <p className="mt-1 text-xs text-risk-red">{errors.wellfi_depth_m.message}</p>
              )}
            </div>
          </div>

          <div>
            <Label htmlFor="no_turn_depth_m">No-Turn Tool Depth (m)</Label>
            <Input
              id="no_turn_depth_m"
              type="number"
              step="any"
              placeholder="e.g. 661"
              {...register('no_turn_depth_m', { setValueAs: toNullableNumber })}
            />
            {errors.no_turn_depth_m && (
              <p className="mt-1 text-xs text-risk-red">{errors.no_turn_depth_m.message}</p>
            )}
          </div>

          <div>
            <Label htmlFor="notes">Notes</Label>
            <Textarea
              id="notes"
              placeholder="Optional installation notes..."
              rows={3}
              {...register('notes')}
            />
          </div>
        </CardContent>
      </Card>

      {/* Actions */}
      <div className="flex gap-2 pt-2">
        <Button
          type="button"
          variant="outline"
          className="flex-1"
          onClick={onCancel}
        >
          Cancel
        </Button>
        <Button
          type="submit"
          className="flex-1 bg-wellfi-cyan text-black hover:bg-wellfi-cyan/90"
          disabled={isSubmitting || registerDevice.isPending}
        >
          {registerDevice.isPending ? 'Registering...' : 'Register WellFi Installation'}
        </Button>
      </div>
    </form>
  );
}
