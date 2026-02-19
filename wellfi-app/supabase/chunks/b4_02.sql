INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100133008216W509', '100/13-30-082-16W5/09', 'OBE HZ SEAL 13-30-82-16',
  56.128296, -116.5007823,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  74.8,
  32297, 15068.2998046875,
  '2023-11-19', '2025-12-01',
  0.9955, 1,
  ARRAY[733,666,730,720,744,720,744,744,720,744,720,736]::int[],
  ARRAY[112.9000,109.0000,98.3000,75.2000,66.7000,101.4000,101.8000,86.4000,82.7000,78.6000,80.0000,75.6000]::numeric[],
  ARRAY[0.9852,0.9911,0.9812,1,1,1,1,1,1,1,1,0.9892]::numeric[],
  NULL
)
ON CONFLICT (well_id) DO UPDATE SET
  name = EXCLUDED.name, lat = EXCLUDED.lat, lon = EXCLUDED.lon,
  formation = EXCLUDED.formation, field = EXCLUDED.field,
  well_status = EXCLUDED.well_status, risk_level = EXCLUDED.risk_level,
  months_running = EXCLUDED.months_running, dec_rate_bbl_d = EXCLUDED.dec_rate_bbl_d,
  total_2025_bbl = EXCLUDED.total_2025_bbl, cumulative_oil = EXCLUDED.cumulative_oil,
  on_production_date = EXCLUDED.on_production_date, last_production_date = EXCLUDED.last_production_date,
  annual_uptime_pct = EXCLUDED.annual_uptime_pct, total_downtime_days = EXCLUDED.total_downtime_days,
  monthly_hrs = EXCLUDED.monthly_hrs, monthly_oil = EXCLUDED.monthly_oil,
  monthly_uptime = EXCLUDED.monthly_uptime, status_note = EXCLUDED.status_note,
  updated_at = now();

INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '1S0013008217W509', '1S0/01-30-082-17W5/09', 'OBE 100 HZ WALRUS 1-30-82-17',
  56.1483221, -116.6356347,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  19,
  16581, 12148.2998046875,
  '2023-04-24', '2025-12-01',
  0.9973, 1,
  ARRAY[744,672,744,720,744,720,744,744,720,744,720,720]::int[],
  ARRAY[70.5000,57.1000,56.2000,52.5000,52.0000,50.8000,49.3000,46.5000,41.5000,29.3000,21.0000,19.6000]::numeric[],
  ARRAY[1,1,1,1,1,1,1,1,1,1,1,0.9677]::numeric[],
  NULL
)
ON CONFLICT (well_id) DO UPDATE SET
  name = EXCLUDED.name, lat = EXCLUDED.lat, lon = EXCLUDED.lon,
  formation = EXCLUDED.formation, field = EXCLUDED.field,
  well_status = EXCLUDED.well_status, risk_level = EXCLUDED.risk_level,
  months_running = EXCLUDED.months_running, dec_rate_bbl_d = EXCLUDED.dec_rate_bbl_d,
  total_2025_bbl = EXCLUDED.total_2025_bbl, cumulative_oil = EXCLUDED.cumulative_oil,
  on_production_date = EXCLUDED.on_production_date, last_production_date = EXCLUDED.last_production_date,
  annual_uptime_pct = EXCLUDED.annual_uptime_pct, total_downtime_days = EXCLUDED.total_downtime_days,
  monthly_hrs = EXCLUDED.monthly_hrs, monthly_oil = EXCLUDED.monthly_oil,
  monthly_uptime = EXCLUDED.monthly_uptime, status_note = EXCLUDED.status_note,
  updated_at = now();

INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '1S0042908217W509', '1S0/04-29-082-17W5/09', 'OBE HZ WALRUS 4-29-82-17',
  56.1483221, -116.6352327,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  33.7,
  13909, 9272.2001953125,
  '2023-04-24', '2025-12-01',
  1, NULL,
  ARRAY[744,672,744,720,744,720,744,744,720,744,720,744]::int[],
  ARRAY[46.1000,44.6000,42.7000,41.5000,44.4000,36.8000,34.6000,35.1000,38.0000,27.2000,33.0000,33.7000]::numeric[],
  ARRAY[1,1,1,1,1,1,1,1,1,1,1,1]::numeric[],
  NULL
)
ON CONFLICT (well_id) DO UPDATE SET
  name = EXCLUDED.name, lat = EXCLUDED.lat, lon = EXCLUDED.lon,
  formation = EXCLUDED.formation, field = EXCLUDED.field,
  well_status = EXCLUDED.well_status, risk_level = EXCLUDED.risk_level,
  months_running = EXCLUDED.months_running, dec_rate_bbl_d = EXCLUDED.dec_rate_bbl_d,
  total_2025_bbl = EXCLUDED.total_2025_bbl, cumulative_oil = EXCLUDED.cumulative_oil,
  on_production_date = EXCLUDED.on_production_date, last_production_date = EXCLUDED.last_production_date,
  annual_uptime_pct = EXCLUDED.annual_uptime_pct, total_downtime_days = EXCLUDED.total_downtime_days,
  monthly_hrs = EXCLUDED.monthly_hrs, monthly_oil = EXCLUDED.monthly_oil,
  monthly_uptime = EXCLUDED.monthly_uptime, status_note = EXCLUDED.status_note,
  updated_at = now();

INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '1S0032908217W509', '1S0/03-29-082-17W5/09', 'OBE HZ WALRUS 3-29-82-17',
  56.1483221, -116.6348297,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  43.6,
  19590, 11214.7001953125,
  '2023-08-10', '2025-12-01',
  0.9994, NULL,
  ARRAY[744,672,744,718,742,719,744,744,720,744,720,744]::int[],
  ARRAY[69.6000,63.2000,58.2000,55.9000,56.5000,55.0000,52.1000,50.4000,52.7000,44.6000,43.3000,43.6000]::numeric[],
  ARRAY[1,1,1,0.9972,0.9973,0.9986,1,1,1,1,1,1]::numeric[],
  NULL
)
ON CONFLICT (well_id) DO UPDATE SET
  name = EXCLUDED.name, lat = EXCLUDED.lat, lon = EXCLUDED.lon,
  formation = EXCLUDED.formation, field = EXCLUDED.field,
  well_status = EXCLUDED.well_status, risk_level = EXCLUDED.risk_level,
  months_running = EXCLUDED.months_running, dec_rate_bbl_d = EXCLUDED.dec_rate_bbl_d,
  total_2025_bbl = EXCLUDED.total_2025_bbl, cumulative_oil = EXCLUDED.cumulative_oil,
  on_production_date = EXCLUDED.on_production_date, last_production_date = EXCLUDED.last_production_date,
  annual_uptime_pct = EXCLUDED.annual_uptime_pct, total_downtime_days = EXCLUDED.total_downtime_days,
  monthly_hrs = EXCLUDED.monthly_hrs, monthly_oil = EXCLUDED.monthly_oil,
  monthly_uptime = EXCLUDED.monthly_uptime, status_note = EXCLUDED.status_note,
  updated_at = now();

INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100101508013W500', '100/10-15-080-13W5/00', 'WOODCOTE OIL HZ SEAL 10-15-80-13',
  55.954113, -115.9423702,
  'Clearwater', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  3044, 3065.39990234375,
  '2023-01-28', '2025-03-01',
  0.0973, 330,
  ARRAY[0,516,336,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[NULL,86.0000,85.3000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0,0.7679,0.4516,0,0,0,0,0,0,0,0,0]::numeric[],
  NULL
)
ON CONFLICT (well_id) DO UPDATE SET
  name = EXCLUDED.name, lat = EXCLUDED.lat, lon = EXCLUDED.lon,
  formation = EXCLUDED.formation, field = EXCLUDED.field,
  well_status = EXCLUDED.well_status, risk_level = EXCLUDED.risk_level,
  months_running = EXCLUDED.months_running, dec_rate_bbl_d = EXCLUDED.dec_rate_bbl_d,
  total_2025_bbl = EXCLUDED.total_2025_bbl, cumulative_oil = EXCLUDED.cumulative_oil,
  on_production_date = EXCLUDED.on_production_date, last_production_date = EXCLUDED.last_production_date,
  annual_uptime_pct = EXCLUDED.annual_uptime_pct, total_downtime_days = EXCLUDED.total_downtime_days,
  monthly_hrs = EXCLUDED.monthly_hrs, monthly_oil = EXCLUDED.monthly_oil,
  monthly_uptime = EXCLUDED.monthly_uptime, status_note = EXCLUDED.status_note,
  updated_at = now();
