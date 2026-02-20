import { useState } from 'react';
import { useInventoryCounts } from '@/hooks/useDeviceInventory';
import { useAuth } from '@/lib/auth';
import { DEVICE_STATUS_CONFIG } from '@/types/deviceInventory';
import type { DeviceStatus } from '@/types/deviceInventory';
import { InventoryManagement } from '@/components/admin/InventoryManagement';

const DISPLAY_STATUSES: { key: DeviceStatus; label: string }[] = [
  { key: 'in_stock', label: 'In Stock' },
  { key: 'incoming', label: 'Incoming' },
  { key: 'assigned', label: 'Assigned' },
  { key: 'installed', label: 'Installed' },
];

interface InventoryOverviewProps {
  className?: string;
}

export function InventoryOverview({ className }: InventoryOverviewProps) {
  const counts = useInventoryCounts();
  const { isAdmin } = useAuth();
  const [manageOpen, setManageOpen] = useState(false);

  return (
    <>
      <div className={`bg-[#080D16]/80 backdrop-blur-xl border border-white/[0.06] rounded-lg px-3 py-2.5 ${className ?? ''}`}>
        <div className="flex items-center justify-between mb-2">
          <h3 className="text-[10px] font-semibold tracking-[0.12em] text-white/40 uppercase">
            Device Inventory
          </h3>
          {isAdmin && (
            <button
              type="button"
              onClick={() => setManageOpen(true)}
              className="text-[10px] text-[#00D4FF]/70 hover:text-[#00D4FF] transition-colors duration-200"
            >
              Manage
            </button>
          )}
        </div>

        <div className="flex items-center gap-3">
          {DISPLAY_STATUSES.map(({ key, label }) => {
            const config = DEVICE_STATUS_CONFIG[key];
            const count = counts[key];
            return (
              <div key={key} className="flex items-center gap-1.5 min-w-0">
                <span
                  className="h-2 w-2 rounded-full shrink-0"
                  style={{
                    backgroundColor: config.color,
                    boxShadow: `0 0 4px ${config.color}50`,
                  }}
                />
                <span className="text-[11px] font-medium text-white/80 tabular-nums">
                  {count}
                </span>
                <span className="text-[10px] text-white/40 truncate">
                  {label}
                </span>
              </div>
            );
          })}
        </div>
      </div>

      {manageOpen && (
        <InventoryManagement
          open={manageOpen}
          onClose={() => setManageOpen(false)}
        />
      )}
    </>
  );
}
