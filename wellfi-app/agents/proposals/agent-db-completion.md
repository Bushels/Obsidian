# agent-db Completion Report

**Agent:** agent-db
**Session:** 1 (Foundation)
**Status:** COMPLETED

## Files Created

### Directory Structure
- `supabase/migrations/`
- `supabase/functions/`

### Migrations
1. **`supabase/migrations/001_initial_schema.sql`** — Core tables: `wells`, `wellfi_devices`, `pump_changes` with auto-updated `updated_at` triggers.
2. **`supabase/migrations/002_indexes.sql`** — Performance indexes on status, risk, field, formation, coordinates; partial index on active devices; realtime publication for all three tables.
3. **`supabase/migrations/003_rls_policies.sql`** — Row Level Security: authenticated users can read wells, read/write devices and pump_changes; service_role has full access to wells.

### Seed Script
4. **`supabase/seed.py`** — Python script that:
   - Reads `combined_data.json` (JSON array of 211 PetroNinja well objects)
   - Maps `producing_formation` to `formation`, `field_name` to `field`
   - Computes `months_running` from `on_production_date` to today
   - Derives `risk_level`: >=17 months = "HIGH — DUE", 14-16 = "WATCH", 9-13 = "WATCH", 1-8 = "LOW", else "NO DATA"
   - Uses `last_oil_rate` as `dec_rate_bbl_d`
   - Sets underivable fields (total_2025_bbl, monthly_hrs, monthly_oil, monthly_uptime, annual_uptime_pct, total_downtime_days) to null
   - Filters out wells missing lat/lon
   - Upserts in batches of 50 via supabase-py service role client
   - Requires: `pip install supabase python-dotenv`

### Config
5. **`supabase/.env.example`** — Template for SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY

## Schema Summary

### wells table
| Column | Type | Notes |
|--------|------|-------|
| id | UUID PK | auto-generated |
| well_id | TEXT UNIQUE | PetroNinja well_id |
| formatted_id | TEXT | e.g. "100/08-08-082-15W5/00" |
| name | TEXT | well_name from source |
| lat, lon | NUMERIC | surface coordinates |
| formation | TEXT | "Bluesky" or "Clearwater" |
| field | TEXT | SEAL, SLAVE, DAWSON, etc. |
| well_status | TEXT | Pumping, Operating, Suspended, Abandoned |
| risk_level | TEXT | Computed from months_running |
| months_running | INTEGER | Months since on_production_date |
| dec_rate_bbl_d | NUMERIC | last_oil_rate from source |
| cumulative_oil | NUMERIC | From source |
| on_production_date | DATE | From source |
| last_production_date | DATE | From source |

### wellfi_devices table
Tracks WellFi ESP controller installations per well.

### pump_changes table
Tracks pump change workflow: warning -> scheduled -> in_progress -> completed/cancelled.

## Data Validation
- 211 total records in combined_data.json
- 4 well_status values: Pumping, Operating, Suspended, Abandoned
- 2 formations: Bluesky, Clearwater
- 6 field names: SEAL, SLAVE, DAWSON, CADOTTE, UNDEFINED, HARMON VALLEY
- All records have surface_latitude and surface_longitude populated

## Dependencies for seed.py
```
pip install supabase python-dotenv
```

## Next Steps
- Run migrations against Supabase project (via Supabase CLI or dashboard SQL editor)
- Configure `.env` with real credentials
- Run `python supabase/seed.py` to populate wells table
- agent-scaffold can now build UI components against this schema
