INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '102062408218W509', '102/06-24-082-18W5/09', 'PENN WEST 102 HZ HARMONV 6-24-82-18',
  56.1118232, -116.68327,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'HIGH', 12,
  43.3,
  18219, 69077.296875,
  '2016-10-18', '2025-12-01',
  0.987, 4,
  ARRAY[744,645,729,720,744,720,710,712,720,744,714,744]::int[],
  ARRAY[55.1000,55.8000,53.2000,51.8000,53.0000,54.4000,53.5000,53.1000,48.1000,44.5000,41.9000,43.3000]::numeric[],
  ARRAY[1,0.9598,0.9798,1,1,1,0.9543,0.957,1,1,0.9917,1]::numeric[],
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
  '100162908318W509', '100/16-29-083-18W5/09', 'PENN WEST PEACE RIVER 16-29-83-18',
  56.229207, -116.7673236,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  16.1,
  4753, 8886.099609375,
  '2017-03-25', '2025-12-01',
  0.9735, 9,
  ARRAY[744,658,744,709,744,720,665,616,720,744,720,744]::int[],
  ARRAY[15.3000,15.8000,14.4000,15.2000,14.9000,13.4000,5.5000,5.6000,9.8000,14.9000,17.7000,16.1000]::numeric[],
  ARRAY[1,0.9792,1,0.9847,1,1,0.8938,0.828,1,1,1,1]::numeric[],
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
  '103133408318W509', '103/13-34-083-18W5/09', 'PENN WEST PEACE RIVER 13-34-83-18',
  56.229207, -116.7669206,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  13.1,
  4523, 8434.7998046875,
  '2017-04-10', '2025-12-01',
  0.9963, 2,
  ARRAY[744,652,732,720,744,720,744,744,720,744,720,744]::int[],
  ARRAY[17.1000,14.7000,14.8000,19.2000,17.4000,10.2000,12.1000,6.4000,4.5000,5.9000,14.1000,13.1000]::numeric[],
  ARRAY[1,0.9702,0.9839,1,1,1,1,1,1,1,1,1]::numeric[],
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
  '100092908318W509', '100/09-29-083-18W5/09', 'PENN WEST PEACE RIVER 9-29-83-18',
  56.229207, -116.7665186,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'WATCH', 11,
  9.2,
  4779, 3912.199951171875,
  '2017-05-04', '2025-12-01',
  0.9202, 30,
  ARRAY[115,658,744,720,706,720,744,726,720,744,720,744]::int[],
  ARRAY[57.6000,25.8000,25.3000,13.4000,16.5000,16.3000,11.7000,7.5000,7.5000,7.2000,10.5000,9.2000]::numeric[],
  ARRAY[0.1546,0.9792,1,1,0.9489,1,1,0.9758,1,1,1,1]::numeric[],
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
  '100022008318W509', '100/02-20-083-18W5/09', 'PENN WEST PEACE RIVER 2-20-83-18',
  56.21786, -116.8095383,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  13.8,
  5628, 13639.7001953125,
  '2017-04-28', '2025-12-01',
  0.8999, 37,
  ARRAY[744,672,622,491,453,586,744,715,720,720,720,696]::int[],
  ARRAY[15.4000,15.1000,18.2000,22.0000,24.9000,19.6000,16.5000,17.1000,15.4000,15.3000,16.3000,14.7000]::numeric[],
  ARRAY[1,1,0.836,0.6819,0.6089,0.8139,1,0.961,1,0.9677,1,0.9355]::numeric[],
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
