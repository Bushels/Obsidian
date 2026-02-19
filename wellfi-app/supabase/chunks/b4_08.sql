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
