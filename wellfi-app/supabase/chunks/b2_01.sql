INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '102032308419W509', '102/03-23-084-19W5/09', 'PENN WEST HZ PEACE RVR 3-23-84-19',
  56.2883157, -116.8838153,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'WATCH', 11,
  7.2,
  2974, 23913.599609375,
  '2013-10-24', '2025-12-01',
  0.8854, 42,
  ARRAY[0,412,744,720,744,720,744,744,720,744,720,744]::int[],
  ARRAY[NULL,10.0000,15.1000,10.5000,11.9000,10.0000,7.9000,7.1000,7.3000,7.2000,7.4000,7.2000]::numeric[],
  ARRAY[0,0.6131,1,1,1,1,1,1,1,1,1,1]::numeric[],
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
  '105132508419W509', '105/13-25-084-19W5/09', 'PENN WEST HZ PEACE RVR 13-25-84-19',
  56.3137647, -116.8449145,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  33.8,
  12066, 67983.8984375,
  '2013-09-12', '2025-12-01',
  0.9785, 8,
  ARRAY[683,637,731,704,736,711,744,710,708,744,720,744]::int[],
  ARRAY[36.0000,36.9000,37.0000,34.7000,32.5000,31.3000,33.3000,31.2000,32.0000,34.6000,32.5000,33.8000]::numeric[],
  ARRAY[0.918,0.9479,0.9825,0.9778,0.9892,0.9875,1,0.9543,0.9833,1,1,1]::numeric[],
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
  '100162208419W509', '100/16-22-084-19W5/09', 'PENN WEST 102 HZ PEACE R 16-22-84-19',
  56.2886847, -116.9077116,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  23.4,
  7716, 45880.30078125,
  '2013-11-19', '2025-12-01',
  0.9955, 1,
  ARRAY[741,670,744,720,744,720,738,744,720,724,720,736]::int[],
  ARRAY[22.9000,32.2000,17.4000,1.5000,17.6000,17.4000,25.5000,25.7000,24.9000,23.0000,23.6000,23.7000]::numeric[],
  ARRAY[0.996,0.997,1,1,1,1,0.9919,1,1,0.9731,1,0.9892]::numeric[],
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
  '100093108318W509', '100/09-31-083-18W5/09', 'PENN WEST 102 PEACE RVR 9-31-83-18',
  56.2371, -116.8200661,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  14.7,
  5431, 38800.30078125,
  '2014-11-13', '2025-12-01',
  0.9953, 1,
  ARRAY[744,672,740,711,732,714,744,743,711,744,720,744]::int[],
  ARRAY[11.4000,18.9000,18.3000,18.6000,16.7000,17.3000,16.8000,11.4000,9.7000,11.6000,14.5000,14.7000]::numeric[],
  ARRAY[1,1,0.9946,0.9875,0.9839,0.9917,1,0.9987,0.9875,1,1,1]::numeric[],
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
  '103043108318W509', '103/04-31-083-18W5/09', 'PENN WEST 103 PEACE RVR  4-31-83-18',
  56.236921, -116.8200661,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  16.9,
  6486, 47895.69921875,
  '2014-11-08', '2025-12-01',
  0.9549, 17,
  ARRAY[744,672,663,591,635,681,744,744,720,707,720,744]::int[],
  ARRAY[12.2000,21.3000,23.0000,24.2000,23.6000,19.7000,17.9000,17.0000,17.5000,15.4000,16.9000,16.9000]::numeric[],
  ARRAY[1,1,0.8911,0.8208,0.8535,0.9458,1,1,1,0.9503,1,1]::numeric[],
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
