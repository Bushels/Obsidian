INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100053108318W509', '100/05-31-083-18W5/09', 'PENN WEST 5-31-83-18',
  56.23701, -116.8200661,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  18.2,
  7594, 48540.1015625,
  '2014-11-08', '2025-12-01',
  0.9968, 1,
  ARRAY[730,672,743,718,743,713,744,744,717,744,720,744]::int[],
  ARRAY[22.4000,23.7000,23.7000,24.4000,24.2000,23.7000,20.7000,19.5000,17.4000,16.6000,16.5000,18.2000]::numeric[],
  ARRAY[0.9812,1,0.9987,0.9972,0.9987,0.9903,1,1,0.9958,1,1,1]::numeric[],
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
  '102143008318W509', '102/14-30-083-18W5/09', 'PENN WEST 102 HZ SEAL HA 14-30-83-18',
  56.21793, -116.8359296,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  14.7,
  6115, 45616.80078125,
  '2015-01-20', '2025-12-01',
  1, NULL,
  ARRAY[744,672,744,720,744,720,744,744,720,744,720,744]::int[],
  ARRAY[26.8000,19.7000,18.9000,22.2000,27.2000,26.6000,8.5000,8.4000,5.5000,6.8000,16.1000,14.7000]::numeric[],
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
  '100041908318W509', '100/04-19-083-18W5/09', 'PENN WEST HZ SEAL HARMON  4-19-83-18',
  56.21793, -116.8360906,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  33,
  6194, 29121.69921875,
  '2015-01-17', '2025-12-01',
  0.911, 33,
  ARRAY[744,672,636,462,500,572,744,744,720,732,720,734]::int[],
  ARRAY[23.6000,20.1000,22.6000,26.6000,27.8000,16.2000,8.8000,8.6000,7.6000,10.5000,23.9000,33.4000]::numeric[],
  ARRAY[1,1,0.8548,0.6417,0.672,0.7944,1,1,1,0.9839,1,0.9866]::numeric[],
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
  '103143008318W509', '103/14-30-083-18W5/09', 'PENN WEST HZ SEAL HARMON 14-30-83-18',
  56.217929, -116.8362516,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'RECENTLY CHANGED', 7,
  1.3,
  3717, 25941.599609375,
  '2015-01-16', '2025-12-01',
  0.7725, 82,
  ARRAY[744,648,448,86,98,399,744,696,720,744,720,720]::int[],
  ARRAY[8.1000,6.5000,13.3000,62.8000,77.5000,24.0000,14.9000,14.1000,11.7000,16.0000,11.5000,1.3000]::numeric[],
  ARRAY[1,0.9643,0.6022,0.1194,0.1317,0.5542,1,0.9355,1,1,1,0.9677]::numeric[],
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
  '100163108318W509', '100/16-31-083-18W5/09', 'PENN WEST HZ 16-31-83-18',
  56.233614, -116.8187841,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  25,
  5342, 24878,
  '2015-03-26', '2025-12-01',
  0.9889, 4,
  ARRAY[744,672,744,719,726,718,744,740,720,672,720,744]::int[],
  ARRAY[16.9000,17.9000,17.2000,14.4000,11.4000,6.7000,4.5000,4.9000,11.4000,20.4000,27.7000,25.0000]::numeric[],
  ARRAY[1,1,1,0.9986,0.9758,0.9972,1,0.9946,1,0.9032,1,1]::numeric[],
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
