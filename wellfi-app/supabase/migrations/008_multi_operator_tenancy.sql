-- 008_multi_operator_tenancy.sql
-- Adds operator tenancy, operator-scoped RLS, and helper functions for
-- multi-operator Clearwater / Bluesky dashboard rollouts.

CREATE TABLE IF NOT EXISTS operators (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug              TEXT NOT NULL UNIQUE,
  display_name      TEXT NOT NULL UNIQUE,
  status            TEXT NOT NULL DEFAULT 'active'
                    CHECK (status IN ('active', 'inactive')),
  onboarding_status TEXT NOT NULL DEFAULT 'inventory'
                    CHECK (onboarding_status IN ('inventory', 'planned', 'pilot', 'ready', 'paused')),
  is_pilot          BOOLEAN NOT NULL DEFAULT FALSE,
  basin_scope       TEXT NOT NULL DEFAULT 'Clearwater|Bluesky',
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);

DROP TRIGGER IF EXISTS operators_updated_at ON operators;
CREATE TRIGGER operators_updated_at
  BEFORE UPDATE ON operators
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

ALTER TABLE operators ENABLE ROW LEVEL SECURITY;

ALTER TABLE wells
  ADD COLUMN IF NOT EXISTS operator_id UUID REFERENCES operators(id) ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_wells_operator_id
  ON wells (operator_id);

ALTER TABLE app_users
  ADD COLUMN IF NOT EXISTS operator_id UUID REFERENCES operators(id) ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_app_users_operator_id
  ON app_users (operator_id);

INSERT INTO operators (slug, display_name, status, onboarding_status, is_pilot, basin_scope)
VALUES ('obsidian-energy-ltd', 'Obsidian Energy Ltd.', 'active', 'ready', true, 'Clearwater|Bluesky')
ON CONFLICT (slug) DO UPDATE SET
  display_name = EXCLUDED.display_name,
  status = EXCLUDED.status,
  onboarding_status = EXCLUDED.onboarding_status,
  is_pilot = EXCLUDED.is_pilot,
  basin_scope = EXCLUDED.basin_scope,
  updated_at = now();

UPDATE wells
SET operator_id = (
  SELECT id FROM operators WHERE slug = 'obsidian-energy-ltd'
)
WHERE operator_id IS NULL;

UPDATE app_users
SET operator_id = (
  SELECT id FROM operators WHERE slug = 'obsidian-energy-ltd'
)
WHERE role = 'viewer' AND operator_id IS NULL;

CREATE OR REPLACE FUNCTION public.current_app_user_role()
RETURNS TEXT
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT role
  FROM public.app_users
  WHERE id = auth.uid()
  LIMIT 1;
$$;

CREATE OR REPLACE FUNCTION public.current_app_user_operator_id()
RETURNS UUID
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT operator_id
  FROM public.app_users
  WHERE id = auth.uid()
  LIMIT 1;
$$;

CREATE OR REPLACE FUNCTION public.current_app_user_is_admin()
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT COALESCE(public.current_app_user_role() = 'admin', FALSE);
$$;

DROP POLICY IF EXISTS "Users can read own data" ON app_users;
CREATE POLICY "users_read_scoped"
  ON app_users FOR SELECT TO authenticated
  USING (
    auth.uid() = id OR public.current_app_user_is_admin()
  );

DROP POLICY IF EXISTS "authenticated_read_wells" ON wells;
CREATE POLICY "operators_read_wells"
  ON wells FOR SELECT TO authenticated
  USING (
    public.current_app_user_is_admin()
    OR operator_id = public.current_app_user_operator_id()
  );

DROP POLICY IF EXISTS "service_role_write_wells" ON wells;
CREATE POLICY "service_role_write_wells"
  ON wells FOR ALL TO service_role
  USING (true)
  WITH CHECK (true);

