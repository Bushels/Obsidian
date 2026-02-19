INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '102082708218W509', '102/08-27-082-18W5/09', 'OBE HZ 102 WALRUS 8-27-82-18',
  56.1358553, -116.7467693,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  65.7,
  45754, 24243.599609375,
  '2024-03-29', '2025-12-01',
  0.9894, 3,
  ARRAY[738,670,744,720,670,717,744,740,716,744,720,744]::int[],
  ARRAY[231.0000,206.9000,208.2000,168.8000,131.2000,91.8000,90.5000,88.1000,76.6000,77.1000,90.5000,65.7000]::numeric[],
  ARRAY[0.9919,0.997,1,1,0.9005,0.9958,1,0.9946,0.9944,1,1,1]::numeric[],
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
  '103012708218W509', '103/01-27-082-18W5/09', 'OBE HZ WALRUS 1-27-82-18',
  56.1358553, -116.7464473,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  64.4,
  48127, 23344,
  '2024-03-29', '2025-12-01',
  0.9914, 3,
  ARRAY[743,670,744,720,744,717,683,740,716,744,720,744]::int[],
  ARRAY[234.9000,227.7000,199.5000,156.5000,152.0000,131.1000,71.1000,86.2000,95.5000,93.7000,85.1000,64.4000]::numeric[],
  ARRAY[0.9987,0.997,1,1,1,0.9958,0.918,0.9946,0.9944,1,1,1]::numeric[],
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
  '102153008216W509', '102/15-30-082-16W5/09', 'OBE HZ SEAL 15-30-82-16',
  56.127769, -116.4892232,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  43.5,
  18417, 4773.60009765625,
  '2024-04-23', '2025-12-01',
  0.9984, 1,
  ARRAY[732,672,744,720,744,720,744,742,720,744,720,744]::int[],
  ARRAY[56.2000,52.5000,48.9000,57.4000,47.1000,57.7000,51.0000,48.8000,53.8000,42.9000,47.4000,43.5000]::numeric[],
  ARRAY[0.9839,1,1,1,1,1,1,0.9973,1,1,1,1]::numeric[],
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
  '100163008216W509', '100/16-30-082-16W5/09', 'OBE HZ SEAL 16-30-82-16',
  56.127769, -116.4889012,
  'Bluesky', 'SEAL',
  'Pumping', 'DOWN NOW', NULL,
  0,
  11, 1114.099975585938,
  '2024-04-23', '2025-09-01',
  0.0274, 355,
  ARRAY[240,0,0,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[1.1000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0.3226,0,0,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '100101808216W509', '100/10-18-082-16W5/09', 'OBE HZ SEAL 10-18-82-16',
  56.127409, -116.4892232,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  26.1,
  18682, 8734.900390625,
  '2024-04-23', '2025-12-01',
  0.9879, 4,
  ARRAY[744,672,744,720,744,720,744,742,720,744,616,744]::int[],
  ARRAY[114.1000,92.0000,77.6000,40.0000,39.8000,32.1000,42.9000,41.2000,45.8000,42.5000,25.7000,26.1000]::numeric[],
  ARRAY[1,1,1,1,1,1,1,0.9973,1,1,0.8556,1]::numeric[],
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
