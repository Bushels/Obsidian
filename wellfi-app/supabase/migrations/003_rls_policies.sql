-- 003_rls_policies.sql
-- Row Level Security policies

ALTER TABLE wells ENABLE ROW LEVEL SECURITY;
ALTER TABLE wellfi_devices ENABLE ROW LEVEL SECURITY;
ALTER TABLE pump_changes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "authenticated_read_wells"
  ON wells FOR SELECT TO authenticated USING (true);

CREATE POLICY "authenticated_write_wellfi"
  ON wellfi_devices FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "authenticated_read_wellfi"
  ON wellfi_devices FOR SELECT TO authenticated USING (true);

CREATE POLICY "authenticated_all_pump_changes"
  ON pump_changes FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "service_role_write_wells"
  ON wells FOR ALL TO service_role USING (true) WITH CHECK (true);
