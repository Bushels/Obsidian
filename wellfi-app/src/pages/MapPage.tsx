import { lazy, Suspense, useState, useCallback, useMemo, useEffect } from 'react';
import { useNavigate, useSearchParams } from 'react-router-dom';
import { useQuery } from '@tanstack/react-query';
import wellfiLogo from '@/assets/wellfi-logo.png';
import type { WellEnriched } from '@/types/operationalStatus';
import { useWells } from '@/hooks/useWells';
import { useProductionSnapshot } from '@/hooks/useProductionSnapshot';
import { useAuth } from '@/lib/auth-context';
import {
  hasScheduledSupport,
  isWellDownNow,
  isWellFlagged,
  needsToolAssignment,
} from '@/lib/wellEventSelectors';
import { supabase } from '@/lib/supabase';
import { DEFAULT_DASHBOARD_FILTERS, type DashboardFilters } from '@/types/mapFilters';
import FilterBar from '@/components/panels/FilterBar';
import UpcomingList from '@/components/panels/UpcomingList';
import { RiskOverview } from '@/components/panels/RiskOverview';
import { InventoryOverview } from '@/components/panels/InventoryOverview';
import { OperatorOverviewCard } from '@/components/panels/OperatorOverviewCard';
import { AdminProductionDeck } from '@/components/panels/AdminProductionDeck';
import { LoadingMap } from '@/components/ui/LoadingMap';
import { Badge } from '@/components/ui/badge';
import { CommandPalette } from '@/components/ui/CommandPalette';
import OperatorSelector from '@/components/admin/OperatorSelector';

const WellMap = lazy(() => import('@/components/map/WellMap'));
const RightPanel = lazy(() => import('@/components/panels/RightPanel'));

type ScopedWell = WellEnriched & {
  operator_id?: string | null;
};

interface ActiveOperator {
  id: string;
  slug: string;
  display_name: string;
  basin_scope: string | null;
}

function formatBasinScope(value: string | null | undefined): string {
  return value?.replace(/\|/g, ' / ') ?? 'Clearwater / Bluesky';
}

