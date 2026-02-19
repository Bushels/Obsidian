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

INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100031608216W509', '100/03-16-082-16W5/09', 'OBE 100 HZ SEAL 3-16-82-16',
  56.1197909, -116.4406783,
  'Bluesky', 'SEAL',
  'Pumping', 'LOW', 9,
  79.8,
  23322, 3707.89990234375,
  '2025-04-19', '2025-12-01',
  0.6997, 109,
  ARRAY[0,0,0,282,726,718,744,744,720,742,720,733]::int[],
  ARRAY[NULL,NULL,NULL,54.8000,185.2000,109.0000,72.3000,59.3000,76.4000,79.2000,84.1000,81.0000]::numeric[],
  ARRAY[0,0,0,0.3917,0.9758,0.9972,1,1,1,0.9973,1,0.9852]::numeric[],
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
  '102132208419W509', '102/13-22-084-19W5/09', 'OBE 102 HZ 13-22-84-19',
  56.2867787, -116.9230309,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  1486, 414,
  '2024-11-04', '2025-02-01',
  0.1108, 325,
  ARRAY[700,271,0,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[34.6000,42.2000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0.9409,0.4033,0,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '103132208419W509', '103/13-22-084-19W5/09', 'OBE 103 HZ 13-22-84-19',
  56.2869587, -116.9230309,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  61.5,
  32440, 6292.2998046875,
  '2024-11-04', '2025-12-01',
  0.9731, 9,
  ARRAY[568,652,744,697,735,720,744,744,720,744,712,744]::int[],
  ARRAY[154.2000,131.2000,136.4000,78.0000,90.8000,84.8000,88.0000,88.6000,71.6000,62.9000,65.0000,61.5000]::numeric[],
  ARRAY[0.7634,0.9702,1,0.9681,0.9879,1,1,1,1,1,0.9889,1]::numeric[],
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
  '102162108419W509', '102/16-21-084-19W5/09', 'OBE 102 HZ 16-21-84-19',
  56.2867787, -116.9233539,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  467, 74.19999694824219,
  '2024-11-04', '2025-02-01',
  0.0749, 337,
  ARRAY[39,617,0,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[5.4000,17.8000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0.0524,0.9182,0,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '100161208317W509', '100/16-12-083-17W5/09', 'OBE 100 HZ 16-12-83-17',
  56.171749, -116.5379514,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  386, 67.80000305175781,
  '2024-12-14', '2025-04-01',
  0.1177, 322,
  ARRAY[0,595,436,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[NULL,2.9000,17.3000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0,0.8854,0.586,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '100151208317W509', '100/15-12-083-17W5/09', 'OBE 100 HZ 15-12-83-17',
  56.17184, -116.5382294,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'RECENTLY CHANGED', 3,
  5.2,
  4461, 820.0999755859375,
  '2024-12-14', '2025-12-01',
  0.5805, 153,
  ARRAY[240,428,740,570,708,267,0,0,0,668,720,744]::int[],
  ARRAY[12.0000,36.0000,56.7000,45.9000,14.1000,8.7000,NULL,NULL,NULL,4.6000,1.9000,5.2000]::numeric[],
  ARRAY[0.3226,0.6369,0.9946,0.7917,0.9516,0.3708,0,0,0,0.8978,1,1]::numeric[],
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
  '100160608316W509', '100/16-06-083-16W5/09', 'OBE 100 HZ 16-6-83-16',
  56.171594, -116.5381154,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  54.7,
  12763, 2029.199951171875,
  '2025-01-09', '2025-12-01',
  0.9288, 25,
  ARRAY[529,644,572,716,576,716,739,744,692,744,720,744]::int[],
  ARRAY[57.6000,67.8000,6.8000,44.9000,8.0000,14.3000,11.5000,9.2000,9.2000,83.4000,78.9000,54.7000]::numeric[],
  ARRAY[0.711,0.9583,0.7688,0.9944,0.7742,0.9944,0.9933,1,0.9611,1,1,1]::numeric[],
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
  '100090608316W509', '100/09-06-083-16W5/09', 'OBE 100 HZ 9-6-83-16',
  56.171685, -116.5383924,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  62.9,
  36809, 5852.2001953125,
  '2025-01-09', '2025-12-01',
  0.9349, 23,
  ARRAY[428,495,740,720,708,716,742,744,694,739,720,744]::int[],
  ARRAY[115.2000,140.1000,191.1000,179.0000,102.0000,78.2000,100.7000,120.2000,96.0000,62.3000,59.2000,62.9000]::numeric[],
  ARRAY[0.5753,0.7366,0.9946,1,0.9516,0.9944,0.9973,1,0.9639,0.9933,1,1]::numeric[],
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
  '100082908218W509', '100/08-29-082-18W5/09', 'OBE SEAL 100 HZ 8-29-82-18',
  56.1360343, -116.7464473,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  137.3,
  75407, 13825.2998046875,
  '2024-10-16', '2025-12-01',
  0.9936, 2,
  ARRAY[730,648,740,715,744,717,742,740,720,744,720,744]::int[],
  ARRAY[216.3000,287.9000,264.7000,212.1000,205.4000,227.5000,231.9000,215.4000,203.0000,185.2000,117.0000,137.3000]::numeric[],
  ARRAY[0.9812,0.9643,0.9946,0.9931,1,0.9958,0.9973,0.9946,1,1,1,1]::numeric[],
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
  '100012908218W509', '100/01-29-082-18W5/09', 'OBE SEAL 100 HZ 1-29-82-18',
  56.1360343, -116.7467683,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  88.7,
  32215, 5878,
  '2024-10-16', '2025-12-01',
  0.9855, 5,
  ARRAY[730,640,744,720,744,717,744,666,720,744,720,744]::int[],
  ARRAY[54.8000,37.4000,45.8000,86.1000,125.7000,102.2000,106.1000,122.7000,110.1000,96.8000,95.2000,88.7000]::numeric[],
  ARRAY[0.9812,0.9524,1,1,1,0.9958,1,0.8952,1,1,1,1]::numeric[],
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
  '100083108319W509', '100/08-31-083-19W5/09', 'OBE 100 HZ HARMONV 8-31-83-19',
  56.2421073, -117.010627,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  504, 80.0999984741211,
  '2025-01-11', '2025-03-01',
  0.0909, 332,
  ARRAY[0,573,223,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[NULL,8.6000,32.2000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0,0.8527,0.2997,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '100093108319W509', '100/09-31-083-19W5/09', 'OBE 100 HZ HARMONV 9-31-83-19',
  56.2422683, -117.010482,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  1, 0.1000000014901161,
  '2024-12-18', '2025-02-01',
  0.0106, 361,
  ARRAY[93,0,0,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[0.2000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0.125,0,0,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '100103108319W509', '100/10-31-083-19W5/09', 'OBE 102 HZ 10-31-83-19',
  56.2423483, -117.010771,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'DOWN NOW', NULL,
  0,
  14, 2.200000047683716,
  '2024-12-18', '2025-03-01',
  0.0184, 358,
  ARRAY[0,157,4,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[NULL,2.0000,3.8000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0,0.2336,0.0054,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '102041108114W509', '102/04-11-081-14W5/09', 'OBE 102 HZ DAWSON 4-11-81-14',
  56.0160618, -116.087428,
  'Bluesky', 'DAWSON',
  'Pumping', 'WATCH', 10,
  164,
  50727, 8065,
  '2025-03-04', '2025-12-01',
  0.8147, 68,
  ARRAY[0,0,664,700,714,718,742,732,707,719,697,744]::int[],
  ARRAY[NULL,NULL,23.6000,263.7000,183.9000,135.8000,159.0000,263.8000,202.8000,144.9000,154.5000,164.0000]::numeric[],
  ARRAY[0,0,0.8925,0.9722,0.9597,0.9972,0.9973,0.9839,0.9819,0.9664,0.9681,1]::numeric[],
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
  '100011608114W509', '100/01-16-081-14W5/09', 'OBE 100 HZ DAWSON 1-16-81-14',
  56.0159279, -116.087461,
  'Bluesky', 'DAWSON',
  'Pumping', 'DOWN NOW', NULL,
  0,
  6151, 978,
  '2025-03-06', '2025-09-01',
  0.2877, 260,
  ARRAY[0,0,0,0,0,694,736,698,392,0,0,0]::int[],
  ARRAY[NULL,NULL,NULL,NULL,NULL,82.4000,61.2000,53.5000,20.6000,NULL,NULL,NULL]::numeric[],
  ARRAY[0,0,0,0,0,0.9639,0.9892,0.9382,0.5444,0,0,0]::numeric[],
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
  '100161808516W509', '100/16-18-085-16W5/09', 'OBE 100 HZ NAMPA 16-18-85-16',
  56.359242, -116.4988657,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  4.2,
  259, 41.20000076293945,
  '2025-01-31', '2025-12-01',
  0.0761, 337,
  ARRAY[0,0,480,0,0,0,0,0,0,0,0,187]::int[],
  ARRAY[NULL,NULL,6.4000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16.8000]::numeric[],
  ARRAY[0,0,0.6452,0,0,0,0,0,0,0,0,0.2513]::numeric[],
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
  '100081408117W509', '100/08-14-081-17W5/09', 'OBE 100 HZ DAWSON 8-14-81-17',
  56.0262552, -116.5675164,
  'Bluesky', 'DAWSON',
  'Pumping', 'DOWN NOW', NULL,
  0,
  1058, 168.1999969482422,
  '2025-02-05', '2025-12-01',
  0.1071, 326,
  ARRAY[0,442,496,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[NULL,2.0000,49.4000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0,0.6577,0.6667,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '100160808218W509', '100/16-08-082-18W5/09', 'OBE 100 HZ HARMONV 16-8-82-18',
  56.0991394, -116.7459458,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'DOWN NOW', NULL,
  0,
  2842, 451.8999938964844,
  '2025-03-31', '2025-10-01',
  0.3877, 223,
  ARRAY[0,0,0,701,614,0,0,733,720,628,0,0]::int[],
  ARRAY[NULL,NULL,NULL,29.6000,10.7000,NULL,NULL,20.3000,23.3000,14.7000,NULL,NULL]::numeric[],
  ARRAY[0,0,0,0.9736,0.8253,0,0,0.9852,1,0.8441,0,0]::numeric[],
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
  '100161008218W509', '100/16-10-082-18W5/09', 'OBE 100 HZ HARMONV 16-10-82-18',
  56.0991384, -116.7456238,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'LOW', 9,
  51.7,
  18263, 2903.60009765625,
  '2025-03-31', '2025-12-01',
  0.7385, 94,
  ARRAY[0,0,0,664,734,720,744,738,696,740,696,737]::int[],
  ARRAY[NULL,NULL,NULL,104.2000,97.3000,64.1000,36.8000,94.7000,68.0000,56.3000,38.6000,52.2000]::numeric[],
  ARRAY[0,0,0,0.9222,0.9866,1,1,0.9919,0.9667,0.9946,0.9667,0.9906]::numeric[],
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
  '100152608117W508', '100/15-26-081-17W5/08', 'OBE 100 HZ DAWSON 15-26-81-17',
  56.0524302, -116.567248,
  'Bluesky', 'DAWSON',
  'Pumping', 'DOWN NOW', NULL,
  0,
  561, 89.19999694824219,
  '2025-02-20', '2025-12-01',
  0.0745, 338,
  ARRAY[0,216,437,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[NULL,0.1000,30.7000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0,0.3214,0.5874,0,0,0,0,0,0,0,0,0]::numeric[],
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
