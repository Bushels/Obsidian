import { useState } from 'react';
import { toast } from 'sonner';

import type { WellEnriched, OperationalStatusType } from '@/types/operationalStatus';
import { OP_STATUS_OPTIONS, OP_STATUS_CONFIG } from '@/types/operationalStatus';
import { useSetOperationalStatus, useClearOperationalStatus } from '@/hooks/useOperationalStatuses';
import { useAuth } from '@/lib/auth';

// ─── Props ────────────────────────────────────────────────────

interface OperationalStatusFormProps {
  well: WellEnriched;
  onStatusChange?: () => void;
}

// ─── Component ────────────────────────────────────────────────

/**
 * OperationalStatusForm — lets engineers set Watch / Warning / Well Down
 * status on a well. Three toggle buttons + optional notes + date range.
 * Glassmorphic dark theme.
 */
export default function OperationalStatusForm({
  well,
  onStatusChange,
}: OperationalStatusFormProps) {
  const { user } = useAuth();
  const setStatus = useSetOperationalStatus();
  const clearStatus = useClearOperationalStatus();

  const currentStatus = well.operational_status?.is_active
    ? well.operational_status.status
    : null;

  const [selected, setSelected] = useState<OperationalStatusType | null>(
    currentStatus,
  );
  const [notes, setNotes] = useState(well.operational_status?.notes ?? '');
  const [showNotes, setShowNotes] = useState(!!well.operational_status?.notes);
  const [pumpChangeStart, setPumpChangeStart] = useState(
    well.operational_status?.pump_change_start ?? '',
  );
  const [pumpChangeEnd, setPumpChangeEnd] = useState(
    well.operational_status?.pump_change_end ?? '',
  );
  const [showDates, setShowDates] = useState(
    !!(well.operational_status?.pump_change_start || well.operational_status?.pump_change_end),
  );

  const wellDisplayName = well.name ?? well.well_id;

  // ─── Handlers ─────────────────────────────────────────────

  function handleSave() {
    if (!selected) return;
    if (!user) {
      toast.error('You must be signed in to set status');
      return;
    }

    setStatus.mutate(
      {
        well_id: well.id,
        status: selected,
        set_by: user.displayName ?? user.email ?? 'Unknown',
        set_by_user_id: user.id,
        notes: notes.trim() || null,
        pump_change_start: pumpChangeStart || null,
        pump_change_end: pumpChangeEnd || null,
      },
      {
        onSuccess: () => {
          const label = OP_STATUS_CONFIG[selected].label;
          toast.success(`Status set to ${label} for ${wellDisplayName}`);
          onStatusChange?.();
        },
      },
    );
  }

  function handleClear() {
    clearStatus.mutate(well.id, {
      onSuccess: () => {
        toast.success(`Status cleared for ${wellDisplayName}`);
        setSelected(null);
        setNotes('');
        setPumpChangeStart('');
        setPumpChangeEnd('');
        onStatusChange?.();
      },
    });
  }

  const isPending = setStatus.isPending || clearStatus.isPending;

  // ─── Render ───────────────────────────────────────────────

  return (
    <div className="bg-[#080D16]/80 backdrop-blur-xl border border-white/[0.06] rounded-lg p-4 space-y-4">
      {/* Header */}
      <div>
        <h3 className="text-[10px] font-semibold tracking-[0.12em] text-white/40 uppercase mb-0.5">
          Operational Status
        </h3>
        <p className="text-xs text-white/50 leading-snug">
          Set a manual status flag for {wellDisplayName}
        </p>
      </div>

      {/* Toggle buttons row */}
      <div className="flex gap-2">
        {OP_STATUS_OPTIONS.map((option) => {
          const isSelected = selected === option.value;
          const config = OP_STATUS_CONFIG[option.value];

          return (
            <button
              key={option.value}
              type="button"
              disabled={isPending}
              onClick={() =>
                setSelected(isSelected ? null : option.value)
              }
              className="flex-1 relative rounded-lg px-3 py-2.5 text-xs font-medium border transition-all duration-200 cursor-pointer disabled:opacity-50 disabled:cursor-not-allowed"
              style={
                isSelected
                  ? {
                      backgroundColor: `${config.color}20`,
                      borderColor: `${config.color}60`,
                      color: config.color,
                      boxShadow: `0 0 16px ${config.color}25, inset 0 0 12px ${config.color}10`,
                    }
                  : {
                      backgroundColor: 'rgba(255, 255, 255, 0.03)',
                      borderColor: 'rgba(255, 255, 255, 0.06)',
                      color: 'rgba(255, 255, 255, 0.50)',
                    }
              }
              title={option.description}
            >
              {/* Glow dot */}
              <span
                className="block h-2 w-2 rounded-full mx-auto mb-1.5"
                style={{
                  backgroundColor: isSelected ? config.color : 'rgba(255, 255, 255, 0.15)',
                  boxShadow: isSelected ? `0 0 8px ${config.color}80` : 'none',
                }}
              />
              {option.label}
            </button>
          );
        })}
      </div>

      {/* Description for selected status */}
      {selected && (
        <p className="text-[11px] text-white/35 leading-relaxed px-1">
          {OP_STATUS_OPTIONS.find((o) => o.value === selected)?.description}
        </p>
      )}

      {/* Optional: Notes section */}
      <div>
        {!showNotes ? (
          <button
            type="button"
            onClick={() => setShowNotes(true)}
            className="text-[11px] text-[#00D4FF]/70 hover:text-[#00D4FF] transition-colors duration-200 cursor-pointer"
          >
            + Add notes
          </button>
        ) : (
          <div className="space-y-1.5">
            <label className="text-[10px] font-medium text-white/40 uppercase tracking-wide">
              Notes
            </label>
            <textarea
              value={notes}
              onChange={(e) => setNotes(e.target.value)}
              rows={2}
              placeholder="Optional notes..."
              disabled={isPending}
              className="w-full bg-white/[0.03] border border-white/[0.06] rounded-md px-3 py-2 text-xs text-white/80 placeholder:text-white/20 focus:outline-none focus:border-[#00D4FF]/30 focus:ring-1 focus:ring-[#00D4FF]/20 resize-none transition-all duration-200 disabled:opacity-50"
            />
          </div>
        )}
      </div>

      {/* Optional: Pump change date range */}
      <div>
        {!showDates ? (
          <button
            type="button"
            onClick={() => setShowDates(true)}
            className="text-[11px] text-[#00D4FF]/70 hover:text-[#00D4FF] transition-colors duration-200 cursor-pointer"
          >
            + Add pump change window
          </button>
        ) : (
          <div className="space-y-1.5">
            <label className="text-[10px] font-medium text-white/40 uppercase tracking-wide">
              Pump Change Window
            </label>
            <div className="grid grid-cols-2 gap-2">
              <div>
                <span className="text-[10px] text-white/30 block mb-1">Earliest</span>
                <input
                  type="date"
                  value={pumpChangeStart}
                  onChange={(e) => setPumpChangeStart(e.target.value)}
                  disabled={isPending}
                  className="w-full bg-white/[0.03] border border-white/[0.06] rounded-md px-2.5 py-1.5 text-xs text-white/80 focus:outline-none focus:border-[#00D4FF]/30 focus:ring-1 focus:ring-[#00D4FF]/20 transition-all duration-200 disabled:opacity-50 [color-scheme:dark]"
                />
              </div>
              <div>
                <span className="text-[10px] text-white/30 block mb-1">Latest</span>
                <input
                  type="date"
                  value={pumpChangeEnd}
                  onChange={(e) => setPumpChangeEnd(e.target.value)}
                  disabled={isPending}
                  className="w-full bg-white/[0.03] border border-white/[0.06] rounded-md px-2.5 py-1.5 text-xs text-white/80 focus:outline-none focus:border-[#00D4FF]/30 focus:ring-1 focus:ring-[#00D4FF]/20 transition-all duration-200 disabled:opacity-50 [color-scheme:dark]"
                />
              </div>
            </div>
          </div>
        )}
      </div>

      {/* Action buttons */}
      <div className="flex gap-2 pt-1">
        {currentStatus && (
          <button
            type="button"
            onClick={handleClear}
            disabled={isPending}
            className="flex-1 rounded-lg px-3 py-2 text-xs font-medium border border-white/[0.06] text-white/40 hover:text-white/60 hover:border-white/[0.12] bg-transparent transition-all duration-200 cursor-pointer disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {clearStatus.isPending ? 'Clearing...' : 'Clear Status'}
          </button>
        )}
        <button
          type="button"
          onClick={handleSave}
          disabled={!selected || isPending}
          className="flex-1 rounded-lg px-3 py-2 text-xs font-semibold border transition-all duration-200 cursor-pointer disabled:opacity-30 disabled:cursor-not-allowed"
          style={{
            backgroundColor: selected ? 'rgba(0, 212, 255, 0.12)' : 'rgba(0, 212, 255, 0.05)',
            borderColor: selected ? 'rgba(0, 212, 255, 0.30)' : 'rgba(0, 212, 255, 0.10)',
            color: selected ? '#00D4FF' : 'rgba(0, 212, 255, 0.40)',
            boxShadow: selected ? '0 0 12px rgba(0, 212, 255, 0.15)' : 'none',
          }}
        >
          {setStatus.isPending ? 'Saving...' : 'Save Status'}
        </button>
      </div>
    </div>
  );
}
