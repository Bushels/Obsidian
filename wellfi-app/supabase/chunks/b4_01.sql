INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100120407815W502', '100/12-04-078-15W5/02', 'WOODCOTE OIL HZ PEAVINE 12-4-78-15',
  55.7330579, -116.2461723,
  'Clearwater', 'UNDEFINED',
  'Pumping', 'LOW', NULL,
  0,
  NULL, 870.5999755859375,
  '2023-01-24', '2024-02-01',
  NULL, NULL,
  NULL,
  NULL,
  NULL,
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
  '100011708317W509', '100/01-17-083-17W5/09', 'OBE SEAL HV SOUTH HZ 1-17-83-17',
  56.1726801, -116.6499034,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  35.4,
  14423, 7351.2998046875,
  '2023-02-18', '2025-12-01',
  0.9919, 3,
  ARRAY[744,663,738,704,728,711,742,743,720,744,708,744]::int[],
  ARRAY[47.6000,51.8000,38.7000,37.8000,47.5000,50.5000,49.2000,34.3000,29.0000,29.1000,28.1000,35.4000]::numeric[],
  ARRAY[1,0.9866,0.9919,0.9778,0.9785,0.9875,0.9973,0.9987,1,1,0.9833,1]::numeric[],
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
  '100143008216W509', '100/14-30-082-16W5/09', 'OBE HZ SEAL 14-30-82-16',
  56.128296, -116.5003793,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  61.4,
  20896, 12186.400390625,
  '2023-02-10', '2025-12-01',
  0.9934, 2,
  ARRAY[744,672,743,720,744,717,744,744,679,744,709,742]::int[],
  ARRAY[86.2000,62.6000,49.0000,53.3000,56.4000,61.8000,55.3000,51.0000,52.7000,52.2000,49.1000,61.5000]::numeric[],
  ARRAY[1,1,0.9987,1,1,0.9958,1,1,0.9431,1,0.9847,0.9973]::numeric[],
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
  '100121507815W500', '100/12-15-078-15W5/00', 'WOODCOTE OIL HZ PEAVINE 12-15-78-15',
  55.7627479, -116.2185468,
  'Clearwater', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  693, 658,
  '2023-03-01', '2025-03-01',
  0.0221, 357,
  ARRAY[0,0,194,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[NULL,NULL,85.7000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0,0,0.2608,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '102022008316W509', '102/02-20-083-16W5/09', 'OBE 102 HZ 2-20-83-16',
  56.2173679, -116.4848973,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'LOW', NULL,
  0,
  NULL, 316.2000122070312,
  '2023-01-31', '2025-12-01',
  NULL, NULL,
  NULL,
  NULL,
  NULL,
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
