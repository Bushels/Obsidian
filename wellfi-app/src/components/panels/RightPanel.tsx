import { lazy, Suspense, useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
} from '@/components/ui/dialog';
import { RiskBadge } from '@/components/ui/RiskBadge';
import { MonthsBar } from '@/components/ui/MonthsBar';
import { SparkLine } from '@/components/ui/SparkLine';
import PumpChecklist from '@/components/forms/PumpChecklist';
import WellEventForm from '@/components/forms/WellEventForm';
import type { WellEnriched } from '@/types/operationalStatus';
import { DeviceAssignment } from '@/components/panels/DeviceAssignment';
import { WellActivityTimeline } from '@/components/panels/WellActivityTimeline';
import { WellEventFulfillment } from '@/components/panels/WellEventFulfillment';
const DownholeModel3D = lazy(() => import('@/components/panels/DownholeModel3D'));
const ComparablesWidget = lazy(() =>
  import('@/components/panels/ComparablesWidget').then((module) => ({ default: module.ComparablesWidget })),
);
const WellFiInstallForm = lazy(() => import('@/components/forms/WellFiInstallForm'));
const PumpChangeForm = lazy(() => import('@/components/forms/PumpChangeForm'));

interface RightPanelProps {
  well: WellEnriched | null;
  onClose: () => void;
  canEdit?: boolean;
  canManageWellEvents?: boolean;
  showProduction?: boolean;
}

type ProductionSnapshotState = WellEnriched & {
  latest_production_snapshot_month?: string | null;
  latest_production_snapshot_status?: 'present' | 'missing' | 'unknown' | null;
  wellClassification?: {
    wellType: string | null;
    wellFluid: string | null;
    name: string | null;
    isService: boolean;
  } | null;
};

function formatDate(dateStr: string | null): string {
  if (!dateStr) return 'N/A';
  const parsedDate = parseDateInput(dateStr);
  if (!parsedDate) return 'N/A';
  return parsedDate.toLocaleDateString('en-CA', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
  });
}

function formatMonth(dateStr: string | null | undefined): string {
  if (!dateStr) return 'Unknown';
  const parsedDate = parseDateInput(dateStr);
  if (!parsedDate) return 'Unknown';
  return parsedDate.toLocaleDateString('en-CA', {
    year: 'numeric',
    month: 'short',
  });
}

function parseDateInput(dateStr: string): Date | null {
  const trimmed = dateStr.trim();
  const dateOnlyMatch = trimmed.match(/^(\d{4})-(\d{2})-(\d{2})$/);
  if (dateOnlyMatch) {
    const [, year, month, day] = dateOnlyMatch;
    return new Date(Number(year), Number(month) - 1, Number(day));
  }

  const parsed = new Date(trimmed);
  return Number.isNaN(parsed.getTime()) ? null : parsed;
}

