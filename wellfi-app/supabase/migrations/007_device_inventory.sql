-- 007_device_inventory.sql
-- Session 9: Device Inventory & Assignment lifecycle
-- Tracks WellFi devices from warehouse stock through field installation.
-- Admin-only writes enforced via RLS (checks app_users.role = 'admin').
-- Lifecycle: incoming → in_stock → assigned → installed

CREATE TABLE device_inventory (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  serial_number       TEXT NOT NULL UNIQUE,
  status              TEXT NOT NULL DEFAULT 'in_stock'
                        CHECK (status IN ('in_stock', 'incoming', 'assigned', 'installed')),
  assigned_well_id    UUID REFERENCES wells(id) ON DELETE SET NULL,
  assigned_by         TEXT,
  assigned_by_user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  assigned_at         TIMESTAMPTZ,
  installed_by        TEXT,
  installed_by_user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  installed_at        TIMESTAMPTZ,
  notes               TEXT,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT now(),

  -- Enforce lifecycle timestamp consistency per status
  CONSTRAINT device_inventory_status_timestamps_chk CHECK (
    (status = 'incoming'   AND assigned_at IS NULL AND installed_at IS NULL)
    OR (status = 'in_stock'   AND assigned_at IS NULL AND installed_at IS NULL)
    OR (status = 'assigned'   AND assigned_at IS NOT NULL AND installed_at IS NULL)
    OR (status = 'installed'  AND installed_at IS NOT NULL)
  )
);

-- Only one active (assigned or installed) device per well
CREATE UNIQUE INDEX idx_inventory_active_well
  ON device_inventory (assigned_well_id)
  WHERE status IN ('assigned', 'installed');

-- Fast status-based count queries
CREATE INDEX idx_inventory_status
  ON device_inventory (status);

-- Serial number lookups
CREATE INDEX idx_inventory_serial
  ON device_inventory (serial_number);

-- All devices for a given well (any status) — supports history lookups
CREATE INDEX idx_inventory_well
  ON device_inventory (assigned_well_id)
  WHERE assigned_well_id IS NOT NULL;

-- Auto-update updated_at (reuses function from 001_initial_schema.sql)
CREATE TRIGGER device_inventory_updated_at
  BEFORE UPDATE ON device_inventory
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Row Level Security
ALTER TABLE device_inventory ENABLE ROW LEVEL SECURITY;

-- All authenticated users can read inventory
CREATE POLICY "authenticated_read_inventory"
  ON device_inventory FOR SELECT TO authenticated USING (true);

-- Only admin can insert
CREATE POLICY "admin_insert_inventory"
  ON device_inventory FOR INSERT TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1 FROM app_users WHERE id = auth.uid() AND role = 'admin')
  );

-- Only admin can update
CREATE POLICY "admin_update_inventory"
  ON device_inventory FOR UPDATE TO authenticated
  USING (
    EXISTS (SELECT 1 FROM app_users WHERE id = auth.uid() AND role = 'admin')
  )
  WITH CHECK (
    EXISTS (SELECT 1 FROM app_users WHERE id = auth.uid() AND role = 'admin')
  );

-- Only admin can delete
CREATE POLICY "admin_delete_inventory"
  ON device_inventory FOR DELETE TO authenticated
  USING (
    EXISTS (SELECT 1 FROM app_users WHERE id = auth.uid() AND role = 'admin')
  );

-- Enable realtime
ALTER PUBLICATION supabase_realtime ADD TABLE device_inventory;
