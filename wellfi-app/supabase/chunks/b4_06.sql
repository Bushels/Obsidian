INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100151908317W509', '100/15-19-083-17W5/09', 'OBE 100 HZ 15-19-83-17',
  56.200401, -116.6834383,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  113.8,
  62143, 17413.30078125,
  '2024-08-23', '2025-12-01',
  0.9764, 8,
  ARRAY[744,624,694,716,744,624,742,744,720,744,713,744]::int[],
  ARRAY[292.8000,239.1000,302.4000,243.8000,183.9000,139.4000,93.1000,105.3000,140.3000,126.2000,125.0000,113.8000]::numeric[],
  ARRAY[1,0.9286,0.9328,0.9944,1,0.8667,0.9973,1,1,1,0.9903,1]::numeric[],
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
  '100131708317W509', '100/13-17-083-17W5/09', 'OBE 100 HZ 13-17-83-17',
  56.185457, -116.6593543,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'LOW', 9,
  164.4,
  56240, 8941.5,
  '2025-04-14', '2025-12-01',
  0.6995, 110,
  ARRAY[0,0,0,404,744,718,744,744,583,740,707,744]::int[],
  ARRAY[NULL,NULL,NULL,326.4000,283.5000,303.4000,240.8000,168.8000,190.1000,169.5000,177.9000,164.4000]::numeric[],
  ARRAY[0,0,0,0.5611,1,0.9972,1,1,0.8097,0.9946,0.9819,1]::numeric[],
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
  '100141708317W509', '100/14-17-083-17W5/09', 'OBE 100 HZ 14-17-83-17',
  56.185277, -116.6593533,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  158.3,
  65082, 17346.599609375,
  '2024-08-03', '2025-12-01',
  0.9737, 9,
  ARRAY[624,672,742,716,744,715,744,744,720,744,621,744]::int[],
  ARRAY[222.9000,221.8000,220.4000,197.0000,239.1000,157.4000,154.5000,168.3000,161.6000,152.7000,146.6000,158.3000]::numeric[],
  ARRAY[0.8387,1,0.9973,0.9944,1,0.9931,1,1,1,1,0.8625,1]::numeric[],
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
  '100132908216W509', '100/13-29-082-16W5/09', 'OBE 100 HZ SEAL 13-29-82-16',
  56.1219969, -116.4689893,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  121.8,
  43879, 10668.900390625,
  '2024-08-04', '2025-12-01',
  0.9588, 15,
  ARRAY[740,672,736,720,596,609,707,735,718,744,716,706]::int[],
  ARRAY[116.8000,152.5000,122.6000,96.8000,150.6000,129.4000,132.6000,114.4000,116.0000,118.1000,134.0000,128.4000]::numeric[],
  ARRAY[0.9946,1,0.9892,1,0.8011,0.8458,0.9503,0.9879,0.9972,1,0.9944,0.9489]::numeric[],
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
  '100021608216W509', '100/02-16-082-16W5/09', 'OBE 100 HZ SEAL 2-16-82-16',
  56.1197909, -116.4403563,
  'Bluesky', 'SEAL',
  'Pumping', 'RECENTLY CHANGED', 9,
  62.4,
  16823, 4626.2001953125,
  '2024-08-26', '2025-12-01',
  0.758, 88,
  ARRAY[625,0,0,279,605,720,744,744,720,744,720,739]::int[],
  ARRAY[101.9000,NULL,NULL,40.0000,111.6000,71.2000,52.1000,42.6000,47.5000,38.2000,42.6000,62.8000]::numeric[],
  ARRAY[0.8401,0,0,0.3875,0.8132,1,1,1,1,1,1,0.9933]::numeric[],
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
