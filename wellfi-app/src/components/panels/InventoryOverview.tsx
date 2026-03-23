import { useState } from 'react';
import { useInventoryCounts } from '@/hooks/useDeviceInventory';
import { useToolInventoryCounts } from '@/hooks/useWellEvents';
import { useAuth } from '@/lib/auth-context';
import { DEVICE_STATUS_CONFIG } from '@/types/deviceInventory';
import type { DeviceStatus } from '@/types/deviceInventory';
import { TOOL_INVENTORY_STATUS_CONFIG } from '@/types/wellEvents';
import { InventoryManagement } from '@/components/admin/InventoryManagement';
import { ToolInventoryManagement } from '@/components/admin/ToolInventoryManagement';

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
  const deviceCounts = useInventoryCounts();
  const toolCounts = useToolInventoryCounts();
  const { isAdmin } = useAuth();
  const [manageOpen, setManageOpen] = useState(false);
  const [toolManageOpen, setToolManageOpen] = useState(false);

  if (!isAdmin) {
    return null;
  }

  return (
    <>
      <div className={`bg-[#080D16]/80 backdrop-blur-xl border border-white/[0.06] rounded-lg px-3 py-2.5 ${className ?? ''}`}>
        <div className="mb-3">
          <h3 className="text-[10px] font-semibold tracking-[0.12em] text-white/40 uppercase">
            Inventory
          </h3>
        </div>

        <div className="space-y-3">
          <div>
            <div className="mb-2 flex items-center justify-between">
              <span className="text-[10px] font-semibold uppercase tracking-wide text-white/35">
                WellFi Devices
              </span>
              <button
                type="button"
                onClick={() => setManageOpen(true)}
                className="text-[10px] text-[#00D4FF]/70 hover:text-[#00D4FF] transition-colors duration-200"
              >
                Manage
              </button>
            </div>
            <div className="flex items-center gap-3">
              {DISPLAY_STATUSES.map(({ key, label }) => {
                const config = DEVICE_STATUS_CONFIG[key];
                const count = deviceCounts[key];
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

          <div className="border-t border-white/[0.06] pt-3">
            <div className="mb-2 flex items-center justify-between">
              <span className="text-[10px] font-semibold uppercase tracking-wide text-white/35">
                Field Tools
              </span>
              <button
                type="button"
                onClick={() => setToolManageOpen(true)}
                className="text-[10px] text-[#00D4FF]/70 hover:text-[#00D4FF] transition-colors duration-200"
              >
                Manage
              </button>
            </div>
            <div className="flex flex-wrap items-center gap-3">
              {(['in_stock', 'reserved', 'deployed', 'service'] as const).map((status) => {
                const config = TOOL_INVENTORY_STATUS_CONFIG[status];
                const count = toolCounts[status];
                return (
                  <div key={status} className="flex items-center gap-1.5 min-w-0">
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
                      {config.label}
                    </span>
                  </div>
                );
              })}
            </div>
          </div>
        </div>
      </div>

      {manageOpen && (
        <InventoryManagement
          open={manageOpen}
          onClose={() => setManageOpen(false)}
        />
      )}

      {toolManageOpen && (
        <ToolInventoryManagement
          open={toolManageOpen}
          onClose={() => setToolManageOpen(false)}
        />
      )}
    </>
  );
}
