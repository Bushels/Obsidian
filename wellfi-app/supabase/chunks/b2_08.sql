INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '102150708317W509', '102/15-07-083-17W5/09', 'PENN WEST HZ WALRUS 15-7-83-17',
  56.1731251, -116.6755508,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  11.7,
  6543, 31320,
  '2016-03-18', '2025-12-01',
  0.9985, NULL,
  ARRAY[744,672,744,720,742,711,742,744,720,744,720,744]::int[],
  ARRAY[26.8000,21.8000,22.0000,23.9000,24.8000,20.1000,14.1000,12.5000,12.0000,13.9000,12.1000,11.7000]::numeric[],
  ARRAY[1,1,1,1,0.9973,0.9875,0.9973,1,1,1,1,1]::numeric[],
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
  '104123608218W509', '104/12-36-082-18W5/09', 'PENN WEST HZ WALRUS 12-36-82-18',
  56.1731381, -116.6853639,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  23.6,
  8701, 42476.19921875,
  '2016-03-09', '2025-12-01',
  0.9982, NULL,
  ARRAY[744,672,744,712,744,720,744,744,720,736,720,744]::int[],
  ARRAY[17.1000,21.0000,21.9000,22.6000,26.3000,25.8000,25.8000,26.1000,25.0000,25.1000,26.0000,23.6000]::numeric[],
  ARRAY[1,1,1,0.9889,1,1,1,1,1,0.9892,1,1]::numeric[],
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
  '103123608218W509', '103/12-36-082-18W5/09', 'PENN WEST HZ WALRUS 12-36-82-18',
  56.1731391, -116.6857659,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  19.3,
  7144, 55366.19921875,
  '2016-03-22', '2025-12-01',
  0.9947, 2,
  ARRAY[744,672,744,720,744,720,727,717,720,742,720,744]::int[],
  ARRAY[22.7000,22.5000,21.7000,22.6000,20.6000,17.8000,16.8000,16.9000,17.9000,18.9000,18.4000,19.3000]::numeric[],
  ARRAY[1,1,1,1,1,1,0.9772,0.9637,1,0.9973,1,1]::numeric[],
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
  '102140708317W509', '102/14-07-083-17W5/09', 'PENN WEST HZ WALRUS 14-7-83-17',
  56.1731401, -116.6861679,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  24.9,
  8250, 30704,
  '2016-04-08', '2025-12-01',
  0.9986, NULL,
  ARRAY[744,672,744,720,744,720,739,737,720,744,720,744]::int[],
  ARRAY[21.1000,20.3000,24.6000,26.5000,25.6000,20.2000,18.4000,19.4000,19.6000,25.6000,25.2000,24.9000]::numeric[],
  ARRAY[1,1,1,1,1,1,0.9933,0.9906,1,1,1,1]::numeric[],
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
  '100150108318W509', '100/15-01-083-18W5/09', 'PENN WEST HZ WALRUS 15-1-83-18',
  56.1731251, -116.6759528,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  19.5,
  5677, 35095.30078125,
  '2016-04-21', '2025-12-01',
  0.9385, 22,
  ARRAY[744,665,575,408,715,712,730,744,720,744,720,744]::int[],
  ARRAY[19.9000,20.8000,13.0000,13.8000,15.5000,15.8000,15.1000,15.0000,13.6000,17.3000,17.7000,19.5000]::numeric[],
  ARRAY[1,0.9896,0.7728,0.5667,0.961,0.9889,0.9812,1,1,1,1,1]::numeric[],
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
