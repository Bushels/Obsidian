# Agent: agent-db — Database & Schema
**Session:** 1 | **Precedence:** 1 (highest in session) | **Mode:** Parallel with agent-scaffold

---

## Pre-Start Checklist
1. Read `agents/MANIFEST.json` — confirm your owned files
2. Read `agents/STATUS.json` — confirm Session 1 is `pending` (no gate required)
3. Write your lock file at `agents/locks/agent-db.lock`
4. Check for any other active `.lock` files — if agent-scaffold is already writing `src/types.ts`, that's fine — no conflict with your files

---

## Your Owned Files (only you write these)
```
supabase/migrations/001_initial_schema.sql
supabase/migrations/002_indexes.sql
supabase/migrations/003_rls_policies.sql
supabase/seed.py
supabase/.env.example
```

---

## Tasks

### Task 1 — Supabase Project Init
Create the directory structure:
```
supabase/
  migrations/
  functions/
  seed.py
  .env.example
```

### Task 2 — Migration 001: Initial Schema
File: `supabase/migrations/001_initial_schema.sql`

Create three tables exactly as defined below. Do not deviate from column names or types.

```sql
-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- WELLS: Core well data (seeded from PetroNinja, refreshed periodically)
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

-- WELLFI_DEVICES: One active device per well when installed
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

-- PUMP_CHANGES: Full lifecycle from warning to completion
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

-- Auto-update trigger for updated_at
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = now(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER wells_updated_at BEFORE UPDATE ON wells FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER wellfi_devices_updated_at BEFORE UPDATE ON wellfi_devices FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER pump_changes_updated_at BEFORE UPDATE ON pump_changes FOR EACH ROW EXECUTE FUNCTION update_updated_at();
```

### Task 3 — Migration 002: Indexes
File: `supabase/migrations/002_indexes.sql`

```sql
-- Performance indexes
CREATE INDEX idx_wells_status     ON wells(well_status);
CREATE INDEX idx_wells_risk       ON wells(risk_level);
CREATE INDEX idx_wells_field      ON wells(field);
CREATE INDEX idx_wells_formation  ON wells(formation);
CREATE INDEX idx_wells_coords     ON wells(lat, lon);
CREATE INDEX idx_wellfi_active    ON wellfi_devices(well_id) WHERE is_active = TRUE;
CREATE INDEX idx_pump_well        ON pump_changes(well_id);
CREATE INDEX idx_pump_status      ON pump_changes(status);
CREATE INDEX idx_pump_date        ON pump_changes(scheduled_date);

-- Enable Realtime on all three tables
ALTER PUBLICATION supabase_realtime ADD TABLE wells;
ALTER PUBLICATION supabase_realtime ADD TABLE wellfi_devices;
ALTER PUBLICATION supabase_realtime ADD TABLE pump_changes;
```

### Task 4 — Migration 003: Row Level Security
File: `supabase/migrations/003_rls_policies.sql`

```sql
-- Enable RLS
ALTER TABLE wells ENABLE ROW LEVEL SECURITY;
ALTER TABLE wellfi_devices ENABLE ROW LEVEL SECURITY;
ALTER TABLE pump_changes ENABLE ROW LEVEL SECURITY;

-- Shared login: all authenticated users can read/write all tables
CREATE POLICY "authenticated_read_wells"
  ON wells FOR SELECT TO authenticated USING (true);

CREATE POLICY "authenticated_write_wellfi"
  ON wellfi_devices FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "authenticated_read_wellfi"
  ON wellfi_devices FOR SELECT TO authenticated USING (true);

CREATE POLICY "authenticated_all_pump_changes"
  ON pump_changes FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- Wells are only updated via seed script (service_role), not by app users directly
CREATE POLICY "service_role_write_wells"
  ON wells FOR ALL TO service_role USING (true) WITH CHECK (true);
```

### Task 5 — Seed Script
File: `supabase/seed.py`

Python script that reads `combined_data.json` (already exists at project root) and upserts all 211 wells into Supabase.

```python
#!/usr/bin/env python3
"""
Seed script: upserts wells from combined_data.json into Supabase.
Usage:
  python supabase/seed.py               # First-time seed
  python supabase/seed.py --update      # Refresh well data, preserve installs/pump changes
"""
import json, os, sys, argparse
from supabase import create_client

SUPABASE_URL = os.environ["SUPABASE_URL"]
SUPABASE_SERVICE_KEY = os.environ["SUPABASE_SERVICE_ROLE_KEY"]

def load_combined_data(path="combined_data.json"):
    with open(path) as f:
        return json.load(f)

def transform_well(wid, w):
    """Map combined_data.json fields to wells table columns."""
    hrs = w.get("hours", {})
    oil = w.get("oil_monthly", {})
    dt = w.get("downtime", {})
    month_keys = ["jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec"]

    return {
        "well_id": wid,
        "formatted_id": w.get("formatted_well_id"),
        "name": w.get("well_name"),
        "lat": w.get("surface_latitude"),
        "lon": w.get("surface_longitude"),
        "formation": w.get("formation"),
        "field": w.get("field_name"),
        "well_status": w.get("well_status"),
        "risk_level": w.get("risk_level"),
        "months_running": w.get("consec_months_running"),
        "dec_rate_bbl_d": w.get("dec_2025_bbl_d"),
        "total_2025_bbl": w.get("total_2025_bbl"),
        "cumulative_oil": w.get("cumulative_oil"),
        "on_production_date": w.get("on_production_date"),
        "last_production_date": w.get("last_production_date"),
        "annual_uptime_pct": dt.get("annual_uptime_pct") if dt else None,
        "total_downtime_days": dt.get("total_downtime_days") if dt else None,
        "monthly_hrs": [hrs.get(m) for m in month_keys] if hrs else None,
        "monthly_oil": [oil.get(m) for m in month_keys] if oil else None,
        "monthly_uptime": w.get("monthly_uptime"),
        "status_note": w.get("status_note"),
    }

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--update", action="store_true")
    args = parser.parse_args()

    client = create_client(SUPABASE_URL, SUPABASE_SERVICE_KEY)
    data = load_combined_data()

    rows = [transform_well(wid, w) for wid, w in data.items()
            if w.get("surface_latitude") and w.get("surface_longitude")]

    print(f"Upserting {len(rows)} wells...")
    result = client.table("wells").upsert(rows, on_conflict="well_id").execute()
    print(f"Done. {len(result.data)} rows affected.")

if __name__ == "__main__":
    main()
```

### Task 6 — Environment Template
File: `supabase/.env.example`
```
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
```

---

## Completion
1. Update `agents/locks/agent-db.lock` → status: `"completed"`
2. List all files written
3. Create `agents/proposals/agent-db-completion.md` with summary

**DO NOT touch:** `src/` directory, any agent-scaffold owned files
