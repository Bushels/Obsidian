-- 001_initial_schema.sql
-- WellFi initial database schema
-- Creates core tables: wells, wellfi_devices, pump_changes

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE wells (
  id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  well_id               TEXT UNIQUE NOT NULL,
  formatted_id          TEXT,
  name                  TEXT,
  lat                   NUMERIC(10,7) NOT NULL,
  lon                   NUMERIC(11,7) NOT NULL,
  formation             TEXT CHECK (formation IN ('Bluesky','Clearwater')),
  field                 TEXT,
  well_status           TEXT CHECK (well_status IN ('Pumping','Operating','Suspended','Abandoned')),
  risk_level            TEXT,
  months_running        INTEGER,
  dec_rate_bbl_d        NUMERIC,
  total_2025_bbl        NUMERIC,
  cumulative_oil        NUMERIC,
  on_production_date    DATE,
  last_production_date  DATE,
  annual_uptime_pct     NUMERIC CHECK (annual_uptime_pct >= 0 AND annual_uptime_pct <= 1),
  total_downtime_days   INTEGER,
  monthly_hrs           INTEGER[],
  monthly_oil           NUMERIC[],
  monthly_uptime        NUMERIC[],
  status_note           TEXT,
  created_at            TIMESTAMPTZ DEFAULT now(),
  updated_at            TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE wellfi_devices (
  id                          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  well_id                     UUID NOT NULL REFERENCES wells(id) ON DELETE CASCADE,
  serial_number               TEXT,
  installed_at                TIMESTAMPTZ,
  installed_by                TEXT NOT NULL,
  is_active                   BOOLEAN DEFAULT TRUE,
  pump_speed_rpm              NUMERIC,
  formation_pressure_kpa      NUMERIC,
  pump_intake_pressure_kpa    NUMERIC,
  target_surface_pressure_kpa NUMERIC,
  firmware_version            TEXT,
  notes                       TEXT,
  created_at                  TIMESTAMPTZ DEFAULT now(),
  updated_at                  TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE pump_changes (
  id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  well_id                 UUID NOT NULL REFERENCES wells(id) ON DELETE CASCADE,
  status                  TEXT DEFAULT 'warning'
                          CHECK (status IN ('warning','scheduled','in_progress','completed','cancelled')),
  flagged_by              TEXT NOT NULL,
  flagged_at              TIMESTAMPTZ DEFAULT now(),
  scheduled_date          DATE,
  notes                   TEXT,
  formation_pressure_kpa  NUMERIC,
  pump_pressure_kpa       NUMERIC,
  pump_speed_rpm          NUMERIC,
  device_sourced          BOOLEAN DEFAULT FALSE,
  program_configured      BOOLEAN DEFAULT FALSE,
  installation_scheduled  BOOLEAN DEFAULT FALSE,
  actual_date             DATE,
  completed_by            TEXT,
  wellfi_installed_after  BOOLEAN DEFAULT FALSE,
  notification_sent       BOOLEAN DEFAULT FALSE,
  created_at              TIMESTAMPTZ DEFAULT now(),
  updated_at              TIMESTAMPTZ DEFAULT now()
);

CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = now(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER wells_updated_at BEFORE UPDATE ON wells FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER wellfi_devices_updated_at BEFORE UPDATE ON wellfi_devices FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER pump_changes_updated_at BEFORE UPDATE ON pump_changes FOR EACH ROW EXECUTE FUNCTION update_updated_at();
