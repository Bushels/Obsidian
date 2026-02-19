INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '102040508317W509', '102/04-05-083-17W5/09', 'PENN WEST HZ WALRUS 4-5-83-17',
  56.1430601, -116.6583231,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  25.2,
  6896, 44370.19921875,
  '2015-12-18', '2025-12-01',
  0.9311, 25,
  ARRAY[744,648,722,655,284,702,740,733,720,744,720,744]::int[],
  ARRAY[15.3000,18.5000,18.7000,19.7000,19.9000,14.8000,18.3000,17.6000,24.4000,24.5000,26.0000,25.2000]::numeric[],
  ARRAY[1,0.9643,0.9704,0.9097,0.3817,0.975,0.9946,0.9852,1,1,1,1]::numeric[],
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
  '103143108217W509', '103/14-31-082-17W5/09', 'PENN WEST HZ WALRUS 14-31-82-17',
  56.1429711, -116.6579221,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  22.9,
  9230, 42085.19921875,
  '2016-01-15', '2025-12-01',
  0.9755, 9,
  ARRAY[744,672,744,706,744,718,739,550,720,744,720,744]::int[],
  ARRAY[21.2000,30.0000,29.6000,29.2000,25.3000,28.6000,27.1000,25.1000,28.5000,24.3000,19.8000,22.9000]::numeric[],
  ARRAY[1,1,1,0.9806,1,0.9972,0.9933,0.7392,1,1,1,1]::numeric[],
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
  '100140808317W509', '100/14-08-083-17W5/09', 'PENN WEST SEAL HV SOUTH 14-8-83-17',
  56.1728171, -116.6504644,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  7.5,
  2601, 12273.900390625,
  '2015-12-12', '2025-12-01',
  0.8013, 72,
  ARRAY[744,510,592,283,420,529,469,544,720,744,720,744]::int[],
  ARRAY[2.8000,3.0000,3.2000,6.7000,7.3000,9.6000,17.3000,22.5000,14.0000,7.5000,7.4000,7.5000]::numeric[],
  ARRAY[1,0.7589,0.7957,0.3931,0.5645,0.7347,0.6304,0.7312,1,1,1,1]::numeric[],
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
  '102153108217W509', '102/15-31-082-17W5/09', 'PENN WEST HZ WALRUS 15-31-82-17',
  56.1728151, -116.6501424,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  5.9,
  2492, 22099.69921875,
  '2015-12-27', '2025-12-01',
  0.7713, 83,
  ARRAY[744,579,598,419,471,405,282,331,720,744,720,744]::int[],
  ARRAY[7.3000,7.5000,8.9000,10.6000,7.8000,10.0000,8.3000,11.1000,9.1000,11.2000,10.1000,5.9000]::numeric[],
  ARRAY[1,0.8616,0.8038,0.5819,0.6331,0.5625,0.379,0.4449,1,1,1,1]::numeric[],
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
  '102143108217W509', '102/14-31-082-17W5/09', 'PENN WEST HZ WALRUS 14-31-82-17',
  56.1728171, -116.6504644,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  16.6,
  5752, 37932.80078125,
  '2015-12-12', '2025-12-01',
  0.9865, 5,
  ARRAY[744,659,737,692,723,699,725,735,720,744,720,744]::int[],
  ARRAY[10.3000,15.1000,15.5000,17.2000,17.4000,16.6000,16.4000,15.8000,17.3000,17.8000,15.9000,16.6000]::numeric[],
  ARRAY[1,0.9807,0.9906,0.9611,0.9718,0.9708,0.9745,0.9879,1,1,1,1]::numeric[],
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
