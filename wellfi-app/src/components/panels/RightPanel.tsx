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
import DownholeModel3D from '@/components/panels/DownholeModel3D';
import type { Well } from '@/types';

const WellFiInstallForm = lazy(() => import('@/components/forms/WellFiInstallForm'));
const PumpChangeForm = lazy(() => import('@/components/forms/PumpChangeForm'));

interface RightPanelProps {
  well: Well | null;
  onClose: () => void;
  canEdit?: boolean;
}

function formatDate(dateStr: string | null): string {
  if (!dateStr) return 'N/A';
  return new Date(dateStr).toLocaleDateString('en-CA', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
  });
}

export default function RightPanel({ well, onClose, canEdit = false }: RightPanelProps) {
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
              {well.name ?? well.well_id}
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

        {/* Section 2 -- Pump Status */}
        <Card>
          <CardHeader className="pb-2 pt-3 px-4">
            <CardTitle className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">
              Pump Status
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-3 px-4 pb-3">
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
          </CardContent>
        </Card>

        {/* Section 3 -- Production */}
        <Card>
          <CardHeader className="pb-2 pt-3 px-4">
            <CardTitle className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">
              Production
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-2 px-4 pb-3">
            <div className="grid grid-cols-2 gap-2 text-sm">
              <div>
                <p className="text-xs text-muted-foreground">Dec rate</p>
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
              ) : (
                <p className="mt-1 text-xs italic text-muted-foreground">No monthly data</p>
              )}
            </div>
          </CardContent>
        </Card>

        {/* Section 4 -- WellFi Device */}
        <Card>
          <CardHeader className="pb-2 pt-3 px-4">
            <CardTitle className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">
              WellFi Device
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-2 px-4 pb-3">
            {well.wellfi_device ? (
              <>
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
              </>
            ) : (
              <div className="text-center py-2">
                <p className="text-sm text-muted-foreground mb-2">No WellFi installed</p>
                {canEdit && (
                  <Button
                    size="sm"
                    className="bg-wellfi-cyan text-black hover:bg-wellfi-cyan/90"
                    onClick={() => setInstallDialogOpen(true)}
                  >
                    Register Installation
                  </Button>
                )}
              </div>
            )}
          </CardContent>
        </Card>

        {/* Section 5 -- Downhole View */}
        <DownholeModel3D well={well} />

        {/* Section 6 -- Pump Change */}
        <Card>
          <CardHeader className="pb-2 pt-3 px-4">
            <CardTitle className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">
              Pump Change
            </CardTitle>
          </CardHeader>
          <CardContent className="px-4 pb-3">
            {well.active_pump_change ? (
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
