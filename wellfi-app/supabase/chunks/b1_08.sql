INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100020108318W502', '100/02-01-083-18W5/02', 'PENN WEST PEACE RIVER 2-1-83-18',
  56.1725741, -116.7026221,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  21, 30120.900390625,
  '2012-03-26', '2025-01-01',
  0.0247, 356,
  ARRAY[216,0,0,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[2.4000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0.2903,0,0,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '102060108216W503', '102/06-01-082-16W5/03', 'PENN WEST 102 HZ SEAL 6-1-82-16',
  56.0868878, -116.3456859,
  'Bluesky', 'SEAL',
  'Pumping', 'WATCH', 11,
  30.4,
  10510, 7041.7998046875,
  '2012-05-14', '2025-12-01',
  0.8808, 43,
  ARRAY[132,360,686,716,744,720,744,744,720,744,720,686]::int[],
  ARRAY[14.1000,4.5000,14.1000,40.7000,38.8000,34.3000,31.7000,31.3000,31.3000,33.1000,55.2000,32.9000]::numeric[],
  ARRAY[0.1774,0.5357,0.922,0.9944,1,1,1,1,1,1,1,0.922]::numeric[],
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
  '104162408419W508', '104/16-24-084-19W5/08', 'PENN WEST 104 HZ PEACE R 16-24-84-19',
  56.2889668, -116.8514159,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  3083, 38096.58984375,
  '2012-03-30', '2025-11-01',
  0.8771, 45,
  ARRAY[737,658,744,720,744,720,744,744,720,744,408,0]::int[],
  ARRAY[10.5000,9.8000,10.6000,9.0000,9.6000,8.9000,9.9000,9.4000,8.4000,8.6000,12.3000,NULL]::numeric[],
  ARRAY[0.9906,0.9792,1,1,1,1,1,1,1,1,0.5667,0]::numeric[],
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
  '104052508419W509', '104/05-25-084-19W5/09', 'PENN WEST 103 HZ PEACE R 5-25-84-19',
  56.3126437, -116.8449145,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  21,
  8055, 28364.599609375,
  '2012-11-20', '2025-12-01',
  0.9606, 15,
  ARRAY[607,576,741,720,743,720,744,744,720,732,624,744]::int[],
  ARRAY[19.4000,24.2000,25.1000,24.0000,23.1000,27.2000,23.6000,22.8000,23.7000,22.5000,18.3000,21.0000]::numeric[],
  ARRAY[0.8159,0.8571,0.996,1,0.9987,1,1,1,1,0.9839,0.8667,1]::numeric[],
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
  '106132508419W508', '106/13-25-084-19W5/08', 'PENN WEST 105 HZ PEACE R 13-25-84-19',
  56.3127337, -116.8449145,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  9.9,
  4487, 29173.30078125,
  '2012-11-20', '2025-12-01',
  0.9821, 6,
  ARRAY[674,640,737,720,744,704,712,744,720,744,720,744]::int[],
  ARRAY[15.2000,15.4000,14.2000,8.7000,7.5000,11.3000,14.1000,14.1000,13.5000,14.0000,12.9000,9.9000]::numeric[],
  ARRAY[0.9059,0.9524,0.9906,1,1,0.9778,0.957,1,1,1,1,1]::numeric[],
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
