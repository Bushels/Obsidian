INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100162608415W500', '100/16-26-084-15W5/00', 'PENN WEST SLAVE 16-26-84-15',
  56.3032751, -116.2455318,
  'Bluesky', 'SLAVE',
  'Pumping', 'HIGH', 12,
  3.6,
  1511, 15869.099609375,
  '2007-02-08', '2025-12-01',
  0.9781, 8,
  ARRAY[744,672,744,720,744,696,744,744,720,720,576,744]::int[],
  ARRAY[4.4000,5.7000,5.2000,3.1000,4.0000,1.5000,4.8000,4.8000,4.8000,4.1000,4.8000,3.6000]::numeric[],
  ARRAY[1,1,1,1,1,0.9667,1,1,1,0.9677,0.8,1]::numeric[],
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
  '100042908318W500', '100/04-29-083-18W5/00', 'PENN WEST PEACE RIVER 4-29-83-18',
  56.233295, -116.8187332,
  'Bluesky', 'UNDEFINED',
  'Operating', 'LOW', NULL,
  0,
  NULL, 4368.60009765625,
  '2007-04-01', '2014-11-01',
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
  '100092608415W507', '100/09-26-084-15W5/07', 'PENN WEST 102 SLAVE 9-26-84-15',
  56.3032821, -116.2456808,
  'Bluesky', 'SLAVE',
  'Pumping', 'HIGH', 12,
  6.1,
  2291, 34200.5,
  '2007-11-01', '2025-12-01',
  0.9909, 4,
  ARRAY[744,672,744,720,744,672,744,744,702,744,718,732]::int[],
  ARRAY[10.5000,8.1000,3.2000,7.1000,7.5000,6.0000,5.7000,4.1000,6.9000,6.1000,4.7000,6.2000]::numeric[],
  ARRAY[1,1,1,1,1,0.9333,1,1,0.975,1,0.9972,0.9839]::numeric[],
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
  '103080808215W500', '103/08-08-082-15W5/00', 'PENN WEST 103 SEAL 8-8-82-15',
  56.0883118, -116.3229397,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  9.6,
  3681, 26795.900390625,
  '2007-12-21', '2025-12-01',
  0.9516, 17,
  ARRAY[652,672,734,717,744,613,680,689,695,706,720,714]::int[],
  ARRAY[11.1000,11.1000,10.6000,10.8000,11.4000,10.5000,10.1000,10.8000,10.4000,10.5000,9.9000,10.0000]::numeric[],
  ARRAY[0.8763,1,0.9866,0.9958,1,0.8514,0.914,0.9261,0.9653,0.9489,1,0.9597]::numeric[],
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
  '100152608218W500', '100/15-26-082-18W5/00', 'PENN WEST WALRUS 15-26-82-18',
  56.1411361, -116.6649203,
  'Bluesky', 'UNDEFINED',
  'Operating', 'LOW', NULL,
  0,
  NULL, 65573.4921875,
  '2008-11-10', '2025-01-01',
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
