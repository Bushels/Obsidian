import { useState, useMemo } from 'react';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import {
  useDeviceInventory,
  useAddDevice,
  useMarkInStock,
  useUnassignDevice,
} from '@/hooks/useDeviceInventory';
import { DEVICE_STATUS_CONFIG } from '@/types/deviceInventory';
import type { DeviceStatus, DeviceInventoryItem } from '@/types/deviceInventory';

interface InventoryManagementProps {
  open: boolean;
  onClose: () => void;
}

type FilterTab = 'all' | DeviceStatus;

const FILTER_TABS: { key: FilterTab; label: string }[] = [
  { key: 'all', label: 'All' },
  { key: 'in_stock', label: 'In Stock' },
  { key: 'incoming', label: 'Incoming' },
  { key: 'assigned', label: 'Assigned' },
  { key: 'installed', label: 'Installed' },
];

function formatDate(dateStr: string | null): string {
  if (!dateStr) return '--';
  return new Date(dateStr).toLocaleDateString('en-CA', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
  });
}

function StatusBadge({ status }: { status: DeviceStatus }) {
  const config = DEVICE_STATUS_CONFIG[status];
  return (
    <span
      className="inline-flex items-center gap-1 rounded-full px-2 py-0.5 text-[10px] font-medium"
      style={{
        backgroundColor: `${config.color}20`,
        color: config.color,
        border: `1px solid ${config.color}30`,
      }}
    >
      <span
        className="h-1.5 w-1.5 rounded-full"
        style={{ backgroundColor: config.color }}
      />
      {config.label}
    </span>
  );
}

function DeviceRow({
  device,
  onMarkInStock,
  onUnassign,
}: {
  device: DeviceInventoryItem;
  onMarkInStock: (id: string) => void;
  onUnassign: (id: string) => void;
}) {
  return (
    <tr className="border-b border-white/[0.04] last:border-0 hover:bg-white/[0.02] transition-colors">
      <td className="px-3 py-2 font-mono text-xs font-medium text-white/80">
        {device.serial_number}
      </td>
      <td className="px-3 py-2">
        <StatusBadge status={device.status} />
      </td>
      <td className="px-3 py-2 text-xs text-white/50">
        {device.assigned_by ? `by ${device.assigned_by}` : '--'}
      </td>
      <td className="px-3 py-2 text-xs text-white/50 tabular-nums">
        {device.status === 'installed'
          ? formatDate(device.installed_at)
          : device.status === 'assigned'
            ? formatDate(device.assigned_at)
            : formatDate(device.created_at)}
      </td>
      <td className="px-3 py-2 text-right">
        {device.status === 'incoming' && (
          <button
            type="button"
            onClick={() => onMarkInStock(device.id)}
            className="text-[10px] text-green-400/70 hover:text-green-400 transition-colors"
          >
            Mark In Stock
          </button>
        )}
        {device.status === 'assigned' && (
          <button
            type="button"
            onClick={() => onUnassign(device.id)}
            className="text-[10px] text-yellow-400/70 hover:text-yellow-400 transition-colors"
          >
            Unassign
          </button>
        )}
      </td>
    </tr>
  );
}

