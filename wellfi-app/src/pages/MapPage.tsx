import { useState, useCallback, useMemo, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import wellfiLogo from '@/assets/wellfi-logo.png';
import type { MapFilters } from '@/types';
import type { WellEnriched } from '@/types/operationalStatus';
import { useWells } from '@/hooks/useWells';
import { useAuth } from '@/lib/auth';
import WellMap from '@/components/map/WellMap';
import FilterBar from '@/components/panels/FilterBar';
import RightPanel from '@/components/panels/RightPanel';
import UpcomingList from '@/components/panels/UpcomingList';
import { RiskOverview } from '@/components/panels/RiskOverview';
import { InventoryOverview } from '@/components/panels/InventoryOverview';
import { LoadingMap } from '@/components/ui/LoadingMap';
import { Badge } from '@/components/ui/badge';
import { CommandPalette } from '@/components/ui/CommandPalette';

const DEFAULT_FILTERS: MapFilters = {
  riskLevels: [],
  formations: [],
  fields: [],
  showWellFiOnly: false,
  showUpcomingOnly: false,
  minRateBblD: 0,
};

export default function MapPage() {
  const { data: wells = [], isLoading, error } = useWells();
  const { user, isAdmin, signOut } = useAuth();
  const navigate = useNavigate();
  const [selectedWell, setSelectedWell] = useState<WellEnriched | null>(null);
  const [filters, setFilters] = useState<MapFilters>(DEFAULT_FILTERS);
  const [mobileFilterOpen, setMobileFilterOpen] = useState(false);
  const [flyTarget, setFlyTarget] = useState<{ lng: number; lat: number } | null>(null);
  const [commandPaletteOpen, setCommandPaletteOpen] = useState(false);

  const handleSignOut = useCallback(async () => {
    await signOut();
    navigate('/');
  }, [signOut, navigate]);

  const handleWellClick = useCallback((well: WellEnriched) => {
    setSelectedWell(well);
    setFlyTarget(null);
  }, []);

  const handleUpcomingWellClick = useCallback(
    (wellId: string) => {
      const found = wells.find((w) => w.id === wellId);
      if (found) {
        setSelectedWell(found);
        setFlyTarget({ lng: found.lon, lat: found.lat });
      }
    },
    [wells],
  );

  const handleClosePanel = useCallback(() => {
    setSelectedWell(null);
  }, []);

  const handleCommandPaletteSelect = useCallback((well: WellEnriched) => {
    setSelectedWell(well);
    setFlyTarget({ lng: well.lon, lat: well.lat });
  }, []);

  // Determine whether any filter is active
  const hasActiveFilters =
    filters.riskLevels.length > 0 ||
    filters.formations.length > 0 ||
    filters.fields.length > 0 ||
    filters.showWellFiOnly ||
    filters.showUpcomingOnly ||
    filters.minRateBblD > 0;

  // Count of active filter categories for the mobile badge
  const activeFilterCount = useMemo(() => {
    let count = 0;
    if (filters.riskLevels.length > 0) count++;
    if (filters.formations.length > 0) count++;
    if (filters.fields.length > 0) count++;
    if (filters.showWellFiOnly) count++;
    if (filters.showUpcomingOnly) count++;
    if (filters.minRateBblD > 0) count++;
    return count;
  }, [filters]);

  // Compute filtered wells to mirror what WellMap shows on the map
  const filteredWells = useMemo(() => {
    if (!hasActiveFilters) return wells;

    return wells.filter((w) => {
      if (
        filters.riskLevels.length > 0 &&
        !filters.riskLevels.includes(w.risk_level ?? 'UNKNOWN')
      ) {
        return false;
      }
      if (
        filters.formations.length > 0 &&
        (!w.formation || !filters.formations.includes(w.formation))
      ) {
        return false;
      }
      if (filters.fields.length > 0 && (!w.field || !filters.fields.includes(w.field))) {
        return false;
      }
      if (filters.showWellFiOnly && !w.wellfi_device) {
        return false;
      }
      if (
        filters.showUpcomingOnly &&
        !(
          w.active_pump_change &&
          ['warning', 'scheduled', 'in_progress'].includes(w.active_pump_change.status)
        )
      ) {
        return false;
      }
      if (filters.minRateBblD > 0 && (w.dec_rate_bbl_d == null || w.dec_rate_bbl_d < filters.minRateBblD)) {
        return false;
      }
      return true;
    });
  }, [wells, filters, hasActiveFilters]);

  const filteredCount = filteredWells.length;

  // Lock body scroll when a mobile bottom sheet is open
  useEffect(() => {
    const isSmallScreen = window.innerWidth < 1024;
    const isSheetOpen = mobileFilterOpen || selectedWell !== null;
    if (isSmallScreen && isSheetOpen) {
      document.body.classList.add('sheet-open');
    } else {
      document.body.classList.remove('sheet-open');
    }
    return () => {
      document.body.classList.remove('sheet-open');
    };
  }, [mobileFilterOpen, selectedWell]);

  // Keyboard shortcuts
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      // Cmd+K / Ctrl+K — open command palette (works from any context)
      if (e.key === 'k' && (e.metaKey || e.ctrlKey)) {
        e.preventDefault();
        setCommandPaletteOpen((prev) => !prev);
        return;
      }

      // Skip when user is typing in an input/textarea or a dialog is focused
      const tag = (e.target as HTMLElement)?.tagName;
      if (tag === 'INPUT' || tag === 'TEXTAREA' || tag === 'SELECT') return;

      if (e.key === 'Escape') {
        e.preventDefault();
        setSelectedWell(null);
        setMobileFilterOpen(false);
        return;
      }

      if ((e.key === 'ArrowDown' || e.key === 'ArrowUp') && filteredWells.length > 0) {
        e.preventDefault();
        const currentIndex = selectedWell
          ? filteredWells.findIndex((w) => w.id === selectedWell.id)
          : -1;

        let nextIndex: number;
        if (e.key === 'ArrowDown') {
          nextIndex = currentIndex < filteredWells.length - 1 ? currentIndex + 1 : 0;
        } else {
          nextIndex = currentIndex > 0 ? currentIndex - 1 : filteredWells.length - 1;
        }

        const nextWell = filteredWells[nextIndex];
        setSelectedWell(nextWell);
        setFlyTarget({ lng: nextWell.lon, lat: nextWell.lat });
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [filteredWells, selectedWell]);

  // Header status text
  const headerStatus = isLoading
    ? 'Loading wells\u2026'
    : hasActiveFilters
      ? `${filteredCount} of ${wells.length} Wells \u00b7 Clearwater & Bluesky`
      : `${wells.length} Wells \u00b7 Clearwater & Bluesky`;

  return (
    <div className="h-screen flex flex-col bg-[#06090F] text-white">
      {/* Header Bar — glassmorphic */}
      <header className="h-14 flex items-center justify-between px-4 border-b border-white/[0.06] bg-[#080D16]/90 backdrop-blur-xl shrink-0">
        <div className="flex items-center gap-2">
          {/* Mobile filter toggle */}
          <button
            type="button"
            className="lg:hidden flex items-center justify-center h-8 w-8 rounded-md text-gray-500 hover:text-white hover:bg-white/[0.06] transition-all duration-200"
            onClick={() => setMobileFilterOpen(true)}
            aria-label="Open filters"
          >
            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <line x1="4" x2="20" y1="6" y2="6" />
              <line x1="8" x2="16" y1="12" y2="12" />
              <line x1="11" x2="13" y1="18" y2="18" />
            </svg>
          </button>

          <div className="h-6 w-6 rounded-md bg-wellfi-cyan/10 border border-wellfi-cyan/20 flex items-center justify-center">
            <div className="h-3 w-3 rounded-sm bg-wellfi-cyan/80" />
          </div>
          <img src={wellfiLogo} alt="WellFi Logo" className="h-7 w-auto object-contain drop-shadow-[0_0_8px_rgba(0,212,255,0.5)] opacity-90" />
        </div>
        <div className="flex items-center gap-3">
          {/* Search button — opens command palette */}
          <button
            type="button"
            className="flex items-center gap-2 h-8 px-3 rounded-lg bg-white/[0.04] border border-white/[0.08] text-sm text-gray-500 hover:text-gray-300 hover:bg-white/[0.06] transition-all duration-200"
            onClick={() => setCommandPaletteOpen(true)}
          >
            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <circle cx="11" cy="11" r="8" />
              <path d="m21 21-4.3-4.3" />
            </svg>
            <span className="hidden md:inline">Search wells</span>
            <kbd className="hidden md:inline-flex items-center gap-0.5 ml-1 px-1.5 py-0.5 text-[10px] font-medium text-gray-600 bg-white/[0.04] border border-white/[0.08] rounded">
              <span className="text-xs">{navigator.platform?.includes('Mac') ? '\u2318' : 'Ctrl+'}</span>K
            </kbd>
          </button>
          <span className="hidden sm:block text-sm text-gray-400">{headerStatus}</span>
          {user && (
            <div className="flex items-center gap-2">
              <span className="hidden md:inline text-sm text-gray-300 font-medium">{user.displayName}</span>
              <Badge variant="outline" className="text-xs capitalize">
                {user.role}
              </Badge>
              <button
                type="button"
                onClick={handleSignOut}
                className="text-xs text-gray-500 hover:text-white transition-all duration-200 px-2 py-1 rounded hover:bg-white/[0.06]"
              >
                Sign Out
              </button>
            </div>
          )}
        </div>
      </header>

      {/* Main Content */}
      <div className="flex flex-1 overflow-hidden relative">
        {/* Left Sidebar: FilterBar + UpcomingList (desktop only) */}
        <aside className="hidden lg:flex w-72 shrink-0 flex-col border-r border-white/[0.06] bg-[#080D16]/80 backdrop-blur-xl overflow-y-auto">
          <div className="p-3 pb-0">
            <RiskOverview wells={filteredWells} />
          </div>
          <div className="px-3 pt-2">
            <InventoryOverview />
          </div>
          <FilterBar filters={filters} onChange={setFilters} wells={wells} />
          <div className="border-t border-white/[0.06] p-4">
            <UpcomingList onWellClick={handleUpcomingWellClick} />
          </div>
        </aside>

        {/* Center: WellMap */}
        <main className="flex-1 relative bg-[#06090F]">
          {isLoading ? (
            <LoadingMap />
          ) : error ? (
            <div className="absolute inset-0 flex items-center justify-center">
              <div className="text-center">
                <p className="text-red-400 text-sm font-medium mb-1">Failed to load wells</p>
                <p className="text-gray-500 text-xs">{String(error)}</p>
              </div>
            </div>
          ) : (
            <WellMap
              wells={wells}
              onWellClick={handleWellClick}
              filters={filters}
              flyToCoords={flyTarget}
            />
          )}
        </main>

        {/* Right Sidebar: RightPanel (desktop only) */}
        <aside className="hidden lg:flex w-96 shrink-0 flex-col border-l border-white/[0.06] bg-[#080D16]/80 backdrop-blur-xl">
          <RightPanel well={selectedWell} onClose={handleClosePanel} canEdit={isAdmin} />
        </aside>

        {/* Mobile filter FAB */}
        <button
          type="button"
          className="lg:hidden fixed bottom-6 left-4 z-30 flex items-center gap-2 rounded-full bg-[#080D16]/90 backdrop-blur-xl border border-white/[0.08] px-4 py-3 text-sm font-medium text-white shadow-2xl shadow-black/40 hover:bg-[#0D1420] transition-all duration-200"
          onClick={() => setMobileFilterOpen(true)}
        >
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <line x1="4" x2="20" y1="6" y2="6" />
            <line x1="8" x2="16" y1="12" y2="12" />
            <line x1="11" x2="13" y1="18" y2="18" />
          </svg>
          Filters
          {activeFilterCount > 0 && (
            <span className="flex h-5 w-5 items-center justify-center rounded-full bg-wellfi-cyan text-xs font-bold text-black">
              {activeFilterCount}
            </span>
          )}
        </button>

        {/* Mobile filter drawer (bottom sheet) */}
        {mobileFilterOpen && (
          <div className="lg:hidden fixed inset-0 z-40">
            <div
              className="absolute inset-0 bg-black/50"
              onClick={() => setMobileFilterOpen(false)}
            />
            <div className="absolute bottom-0 left-0 right-0 max-h-[80vh] mobile-sheet-landscape overflow-y-auto bg-[#080D16]/95 backdrop-blur-xl rounded-t-2xl border-t border-white/[0.08] animate-slide-up safe-area-bottom">
              <div className="drag-handle" />
              <div className="sticky top-0 z-10 bg-[#080D16]/95 backdrop-blur-xl px-4 py-3 border-b border-white/[0.06] flex items-center justify-between">
                <span className="text-sm font-semibold">Filters & Overview</span>
                <button
                  type="button"
                  className="flex h-8 w-8 items-center justify-center rounded-md text-gray-500 hover:text-white hover:bg-white/[0.06] transition-all duration-200"
                  onClick={() => setMobileFilterOpen(false)}
                  aria-label="Close filters"
                >
                  &times;
                </button>
              </div>
              {/* Mobile-only dashboard widgets */}
              <div className="px-3 pt-3 space-y-2">
                <RiskOverview wells={filteredWells} />
                <InventoryOverview />
              </div>
              <FilterBar filters={filters} onChange={setFilters} wells={wells} />
              <div className="p-4 border-t border-white/[0.06]">
                <UpcomingList onWellClick={(wellId) => {
                  handleUpcomingWellClick(wellId);
                  setMobileFilterOpen(false);
                }} />
              </div>
            </div>
          </div>
        )}

        {/* Mobile well detail (bottom sheet) */}
        {selectedWell && (
          <div className="lg:hidden fixed inset-0 z-40">
            <div
              className="absolute inset-0 bg-black/50"
              onClick={handleClosePanel}
            />
            <div className="absolute bottom-0 left-0 right-0 max-h-[80vh] mobile-sheet-landscape overflow-y-auto bg-[#080D16]/95 backdrop-blur-xl rounded-t-2xl border-t border-white/[0.08] animate-slide-up safe-area-bottom">
              <RightPanel well={selectedWell} onClose={handleClosePanel} canEdit={isAdmin} />
            </div>
          </div>
        )}
      </div>

      {/* Command Palette — Cmd+K / Ctrl+K */}
      <CommandPalette
        wells={wells}
        open={commandPaletteOpen}
        onClose={() => setCommandPaletteOpen(false)}
        onSelect={handleCommandPaletteSelect}
      />
    </div>
  );
}
