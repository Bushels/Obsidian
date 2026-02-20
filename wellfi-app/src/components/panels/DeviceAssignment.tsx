import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { useAuth } from '@/lib/auth';
import {
  useDeviceInventory,
  useAssignDevice,
  useMarkInstalled,
  useUnassignDevice,
} from '@/hooks/useDeviceInventory';
import { DEVICE_STATUS_CONFIG } from '@/types/deviceInventory';
import type { WellEnriched } from '@/types/operationalStatus';

interface DeviceAssignmentProps {
  well: WellEnriched;
  canEdit: boolean;
}

function formatDate(dateStr: string | null): string {
  if (!dateStr) return 'N/A';
  return new Date(dateStr).toLocaleDateString('en-CA', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
  });
}

export function DeviceAssignment({ well, canEdit }: DeviceAssignmentProps) {
  const { user } = useAuth();
  const { data: allDevices = [] } = useDeviceInventory();
  const assignDevice = useAssignDevice();
  const markInstalled = useMarkInstalled();
  const unassignDevice = useUnassignDevice();
  const [selectedDeviceId, setSelectedDeviceId] = useState<string>('');

  const assignedDevice = well.assigned_device;
  const hasOpStatus = !!well.operational_status?.is_active;
  const availableDevices = allDevices.filter(d => d.status === 'in_stock');

  // Don't render if no operational status and no device assigned
  if (!hasOpStatus && !assignedDevice) return null;

  const handleAssign = () => {
    if (!selectedDeviceId || !user) return;
    assignDevice.mutate({
      deviceId: selectedDeviceId,
      wellId: well.id,
      assignedBy: user.displayName,
      assignedByUserId: user.id,
    }, {
      onSuccess: () => setSelectedDeviceId(''),
    });
  };

  const handleMarkInstalled = () => {
    if (!assignedDevice || !user) return;
    markInstalled.mutate({
      deviceId: assignedDevice.id,
      installedBy: user.displayName,
      installedByUserId: user.id,
    });
  };

  const handleUnassign = () => {
    if (!assignedDevice) return;
    unassignDevice.mutate(assignedDevice.id);
  };

  // Device is assigned or installed
  if (assignedDevice) {
    const config = DEVICE_STATUS_CONFIG[assignedDevice.status];
    const isAssigned = assignedDevice.status === 'assigned';

    return (
      <Card>
        <CardHeader className="pb-2 pt-3 px-4">
          <CardTitle className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">
            Device Assignment
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-3 px-4 pb-3">
          {/* Status badge */}
          <div className="flex items-center gap-2">
            <span
              className="h-2.5 w-2.5 rounded-full shrink-0"
              style={{
                backgroundColor: config.color,
                boxShadow: `0 0 6px ${config.color}40`,
              }}
            />
            <span className="text-sm font-medium" style={{ color: config.color }}>
              {config.label}
            </span>
          </div>

          {/* Device info */}
          <div className="grid grid-cols-2 gap-x-4 gap-y-1 text-sm">
            <div>
              <p className="text-xs text-muted-foreground">Serial Number</p>
              <p className="font-mono font-medium text-xs">{assignedDevice.serial_number}</p>
            </div>
            {assignedDevice.assigned_by && (
              <div>
                <p className="text-xs text-muted-foreground">Assigned by</p>
                <p className="font-medium text-xs">{assignedDevice.assigned_by}</p>
              </div>
            )}
            {assignedDevice.assigned_at && (
              <div>
                <p className="text-xs text-muted-foreground">Assigned</p>
                <p className="font-medium text-xs">{formatDate(assignedDevice.assigned_at)}</p>
              </div>
            )}
            {assignedDevice.installed_at && (
              <div>
                <p className="text-xs text-muted-foreground">Installed</p>
                <p className="font-medium text-xs">{formatDate(assignedDevice.installed_at)}</p>
              </div>
            )}
          </div>

          {/* Admin actions */}
          {canEdit && isAssigned && (
            <div className="flex gap-2">
              <Button
                size="sm"
                className="flex-1 bg-[#00D4FF] text-black hover:bg-[#00D4FF]/90"
                onClick={handleMarkInstalled}
                disabled={markInstalled.isPending}
              >
                {markInstalled.isPending ? 'Updating...' : 'Mark Installed'}
              </Button>
              <Button
                size="sm"
                variant="outline"
                className="flex-1"
                onClick={handleUnassign}
                disabled={unassignDevice.isPending}
              >
                {unassignDevice.isPending ? 'Removing...' : 'Unassign'}
              </Button>
            </div>
          )}

          {assignedDevice.notes && (
            <p className="text-xs text-muted-foreground italic">{assignedDevice.notes}</p>
          )}
        </CardContent>
      </Card>
    );
  }

  // Has op status but no device assigned
  if (hasOpStatus && canEdit) {
    return (
      <Card>
        <CardHeader className="pb-2 pt-3 px-4">
          <CardTitle className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">
            Device Assignment
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-3 px-4 pb-3">
          {availableDevices.length > 0 ? (
            <>
              <p className="text-xs text-muted-foreground">
                Assign a WellFi device from available stock
              </p>
              <Select value={selectedDeviceId} onValueChange={setSelectedDeviceId}>
                <SelectTrigger className="h-9 text-xs">
                  <SelectValue placeholder="Select a device..." />
                </SelectTrigger>
                <SelectContent>
                  {availableDevices.map(device => (
                    <SelectItem key={device.id} value={device.id}>
                      <span className="font-mono">{device.serial_number}</span>
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
              <Button
                size="sm"
                className="w-full bg-[#00D4FF] text-black hover:bg-[#00D4FF]/90"
                onClick={handleAssign}
                disabled={!selectedDeviceId || assignDevice.isPending}
              >
                {assignDevice.isPending ? 'Assigning...' : 'Assign Device'}
              </Button>
            </>
          ) : (
            <p className="text-xs text-muted-foreground text-center py-1">
              No devices in stock. Add devices via inventory management.
            </p>
          )}
        </CardContent>
      </Card>
    );
  }

  // Has op status, no device, viewer role
  if (hasOpStatus && !canEdit) {
    return (
      <Card>
        <CardHeader className="pb-2 pt-3 px-4">
          <CardTitle className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">
            Device Assignment
          </CardTitle>
        </CardHeader>
        <CardContent className="px-4 pb-3">
          <p className="text-xs text-muted-foreground text-center py-1">
            No device assigned yet
          </p>
        </CardContent>
      </Card>
    );
  }

  return null;
}
