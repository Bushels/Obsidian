INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '102143408318W509', '102/14-34-083-18W5/09', 'PENN WEST 102 HZ PEACE R 14-34-83-18',
  56.229532, -116.7598545,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  18.8,
  6002, 17282.599609375,
  '2017-09-21', '2025-12-01',
  0.9917, 3,
  ARRAY[706,664,744,720,744,720,744,744,720,744,693,744]::int[],
  ARRAY[24.7000,18.4000,10.0000,12.6000,16.8000,13.0000,13.6000,7.2000,16.4000,26.5000,21.7000,18.8000]::numeric[],
  ARRAY[0.9489,0.9881,1,1,1,1,1,1,1,1,0.9625,1]::numeric[],
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
  '100023508218W509', '100/02-35-082-18W5/09', 'OBE PENN WEST HZ WALRUS 4 2-35-82-18',
  56.1429681, -116.6591272,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  31.7,
  14558, 75057.796875,
  '2017-09-21', '2025-12-01',
  0.9892, 3,
  ARRAY[744,669,744,699,736,713,725,718,709,744,720,744]::int[],
  ARRAY[72.0000,76.2000,61.3000,45.6000,31.3000,11.0000,17.8000,41.2000,34.4000,33.3000,29.7000,31.7000]::numeric[],
  ARRAY[1,0.9955,1,0.9708,0.9892,0.9903,0.9745,0.9651,0.9847,1,1,1]::numeric[],
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
  '104113608218W509', '104/11-36-082-18W5/09', 'OBE HZ HARMON 11-36-82-18',
  56.1428372, -116.6823804,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  25.2,
  11022, 43300.80078125,
  '2017-10-29', '2025-12-01',
  0.9967, NULL,
  ARRAY[744,671,744,712,743,715,738,744,720,736,720,744]::int[],
  ARRAY[34.5000,28.8000,26.3000,26.6000,26.7000,30.5000,29.5000,30.0000,30.2000,37.4000,38.0000,25.2000]::numeric[],
  ARRAY[1,0.9985,1,0.9889,0.9987,0.9931,0.9919,1,1,0.9892,1,1]::numeric[],
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
  '104020808317W509', '104/02-08-083-17W5/09', 'OBE HZ WALRUS 2-8-83-17',
  56.1611101, -116.6447796,
  'Bluesky', 'CADOTTE',
  'Pumping', 'HIGH', 12,
  4.7,
  2617, 7161.7998046875,
  '2017-12-11', '2025-12-01',
  0.9986, NULL,
  ARRAY[744,672,741,714,742,719,744,744,720,744,720,744]::int[],
  ARRAY[7.8000,8.2000,8.6000,8.5000,9.9000,8.9000,9.8000,5.4000,4.6000,4.9000,5.0000,4.7000]::numeric[],
  ARRAY[1,1,0.996,0.9917,0.9973,0.9986,1,1,1,1,1,1]::numeric[],
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
  '102013108217W509', '102/01-31-082-17W5/09', 'PENN WEST HZ WALRU WALRUS 1-31-82-17',
  56.1611091, -116.6443776,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  12.3,
  4225, 10885.7001953125,
  '2017-12-09', '2025-12-01',
  0.9993, NULL,
  ARRAY[744,672,742,718,743,719,744,744,720,744,720,744]::int[],
  ARRAY[12.8000,10.9000,10.5000,11.5000,10.7000,10.9000,11.3000,11.2000,12.0000,12.3000,12.5000,12.3000]::numeric[],
  ARRAY[1,1,0.9973,0.9972,0.9987,0.9986,1,1,1,1,1,1]::numeric[],
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
