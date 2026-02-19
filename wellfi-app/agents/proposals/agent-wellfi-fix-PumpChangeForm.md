# Proposal: Fix PumpChangeForm.tsx type error

## Agent: agent-wellfi
## File: src/components/forms/PumpChangeForm.tsx (owned by agent-pump-change)

## Problem

The `createPumpChange.mutate()` call on line 102 passes an object that is missing required fields from `PumpChangeInsert` type (`Omit<PumpChange, 'id' | 'created_at' | 'updated_at'>`).

Missing fields:
- `flagged_at` (string)
- `device_sourced` (boolean)
- `program_configured` (boolean)
- `installation_scheduled` (boolean)
- `actual_date` (string | null)
- `completed_by` (string | null)
- `wellfi_installed_after` (boolean)
- `notification_sent` (boolean)

## Suggested Fix

Add default values for the missing fields in the mutate call (around line 102):

```typescript
createPumpChange.mutate(
  {
    well_id: well.id,
    status: 'warning',
    flagged_by: data.flagged_by,
    flagged_at: new Date().toISOString(),
    scheduled_date: format(data.scheduled_date, 'yyyy-MM-dd'),
    formation_pressure_kpa: data.formation_pressure_kpa,
    pump_pressure_kpa: data.pump_pressure_kpa,
    pump_speed_rpm: data.pump_speed_rpm ?? null,
    notes: data.notes ?? null,
    device_sourced: false,
    program_configured: false,
    installation_scheduled: false,
    actual_date: null,
    completed_by: null,
    wellfi_installed_after: false,
    notification_sent: false,
  },
  // ... callbacks
);
```

## Impact

This is the only remaining build error. Fixing it will make `npm run build` pass.
