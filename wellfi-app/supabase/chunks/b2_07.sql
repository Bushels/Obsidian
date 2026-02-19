INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100160808317W509', '100/16-08-083-17W5/09', 'PENN WEST 102 HZ WALRUS 16-8-83-17',
  56.1728141, -116.6497154,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  26.7,
  9869, 18814.69921875,
  '2015-12-30', '2025-12-01',
  0.8795, 45,
  ARRAY[744,575,644,512,484,579,588,650,720,744,720,744]::int[],
  ARRAY[28.1000,32.6000,33.4000,42.2000,42.3000,32.5000,33.1000,28.4000,25.8000,26.7000,25.7000,26.7000]::numeric[],
  ARRAY[1,0.8557,0.8656,0.7111,0.6505,0.8042,0.7903,0.8737,1,1,1,1]::numeric[],
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
  '1W0133108217W509', '1W0/13-31-082-17W5/09', 'PENN WEST 102 HZ WALRUS 13-31-82-17',
  56.1729271, -116.6600746,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  12.4,
  4549, 54068.80078125,
  '2016-02-03', '2025-12-01',
  0.9287, 26,
  ARRAY[744,672,313,528,744,720,743,743,720,744,720,744]::int[],
  ARRAY[17.4000,18.2000,11.4000,8.2000,11.4000,11.4000,13.1000,13.8000,13.7000,14.2000,13.6000,12.4000]::numeric[],
  ARRAY[1,1,0.4207,0.7333,1,1,0.9987,0.9987,1,1,1,1]::numeric[],
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
  '1W0130808317W509', '1W0/13-08-083-17W5/09', 'PENN WEST HZ WALRUS 13-8-83-17',
  56.1729261, -116.6596726,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  25.4,
  6443, 51254.69921875,
  '2016-01-19', '2025-12-01',
  0.988, 5,
  ARRAY[744,672,744,720,744,720,681,702,720,744,720,744]::int[],
  ARRAY[13.5000,11.8000,12.4000,13.8000,11.8000,15.3000,16.7000,18.4000,24.7000,25.2000,24.9000,25.4000]::numeric[],
  ARRAY[1,1,1,1,1,1,0.9153,0.9435,1,1,1,1]::numeric[],
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
  '100160508317W509', '100/16-05-083-17W5/09', 'PENN WEST HZ WALRUS 16-5-83-17',
  56.1731261, -116.6747458,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'WATCH', 11,
  14.6,
  5246, 42460.19921875,
  '2016-02-25', '2025-12-01',
  0.8256, 64,
  ARRAY[72,642,683,474,460,603,626,744,720,744,720,744]::int[],
  ARRAY[25.2000,16.7000,14.2000,20.4000,24.4000,20.9000,23.4000,17.2000,17.6000,13.2000,13.0000,14.6000]::numeric[],
  ARRAY[0.0968,0.9554,0.918,0.6583,0.6183,0.8375,0.8414,1,1,1,1,1]::numeric[],
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
  '100150708317W509', '100/15-07-083-17W5/09', 'PENN WEST HZ WALRUS 15-7-83-17',
  56.1731261, -116.6751478,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  19.1,
  10188, 48106.69921875,
  '2016-03-05', '2025-12-01',
  0.9978, 1,
  ARRAY[740,672,744,720,741,720,744,744,720,744,708,744]::int[],
  ARRAY[30.9000,31.1000,31.5000,30.9000,30.5000,29.1000,26.5000,26.0000,26.9000,27.4000,26.2000,19.1000]::numeric[],
  ARRAY[0.9946,1,1,1,0.996,1,1,1,1,1,0.9833,1]::numeric[],
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
