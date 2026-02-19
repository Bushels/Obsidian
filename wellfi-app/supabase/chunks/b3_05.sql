INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100130508317W509', '100/13-05-083-17W5/09', 'OBE 103 HZ 13-5-83-17',
  56.1730361, -116.6760848,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  34.9,
  12980, 59402.1015625,
  '2018-02-20', '2025-12-01',
  0.9942, 2,
  ARRAY[744,672,744,720,744,689,744,744,720,744,700,744]::int[],
  ARRAY[56.1000,54.7000,44.8000,41.7000,39.9000,22.2000,21.7000,23.5000,30.3000,28.5000,31.3000,34.9000]::numeric[],
  ARRAY[1,1,1,1,1,0.9569,1,1,1,1,0.9722,1]::numeric[],
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
  '103113608218W509', '103/11-36-082-18W5/09', 'PENN WEST 103 HZ WALRUS 11-36-82-18',
  56.1730361, -116.6768898,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  75,
  32619, 91092.4921875,
  '2018-03-23', '2025-12-01',
  0.9949, 2,
  ARRAY[744,672,743,720,744,720,725,729,720,744,710,744]::int[],
  ARRAY[91.4000,105.3000,93.0000,92.6000,87.2000,89.8000,94.1000,90.4000,92.2000,89.3000,79.1000,75.0000]::numeric[],
  ARRAY[1,1,0.9987,1,1,1,0.9745,0.9798,1,1,0.9861,1]::numeric[],
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
  '102103608218W509', '102/10-36-082-18W5/09', 'PENN WEST 102 HZ 10-36-82-18',
  56.1730361, -116.6764868,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  51.1,
  19134, 61108.30078125,
  '2018-03-08', '2025-12-01',
  0.9989, NULL,
  ARRAY[744,672,744,719,742,715,742,744,720,744,720,744]::int[],
  ARRAY[66.2000,58.4000,47.4000,41.0000,47.6000,50.3000,57.2000,54.0000,50.4000,54.7000,51.5000,51.1000]::numeric[],
  ARRAY[1,1,1,0.9986,0.9973,0.9931,0.9973,1,1,1,1,1]::numeric[],
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
  '100040708317W509', '100/04-07-083-17W5/09', 'PENN WEST HZ WALRUS 4-7-83-17',
  56.1729731, -116.6604766,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  54.6,
  24460, 84717.296875,
  '2018-04-23', '2025-12-01',
  0.9999, NULL,
  ARRAY[744,672,743,720,744,720,744,744,720,744,720,744]::int[],
  ARRAY[70.9000,68.6000,74.8000,73.5000,70.8000,67.2000,74.0000,72.3000,66.1000,56.7000,54.6000,54.6000]::numeric[],
  ARRAY[1,1,0.9987,1,1,1,1,1,1,1,1,1]::numeric[],
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
  '103010508215W509', '103/01-05-082-15W5/09', 'OBE 103 HZ SEAL 1-5-82-15',
  56.0765788, -116.32664,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  22.6,
  9077, 19772.19921875,
  '2018-10-06', '2025-12-01',
  0.9124, 32,
  ARRAY[738,672,734,717,516,586,624,648,687,698,720,653]::int[],
  ARRAY[28.5000,28.5000,27.1000,27.9000,29.3000,27.1000,25.9000,28.0000,26.8000,26.9000,25.6000,25.8000]::numeric[],
  ARRAY[0.9919,1,0.9866,0.9958,0.6935,0.8139,0.8387,0.871,0.9542,0.9382,1,0.8777]::numeric[],
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
