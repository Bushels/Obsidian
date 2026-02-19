INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '102082508218W509', '102/08-25-082-18W5/09', 'PENN WEST HZ WALRUS 8-25-82-18',
  56.1134812, -116.6692609,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'HIGH', 12,
  26.8,
  9550, 15292.5,
  '2017-08-12', '2025-12-01',
  0.9962, 1,
  ARRAY[740,672,744,708,736,720,744,735,720,744,720,744]::int[],
  ARRAY[33.1000,34.1000,34.5000,43.9000,22.5000,19.2000,19.1000,22.3000,17.8000,18.1000,24.6000,26.8000]::numeric[],
  ARRAY[0.9946,1,1,0.9833,0.9892,1,1,0.9879,1,1,1,1]::numeric[],
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
  '103082408218W509', '103/08-24-082-18W5/09', 'PENN WEST 103 HZ WALRUS 8-24-82-18',
  56.1134812, -116.6684588,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'HIGH', 12,
  6.4,
  2596, 12973.2998046875,
  '2016-12-05', '2025-12-01',
  0.999, NULL,
  ARRAY[744,672,744,720,741,720,744,738,720,744,720,744]::int[],
  ARRAY[11.1000,13.4000,11.1000,7.8000,6.6000,11.7000,7.3000,1.8000,2.4000,2.8000,3.5000,6.4000]::numeric[],
  ARRAY[1,1,1,1,0.996,1,1,0.9919,1,1,1,1]::numeric[],
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
  '100031308218W509', '100/03-13-082-18W5/09', 'PENN WEST HZ HARMONV 3-13-82-18',
  56.1118232, -116.682869,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'HIGH', 12,
  1.8,
  2822, 9142.099609375,
  '2016-10-11', '2025-12-01',
  0.8788, 43,
  ARRAY[744,547,671,720,744,720,692,638,720,744,456,302]::int[],
  ARRAY[6.5000,14.5000,13.4000,10.3000,8.9000,6.7000,7.4000,7.0000,9.9000,8.0000,6.7000,4.5000]::numeric[],
  ARRAY[1,0.814,0.9019,1,1,1,0.9301,0.8575,1,1,0.6333,0.4059]::numeric[],
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
  '100041308218W509', '100/04-13-082-18W5/09', 'PENN WEST HZ HARMONV 4-13-82-18',
  56.1118232, -116.683591,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'HIGH', 12,
  22.2,
  7857, 27960.19921875,
  '2016-11-02', '2025-12-01',
  0.9185, 30,
  ARRAY[744,589,249,720,744,720,707,651,720,744,714,744]::int[],
  ARRAY[39.5000,36.4000,12.5000,18.9000,23.8000,19.9000,19.3000,19.5000,18.8000,23.4000,21.2000,22.2000]::numeric[],
  ARRAY[1,0.8765,0.3347,1,1,1,0.9503,0.875,1,1,0.9917,1]::numeric[],
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
  '104052408218W509', '104/05-24-082-18W5/09', 'PENN WEST 104 HZ HARMONV 5-24-82-18',
  56.1118232, -116.683912,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'HIGH', 12,
  57.3,
  22494, 73045.203125,
  '2016-11-10', '2025-12-01',
  0.9961, 1,
  ARRAY[744,669,742,720,744,720,742,742,720,725,714,744]::int[],
  ARRAY[65.8000,66.7000,64.0000,63.9000,60.4000,57.4000,60.0000,63.5000,60.9000,59.5000,63.3000,57.3000]::numeric[],
  ARRAY[1,0.9955,0.9973,1,1,1,0.9973,0.9973,1,0.9745,0.9917,1]::numeric[],
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
