INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100010608013W502', '100/01-06-080-13W5/02', 'WOODCOTE OIL HZ DAWSON 1-6-80-13',
  55.897111, -115.9820529,
  'Clearwater', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  12.3,
  6072, 6317.2998046875,
  '2022-09-04', '2025-12-01',
  0.9841, 4,
  ARRAY[742,663,744,714,744,712,744,737,720,744,694,663]::int[],
  ARRAY[25.8000,21.0000,19.4000,17.1000,17.1000,17.7000,15.7000,14.4000,13.2000,13.9000,13.4000,13.8000]::numeric[],
  ARRAY[0.9973,0.9866,1,0.9917,1,0.9889,1,0.9906,1,1,0.9639,0.8911]::numeric[],
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
  '105163208115W509', '105/16-32-081-15W5/09', 'OBE 105 HZ DAWSON 16-32-81-15',
  56.0707828, -116.3262371,
  'Bluesky', 'DAWSON',
  'Pumping', 'HIGH', 12,
  62.8,
  28622, 17865.30078125,
  '2022-08-30', '2025-12-01',
  0.9782, 8,
  ARRAY[744,672,734,717,732,706,713,726,686,729,720,690]::int[],
  ARRAY[72.4000,74.2000,91.9000,100.5000,105.5000,91.6000,63.2000,68.3000,73.2000,76.4000,75.9000,67.7000]::numeric[],
  ARRAY[1,1,0.9866,0.9958,0.9839,0.9806,0.9583,0.9758,0.9528,0.9798,1,0.9274]::numeric[],
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
  '106080508215W509', '106/08-05-082-15W5/09', 'OBE HZ SEAL 8-5-82-15',
  56.0812898, -116.3288869,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  67.1,
  19995, 10286.2001953125,
  '2022-09-14', '2025-12-01',
  0.984, 6,
  ARRAY[720,672,734,717,720,706,698,741,716,732,720,744]::int[],
  ARRAY[57.0000,57.1000,54.3000,55.8000,58.6000,54.2000,51.8000,55.9000,53.6000,53.8000,48.4000,67.1000]::numeric[],
  ARRAY[0.9677,1,0.9866,0.9958,0.9677,0.9806,0.9382,0.996,0.9944,0.9839,1,1]::numeric[],
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
  '106010808215W505', '106/01-08-082-15W5/05', 'OBE 106 HZ SEAL 1-8-82-15',
  56.0882138, -116.3240667,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  57.2,
  23600, 13534.5,
  '2022-10-15', '2025-12-01',
  0.9825, 6,
  ARRAY[719,672,734,717,744,706,696,741,720,742,720,696]::int[],
  ARRAY[55.8000,55.8000,38.2000,54.3000,63.8000,85.3000,80.2000,87.2000,76.4000,63.3000,68.2000,61.1000]::numeric[],
  ARRAY[0.9664,1,0.9866,0.9958,1,0.9806,0.9355,0.996,1,0.9973,1,0.9355]::numeric[],
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
  '108160508215W506', '108/16-05-082-15W5/06', 'OBE 108 HZ SEAL 16-5-82-15',
  56.0881238, -116.3240727,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  44.3,
  18752, 12737.599609375,
  '2022-10-15', '2025-12-01',
  0.9832, 6,
  ARRAY[719,672,734,717,744,706,702,741,720,742,720,696]::int[],
  ARRAY[54.5000,52.0000,49.5000,50.9000,53.4000,59.0000,55.8000,55.9000,55.4000,58.3000,34.9000,47.3000]::numeric[],
  ARRAY[0.9664,1,0.9866,0.9958,1,0.9806,0.9435,0.996,1,0.9973,1,0.9355]::numeric[],
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