export function InventoryManagement({ open, onClose }: InventoryManagementProps) {
  const { data: devices = [] } = useDeviceInventory();
  const addDevice = useAddDevice();
  const markInStock = useMarkInStock();
  const unassignDevice = useUnassignDevice();

  const [serialInput, setSerialInput] = useState('');
  const [notesInput, setNotesInput] = useState('');
  const [addStatus, setAddStatus] = useState<'in_stock' | 'incoming'>('in_stock');
  const [activeTab, setActiveTab] = useState<FilterTab>('all');

  const filteredDevices = useMemo(() => {
    if (activeTab === 'all') return devices;
    return devices.filter(d => d.status === activeTab);
  }, [devices, activeTab]);

  const tabCounts = useMemo(() => {
    const counts: Record<string, number> = { all: devices.length };
    for (const d of devices) {
      counts[d.status] = (counts[d.status] ?? 0) + 1;
    }
    return counts;
  }, [devices]);

  const handleAddDevice = (e: React.FormEvent) => {
    e.preventDefault();
    const serial = serialInput.trim();
    if (!serial) return;
    addDevice.mutate(
      { serial_number: serial, status: addStatus, notes: notesInput.trim() || null },
      { onSuccess: () => { setSerialInput(''); setNotesInput(''); } },
    );
  };

  return (
    <Dialog open={open} onOpenChange={(v) => { if (!v) onClose(); }}>
      <DialogContent className="max-w-2xl max-h-[85vh] overflow-hidden flex flex-col">
        <DialogHeader>
          <DialogTitle>Device Inventory</DialogTitle>
          <DialogDescription>
            Manage WellFi device stock, assignments, and lifecycle
          </DialogDescription>
        </DialogHeader>

        {/* Add device form */}
        <form onSubmit={handleAddDevice} className="flex gap-2 items-end">
          <div className="flex-1">
            <label htmlFor="serial" className="text-[10px] font-medium text-white/40 uppercase tracking-wide">
              Serial Number
            </label>
            <Input
              id="serial"
              value={serialInput}
              onChange={(e) => setSerialInput(e.target.value)}
              placeholder="e.g. WF-2026-001"
              className="h-9 text-xs font-mono mt-1"
            />
          </div>
          <div className="w-32">
            <label htmlFor="add-status" className="text-[10px] font-medium text-white/40 uppercase tracking-wide">
              Status
            </label>
            <Select value={addStatus} onValueChange={(v) => setAddStatus(v as 'in_stock' | 'incoming')}>
              <SelectTrigger className="h-9 text-xs mt-1">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="in_stock">In Stock</SelectItem>
                <SelectItem value="incoming">Incoming</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="flex-1">
            <label htmlFor="notes" className="text-[10px] font-medium text-white/40 uppercase tracking-wide">
              Notes (optional)
            </label>
            <Input
              id="notes"
              value={notesInput}
              onChange={(e) => setNotesInput(e.target.value)}
              placeholder="Optional notes..."
              className="h-9 text-xs mt-1"
            />
          </div>
          <Button
            type="submit"
            size="sm"
            className="h-9 bg-[#00D4FF] text-black hover:bg-[#00D4FF]/90 shrink-0"
            disabled={!serialInput.trim() || addDevice.isPending}
          >
            {addDevice.isPending ? 'Adding...' : 'Add Device'}
          </Button>
        </form>

        {/* Filter tabs */}
        <div className="flex gap-1 border-b border-white/[0.06] pb-0">
          {FILTER_TABS.map(({ key, label }) => {
            const count = tabCounts[key] ?? 0;
            const isActive = activeTab === key;
            return (
              <button
                key={key}
                type="button"
                onClick={() => setActiveTab(key)}
                className={`px-3 py-1.5 text-[11px] font-medium rounded-t transition-colors ${
                  isActive
                    ? 'text-white bg-white/[0.06] border-b-2 border-[#00D4FF]'
                    : 'text-white/40 hover:text-white/60'
                }`}
              >
                {label}
                <span className="ml-1 text-[10px] opacity-60">{count}</span>
              </button>
            );
          })}
        </div>

        {/* Device table */}
        <div className="flex-1 overflow-y-auto rounded border border-white/[0.06]">
          {filteredDevices.length > 0 ? (
            <table className="w-full">
              <thead className="sticky top-0 bg-[#0a0f18]">
                <tr className="border-b border-white/[0.08] text-[10px] font-semibold text-white/30 uppercase tracking-wide">
                  <th className="px-3 py-2 text-left">Serial</th>
                  <th className="px-3 py-2 text-left">Status</th>
                  <th className="px-3 py-2 text-left">Info</th>
                  <th className="px-3 py-2 text-left">Date</th>
                  <th className="px-3 py-2 text-right">Action</th>
                </tr>
              </thead>
              <tbody>
                {filteredDevices.map(device => (
                  <DeviceRow
                    key={device.id}
                    device={device}
                    onMarkInStock={(id) => markInStock.mutate(id)}
                    onUnassign={(id) => unassignDevice.mutate(id)}
                  />
                ))}
              </tbody>
            </table>
          ) : (
            <div className="flex items-center justify-center py-8 text-xs text-white/30">
              {activeTab === 'all' ? 'No devices in inventory' : `No ${FILTER_TABS.find(t => t.key === activeTab)?.label.toLowerCase()} devices`}
            </div>
          )}
        </div>
      </DialogContent>
    </Dialog>
  );
}
