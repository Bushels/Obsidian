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
