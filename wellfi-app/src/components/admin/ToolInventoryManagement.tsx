import { useMemo, useState } from 'react';

import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
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
  useAddToolInventoryItem,
  useToolInventory,
  useUpdateToolInventoryItem,
} from '@/hooks/useWellEvents';
import {
  TOOL_INVENTORY_STATUS_CONFIG,
  type ToolInventoryItem,
  type ToolInventoryStatus,
} from '@/types/wellEvents';

interface ToolInventoryManagementProps {
  open: boolean;
  onClose: () => void;
}

type FilterTab = 'all' | ToolInventoryStatus;

const FILTER_TABS: { key: FilterTab; label: string }[] = [
  { key: 'all', label: 'All' },
  { key: 'in_stock', label: 'In Stock' },
  { key: 'reserved', label: 'Reserved' },
  { key: 'deployed', label: 'Deployed' },
  { key: 'service', label: 'Service' },
  { key: 'retired', label: 'Retired' },
];

function formatDate(dateStr: string | null): string {
  if (!dateStr) return '--';

  return new Date(dateStr).toLocaleDateString('en-CA', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
  });
}

function ToolStatusBadge({ status }: { status: ToolInventoryStatus }) {
  const config = TOOL_INVENTORY_STATUS_CONFIG[status];

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

function ToolRow({
  tool,
  onStatusChange,
}: {
  tool: ToolInventoryItem;
  onStatusChange: (id: string, status: ToolInventoryStatus) => void;
}) {
  const isManagedByFulfillment = tool.status === 'reserved' || tool.status === 'deployed';

  return (
    <tr className="border-b border-white/[0.04] last:border-0 hover:bg-white/[0.02] transition-colors">
      <td className="px-3 py-2 font-mono text-xs font-medium text-white/80">
        {tool.serial_number}
      </td>
      <td className="px-3 py-2 text-xs text-white/70">
        <div>{tool.tool_type}</div>
        {tool.model && <div className="text-white/40">{tool.model}</div>}
      </td>
      <td className="px-3 py-2">
        <ToolStatusBadge status={tool.status} />
      </td>
      <td className="px-3 py-2 text-xs text-white/45">
        {tool.notes ?? '--'}
      </td>
      <td className="px-3 py-2 text-xs text-white/45 tabular-nums">
        {formatDate(tool.updated_at)}
      </td>
      <td className="px-3 py-2 text-right">
        <div className="flex items-center justify-end gap-2">
          {tool.status === 'in_stock' && (
            <>
              <button
                type="button"
                onClick={() => onStatusChange(tool.id, 'service')}
                className="text-[10px] text-yellow-400/80 hover:text-yellow-400 transition-colors"
              >
                Service
              </button>
              <button
                type="button"
                onClick={() => onStatusChange(tool.id, 'retired')}
                className="text-[10px] text-white/55 hover:text-white transition-colors"
              >
                Retire
              </button>
            </>
          )}
          {tool.status === 'service' && (
            <>
              <button
                type="button"
                onClick={() => onStatusChange(tool.id, 'in_stock')}
                className="text-[10px] text-green-400/80 hover:text-green-400 transition-colors"
              >
                Return to Stock
              </button>
              <button
                type="button"
                onClick={() => onStatusChange(tool.id, 'retired')}
                className="text-[10px] text-white/55 hover:text-white transition-colors"
              >
                Retire
              </button>
            </>
          )}
          {tool.status === 'retired' && (
            <button
              type="button"
              onClick={() => onStatusChange(tool.id, 'in_stock')}
              className="text-[10px] text-green-400/80 hover:text-green-400 transition-colors"
            >
              Restore
            </button>
          )}
          {isManagedByFulfillment && (
            <span className="text-[10px] text-white/35">
              Controlled by fulfillment
            </span>
          )}
        </div>
      </td>
    </tr>
  );
}

export function ToolInventoryManagement({ open, onClose }: ToolInventoryManagementProps) {
  const { data: tools = [] } = useToolInventory();
  const addTool = useAddToolInventoryItem();
  const updateTool = useUpdateToolInventoryItem();

  const [serialInput, setSerialInput] = useState('');
  const [toolTypeInput, setToolTypeInput] = useState('');
  const [modelInput, setModelInput] = useState('');
  const [notesInput, setNotesInput] = useState('');
  const [addStatus, setAddStatus] = useState<'in_stock' | 'service'>('in_stock');
  const [activeTab, setActiveTab] = useState<FilterTab>('all');

  const filteredTools = useMemo(() => {
    if (activeTab === 'all') {
      return tools;
    }

    return tools.filter((tool) => tool.status === activeTab);
  }, [activeTab, tools]);

  const tabCounts = useMemo(() => {
    const counts: Record<string, number> = { all: tools.length };

    for (const tool of tools) {
      counts[tool.status] = (counts[tool.status] ?? 0) + 1;
    }

    return counts;
  }, [tools]);

  function handleAddTool(event: React.FormEvent) {
    event.preventDefault();

    const serialNumber = serialInput.trim();
    const toolType = toolTypeInput.trim();

    if (!serialNumber || !toolType) {
      return;
    }

    addTool.mutate(
      {
        serialNumber,
        toolType,
        model: modelInput.trim() || null,
        status: addStatus,
        notes: notesInput.trim() || null,
      },
      {
        onSuccess: () => {
          setSerialInput('');
          setToolTypeInput('');
          setModelInput('');
          setNotesInput('');
          setAddStatus('in_stock');
        },
      },
    );
  }

  function handleStatusChange(id: string, status: ToolInventoryStatus) {
    updateTool.mutate({
      id,
      updates: {
        status,
      },
    });
  }

  return (
    <Dialog open={open} onOpenChange={(nextOpen) => { if (!nextOpen) onClose(); }}>
      <DialogContent className="w-[calc(100%-2rem)] sm:w-full max-w-4xl max-h-[85vh] overflow-hidden flex flex-col">
        <DialogHeader>
          <DialogTitle>Tool Inventory</DialogTitle>
          <DialogDescription>
            Manage separate field tool stock for well event fulfillment.
          </DialogDescription>
        </DialogHeader>

        <form onSubmit={handleAddTool} className="grid gap-2 md:grid-cols-[1.1fr_1fr_1fr_1.2fr_auto] md:items-end">
          <div>
            <label htmlFor="tool-serial" className="text-[10px] font-medium text-white/40 uppercase tracking-wide">
              Serial Number
            </label>
            <Input
              id="tool-serial"
              value={serialInput}
              onChange={(event) => setSerialInput(event.target.value)}
              placeholder="e.g. WT-2026-014"
              className="mt-1 h-9 text-xs font-mono"
            />
          </div>
          <div>
            <label htmlFor="tool-type" className="text-[10px] font-medium text-white/40 uppercase tracking-wide">
              Tool Type
            </label>
            <Input
              id="tool-type"
              value={toolTypeInput}
              onChange={(event) => setToolTypeInput(event.target.value)}
              placeholder="e.g. Pull-through"
              className="mt-1 h-9 text-xs"
            />
          </div>
          <div>
            <label htmlFor="tool-model" className="text-[10px] font-medium text-white/40 uppercase tracking-wide">
              Model
            </label>
            <Input
              id="tool-model"
              value={modelInput}
              onChange={(event) => setModelInput(event.target.value)}
              placeholder="Optional"
              className="mt-1 h-9 text-xs"
            />
          </div>
          <div className="grid gap-2 sm:grid-cols-[1fr_1fr]">
            <div>
              <label htmlFor="tool-status" className="text-[10px] font-medium text-white/40 uppercase tracking-wide">
                Initial Status
              </label>
              <Select value={addStatus} onValueChange={(value) => setAddStatus(value as 'in_stock' | 'service')}>
                <SelectTrigger className="mt-1 h-9 text-xs">
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="in_stock">In Stock</SelectItem>
                  <SelectItem value="service">Service</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div>
              <label htmlFor="tool-notes" className="text-[10px] font-medium text-white/40 uppercase tracking-wide">
                Notes
              </label>
              <Input
                id="tool-notes"
                value={notesInput}
                onChange={(event) => setNotesInput(event.target.value)}
                placeholder="Optional"
                className="mt-1 h-9 text-xs"
              />
            </div>
          </div>
          <Button
            type="submit"
            size="sm"
            className="h-9 w-full md:w-auto bg-[#00D4FF] text-black hover:bg-[#00D4FF]/90"
            disabled={!serialInput.trim() || !toolTypeInput.trim() || addTool.isPending}
          >
            {addTool.isPending ? 'Adding...' : 'Add Tool'}
          </Button>
        </form>

        <div className="flex gap-1 border-b border-white/[0.06] pb-0">
          {FILTER_TABS.map(({ key, label }) => {
            const isActive = activeTab === key;
            const count = tabCounts[key] ?? 0;

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

        <div className="flex-1 overflow-auto rounded border border-white/[0.06]">
          {filteredTools.length > 0 ? (
            <table className="w-full min-w-[720px]">
              <thead className="sticky top-0 bg-[#0a0f18]">
                <tr className="border-b border-white/[0.08] text-[10px] font-semibold text-white/30 uppercase tracking-wide">
                  <th className="px-3 py-2 text-left">Serial</th>
                  <th className="px-3 py-2 text-left">Tool</th>
                  <th className="px-3 py-2 text-left">Status</th>
                  <th className="px-3 py-2 text-left">Notes</th>
                  <th className="px-3 py-2 text-left">Updated</th>
                  <th className="px-3 py-2 text-right">Action</th>
                </tr>
              </thead>
              <tbody>
                {filteredTools.map((tool) => (
                  <ToolRow
                    key={tool.id}
                    tool={tool}
                    onStatusChange={handleStatusChange}
                  />
                ))}
              </tbody>
            </table>
          ) : (
            <div className="flex items-center justify-center py-8 text-xs text-white/30">
              {activeTab === 'all'
                ? 'No tools in inventory'
                : `No ${FILTER_TABS.find((tab) => tab.key === activeTab)?.label.toLowerCase()} tools`}
            </div>
          )}
        </div>
      </DialogContent>
    </Dialog>
  );
}