export default function RightPanel({
  well,
  onClose,
  canEdit = false,
  canManageWellEvents = false,
  showProduction = false,
}: RightPanelProps) {
  const [installDialogOpen, setInstallDialogOpen] = useState(false);
  const [pumpChangeDialogOpen, setPumpChangeDialogOpen] = useState(false);

  if (!well) {
    return (
      <div className="flex h-full items-center justify-center p-6 text-muted-foreground">
        Click a well to see details
      </div>
    );
  }

  const monthsRunning = well.months_running ?? 0;
  const productionSnapshotWell = well as ProductionSnapshotState;
  const latestSnapshotMonth = productionSnapshotWell.latest_production_snapshot_month;
  const latestSnapshotStatus = productionSnapshotWell.latest_production_snapshot_status;
  const wellClassification = productionSnapshotWell.wellClassification ?? null;
  const isServiceWell = wellClassification?.isService === true;
  const displayName = well.name ?? wellClassification?.name ?? well.well_id;
  const asyncCardFallback = (label: string) => (
    <Card>
      <CardHeader className="pb-2 pt-3 px-4">
        <CardTitle className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">
          {label}
        </CardTitle>
      </CardHeader>
      <CardContent className="px-4 pb-3 text-sm text-muted-foreground">
        Loading {label.toLowerCase()}...
      </CardContent>
    </Card>
  );

  return (
    <div className="flex h-full flex-col overflow-y-auto safe-area-bottom">
      {/* Mobile drag handle */}
      <div className="mx-auto mt-2 h-1 w-10 rounded-full bg-gray-600 lg:hidden" />

      {/* Close button */}
      <div className="flex items-center justify-between border-b px-4 py-3">
        <span className="text-xs font-medium uppercase tracking-wide text-muted-foreground">
          Well Details
        </span>
        <Button variant="ghost" size="sm" onClick={onClose} className="h-8 w-8 p-0 lg:h-7 lg:w-7">
          &times;
        </Button>
      </div>

      <div className="space-y-3 p-4">
        {/* Section 1 -- Well Identity */}
        <Card>
          <CardHeader className="pb-2 pt-3 px-4">
            <CardTitle className="text-lg font-bold leading-tight">
              {displayName}
            </CardTitle>
            {well.formatted_id && (
              <p className="text-xs text-muted-foreground">{well.formatted_id}</p>
            )}
          </CardHeader>
          <CardContent className="flex flex-wrap gap-1.5 px-4 pb-3">
            {well.formation && (
              <Badge variant="outline">{well.formation}</Badge>
            )}
            {well.field && (
              <Badge variant="secondary">{well.field}</Badge>
            )}
            {wellClassification?.wellType && (
              <Badge variant="outline" className="border-sky-500/40 text-sky-300">
                {wellClassification.wellType}
              </Badge>
            )}
            {well.well_status && (
              <Badge variant="outline">{well.well_status}</Badge>
            )}
            {well.on_production_date && (
              <span className="text-xs text-muted-foreground">
                On prod: {formatDate(well.on_production_date)}
              </span>
            )}
          </CardContent>
        </Card>

        {/* Section 2 -- Well Event */}
        <WellEventForm
          key={`${well.id}:${well.active_well_event?.id ?? 'no-event'}`}
          well={well}
          canManage={canManageWellEvents}
        />

        {/* Section 2a -- MPS Fulfillment */}
        <WellEventFulfillment
          key={`${well.id}:${well.well_event_fulfillment?.updated_at ?? well.well_event_fulfillment?.id ?? 'no-fulfillment'}`}
          well={well}
          canManage={canEdit}
        />

        {/* Section 2b -- Activity Timeline */}
        <WellActivityTimeline well={well} />

        {/* Section 2c -- Device Assignment */}
        <DeviceAssignment well={well} canEdit={canEdit} />

        {/* Section 3 -- Pump Status */}
        <Card>
          <CardHeader className="pb-2 pt-3 px-4">
            <CardTitle className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">
              Pump Status
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-3 px-4 pb-3">
            {isServiceWell ? (
              <div className="space-y-2">
                <div className="flex items-center gap-2">
                  <span className="text-xs text-muted-foreground">Classification:</span>
                  <Badge variant="outline" className="border-sky-500/40 text-sky-300">
                    {wellClassification?.wellType ?? 'Service Well'}
                  </Badge>
                </div>
                <p className="text-xs text-muted-foreground">
                  This is a non-producing service well. Pump-life months and producer risk scoring do not apply.
                </p>
                {wellClassification?.wellFluid && (
                  <p className="text-xs text-muted-foreground">
                    Service fluid: {wellClassification.wellFluid}
                  </p>
                )}
              </div>
            ) : (
              <>
                <div className="flex items-center gap-2">
                  <span className="text-xs text-muted-foreground">Risk:</span>
                  <RiskBadge risk={well.risk_level} />
                </div>

                <div>
                  <div className="flex items-center justify-between text-xs mb-1">
                    <span className="text-muted-foreground">Months running</span>
                    <span className="font-semibold">{monthsRunning}/20</span>
                  </div>
                  <MonthsBar months={monthsRunning} showLabel />
                </div>

                {well.last_production_date && (
                  <p className="text-xs text-muted-foreground">
                    Last production: {formatDate(well.last_production_date)}
                  </p>
                )}
              </>
            )}
          </CardContent>
        </Card>

        {showProduction && (
          <Card>
            <CardHeader className="pb-2 pt-3 px-4">
              <CardTitle className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">
                Production
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-2 px-4 pb-3">
              {isServiceWell && (
                <p className="text-xs italic text-muted-foreground">
                  Production metrics are secondary here because this well is classified as {wellClassification?.wellType?.toLowerCase() ?? 'a service well'}.
                </p>
              )}
              <div className="grid grid-cols-2 gap-2 text-sm">
                <div>
                  <p className="text-xs text-muted-foreground">Latest oil rate</p>
                  <p className="font-semibold">
                    {well.dec_rate_bbl_d != null ? `${well.dec_rate_bbl_d.toFixed(1)} bbl/d` : 'N/A'}
                  </p>
                </div>
                <div>
                  <p className="text-xs text-muted-foreground">Cumulative oil</p>
                  <p className="font-semibold">
                    {well.cumulative_oil != null
                      ? `${(well.cumulative_oil / 1000).toFixed(1)}k bbl`
                      : 'N/A'}
                  </p>
                </div>
              </div>

              <div>
                <p className="text-xs text-muted-foreground">Monthly Oil (12mo)</p>
                {well.monthly_oil && well.monthly_oil.length > 0 ? (
                  <div className="mt-1">
                    <SparkLine data={well.monthly_oil.slice(-12)} />
                  </div>
                ) : latestSnapshotStatus === 'present' ? (
                  <p className="mt-1 text-xs italic text-muted-foreground">
                    Latest monthly snapshot is loaded. 12mo history is not available for this well yet.
                  </p>
                ) : (
                  <p className="mt-1 text-xs italic text-muted-foreground">No monthly data</p>
                )}
              </div>

              {(latestSnapshotMonth || latestSnapshotStatus) && (
                <div className="rounded-md border border-border/60 bg-muted/20 p-2 text-xs text-muted-foreground">
                  <p>
                    Snapshot month: {formatMonth(latestSnapshotMonth)}
                  </p>
                  <p>
                    Snapshot status:{' '}
                    {latestSnapshotStatus === 'present'
                      ? 'Present in latest monthly CSV'
                      : latestSnapshotStatus === 'missing'
                        ? 'Missing from latest monthly CSV, current-month rate forced to 0'
                        : 'Unknown'}
                  </p>
                </div>
              )}
            </CardContent>
          </Card>
        )}

        {/* Section 4 -- WellFi Device */}
        {well.wellfi_device ? (
          <Card>
            <CardHeader className="pb-2 pt-3 px-4">
              <CardTitle className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">
                WellFi Device
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-2 px-4 pb-3">
              <div className="grid grid-cols-2 gap-x-4 gap-y-1 text-sm">
                <div>
                  <p className="text-xs text-muted-foreground">Serial</p>
                  <p className="font-medium">{well.wellfi_device.serial_number ?? 'N/A'}</p>
                </div>
                <div>
                  <p className="text-xs text-muted-foreground">Firmware</p>
                  <p className="font-medium">{well.wellfi_device.firmware_version ?? 'N/A'}</p>
                </div>
                <div>
                  <p className="text-xs text-muted-foreground">Installed by</p>
                  <p className="font-medium">{well.wellfi_device.installed_by}</p>
                </div>
                <div>
                  <p className="text-xs text-muted-foreground">Installed</p>
                  <p className="font-medium">{formatDate(well.wellfi_device.installed_at)}</p>
                </div>
              </div>

              {/* Parameters table */}
              <div className="mt-2 rounded border text-xs">
                <table className="w-full">
                  <tbody>
                    <tr className="border-b">
                      <td className="px-2 py-1 text-muted-foreground">Pump Speed</td>
                      <td className="px-2 py-1 text-right font-medium">
                        {well.wellfi_device.pump_speed_rpm != null
                          ? `${well.wellfi_device.pump_speed_rpm} RPM`
                          : 'N/A'}
                      </td>
                    </tr>
                    <tr className="border-b">
                      <td className="px-2 py-1 text-muted-foreground">Formation Pressure</td>
                      <td className="px-2 py-1 text-right font-medium">
                        {well.wellfi_device.formation_pressure_kpa != null
                          ? `${well.wellfi_device.formation_pressure_kpa} kPa`
                          : 'N/A'}
                      </td>
                    </tr>
                    <tr className="border-b">
                      <td className="px-2 py-1 text-muted-foreground">Pump Intake</td>
                      <td className="px-2 py-1 text-right font-medium">
                        {well.wellfi_device.pump_intake_pressure_kpa != null
                          ? `${well.wellfi_device.pump_intake_pressure_kpa} kPa`
                          : 'N/A'}
                      </td>
                    </tr>
                    <tr>
                      <td className="px-2 py-1 text-muted-foreground">Target Surface</td>
                      <td className="px-2 py-1 text-right font-medium">
                        {well.wellfi_device.target_surface_pressure_kpa != null
                          ? `${well.wellfi_device.target_surface_pressure_kpa} kPa`
                          : 'N/A'}
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

              {canEdit && (
                <Button
                  variant="outline"
                  size="sm"
                  className="mt-2 w-full"
                  onClick={() => setInstallDialogOpen(true)}
                >
                  Update Device
                </Button>
              )}
            </CardContent>
          </Card>
        ) : (
          canEdit ? (
            <Suspense fallback={asyncCardFallback('Deployment Projection')}>
              <div className="mt-2"><ComparablesWidget onDeploy={() => setInstallDialogOpen(true)} /></div>
            </Suspense>
          ) : null
        )}

        {/* Section 5 -- Downhole View */}
        <Suspense fallback={asyncCardFallback('Downhole View')}>
          <DownholeModel3D well={well} canEdit={canEdit} />
        </Suspense>

        {/* Section 6 -- Pump Change */}
        <Card>
          <CardHeader className="pb-2 pt-3 px-4">
            <CardTitle className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">
              Pump Change
            </CardTitle>
          </CardHeader>
          <CardContent className="px-4 pb-3">
            {isServiceWell ? (
              <p className="text-sm text-muted-foreground">
                Pump change workflow is disabled for non-producing service wells.
              </p>
            ) : well.active_pump_change ? (
              <PumpChecklist pumpChange={well.active_pump_change} canEdit={canEdit} />
            ) : monthsRunning >= 14 ? (
              <div className="space-y-2">
                <div className="rounded-md border border-risk-orange bg-risk-orange/10 p-2 text-xs text-risk-orange">
                  {monthsRunning} months running — consider flagging for pump change
                </div>
                {canEdit && (
                  <Button
                    size="sm"
                    variant="outline"
                    className="w-full border-risk-orange text-risk-orange hover:bg-risk-orange/10"
                    onClick={() => setPumpChangeDialogOpen(true)}
                  >
                    Flag Pump Change
                  </Button>
                )}
              </div>
            ) : (
              <p className="text-sm text-muted-foreground">No active pump change</p>
            )}
          </CardContent>
        </Card>
      </div>

      {/* WellFi Install Dialog */}
      <Dialog open={installDialogOpen} onOpenChange={setInstallDialogOpen}>
        <DialogContent className="max-w-md max-h-[90vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle>Register WellFi Installation</DialogTitle>
            <DialogDescription>
              Install a WellFi device on {well.name ?? well.well_id}
            </DialogDescription>
          </DialogHeader>
          <Suspense fallback={<div className="py-4 text-center text-sm text-muted-foreground">Loading form...</div>}>
            <WellFiInstallForm
              well={well}
              onSuccess={() => setInstallDialogOpen(false)}
              onCancel={() => setInstallDialogOpen(false)}
            />
          </Suspense>
        </DialogContent>
      </Dialog>

      {/* Pump Change Dialog */}
      <Dialog open={pumpChangeDialogOpen} onOpenChange={setPumpChangeDialogOpen}>
        <DialogContent className="max-w-md max-h-[90vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle>Flag Pump Change</DialogTitle>
            <DialogDescription>
              Create a pump change record for {well.name ?? well.well_id}
            </DialogDescription>
          </DialogHeader>
          <Suspense fallback={<div className="py-4 text-center text-sm text-muted-foreground">Loading form...</div>}>
            <PumpChangeForm
              well={well}
              onSuccess={() => setPumpChangeDialogOpen(false)}
              onCancel={() => setPumpChangeDialogOpen(false)}
            />
          </Suspense>
        </DialogContent>
      </Dialog>
    </div>
  );
}
