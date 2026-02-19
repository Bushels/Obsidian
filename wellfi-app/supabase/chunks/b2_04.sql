INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100013308218W509', '100/01-33-082-18W5/09', 'PENN WEST 102 HZ WALRUS 1-33-82-18',
  56.1438742, -116.7180258,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'RECENTLY CHANGED', 7,
  12.7,
  3492, 21342.19921875,
  '2015-09-12', '2025-12-01',
  0.8418, 58,
  ARRAY[744,672,744,366,0,432,744,744,720,744,720,744]::int[],
  ARRAY[9.1000,9.1000,9.0000,3.9000,NULL,2.7000,3.3000,3.5000,10.5000,15.6000,38.8000,12.7000]::numeric[],
  ARRAY[1,1,1,0.5083,0,0.6,1,1,1,1,1,1]::numeric[],
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
  '100083308218W509', '100/08-33-082-18W5/09', 'PENN WEST 100 HZ WALRUS 8-33-82-18',
  56.1438742, -116.7178648,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  15.9,
  6382, 19837.19921875,
  '2015-09-12', '2025-12-01',
  0.9995, NULL,
  ARRAY[744,670,744,718,744,720,744,744,720,744,720,744]::int[],
  ARRAY[14.2000,17.3000,17.4000,23.3000,19.9000,17.3000,17.3000,17.1000,17.5000,17.1000,15.7000,15.9000]::numeric[],
  ARRAY[1,0.997,1,0.9972,1,1,1,1,1,1,1,1]::numeric[],
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
  '100121908217W509', '100/12-19-082-17W5/09', 'PENN WEST HZ WALRUS 12-19-82-17',
  56.1406851, -116.6649433,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  1,
  5730, 15277.099609375,
  '2015-10-17', '2025-12-01',
  0.9992, NULL,
  ARRAY[744,672,744,720,744,720,740,741,720,744,720,744]::int[],
  ARRAY[17.8000,19.2000,19.3000,19.2000,14.1000,10.0000,13.4000,6.4000,15.4000,29.3000,23.8000,1.0000]::numeric[],
  ARRAY[1,1,1,1,1,1,0.9946,0.996,1,1,1,1]::numeric[],
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
  '102123608218W509', '102/12-36-082-18W5/09', 'PENN WEST HZ 102 HARMON 12-36-82-18',
  56.1419162, -116.6830985,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  5,
  4761, 40818.69921875,
  '2015-10-23', '2025-12-01',
  0.9563, 16,
  ARRAY[744,672,744,461,657,694,733,744,720,744,720,744]::int[],
  ARRAY[27.7000,27.7000,26.1000,22.1000,9.9000,6.5000,6.1000,6.2000,13.1000,9.6000,6.9000,5.0000]::numeric[],
  ARRAY[1,1,1,0.6403,0.8831,0.9639,0.9852,1,1,1,1,1]::numeric[],
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
  '102113608218W509', '102/11-36-082-18W5/09', 'PENN WEST HZ 102 HARMON 11-36-82-18',
  56.1419122, -116.6829375,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  41.9,
  10778, 65606.6015625,
  '2015-10-25', '2025-12-01',
  0.9008, 36,
  ARRAY[734,649,578,455,490,613,700,744,720,744,720,744]::int[],
  ARRAY[30.4000,29.9000,30.7000,30.6000,30.9000,25.1000,22.6000,29.8000,36.4000,37.6000,43.6000,41.9000]::numeric[],
  ARRAY[0.9866,0.9658,0.7769,0.6319,0.6586,0.8514,0.9409,1,1,1,1,1]::numeric[],
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
