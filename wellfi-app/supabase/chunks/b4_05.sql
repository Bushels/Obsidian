INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100091808216W509', '100/09-18-082-16W5/09', 'OBE HZ SEAL 9-18-82-16',
  56.127409, -116.4889012,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  25.8,
  8613, 4094.300048828125,
  '2024-04-23', '2025-12-01',
  0.9674, 12,
  ARRAY[500,656,738,720,744,704,742,742,720,744,720,744]::int[],
  ARRAY[57.1000,50.4000,32.1000,13.9000,15.6000,12.9000,14.5000,13.9000,21.0000,24.3000,23.8000,25.8000]::numeric[],
  ARRAY[0.672,0.9762,0.9919,1,1,0.9778,0.9973,0.9973,1,1,1,1]::numeric[],
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
  '103153008216W509', '103/15-30-082-16W5/09', 'OBE HZ SEAL 15-30-82-16',
  56.127589, -116.4892222,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  77.2,
  35090, 11735.900390625,
  '2024-04-23', '2025-12-01',
  0.9973, 1,
  ARRAY[730,672,736,720,744,720,744,742,720,744,720,744]::int[],
  ARRAY[98.5000,107.2000,98.3000,98.5000,101.8000,110.3000,106.8000,102.3000,81.5000,91.9000,83.4000,77.2000]::numeric[],
  ARRAY[0.9812,1,0.9892,1,1,1,1,0.9973,1,1,1,1]::numeric[],
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
  '102163008216W509', '102/16-30-082-16W5/09', 'OBE 102 SEAL 16-30-82-16',
  56.127589, -116.4889012,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  58,
  15735, 5460.39990234375,
  '2024-04-23', '2025-12-01',
  0.9995, NULL,
  ARRAY[744,670,744,720,744,720,744,742,720,744,720,744]::int[],
  ARRAY[41.1000,38.1000,45.9000,52.7000,40.6000,37.5000,40.8000,35.0000,36.3000,55.2000,35.5000,58.0000]::numeric[],
  ARRAY[1,0.997,1,1,1,1,1,0.9973,1,1,1,1]::numeric[],
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
  '100131908317W509', '100/13-19-083-17W5/09', 'OBE 100 HZ 13-19-83-17',
  56.20058, -116.6837623,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'LOW', 9,
  72.3,
  26634, 4234.39990234375,
  '2025-04-14', '2025-12-01',
  0.7162, 104,
  ARRAY[0,0,0,408,744,720,742,744,720,732,720,744]::int[],
  ARRAY[NULL,NULL,NULL,155.6000,133.9000,115.9000,139.3000,96.8000,94.8000,69.9000,61.3000,72.3000]::numeric[],
  ARRAY[0,0,0,0.5667,1,1,0.9973,1,1,0.9839,1,1]::numeric[],
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
  '102141908317W509', '102/14-19-083-17W5/09', 'OBE 102 HZ 14-19-83-17',
  56.200581, -116.6834403,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'LOW', 9,
  78.2,
  34389, 5467.39990234375,
  '2025-04-14', '2025-12-01',
  0.7067, 106,
  ARRAY[0,0,0,408,744,711,742,686,696,740,720,744]::int[],
  ARRAY[NULL,NULL,NULL,91.5000,242.5000,145.1000,147.6000,244.9000,94.2000,77.1000,64.0000,78.2000]::numeric[],
  ARRAY[0,0,0,0.5667,1,0.9875,0.9973,0.922,0.9667,0.9946,1,1]::numeric[],
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
