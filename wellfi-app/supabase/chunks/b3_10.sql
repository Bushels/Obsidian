INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '103162908115W506', '103/16-29-081-15W5/06', 'OBE 103 HZ DAWSON 16-29-81-15',
  56.0554508, -116.3274703,
  'Bluesky', 'DAWSON',
  'Pumping', 'HIGH', 12,
  63.6,
  15057, 12222.2001953125,
  '2022-10-31', '2025-12-01',
  0.9435, 20,
  ARRAY[456,672,734,693,734,706,728,697,695,718,720,712]::int[],
  ARRAY[52.8000,60.9000,62.1000,27.3000,35.8000,33.1000,32.1000,38.3000,38.7000,39.0000,41.5000,66.5000]::numeric[],
  ARRAY[0.6129,1,0.9866,0.9625,0.9866,0.9806,0.9785,0.9368,0.9653,0.9651,1,0.957]::numeric[],
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
  '104092908115W506', '104/09-29-081-15W5/06', 'OBE 104 HZ DAWSON 9-29-81-15',
  56.0551888, -116.3273533,
  'Bluesky', 'DAWSON',
  'Pumping', 'HIGH', 12,
  61.8,
  22170, 14312,
  '2022-10-31', '2025-12-01',
  0.9703, 12,
  ARRAY[744,672,734,645,744,706,728,701,704,726,720,676]::int[],
  ARRAY[91.5000,72.8000,47.7000,37.8000,87.9000,76.3000,61.0000,58.3000,50.9000,46.8000,49.1000,68.0000]::numeric[],
  ARRAY[1,1,0.9866,0.8958,1,0.9806,0.9785,0.9422,0.9778,0.9758,1,0.9086]::numeric[],
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
  '100033208217W509', '100/03-32-082-17W5/09', 'OBE HZ WALRUS 3-32-82-17',
  56.16475, -116.6295363,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  17.6,
  8335, 7038.2001953125,
  '2023-02-28', '2025-12-01',
  0.9877, 4,
  ARRAY[744,672,742,714,743,621,744,744,720,744,720,744]::int[],
  ARRAY[32.5000,29.0000,27.2000,26.7000,27.0000,12.5000,22.6000,20.4000,22.6000,24.4000,13.6000,17.6000]::numeric[],
  ARRAY[1,1,0.9973,0.9917,0.9987,0.8625,1,1,1,1,1,1]::numeric[],
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
  '102033208217W509', '102/03-32-082-17W5/09', 'OBE 102 HZ WALRUS 3-32-82-17',
  56.164592, -116.6298233,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  18.7,
  5917, 4271.60009765625,
  '2023-02-28', '2025-12-01',
  0.9387, 21,
  ARRAY[744,672,593,620,662,705,744,744,710,744,541,744]::int[],
  ARRAY[19.6000,20.3000,19.7000,20.4000,21.8000,11.4000,17.5000,17.7000,18.6000,10.9000,10.1000,18.7000]::numeric[],
  ARRAY[1,1,0.797,0.8611,0.8898,0.9792,1,1,0.9861,1,0.7514,1]::numeric[],
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
  '100040908013W500', '100/04-09-080-13W5/00', 'WOODCOTE OIL HZ GIFT 4-9-80-13',
  55.897141, -115.9818319,
  'Clearwater', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  19,
  7909, 5386.10009765625,
  '2023-01-03', '2025-12-01',
  0.986, 4,
  ARRAY[742,663,744,714,744,712,744,737,720,744,694,679]::int[],
  ARRAY[29.0000,24.5000,22.4000,20.6000,20.6000,21.2000,22.2000,21.6000,19.9000,20.8000,20.1000,20.8000]::numeric[],
  ARRAY[0.9973,0.9866,1,0.9917,1,0.9889,1,0.9906,1,1,0.9639,0.9126]::numeric[],
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
