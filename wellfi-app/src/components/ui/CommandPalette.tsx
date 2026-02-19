import { useState, useEffect, useRef, useCallback, useMemo } from 'react';
import type { Well, RiskLevel } from '@/types';
import { riskColor } from '@/lib/mapUtils';

interface CommandPaletteProps {
  wells: Well[];
  open: boolean;
  onClose: () => void;
  onSelect: (well: Well) => void;
}

// Risk level short labels for compact display
const RISK_SHORT: Record<RiskLevel, string> = {
  'HIGH — DUE': 'DUE',
  'WATCH': 'WATCH',
  'LOW': 'LOW',
  'RECENTLY CHANGED': 'NEW',
  'DOWN NOW': 'DOWN',
  'NO DATA': 'N/A',
  'UNKNOWN': '?',
};

export function CommandPalette({ wells, open, onClose, onSelect }: CommandPaletteProps) {
  const [query, setQuery] = useState('');
  const [selectedIndex, setSelectedIndex] = useState(0);
  const [recentWells, setRecentWells] = useState<Well[]>([]);
  const inputRef = useRef<HTMLInputElement>(null);
  const listRef = useRef<HTMLDivElement>(null);

  // Search logic: filter + rank wells
  const results = useMemo(() => {
    const q = query.trim().toLowerCase();
    if (q.length === 0) return [];

    const matches: { well: Well; score: number }[] = [];

    for (const well of wells) {
      const name = (well.name ?? '').toLowerCase();
      const formattedId = (well.formatted_id ?? '').toLowerCase();
      const field = (well.field ?? '').toLowerCase();
      const formation = (well.formation ?? '').toLowerCase();

      let score = 0;

      // Exact prefix matches get highest priority
      if (name.startsWith(q)) score = 100;
      else if (formattedId.startsWith(q)) score = 90;
      else if (field.startsWith(q)) score = 80;
      else if (formation.startsWith(q)) score = 70;
      // Substring matches get lower priority
      else if (name.includes(q)) score = 60;
      else if (formattedId.includes(q)) score = 50;
      else if (field.includes(q)) score = 40;
      else if (formation.includes(q)) score = 30;

      if (score > 0) {
        matches.push({ well, score });
      }
    }

    // Sort by score descending, then by name alphabetically
    matches.sort((a, b) => {
      if (b.score !== a.score) return b.score - a.score;
      return (a.well.name ?? '').localeCompare(b.well.name ?? '');
    });

    return matches.slice(0, 10).map((m) => m.well);
  }, [query, wells]);

  // What to display: search results or recent wells
  const displayWells = query.trim().length > 0 ? results : recentWells;
  const isShowingRecent = query.trim().length === 0 && recentWells.length > 0;

  // Reset state when opened
  useEffect(() => {
    if (open) {
      setQuery('');
      setSelectedIndex(0);
      // Focus the input after the animation frame
      requestAnimationFrame(() => {
        inputRef.current?.focus();
      });
    }
  }, [open]);

  // Reset selection index when results change
  useEffect(() => {
    setSelectedIndex(0);
  }, [results]);

  // Scroll selected item into view
  useEffect(() => {
    if (!listRef.current) return;
    const items = listRef.current.querySelectorAll('[data-result-item]');
    const current = items[selectedIndex];
    if (current) {
      current.scrollIntoView({ block: 'nearest' });
    }
  }, [selectedIndex]);

  const handleSelect = useCallback(
    (well: Well) => {
      // Update recent wells (prepend, dedupe, keep max 5)
      setRecentWells((prev) => {
        const filtered = prev.filter((w) => w.id !== well.id);
        return [well, ...filtered].slice(0, 5);
      });
      onSelect(well);
      onClose();
    },
    [onSelect, onClose],
  );

  const handleKeyDown = useCallback(
    (e: React.KeyboardEvent) => {
      switch (e.key) {
        case 'ArrowDown':
          e.preventDefault();
          setSelectedIndex((i) => Math.min(i + 1, displayWells.length - 1));
          break;
        case 'ArrowUp':
          e.preventDefault();
          setSelectedIndex((i) => Math.max(i - 1, 0));
          break;
        case 'Enter':
          e.preventDefault();
          if (displayWells[selectedIndex]) {
            handleSelect(displayWells[selectedIndex]);
          }
          break;
        case 'Escape':
          e.preventDefault();
          onClose();
          break;
      }
    },
    [displayWells, selectedIndex, handleSelect, onClose],
  );

  if (!open) return null;

  return (
    <div
      className="fixed inset-0 z-50 flex items-start justify-center pt-[15vh] animate-in fade-in duration-150"
      onClick={onClose}
      role="dialog"
      aria-modal="true"
      aria-label="Search wells"
    >
      {/* Backdrop */}
      <div className="absolute inset-0 bg-black/60 backdrop-blur-sm" />

      {/* Modal */}
      <div
        className="relative w-full max-w-[540px] mx-4 bg-gray-900 border border-gray-700 rounded-xl shadow-2xl overflow-hidden animate-in slide-in-from-top-4 fade-in duration-200"
        onClick={(e) => e.stopPropagation()}
        onKeyDown={handleKeyDown}
      >
        {/* Search Input */}
        <div className="flex items-center gap-3 px-4 py-3 border-b border-gray-800">
          {/* Search icon */}
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="20"
            height="20"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            strokeLinecap="round"
            strokeLinejoin="round"
            className="text-gray-500 shrink-0"
          >
            <circle cx="11" cy="11" r="8" />
            <path d="m21 21-4.3-4.3" />
          </svg>

          <input
            ref={inputRef}
            type="text"
            className="flex-1 bg-transparent text-white text-base placeholder:text-gray-500 outline-none"
            placeholder="Search wells by name, ID, field, or formation..."
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            autoComplete="off"
            spellCheck={false}
          />

          {/* Keyboard shortcut hint */}
          <kbd className="hidden sm:inline-flex items-center gap-1 px-1.5 py-0.5 text-[10px] font-medium text-gray-500 bg-gray-800 border border-gray-700 rounded">
            ESC
          </kbd>
        </div>

        {/* Results List */}
        <div ref={listRef} className="max-h-[360px] overflow-y-auto">
          {/* Section header for recent wells */}
          {isShowingRecent && (
            <div className="px-4 pt-3 pb-1.5">
              <span className="text-[10px] font-semibold uppercase tracking-wider text-gray-500">
                Recent
              </span>
            </div>
          )}

          {displayWells.length > 0 ? (
            displayWells.map((well, index) => {
              const isSelected = index === selectedIndex;
              const risk = well.risk_level ?? 'UNKNOWN';
              const riskLabel = RISK_SHORT[risk] ?? '?';
              const color = riskColor(risk);

              return (
                <button
                  key={well.id}
                  data-result-item
                  type="button"
                  className={`w-full flex items-center gap-3 px-4 py-2.5 text-left transition-colors cursor-pointer ${
                    isSelected
                      ? 'bg-wellfi-cyan/10 border-l-2 border-wellfi-cyan'
                      : 'border-l-2 border-transparent hover:bg-gray-800'
                  }`}
                  onClick={() => handleSelect(well)}
                  onMouseEnter={() => setSelectedIndex(index)}
                >
                  {/* Risk dot */}
                  <span
                    className="w-2 h-2 rounded-full shrink-0"
                    style={{ backgroundColor: color }}
                  />

                  {/* Well info */}
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2">
                      <span className="text-sm font-semibold text-white truncate">
                        {well.name ?? 'Unnamed Well'}
                      </span>
                      <span className="text-xs text-gray-500 truncate shrink-0">
                        {well.formatted_id ?? well.well_id}
                      </span>
                    </div>
                  </div>

                  {/* Formation badge */}
                  {well.formation && (
                    <span className="shrink-0 text-[10px] font-medium px-1.5 py-0.5 rounded bg-gray-800 text-gray-400">
                      {well.formation}
                    </span>
                  )}

                  {/* Risk badge */}
                  <span
                    className="shrink-0 text-[10px] font-bold px-1.5 py-0.5 rounded"
                    style={{
                      backgroundColor: `${color}20`,
                      color: color,
                    }}
                  >
                    {riskLabel}
                  </span>
                </button>
              );
            })
          ) : query.trim().length > 0 ? (
            /* No results empty state */
            <div className="flex flex-col items-center justify-center py-12 text-gray-500">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="32"
                height="32"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="1.5"
                strokeLinecap="round"
                strokeLinejoin="round"
                className="mb-3 text-gray-600"
              >
                <circle cx="11" cy="11" r="8" />
                <path d="m21 21-4.3-4.3" />
                <path d="M8 11h6" />
              </svg>
              <p className="text-sm font-medium">No wells found</p>
              <p className="text-xs text-gray-600 mt-1">
                Try a different name, ID, or formation
              </p>
            </div>
          ) : recentWells.length === 0 ? (
            /* Initial empty state: hint */
            <div className="flex flex-col items-center justify-center py-12 text-gray-500">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="32"
                height="32"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="1.5"
                strokeLinecap="round"
                strokeLinejoin="round"
                className="mb-3 text-gray-600"
              >
                <circle cx="11" cy="11" r="8" />
                <path d="m21 21-4.3-4.3" />
              </svg>
              <p className="text-sm font-medium">Search {wells.length} wells</p>
              <p className="text-xs text-gray-600 mt-1">
                Type to search by name, ID, field, or formation
              </p>
            </div>
          ) : null}
        </div>

        {/* Footer */}
        <div className="flex items-center justify-between px-4 py-2 border-t border-gray-800 text-[10px] text-gray-600">
          <div className="flex items-center gap-3">
            <span className="flex items-center gap-1">
              <kbd className="px-1 py-0.5 bg-gray-800 border border-gray-700 rounded text-gray-500 font-mono">
                &uarr;
              </kbd>
              <kbd className="px-1 py-0.5 bg-gray-800 border border-gray-700 rounded text-gray-500 font-mono">
                &darr;
              </kbd>
              <span className="ml-0.5">navigate</span>
            </span>
            <span className="flex items-center gap-1">
              <kbd className="px-1 py-0.5 bg-gray-800 border border-gray-700 rounded text-gray-500 font-mono">
                &crarr;
              </kbd>
              <span className="ml-0.5">select</span>
            </span>
            <span className="flex items-center gap-1">
              <kbd className="px-1 py-0.5 bg-gray-800 border border-gray-700 rounded text-gray-500 font-mono">
                esc
              </kbd>
              <span className="ml-0.5">close</span>
            </span>
          </div>
          <span className="text-wellfi-cyan font-semibold tracking-wide">
            WellFi
          </span>
        </div>
      </div>
    </div>
  );
}
