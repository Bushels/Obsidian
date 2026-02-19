INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '102143508218W509', '102/14-35-082-18W5/09', 'PENN WEST 102 HZ WALRUS 14-35-82-18',
  56.1408862, -116.7064747,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  30.7,
  14237, 98896.0078125,
  '2015-11-30', '2025-12-01',
  0.9983, NULL,
  ARRAY[744,662,744,720,744,720,744,744,715,744,720,744]::int[],
  ARRAY[48.0000,45.6000,44.1000,37.5000,41.5000,31.8000,32.0000,29.9000,39.0000,48.0000,41.3000,30.7000]::numeric[],
  ARRAY[1,0.9851,1,1,1,1,1,1,0.9931,1,1,1]::numeric[],
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
  '100143508218W509', '100/14-35-082-18W5/09', 'PENN WEST HZ WALRUS 14-35-82-18',
  56.1408862, -116.7067967,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  12,
  8318, 53524.30078125,
  '2015-11-27', '2025-12-01',
  0.9968, 1,
  ARRAY[744,663,727,720,744,720,742,744,720,744,720,744]::int[],
  ARRAY[17.0000,31.7000,34.3000,29.3000,31.0000,30.4000,24.0000,12.5000,18.0000,20.7000,14.7000,12.0000]::numeric[],
  ARRAY[1,0.9866,0.9772,1,1,1,0.9973,1,1,1,1,1]::numeric[],
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
  '100123508218W509', '100/12-35-082-18W5/09', 'PENN WEST HZ WALRUS 12-35-82-18',
  56.1408862, -116.7071177,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  23.4,
  10282, 39710.6015625,
  '2015-11-16', '2025-12-01',
  0.9999, NULL,
  ARRAY[744,671,744,720,744,720,744,744,720,744,720,744]::int[],
  ARRAY[33.9000,33.9000,32.5000,30.0000,32.1000,27.7000,25.4000,20.6000,27.5000,27.4000,24.0000,23.4000]::numeric[],
  ARRAY[1,0.9985,1,1,1,1,1,1,1,1,1,1]::numeric[],
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
  '100161208318W509', '100/16-12-083-18W5/09', 'PENN WEST HZ 102 PEACE R 16-12-83-18',
  56.1715441, -116.69449,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  13,
  5678, 22980.19921875,
  '2015-11-03', '2025-12-01',
  0.9429, 20,
  ARRAY[744,667,501,471,744,720,744,741,720,744,720,744]::int[],
  ARRAY[21.5000,21.2000,19.5000,23.9000,21.2000,16.2000,12.7000,13.0000,13.0000,13.5000,13.3000,13.0000]::numeric[],
  ARRAY[1,0.9926,0.6734,0.6542,1,1,1,0.996,1,1,1,1]::numeric[],
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
  '100163508218W509', '100/16-35-082-18W5/09', 'PENN WEST HZ PEACE RIVER 16-35-82-18',
  56.1715441, -116.694653,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  8.3,
  3322, 36877,
  '2015-11-03', '2025-12-01',
  0.9659, 10,
  ARRAY[733,639,737,697,733,712,737,665,720,624,720,744]::int[],
  ARRAY[10.6000,11.4000,11.0000,11.7000,11.3000,11.1000,11.2000,8.3000,3.5000,5.3000,8.8000,8.3000]::numeric[],
  ARRAY[0.9852,0.9509,0.9906,0.9681,0.9852,0.9889,0.9906,0.8938,1,0.8387,1,1]::numeric[],
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
