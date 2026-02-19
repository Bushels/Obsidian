"""
WellFi seed script — loads combined_data.json into Supabase wells table.

Reads the raw PetroNinja JSON array, maps fields to the wells schema,
computes derived fields (months_running, risk_level), and upserts.

Usage:
  pip install supabase python-dotenv
  export SUPABASE_URL=... SUPABASE_SERVICE_ROLE_KEY=...
  python supabase/seed.py

Or with a .env file in the supabase/ directory.
"""

import json
import os
import sys
from datetime import date, datetime
from pathlib import Path

from dotenv import load_dotenv
from supabase import create_client

# ---------------------------------------------------------------------------
# Config
# ---------------------------------------------------------------------------

# Load .env from the supabase/ directory (next to this script)
load_dotenv(Path(__file__).resolve().parent / ".env")

SUPABASE_URL = os.environ.get("SUPABASE_URL")
SUPABASE_SERVICE_ROLE_KEY = os.environ.get("SUPABASE_SERVICE_ROLE_KEY")

if not SUPABASE_URL or not SUPABASE_SERVICE_ROLE_KEY:
    print("ERROR: SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY must be set.")
    sys.exit(1)

# Path to the combined data file (project root)
DATA_FILE = Path(__file__).resolve().parent.parent / "combined_data.json"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def compute_months_running(on_production_date_str: str | None) -> int | None:
    """Months between on_production_date and today."""
    if not on_production_date_str:
        return None
    try:
        prod_date = datetime.strptime(on_production_date_str[:10], "%Y-%m-%d").date()
    except (ValueError, TypeError):
        return None
    today = date.today()
    months = (today.year - prod_date.year) * 12 + (today.month - prod_date.month)
    return max(months, 0)


def compute_risk_level(months: int | None) -> str:
    """Derive risk_level from months_running."""
    if months is None or months == 0:
        return "NO DATA"
    if months >= 17:
        return "HIGH — DUE"
    if months >= 14:
        return "WATCH"
    if months >= 9:
        return "WATCH"
    if months >= 1:
        return "LOW"
    return "NO DATA"


def parse_date(val: str | None) -> str | None:
    """Return ISO date string or None."""
    if not val:
        return None
    try:
        return datetime.strptime(val[:10], "%Y-%m-%d").date().isoformat()
    except (ValueError, TypeError):
        return None


def to_numeric(val) -> float | None:
    """Coerce to float or None."""
    if val is None:
        return None
    try:
        return float(val)
    except (ValueError, TypeError):
        return None


def transform_well(raw: dict) -> dict | None:
    """Map a raw PetroNinja record to the wells table schema."""
    lat = to_numeric(raw.get("surface_latitude"))
    lon = to_numeric(raw.get("surface_longitude"))
    if lat is None or lon is None:
        return None  # skip wells without coordinates

    months = compute_months_running(raw.get("on_production_date"))
    risk = compute_risk_level(months)

    return {
        "well_id": raw.get("well_id"),
        "formatted_id": raw.get("formatted_well_id"),
        "name": raw.get("well_name"),
        "lat": lat,
        "lon": lon,
        "formation": raw.get("producing_formation"),
        "field": raw.get("field_name"),
        "well_status": raw.get("well_status"),
        "risk_level": risk,
        "months_running": months,
        "dec_rate_bbl_d": to_numeric(raw.get("last_oil_rate")),
        "total_2025_bbl": None,
        "cumulative_oil": to_numeric(raw.get("cumulative_oil")),
        "on_production_date": parse_date(raw.get("on_production_date")),
        "last_production_date": parse_date(raw.get("last_production_date")),
        "annual_uptime_pct": None,
        "total_downtime_days": None,
        "monthly_hrs": None,
        "monthly_oil": None,
        "monthly_uptime": None,
        "status_note": None,
    }


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    print(f"Reading data from {DATA_FILE} ...")
    with open(DATA_FILE, "r", encoding="utf-8") as f:
        raw_data: list[dict] = json.load(f)

    print(f"Loaded {len(raw_data)} raw well records.")

    # Transform
    rows = []
    skipped = 0
    for raw in raw_data:
        row = transform_well(raw)
        if row is None:
            skipped += 1
            continue
        rows.append(row)

    print(f"Transformed {len(rows)} wells ({skipped} skipped — missing lat/lon).")

    if not rows:
        print("No rows to upsert. Exiting.")
        return

    # Connect to Supabase with service role key (bypasses RLS)
    client = create_client(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY)

    # Upsert in batches of 50
    batch_size = 50
    total_upserted = 0
    for i in range(0, len(rows), batch_size):
        batch = rows[i : i + batch_size]
        result = (
            client.table("wells")
            .upsert(batch, on_conflict="well_id")
            .execute()
        )
        total_upserted += len(batch)
        print(f"  Upserted batch {i // batch_size + 1}: {len(batch)} rows")

    print(f"Done. {total_upserted} wells upserted into Supabase.")


if __name__ == "__main__":
    main()
