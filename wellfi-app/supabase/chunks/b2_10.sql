INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100011908318W509', '100/01-19-083-18W5/09', 'PENN WEST HZ PEACE RIVER 1-19-83-18',
  56.218017, -116.8299975,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  3.2,
  3900, 22898,
  '2016-09-10', '2025-12-01',
  0.9911, 2,
  ARRAY[744,672,739,714,728,685,744,734,714,744,720,744]::int[],
  ARRAY[17.5000,13.0000,14.2000,17.5000,15.8000,9.0000,7.8000,10.0000,10.9000,6.1000,4.7000,3.2000]::numeric[],
  ARRAY[1,1,0.9933,0.9917,0.9785,0.9514,1,0.9866,0.9917,1,1,1]::numeric[],
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
  '102021908318W509', '102/02-19-083-18W5/09', 'PENN WEST HZ PEACE RIVER 2-19-83-18',
  56.218016, -116.8304005,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  9.5,
  2840, 23763.5,
  '2016-09-25', '2025-12-01',
  0.9957, 2,
  ARRAY[744,648,744,720,744,706,744,744,720,744,720,744]::int[],
  ARRAY[10.6000,10.7000,11.7000,10.8000,10.2000,7.9000,1.1000,3.3000,3.4000,4.5000,10.5000,9.5000]::numeric[],
  ARRAY[1,0.9643,1,1,1,0.9806,1,1,1,1,1,1]::numeric[],
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
  '100081908217W509', '100/08-19-082-17W5/09', 'PENN WEST HZ WALRUS 8-19-82-17',
  56.1134812, -116.6676558,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'HIGH', 12,
  6.4,
  5407, 14619.099609375,
  '2016-12-23', '2025-12-01',
  0.9997, NULL,
  ARRAY[744,672,744,720,741,720,744,744,720,744,720,744]::int[],
  ARRAY[33.6000,32.0000,33.4000,27.5000,10.1000,4.8000,5.1000,5.2000,6.7000,7.4000,6.8000,6.4000]::numeric[],
  ARRAY[1,1,1,1,0.996,1,1,1,1,1,1,1]::numeric[],
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
  '100011308218W509', '100/01-13-082-18W5/09', 'PENN WEST HZ HARMONV 1-13-82-18',
  56.1134812, -116.6680568,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'HIGH', 12,
  6.1,
  3038, 12639.900390625,
  '2016-12-15', '2025-12-01',
  0.9993, NULL,
  ARRAY[744,672,744,720,741,720,744,741,720,744,720,744]::int[],
  ARRAY[11.2000,13.3000,13.0000,8.8000,8.4000,6.9000,6.6000,6.2000,4.7000,7.8000,7.4000,6.1000]::numeric[],
  ARRAY[1,1,1,1,0.996,1,1,0.996,1,1,1,1]::numeric[],
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
  '102011308218W509', '102/01-13-082-18W5/09', 'PENN WEST 102 HZ HARMONV 1-13-82-18',
  56.1134812, -116.6688598,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'HIGH', 12,
  3.8,
  4900, 22707.80078125,
  '2016-12-14', '2025-12-01',
  0.9942, 2,
  ARRAY[744,672,725,720,741,696,744,744,720,739,720,744]::int[],
  ARRAY[15.9000,16.2000,19.3000,22.1000,13.0000,16.9000,20.5000,10.4000,9.5000,9.8000,5.2000,3.8000]::numeric[],
  ARRAY[1,1,0.9745,1,0.996,0.9667,1,1,1,0.9933,1,1]::numeric[],
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