DROP POLICY IF EXISTS "authenticated_read_wellfi" ON wellfi_devices;
DROP POLICY IF EXISTS "authenticated_write_wellfi" ON wellfi_devices;
CREATE POLICY "operators_read_wellfi_devices"
  ON wellfi_devices FOR SELECT TO authenticated
  USING (
    public.current_app_user_is_admin()
    OR EXISTS (
      SELECT 1
      FROM wells
      WHERE wells.id = wellfi_devices.well_id
        AND wells.operator_id = public.current_app_user_operator_id()
    )
  );

CREATE POLICY "admin_write_wellfi_devices"
  ON wellfi_devices FOR ALL TO authenticated
  USING (public.current_app_user_is_admin())
  WITH CHECK (public.current_app_user_is_admin());

DROP POLICY IF EXISTS "authenticated_all_pump_changes" ON pump_changes;
CREATE POLICY "operators_read_pump_changes"
  ON pump_changes FOR SELECT TO authenticated
  USING (
    public.current_app_user_is_admin()
    OR EXISTS (
      SELECT 1
      FROM wells
      WHERE wells.id = pump_changes.well_id
        AND wells.operator_id = public.current_app_user_operator_id()
    )
  );

CREATE POLICY "admin_write_pump_changes"
  ON pump_changes FOR ALL TO authenticated
  USING (public.current_app_user_is_admin())
  WITH CHECK (public.current_app_user_is_admin());

DROP POLICY IF EXISTS "authenticated_read_operational_statuses" ON operational_statuses;
DROP POLICY IF EXISTS "authenticated_write_operational_statuses" ON operational_statuses;
CREATE POLICY "operators_read_operational_statuses"
  ON operational_statuses FOR SELECT TO authenticated
  USING (
    public.current_app_user_is_admin()
    OR EXISTS (
      SELECT 1
      FROM wells
      WHERE wells.id = operational_statuses.well_id
        AND wells.operator_id = public.current_app_user_operator_id()
    )
  );

CREATE POLICY "admin_write_operational_statuses"
  ON operational_statuses FOR ALL TO authenticated
  USING (public.current_app_user_is_admin())
  WITH CHECK (public.current_app_user_is_admin());

DROP POLICY IF EXISTS "authenticated_read_inventory" ON device_inventory;
DROP POLICY IF EXISTS "admin_insert_inventory" ON device_inventory;
DROP POLICY IF EXISTS "admin_update_inventory" ON device_inventory;
DROP POLICY IF EXISTS "admin_delete_inventory" ON device_inventory;
CREATE POLICY "operators_read_device_inventory"
  ON device_inventory FOR SELECT TO authenticated
  USING (
    public.current_app_user_is_admin()
    OR (
      assigned_well_id IS NOT NULL
      AND EXISTS (
        SELECT 1
        FROM wells
        WHERE wells.id = device_inventory.assigned_well_id
          AND wells.operator_id = public.current_app_user_operator_id()
      )
    )
  );

CREATE POLICY "admin_insert_inventory"
  ON device_inventory FOR INSERT TO authenticated
  WITH CHECK (public.current_app_user_is_admin());

CREATE POLICY "admin_update_inventory"
  ON device_inventory FOR UPDATE TO authenticated
  USING (public.current_app_user_is_admin())
  WITH CHECK (public.current_app_user_is_admin());

CREATE POLICY "admin_delete_inventory"
  ON device_inventory FOR DELETE TO authenticated
  USING (public.current_app_user_is_admin());

DROP POLICY IF EXISTS "operators_read_scoped" ON operators;
DROP POLICY IF EXISTS "admin_manage_operators" ON operators;
CREATE POLICY "operators_read_scoped"
  ON operators FOR SELECT TO authenticated
  USING (
    public.current_app_user_is_admin()
    OR id = public.current_app_user_operator_id()
  );

CREATE POLICY "admin_manage_operators"
  ON operators FOR ALL TO authenticated
  USING (public.current_app_user_is_admin())
  WITH CHECK (public.current_app_user_is_admin());
