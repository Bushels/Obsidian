INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100112608218W500', '100/11-26-082-18W5/00', 'PENN WEST WALRUS 11-26-82-18',
  56.1409571, -116.6649203,
  'Bluesky', 'UNDEFINED',
  'Operating', 'LOW', NULL,
  0,
  NULL, 367.7000122070312,
  '2008-11-10', '2013-06-01',
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
  '102052408218W502', '102/05-24-082-18W5/02', 'PENN WEST HZ HARMON 5-24-82-18',
  56.1407302, -116.6829395,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0.3,
  7241, 86514.5,
  '2010-04-26', '2025-12-01',
  0.9201, 29,
  ARRAY[744,595,702,720,744,720,715,744,720,744,720,192]::int[],
  ARRAY[21.4000,23.3000,21.2000,20.4000,20.9000,34.8000,26.7000,17.9000,18.6000,35.8000,1.5000,1.3000]::numeric[],
  ARRAY[1,0.8854,0.9435,1,1,1,0.961,1,1,1,1,0.2581]::numeric[],
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
  '100062408218W503', '100/06-24-082-18W5/03', 'PENN WEST HZ HARMON 6-24-82-18',
  56.1407302, -116.6827785,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  1.4,
  7069, 57136.19921875,
  '2010-04-23', '2025-12-01',
  0.9295, 25,
  ARRAY[744,658,734,720,744,720,715,736,720,744,715,192]::int[],
  ARRAY[32.5000,23.8000,21.6000,31.3000,23.3000,21.6000,20.3000,17.3000,23.9000,11.2000,6.5000,5.6000]::numeric[],
  ARRAY[1,0.9792,0.9866,1,1,1,0.961,0.9892,1,1,0.9931,0.2581]::numeric[],
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
  '103052408218W502', '103/05-24-082-18W5/02', 'PENN WEST HZ 103 HARMON  5-24-82-18',
  56.1404602, -116.6834215,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  4.5,
  9588, 85981.109375,
  '2010-11-30', '2025-12-01',
  0.9694, 11,
  ARRAY[741,668,505,720,744,720,744,744,720,744,720,722]::int[],
  ARRAY[36.8000,31.3000,25.6000,35.6000,36.4000,32.5000,28.5000,26.2000,22.0000,22.7000,22.4000,4.7000]::numeric[],
  ARRAY[0.996,0.994,0.6788,1,1,1,1,1,1,1,1,0.9704]::numeric[],
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
  '100040608317W502', '100/04-06-083-17W5/02', 'PENN WEST 102 HZ WALRUS 4-6-83-17',
  56.1427032, -116.6827784,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  29.6,
  11574, 43556.80078125,
  '2010-12-02', '2025-12-01',
  0.8981, 38,
  ARRAY[744,603,667,510,524,634,696,648,648,744,720,729]::int[],
  ARRAY[39.6000,41.1000,41.1000,49.2000,47.0000,37.1000,30.6000,29.3000,28.3000,23.7000,34.0000,30.2000]::numeric[],
  ARRAY[1,0.8973,0.8965,0.7083,0.7043,0.8806,0.9355,0.871,0.9,1,1,0.9798]::numeric[],
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
