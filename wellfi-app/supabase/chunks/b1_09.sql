INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '105132408419W509', '105/13-24-084-19W5/09', 'PENN WEST 104 HZ PEACE R 13-24-84-19',
  56.2886717, -116.8713331,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  15.8,
  7110, 46227.1015625,
  '2012-12-23', '2025-12-01',
  0.9949, 2,
  ARRAY[719,655,741,720,744,720,744,744,720,744,720,744]::int[],
  ARRAY[20.1000,19.9000,20.7000,20.1000,21.0000,18.8000,19.6000,19.5000,19.7000,20.1000,19.6000,15.8000]::numeric[],
  ARRAY[0.9664,0.9747,0.996,1,1,1,1,1,1,1,1,1]::numeric[],
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
  '104162308419W508', '104/16-23-084-19W5/08', 'PENN WEST 104 PEACE RIVE 16-23-84-19',
  56.2886717, -116.8714941,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  16.7,
  6404, 33514.19921875,
  '2012-12-23', '2025-12-01',
  0.9759, 9,
  ARRAY[717,503,729,720,744,720,744,744,720,744,720,744]::int[],
  ARRAY[18.8000,7.1000,17.2000,16.0000,16.8000,17.1000,19.4000,18.8000,22.1000,21.3000,21.2000,16.7000]::numeric[],
  ARRAY[0.9637,0.7485,0.9798,1,1,1,1,1,1,1,1,1]::numeric[],
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
  '105142408419W509', '105/14-24-084-19W5/09', 'PENN WEST 105 HZ PEACE R 14-24-84-19',
  56.2886687, -116.862119,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  12.9,
  6203, 32407.69921875,
  '2012-11-28', '2025-12-01',
  0.9742, 9,
  ARRAY[739,643,744,720,744,720,744,744,720,744,720,552]::int[],
  ARRAY[17.3000,17.2000,18.1000,17.8000,18.2000,17.6000,18.0000,12.9000,18.6000,17.4000,19.0000,17.4000]::numeric[],
  ARRAY[0.9933,0.9568,1,1,1,1,1,1,1,1,1,0.7419]::numeric[],
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
  '106042508419W508', '106/04-25-084-19W5/08', 'PENN WEST 106 PEACE RIVER 4-25-84-19',
  56.3071167, -116.8449136,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  22.5,
  7055, 31722,
  '2013-02-11', '2025-12-01',
  0.9817, 7,
  ARRAY[744,672,619,702,728,719,744,744,720,744,720,744]::int[],
  ARRAY[18.3000,21.2000,22.4000,17.8000,14.7000,16.5000,22.1000,20.8000,19.0000,20.8000,20.6000,22.5000]::numeric[],
  ARRAY[1,1,0.832,0.975,0.9785,0.9986,1,1,1,1,1,1]::numeric[],
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
  '100082708218W509', '100/08-27-082-18W5/09', 'OBE REENTRY HZ WALR 8-27-82-18',
  56.1453652, -116.7225968,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'LOW', NULL,
  0,
  NULL, 7301.60009765625,
  '2017-08-29', '2024-11-01',
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
