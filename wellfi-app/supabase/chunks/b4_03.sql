INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '104160808215W509', '104/16-08-082-15W5/09', 'OBE 104 HZ SEAL 16-8-82-15',
  56.0986747, -116.3216115,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  39.5,
  21160, 9067.900390625,
  '2024-01-20', '2025-12-01',
  0.9336, 25,
  ARRAY[739,672,734,717,654,706,734,482,708,730,720,582]::int[],
  ARRAY[71.9000,71.0000,67.6000,69.5000,72.9000,67.4000,64.5000,65.3000,52.1000,43.1000,49.7000,50.4000]::numeric[],
  ARRAY[0.9933,1,0.9866,0.9958,0.879,0.9806,0.9866,0.6478,0.9833,0.9812,1,0.7823]::numeric[],
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
  '100040908012W500', '100/04-09-080-12W5/00', 'WOODCOTE OIL HZ SEAL 4-9-80-12',
  55.911469, -115.7990644,
  'Clearwater', 'SEAL',
  'Pumping', 'HIGH', 12,
  22.9,
  5682, 1985.199951171875,
  '2023-12-24', '2025-12-01',
  0.9817, 7,
  ARRAY[625,672,744,720,744,696,744,744,720,744,720,727]::int[],
  ARRAY[10.2000,13.0000,13.1000,13.9000,13.5000,11.5000,14.8000,13.7000,18.8000,18.2000,25.1000,23.5000]::numeric[],
  ARRAY[0.8401,1,1,1,1,0.9667,1,1,1,1,1,0.9772]::numeric[],
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
  '102143008216W509', '102/14-30-082-16W5/09', 'OBE 102 HZ SEAL 14-30-82-16',
  56.128116, -116.5007013,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  126.3,
  49412, 20847,
  '2023-11-20', '2025-12-01',
  0.9881, 3,
  ARRAY[734,641,722,712,722,716,744,744,720,744,713,744]::int[],
  ARRAY[155.7000,152.7000,147.7000,131.4000,130.3000,132.2000,138.1000,134.7000,131.1000,133.4000,132.3000,126.3000]::numeric[],
  ARRAY[0.9866,0.9539,0.9704,0.9889,0.9704,0.9944,1,1,1,1,0.9903,1]::numeric[],
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
  '100141808216W509', '100/14-18-082-16W5/09', 'OBE 100 HZ SEAL 14-18-82-16',
  56.128116, -116.5003793,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  18.4,
  9111, 7448.39990234375,
  '2023-11-20', '2025-12-01',
  0.975, 10,
  ARRAY[742,629,717,588,744,720,744,744,720,744,705,744]::int[],
  ARRAY[33.5000,21.7000,15.2000,27.1000,29.5000,24.6000,30.7000,26.3000,27.5000,27.3000,24.6000,18.4000]::numeric[],
  ARRAY[0.9973,0.936,0.9637,0.8167,1,1,1,1,1,1,0.9792,1]::numeric[],
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
  '100121808216W509', '100/12-18-082-16W5/09', 'OBE HZ SEAL 12-18-82-16',
  56.128296, -116.5000573,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  12.7,
  10274, 5051.7998046875,
  '2023-11-20', '2025-12-01',
  0.9546, 17,
  ARRAY[744,639,554,656,721,690,723,740,720,744,707,724]::int[],
  ARRAY[29.6000,29.1000,28.3000,32.4000,31.0000,28.3000,25.8000,28.2000,50.7000,38.3000,18.7000,13.1000]::numeric[],
  ARRAY[1,0.9509,0.7446,0.9111,0.9691,0.9583,0.9718,0.9946,1,1,0.9819,0.9731]::numeric[],
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
