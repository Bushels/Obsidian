INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '104131908217W509', '104/13-19-082-17W5/09', 'OBE HZ WALRUS 13-19-82-17',
  56.1516491, -116.6528599,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  51.4,
  21688, 32770.8984375,
  '2021-12-28', '2025-12-01',
  0.9997, NULL,
  ARRAY[741,672,744,720,744,720,744,744,720,744,720,744]::int[],
  ARRAY[77.0000,72.3000,68.7000,59.2000,46.5000,53.6000,64.7000,51.1000,59.3000,56.8000,53.7000,51.4000]::numeric[],
  ARRAY[0.996,1,1,1,1,1,1,1,1,1,1,1]::numeric[],
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
  '104093508218W509', '104/09-35-082-18W5/09', 'OBE 102 HZ HARMON 9-35-82-18',
  56.1418182, -116.6832505,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  41.9,
  16711, 47383.1015625,
  '2022-01-01', '2025-12-01',
  0.9267, 27,
  ARRAY[744,535,694,523,578,657,715,744,720,744,720,744]::int[],
  ARRAY[58.5000,31.8000,43.6000,88.2000,66.6000,56.8000,50.3000,44.1000,60.7000,36.2000,24.7000,41.9000]::numeric[],
  ARRAY[1,0.7961,0.9328,0.7264,0.7769,0.9125,0.961,1,1,1,1,1]::numeric[],
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
  '100083408218W509', '100/08-34-082-18W5/09', 'OBE HZ 8-34-82-18',
  56.1474422, -116.7035196,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  21.3,
  16733, 13833.400390625,
  '2022-04-11', '2025-12-01',
  0.9508, 19,
  ARRAY[744,672,608,588,677,706,742,742,642,744,720,744]::int[],
  ARRAY[56.0000,54.0000,54.0000,52.3000,53.5000,55.2000,53.0000,55.5000,53.2000,40.1000,33.9000,21.3000]::numeric[],
  ARRAY[1,1,0.8172,0.8167,0.9099,0.9806,0.9973,0.9973,0.8917,1,1,1]::numeric[],
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
  '103032608218W509', '103/03-26-082-18W5/09', 'OBE 103 HZ 3-26-82-18',
  56.1474432, -116.7027946,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  67.2,
  31051, 19972.19921875,
  '2022-04-11', '2025-12-01',
  0.9642, 13,
  ARRAY[744,648,739,718,732,720,742,742,720,744,480,717]::int[],
  ARRAY[103.7000,114.6000,111.7000,106.8000,90.7000,70.2000,62.9000,91.0000,84.0000,65.3000,92.5000,69.7000]::numeric[],
  ARRAY[1,0.9643,0.9933,0.9972,0.9839,1,0.9973,0.9973,1,1,0.6667,0.9637]::numeric[],
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
  '100013208319W509', '100/01-32-083-19W5/09', 'OBE 100 HZ HARMONV 1-32-83-19',
  56.2483071, -116.9652097,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  97.8,
  39611, 23184.19921875,
  '2023-02-15', '2025-12-01',
  0.94, 22,
  ARRAY[743,598,744,666,584,562,743,688,720,730,718,738]::int[],
  ARRAY[112.9000,142.4000,112.7000,107.2000,130.1000,152.2000,116.4000,118.6000,104.1000,100.9000,105.0000,98.6000]::numeric[],
  ARRAY[0.9987,0.8899,1,0.925,0.7849,0.7806,0.9987,0.9247,1,0.9812,0.9972,0.9919]::numeric[],
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