export default function MapPage() {
  const { data: wells = [], isLoading, error } = useWells();
  const { user, isAdmin, signOut } = useAuth();
  const { data: operators = [] } = useQuery({
    queryKey: ['operators', isAdmin ? 'admin' : 'viewer'],
    enabled: isAdmin,
    queryFn: async (): Promise<ActiveOperator[]> => {
      const { data, error: operatorsError } = await supabase
        .from('operators' as never)
        .select('id, slug, display_name, basin_scope')
        .eq('status', 'active')
        .order('display_name');

      if (operatorsError) {
        throw operatorsError;
      }

      return (data ?? []) as unknown as ActiveOperator[];
    },
    staleTime: 5 * 60 * 1000,
  });
  const navigate = useNavigate();
  const [searchParams, setSearchParams] = useSearchParams();
  const [selectedWell, setSelectedWell] = useState<WellEnriched | null>(null);
  const [filters, setFilters] = useState<DashboardFilters>(DEFAULT_DASHBOARD_FILTERS);
  const [mobileFilterOpen, setMobileFilterOpen] = useState(false);
  const [flyTarget, setFlyTarget] = useState<{ lng: number; lat: number } | null>(null);
  const [commandPaletteOpen, setCommandPaletteOpen] = useState(false);
  const [adminOperatorSlug, setAdminOperatorSlug] = useState<string | null>(null);
  const effectiveOperatorSlug = isAdmin ? adminOperatorSlug : (user?.operatorSlug ?? null);
  const allScopedWells = wells as ScopedWell[];
  const selectedOperator = useMemo(
    () => operators.find((operator) => operator.slug === adminOperatorSlug) ?? null,
    [adminOperatorSlug, operators],
  );
  const operatorNameById = useMemo(
    () => new Map(operators.map((operator) => [operator.id, operator.display_name])),
    [operators],
  );
  const scopedWells = useMemo(() => {
    if (!isAdmin || !selectedOperator) {
      return allScopedWells;
    }

    return allScopedWells.filter((well) => well.operator_id === selectedOperator.id);
  }, [allScopedWells, isAdmin, selectedOperator]);
  const loadedOperatorNames = useMemo(
    () =>
      [
        ...new Set(
          allScopedWells
            .map((well) => (well.operator_id ? operatorNameById.get(well.operator_id) ?? null : null))
            .filter((value): value is string => Boolean(value)),
        ),
      ].sort(),
    [allScopedWells, operatorNameById],
  );
  const loadedOperatorNameSet = useMemo(
    () => new Set(loadedOperatorNames),
    [loadedOperatorNames],
  );
  const activeWellFiUwis = useMemo(
    () =>
      scopedWells
        .filter((well) => well.wellfi_device?.is_active)
        .map((well) => well.well_id),
    [scopedWells],
  );
  const loadedOperatorCount = isAdmin && selectedOperator
    ? (scopedWells.length > 0 ? 1 : 0)
    : loadedOperatorNames.length;
  const canShowScopedProduction = !selectedOperator || loadedOperatorNameSet.has(selectedOperator.display_name);
  const { data: productionFeatures = [], isLoading: isProductionLoading } = useProductionSnapshot(
    isAdmin && loadedOperatorNames.length > 0,
    loadedOperatorNames,
  );

  const updateSelectedWellParam = useCallback(
    (well: WellEnriched | null) => {
      setSearchParams((currentParams) => {
        const nextParams = new URLSearchParams(currentParams);
        if (well?.well_id) {
          nextParams.set('well_id', well.well_id);
        } else {
          nextParams.delete('well_id');
        }
        return nextParams;
      }, { replace: true });
    },
    [setSearchParams],
  );

  const selectWell = useCallback(
    (well: WellEnriched, options?: { flyTo?: boolean }) => {
      setSelectedWell(well);
      setFlyTarget(options?.flyTo ? { lng: well.lon, lat: well.lat } : null);
      updateSelectedWellParam(well);
    },
    [updateSelectedWellParam],
  );

  const handleSignOut = useCallback(async () => {
    await signOut();
    navigate('/');
  }, [navigate, signOut]);

  const handleWellClick = useCallback((well: WellEnriched) => {
    selectWell(well);
  }, [selectWell]);

  const handleUpcomingWellClick = useCallback(
    (wellId: string) => {
      const found = scopedWells.find((well) => well.id === wellId);
      if (found) {
        selectWell(found, { flyTo: true });
      }
    },
    [scopedWells, selectWell],
  );

  const handleClosePanel = useCallback(() => {
    setSelectedWell(null);
    setFlyTarget(null);
    updateSelectedWellParam(null);
  }, [updateSelectedWellParam]);

  const handleCommandPaletteSelect = useCallback((well: WellEnriched) => {
    selectWell(well, { flyTo: true });
  }, [selectWell]);

  const rightPanelPlaceholder = (
    <div className="flex h-full items-center justify-center p-6 text-muted-foreground">
      Click a well to see details
    </div>
  );

  const rightPanelFallback = (
    <div className="flex h-full items-center justify-center p-6 text-muted-foreground">
      Loading well details...
    </div>
  );

  const hasActiveFilters =
    filters.riskLevels.length > 0 ||
    filters.formations.length > 0 ||
    filters.fields.length > 0 ||
    filters.showWellFiOnly ||
    filters.showFlaggedOnly ||
    filters.showNeedsToolOnly ||
    filters.showScheduledSupportOnly ||
    filters.showDownNowOnly ||
    filters.minRateBblD > 0;

  const activeFilterCount = useMemo(() => {
    let count = 0;
    if (filters.riskLevels.length > 0) count++;
    if (filters.formations.length > 0) count++;
    if (filters.fields.length > 0) count++;
    if (filters.showWellFiOnly) count++;
    if (filters.showFlaggedOnly) count++;
    if (filters.showNeedsToolOnly) count++;
    if (filters.showScheduledSupportOnly) count++;
    if (filters.showDownNowOnly) count++;
    if (filters.minRateBblD > 0) count++;
    return count;
  }, [filters]);

  const filteredWells = useMemo(() => {
    if (!hasActiveFilters) return scopedWells;

    return scopedWells.filter((well) => {
      if (
        filters.riskLevels.length > 0 &&
        !filters.riskLevels.includes(well.risk_level ?? 'UNKNOWN')
      ) {
        return false;
      }

      if (
        filters.formations.length > 0 &&
        (!well.formation || !filters.formations.includes(well.formation))
      ) {
        return false;
      }

      if (filters.fields.length > 0 && (!well.field || !filters.fields.includes(well.field))) {
        return false;
      }

      if (filters.showWellFiOnly && !well.wellfi_device?.is_active) {
        return false;
      }

      if (filters.showFlaggedOnly && !isWellFlagged(well)) {
        return false;
      }

      if (filters.showNeedsToolOnly && !needsToolAssignment(well)) {
        return false;
      }

      if (filters.showScheduledSupportOnly && !hasScheduledSupport(well)) {
        return false;
      }

      if (filters.showDownNowOnly && !isWellDownNow(well)) {
        return false;
      }

      if (
        filters.minRateBblD > 0 &&
        (well.dec_rate_bbl_d == null || well.dec_rate_bbl_d < filters.minRateBblD)
      ) {
        return false;
      }

      return true;
    });
  }, [filters, hasActiveFilters, scopedWells]);

  const totalScopedWells = scopedWells.length;
  const filteredCount = filteredWells.length;
  const selectedWellInScope = useMemo(
    () => {
      if (!selectedWell) {
        return null;
      }

      return scopedWells.find((well) => well.id === selectedWell.id) ?? null;
    },
    [scopedWells, selectedWell],
  );
  const activeFieldCount = useMemo(
    () =>
      new Set(
        scopedWells.map((well) => well.field).filter((field): field is string => Boolean(field)),
      ).size,
    [scopedWells],
  );
  const headerOperatorLabel = isAdmin
    ? selectedOperator?.display_name ?? 'MPS Multi-Operator View'
    : user?.operatorDisplayName ?? 'Operator Dashboard';
  const basinLabel = isAdmin
    ? formatBasinScope(selectedOperator?.basin_scope)
    : formatBasinScope(user?.basinScope);
  const roleBadgeLabel = isAdmin ? 'MPS Admin' : 'Operator Viewer';
  const operatorCoverageLabel = `${loadedOperatorCount} loaded | ${operators.length} provisioned`;
  const headerStatus = isLoading
    ? 'Loading wells...'
    : isAdmin
      ? selectedOperator
        ? hasActiveFilters
          ? `${filteredCount} of ${totalScopedWells} Wells | ${selectedOperator.display_name}`
          : `${totalScopedWells} Wells | ${selectedOperator.display_name} | ${basinLabel}`
        : hasActiveFilters
          ? `${filteredCount} of ${totalScopedWells} Wells | ${operatorCoverageLabel}`
          : `${totalScopedWells} Wells | ${basinLabel} | ${operatorCoverageLabel}`
      : hasActiveFilters
        ? `${filteredCount} of ${totalScopedWells} Wells | ${headerOperatorLabel}`
        : `${totalScopedWells} Wells | ${headerOperatorLabel}`;

  const overviewHeading = isAdmin
    ? selectedOperator
      ? 'Operator Dashboard'
      : 'MPS Dashboard'
    : 'Operator Overview';
  const overviewContextMetricLabel = isAdmin && !selectedOperator ? 'Loaded Operators' : 'Active Fields';
  const overviewContextMetricValue = isAdmin && !selectedOperator ? loadedOperatorCount : activeFieldCount;
  const overviewScopeDescription = isAdmin
    ? selectedOperator
      ? 'Scoped to one operator for dashboard review.'
      : `${loadedOperatorCount} of ${operators.length} provisioned operators currently have live wells loaded in Supabase.`
    : 'Map results are already scoped to your company account.';

  useEffect(() => {
    if (selectedWell && !selectedWellInScope) {
      updateSelectedWellParam(null);
    }
  }, [selectedWell, selectedWellInScope, updateSelectedWellParam]);

  useEffect(() => {
    const isSmallScreen = window.innerWidth < 1024;
    const isSheetOpen = mobileFilterOpen || selectedWellInScope !== null;
    if (isSmallScreen && isSheetOpen) {
      document.body.classList.add('sheet-open');
    } else {
      document.body.classList.remove('sheet-open');
    }

    return () => {
      document.body.classList.remove('sheet-open');
    };
  }, [mobileFilterOpen, selectedWellInScope]);

  useEffect(() => {
    const requestedWellId = searchParams.get('well_id');
    if (!requestedWellId || scopedWells.length === 0) {
      return;
    }

    const normalizedRequestedId = requestedWellId.trim().toLowerCase();
    const matchesSelectedWell =
      selectedWellInScope &&
      [selectedWellInScope.id, selectedWellInScope.well_id, selectedWellInScope.formatted_id]
        .filter((value): value is string => Boolean(value))
        .some((value) => value.trim().toLowerCase() === normalizedRequestedId);

    if (matchesSelectedWell) {
      return;
    }

    const matchedWell = scopedWells.find((well) =>
      [well.id, well.well_id, well.formatted_id]
        .filter((value): value is string => Boolean(value))
        .some((value) => value.trim().toLowerCase() === normalizedRequestedId),
    );

    if (!matchedWell) {
      return;
    }

    const frame = requestAnimationFrame(() => {
      setSelectedWell(matchedWell);
      setFlyTarget({ lng: matchedWell.lon, lat: matchedWell.lat });
    });

    return () => cancelAnimationFrame(frame);
  }, [scopedWells, searchParams, selectedWellInScope]);

  useEffect(() => {
    const handleKeyDown = (event: KeyboardEvent) => {
      if (event.key === 'k' && (event.metaKey || event.ctrlKey)) {
        event.preventDefault();
        setCommandPaletteOpen((previous) => !previous);
        return;
      }

      const tag = (event.target as HTMLElement)?.tagName;
      if (tag === 'INPUT' || tag === 'TEXTAREA' || tag === 'SELECT') return;

      if (event.key === 'Escape') {
        event.preventDefault();
        handleClosePanel();
        setMobileFilterOpen(false);
        return;
      }

      if ((event.key === 'ArrowDown' || event.key === 'ArrowUp') && filteredWells.length > 0) {
        event.preventDefault();
        const currentIndex = selectedWellInScope
          ? filteredWells.findIndex((well) => well.id === selectedWellInScope.id)
          : -1;

        let nextIndex: number;
        if (event.key === 'ArrowDown') {
          nextIndex = currentIndex < filteredWells.length - 1 ? currentIndex + 1 : 0;
        } else {
          nextIndex = currentIndex > 0 ? currentIndex - 1 : filteredWells.length - 1;
        }

        selectWell(filteredWells[nextIndex], { flyTo: true });
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [filteredWells, handleClosePanel, selectWell, selectedWellInScope]);

  return (
    <div className="h-screen flex flex-col bg-[#06090F] text-white">
      <header className="h-14 flex items-center justify-between px-4 border-b border-white/[0.06] bg-[#080D16]/90 backdrop-blur-xl shrink-0">
        <div className="flex items-center gap-2">
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
          <img
            src={wellfiLogo}
            alt="WellFi Logo"
            className="h-7 w-auto object-contain drop-shadow-[0_0_8px_rgba(0,212,255,0.5)] opacity-90"
          />
        </div>

        <div className="flex items-center gap-3">
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
              <span className="text-xs">{navigator.platform?.includes('Mac') ? 'Cmd' : 'Ctrl'}</span>
              <span>K</span>
            </kbd>
          </button>

          <span className="hidden sm:block text-sm text-gray-400">{headerStatus}</span>

          {user && (
            <div className="flex items-center gap-2">
              {isAdmin && (
                <OperatorSelector
                  selectedSlug={adminOperatorSlug}
                  onSelect={setAdminOperatorSlug}
                />
              )}
              <div className="hidden md:flex flex-col leading-tight">
                <span className="text-sm text-gray-300 font-medium">{user.displayName}</span>
                {!isAdmin && user.operatorDisplayName && (
                  <span className="text-[11px] text-gray-500">{user.operatorDisplayName}</span>
                )}
              </div>
              <Badge variant="outline" className="text-xs">
                {roleBadgeLabel}
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

      <div className="flex flex-1 overflow-hidden relative">
        <aside className="hidden lg:flex w-72 shrink-0 flex-col border-r border-white/[0.06] bg-[#080D16]/80 backdrop-blur-xl overflow-y-auto">
          <div className="p-3 pb-0 space-y-2">
            <OperatorOverviewCard
              wells={scopedWells}
              heading={overviewHeading}
              badgeLabel={roleBadgeLabel}
              operatorName={headerOperatorLabel}
              scopeDescription={overviewScopeDescription}
              contextMetricLabel={overviewContextMetricLabel}
              contextMetricValue={overviewContextMetricValue}
              basinScope={isAdmin ? selectedOperator?.basin_scope : user?.basinScope}
              filteredCount={filteredCount}
              hasActiveFilters={hasActiveFilters}
            />
            {isAdmin && (
              <AdminProductionDeck
                features={canShowScopedProduction ? productionFeatures : []}
                isLoading={isProductionLoading}
                selectedOperatorName={selectedOperator?.display_name ?? null}
                loadedOperatorCount={loadedOperatorCount}
                provisionedOperatorCount={operators.length}
                activeWellFiUwis={activeWellFiUwis}
              />
            )}
            <UpcomingList wells={filteredWells} onWellClick={handleUpcomingWellClick} />
            {isAdmin && <RiskOverview wells={filteredWells} />}
            {isAdmin && <InventoryOverview />}
          </div>

          <FilterBar filters={filters} onChange={setFilters} wells={scopedWells} />
        </aside>

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
            <Suspense fallback={<LoadingMap />}>
              <WellMap
                wells={scopedWells}
                onWellClick={handleWellClick}
                filters={filters}
                flyToCoords={flyTarget}
                operatorSlug={effectiveOperatorSlug}
                showProductionOverlay={isAdmin && canShowScopedProduction}
                allowedProductionOperators={loadedOperatorNames}
              />
            </Suspense>
          )}
        </main>

        <aside className="hidden lg:flex w-96 shrink-0 flex-col border-l border-white/[0.06] bg-[#080D16]/80 backdrop-blur-xl">
          {selectedWellInScope ? (
            <Suspense fallback={rightPanelFallback}>
              <RightPanel
                well={selectedWellInScope}
                onClose={handleClosePanel}
                canEdit={isAdmin}
                canManageWellEvents={!!user}
                showProduction={isAdmin}
              />
            </Suspense>
          ) : (
            rightPanelPlaceholder
          )}
        </aside>

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

        {mobileFilterOpen && (
          <div className="lg:hidden fixed inset-0 z-40">
            <div
              className="absolute inset-0 bg-black/50"
              onClick={() => setMobileFilterOpen(false)}
            />
            <div className="absolute bottom-0 left-0 right-0 max-h-[80vh] mobile-sheet-landscape overflow-y-auto bg-[#080D16]/95 backdrop-blur-xl rounded-t-2xl border-t border-white/[0.08] animate-slide-up safe-area-bottom">
              <div className="drag-handle" />
              <div className="sticky top-0 z-10 bg-[#080D16]/95 backdrop-blur-xl px-4 py-3 border-b border-white/[0.06] flex items-center justify-between">
                <span className="text-sm font-semibold">Filters and Overview</span>
                <button
                  type="button"
                  className="flex h-8 w-8 items-center justify-center rounded-md text-gray-500 hover:text-white hover:bg-white/[0.06] transition-all duration-200"
                  onClick={() => setMobileFilterOpen(false)}
                  aria-label="Close filters"
                >
                  &times;
                </button>
              </div>

              <div className="px-3 pt-3 space-y-2">
                <OperatorOverviewCard
                  wells={scopedWells}
                  heading={overviewHeading}
                  badgeLabel={roleBadgeLabel}
                  operatorName={headerOperatorLabel}
                  scopeDescription={overviewScopeDescription}
                  contextMetricLabel={overviewContextMetricLabel}
                  contextMetricValue={overviewContextMetricValue}
                  basinScope={isAdmin ? selectedOperator?.basin_scope : user?.basinScope}
                  filteredCount={filteredCount}
                  hasActiveFilters={hasActiveFilters}
                />
                {isAdmin && (
                  <AdminProductionDeck
                    features={canShowScopedProduction ? productionFeatures : []}
                    isLoading={isProductionLoading}
                    selectedOperatorName={selectedOperator?.display_name ?? null}
                    loadedOperatorCount={loadedOperatorCount}
                    provisionedOperatorCount={operators.length}
                    activeWellFiUwis={activeWellFiUwis}
                  />
                )}
                <UpcomingList
                  wells={filteredWells}
                  onWellClick={(wellId) => {
                    handleUpcomingWellClick(wellId);
                    setMobileFilterOpen(false);
                  }}
                />
                {isAdmin && <RiskOverview wells={filteredWells} />}
                {isAdmin && <InventoryOverview />}
              </div>

              <FilterBar filters={filters} onChange={setFilters} wells={scopedWells} />
            </div>
          </div>
        )}

        {selectedWellInScope && (
          <div className="lg:hidden fixed inset-0 z-40">
            <div
              className="absolute inset-0 bg-black/50"
              onClick={handleClosePanel}
            />
            <div className="absolute bottom-0 left-0 right-0 max-h-[80vh] mobile-sheet-landscape overflow-y-auto bg-[#080D16]/95 backdrop-blur-xl rounded-t-2xl border-t border-white/[0.08] animate-slide-up safe-area-bottom">
              <Suspense fallback={rightPanelFallback}>
                <RightPanel
                  well={selectedWellInScope}
                  onClose={handleClosePanel}
                  canEdit={isAdmin}
                  canManageWellEvents={!!user}
                  showProduction={isAdmin}
                />
              </Suspense>
            </div>
          </div>
        )}
      </div>

      <CommandPalette
        wells={scopedWells}
        open={commandPaletteOpen}
        onClose={() => setCommandPaletteOpen(false)}
        onSelect={handleCommandPaletteSelect}
      />
    </div>
  );
}
