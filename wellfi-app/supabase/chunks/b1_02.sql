INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100010808215W500', '100/01-08-082-15W5/00', 'PENN WEST SEAL 1-8-82-15',
  56.0880898, -116.3244048,
  'Bluesky', 'SEAL',
  'Pumping', 'LOW', NULL,
  0,
  NULL, 16719.400390625,
  '2006-07-16', '2024-12-01',
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
  '103160808215W500', '103/16-08-082-15W5/00', 'PENN WEST 103 SEAL 16-8-82-15',
  56.0989337, -116.3215535,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  8.7,
  3295, 11979.7001953125,
  '2006-08-21', '2025-12-01',
  0.8963, 38,
  ARRAY[356,660,734,708,600,625,665,720,644,742,720,678]::int[],
  ARRAY[12.6000,9.5000,8.6000,7.8000,8.1000,8.6000,8.2000,9.4000,15.0000,14.9000,9.5000,9.6000]::numeric[],
  ARRAY[0.4785,0.9821,0.9866,0.9833,0.8065,0.8681,0.8938,0.9677,0.8944,0.9973,1,0.9113]::numeric[],
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
  '103090508215W500', '103/09-05-082-15W5/00', 'PENN WEST 103 SEAL 9-5-82-15',
  56.0817708, -116.3256049,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  15.5,
  3586, 22069.900390625,
  '2006-10-02', '2025-12-01',
  0.9803, 9,
  ARRAY[744,660,734,717,732,706,698,741,683,708,720,744]::int[],
  ARRAY[9.5000,9.5000,9.0000,9.3000,9.8000,9.0000,8.6000,9.3000,9.0000,8.9000,12.5000,15.5000]::numeric[],
  ARRAY[1,0.9821,0.9866,0.9958,0.9839,0.9806,0.9382,0.996,0.9486,0.9516,1,1]::numeric[],
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
  '100152408419W500', '100/15-24-084-19W5/00', 'PENN WEST PEACE RIVER 15-24-84-19',
  56.2886668, -116.8523369,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  1.5,
  2398, 24312.30078125,
  '2006-05-28', '2025-12-01',
  0.9726, 10,
  ARRAY[744,672,744,720,744,720,744,744,720,744,720,504]::int[],
  ARRAY[7.5000,5.8000,7.3000,6.9000,6.7000,7.3000,7.3000,7.3000,7.3000,6.8000,7.2000,2.3000]::numeric[],
  ARRAY[1,1,1,1,1,1,1,1,1,1,1,0.6774]::numeric[],
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
  '100162408419W500', '100/16-24-084-19W5/00', 'PENN WEST PEACE RIVER 16-24-84-19',
  56.2886668, -116.8518529,
  'Bluesky', 'UNDEFINED',
  'Operating', 'DOWN NOW', NULL,
  0,
  1049, 16685.30078125,
  '2006-05-28', '2025-07-01',
  0.5507, 164,
  ARRAY[744,672,744,720,744,720,480,0,0,0,0,0]::int[],
  ARRAY[4.5000,5.7000,5.5000,5.6000,4.7000,5.3000,5.4000,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[1,1,1,1,1,1,0.6452,0,0,0,0,0]::numeric[],
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
