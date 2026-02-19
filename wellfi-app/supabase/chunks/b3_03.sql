INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100151908318W509', '100/15-19-083-18W5/09', 'PENN WEST PEACE RIVER 15-19-83-18',
  56.217858, -116.8091363,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'RECENTLY CHANGED', 4,
  5.8,
  1802, 12340,
  '2017-05-20', '2025-12-01',
  0.8281, 63,
  ARRAY[744,672,744,720,744,720,0,0,720,726,720,744]::int[],
  ARRAY[6.5000,6.0000,5.8000,6.5000,6.4000,5.9000,NULL,NULL,4.7000,5.8000,6.1000,5.8000]::numeric[],
  ARRAY[1,1,1,1,1,1,0,0,1,0.9758,1,1]::numeric[],
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
  '100023208318W509', '100/02-32-083-18W5/09', 'PENN WEST PEACE RIVER 2-32-83-18',
  56.217863, -116.8099413,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  6.9,
  2971, 14033.900390625,
  '2017-04-06', '2025-12-01',
  0.8935, 38,
  ARRAY[744,672,615,427,364,651,744,736,720,738,720,696]::int[],
  ARRAY[9.4000,9.5000,10.8000,14.8000,17.5000,10.0000,9.3000,7.7000,8.4000,7.6000,3.7000,7.4000]::numeric[],
  ARRAY[1,1,0.8266,0.5931,0.4892,0.9042,1,0.9892,1,0.9919,1,0.9355]::numeric[],
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
  '100033208318W509', '100/03-32-083-18W5/09', 'PENN WEST PEACE RIVER 3-32-83-18',
  56.217867, -116.8107453,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  7.2,
  1702, 14742,
  '2017-03-20', '2025-12-01',
  0.9968, NULL,
  ARRAY[744,672,740,712,735,713,744,744,720,744,720,744]::int[],
  ARRAY[2.6000,3.1000,3.1000,3.1000,3.1000,3.1000,3.3000,4.3000,5.6000,7.5000,9.9000,7.2000]::numeric[],
  ARRAY[1,1,0.9946,0.9889,0.9879,0.9903,1,1,1,1,1,1]::numeric[],
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
  '100163408318W509', '100/16-34-083-18W5/09', 'OBE HZ PEACE RIVER 16-34-83-18',
  56.229531, -116.7594515,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'WATCH', 11,
  7.7,
  5907, 17332.599609375,
  '2017-10-09', '2025-12-01',
  0.9207, 29,
  ARRAY[114,658,744,720,744,720,723,744,720,740,712,726]::int[],
  ARRAY[25.7000,19.8000,20.1000,23.0000,22.4000,20.6000,16.7000,15.6000,18.8000,13.0000,14.5000,7.9000]::numeric[],
  ARRAY[0.1532,0.9792,1,1,1,1,0.9718,1,1,0.9946,0.9889,0.9758]::numeric[],
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
  '103143408318W509', '103/14-34-083-18W5/09', 'OBE 102 HZ PEACE R 14-34-83-18',
  56.229533, -116.7602565,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  5,
  6310, 19873.5,
  '2017-09-16', '2025-12-01',
  0.9963, 1,
  ARRAY[744,664,744,720,744,720,744,744,720,744,720,720]::int[],
  ARRAY[22.8000,21.6000,22.0000,22.7000,24.9000,19.7000,14.3000,14.3000,15.3000,14.2000,11.3000,5.2000]::numeric[],
  ARRAY[1,0.9881,1,1,1,1,1,1,1,1,1,0.9677]::numeric[],
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
