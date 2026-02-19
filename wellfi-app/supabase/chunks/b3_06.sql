INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '104080508215W509', '104/08-05-082-15W5/09', 'OBE 104 HZ SEAL 8-5-82-15',
  56.0766688, -116.32664,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  23.1,
  8755, 9414.7001953125,
  '2018-10-06', '2025-12-01',
  0.9434, 21,
  ARRAY[738,672,734,717,516,706,674,660,701,713,720,713]::int[],
  ARRAY[26.6000,26.6000,25.4000,26.0000,27.4000,25.3000,24.2000,26.1000,25.0000,25.1000,23.9000,24.1000]::numeric[],
  ARRAY[0.9919,1,0.9866,0.9958,0.6935,0.9806,0.9059,0.8871,0.9736,0.9583,1,0.9583]::numeric[],
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
  '100060808215W508', '100/06-08-082-15W5/08', 'OBE HZ 104 SEAL 6-8-82-15',
  56.0919898, -116.3244757,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  9.4,
  3588, 18583.599609375,
  '2019-02-26', '2025-12-01',
  0.9892, 4,
  ARRAY[744,672,734,717,720,706,706,741,720,742,720,743]::int[],
  ARRAY[10.4000,10.4000,9.9000,10.2000,10.7000,9.9000,9.4000,10.2000,9.8000,9.8000,9.3000,9.4000]::numeric[],
  ARRAY[1,1,0.9866,0.9958,0.9677,0.9806,0.9489,0.996,1,0.9973,1,0.9987]::numeric[],
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
  '105090808215W507', '105/09-08-082-15W5/07', 'OBE HZ 105 SEAL 9-8-82-15',
  56.0919818, -116.3246367,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  37.2,
  12693, 21240.599609375,
  '2019-02-26', '2025-12-01',
  0.9935, 2,
  ARRAY[744,672,734,717,744,706,720,741,720,742,720,743]::int[],
  ARRAY[30.1000,30.1000,28.7000,29.5000,32.8000,39.1000,37.4000,40.4000,38.7000,38.9000,36.9000,37.3000]::numeric[],
  ARRAY[1,1,0.9866,0.9958,1,0.9806,0.9677,0.996,1,0.9973,1,0.9987]::numeric[],
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
  '103151908217W509', '103/15-19-082-17W5/09', 'OBE HZ WALRUS 15-19-82-17',
  56.1519661, -116.6522849,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  87.4,
  39114, 47262.3984375,
  '2021-12-28', '2025-12-01',
  0.9995, NULL,
  ARRAY[744,672,744,720,744,720,744,740,720,744,720,744]::int[],
  ARRAY[118.9000,135.8000,129.7000,88.1000,118.6000,110.2000,112.1000,106.9000,102.6000,87.0000,90.8000,87.4000]::numeric[],
  ARRAY[1,1,1,1,1,1,1,0.9946,1,1,1,1]::numeric[],
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
  '104141908217W509', '104/14-19-082-17W5/09', 'OBE HZ WALRUS 14-19-82-17',
  56.1518071, -116.6525719,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  58.6,
  28558, 36121.8984375,
  '2021-12-28', '2025-12-01',
  0.9965, 1,
  ARRAY[744,672,744,720,738,720,744,734,720,744,705,744]::int[],
  ARRAY[104.8000,98.3000,96.8000,89.1000,86.1000,76.2000,77.4000,69.0000,65.0000,60.4000,61.3000,58.6000]::numeric[],
  ARRAY[1,1,1,1,0.9919,1,1,0.9866,1,1,0.9792,1]::numeric[],
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
