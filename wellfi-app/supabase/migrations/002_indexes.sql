-- 002_indexes.sql
-- Performance indexes and realtime subscriptions

CREATE INDEX idx_wells_status     ON wells(well_status);
CREATE INDEX idx_wells_risk       ON wells(risk_level);
CREATE INDEX idx_wells_field      ON wells(field);
CREATE INDEX idx_wells_formation  ON wells(formation);
CREATE INDEX idx_wells_coords     ON wells(lat, lon);
CREATE INDEX idx_wellfi_active    ON wellfi_devices(well_id) WHERE is_active = TRUE;
CREATE INDEX idx_pump_well        ON pump_changes(well_id);
CREATE INDEX idx_pump_status      ON pump_changes(status);
CREATE INDEX idx_pump_date        ON pump_changes(scheduled_date);

ALTER PUBLICATION supabase_realtime ADD TABLE wells;
ALTER PUBLICATION supabase_realtime ADD TABLE wellfi_devices;
ALTER PUBLICATION supabase_realtime ADD TABLE pump_changes;
