INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100161508216W509', '100/16-15-082-16W5/09', 'OBE 100 HZ SEAL 16-15-82-16',
  56.1199709, -116.4406783,
  'Bluesky', 'SEAL',
  'Pumping', 'LOW', 8,
  270.9,
  71517, 11370.2998046875,
  '2025-04-19', '2025-12-01',
  0.6669, 121,
  ARRAY[0,0,0,0,710,720,744,744,720,744,720,740]::int[],
  ARRAY[NULL,NULL,NULL,NULL,379.1000,379.4000,298.8000,299.6000,261.5000,241.3000,221.6000,272.4000]::numeric[],
  ARRAY[0,0,0,0,0.9543,1,1,1,1,1,1,0.9946]::numeric[],
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
  '100131808317W509', '100/13-18-083-17W5/09', 'OBE 100 HZ SEAL HV SOUTH 13-18-83-17',
  56.186332, -116.6802246,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'LOW', 5,
  204.4,
  32818, 5217.7001953125,
  '2025-07-28', '2025-12-01',
  0.4045, 217,
  ARRAY[0,0,0,0,0,0,0,739,717,743,600,744]::int[],
  ARRAY[NULL,NULL,NULL,NULL,NULL,NULL,NULL,274.4000,230.5000,233.7000,156.6000,204.4000]::numeric[],
  ARRAY[0,0,0,0,0,0,0,0.9933,0.9958,0.9987,0.8333,1]::numeric[],
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
  '100141808317W509', '100/14-18-083-17W5/09', 'OBE 100 HZ SEAL HV SOUTH 14-18-83-17',
  56.186153, -116.6802266,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'LOW', 5,
  222,
  53339, 8480.2001953125,
  '2025-07-28', '2025-12-01',
  0.3968, 220,
  ARRAY[0,0,0,0,0,0,0,743,719,742,720,552]::int[],
  ARRAY[NULL,NULL,NULL,NULL,NULL,NULL,NULL,462.2000,450.3000,330.5000,281.3000,299.2000]::numeric[],
  ARRAY[0,0,0,0,0,0,0,0.9987,0.9986,0.9973,1,0.7419]::numeric[],
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
  '100021908317W509', '100/02-19-083-17W5/09', 'OBE 100 HZ SEAL HV SOUTH 2-19-83-17',
  56.186152, -116.6799046,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'RECENTLY CHANGED', 5,
  272,
  78009, 14190.599609375,
  '2025-05-03', '2025-12-01',
  0.5747, 155,
  ARRAY[0,0,0,0,663,720,96,722,701,672,720,740]::int[],
  ARRAY[NULL,NULL,NULL,NULL,451.1000,492.8000,366.2000,403.6000,341.2000,332.9000,314.5000,273.5000]::numeric[],
  ARRAY[0,0,0,0,0.8911,1,0.129,0.9704,0.9736,0.9032,1,0.9946]::numeric[],
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
  '102161808317W509', '102/16-18-083-17W5/09', 'OBE 102 HZ 16-18-83-17',
  56.185591, -116.6596773,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'LOW', 9,
  211.5,
  75081, 11937,
  '2025-04-14', '2025-12-01',
  0.704, 108,
  ARRAY[0,0,0,404,744,720,731,654,715,738,717,744]::int[],
  ARRAY[NULL,NULL,NULL,265.9000,408.8000,315.2000,286.0000,320.2000,341.5000,239.8000,232.1000,211.5000]::numeric[],
  ARRAY[0,0,0,0.5611,1,1,0.9825,0.879,0.9931,0.9919,0.9958,1]::numeric[],
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
