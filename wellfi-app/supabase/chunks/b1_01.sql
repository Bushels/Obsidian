INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100080808215W500', '100/08-08-082-15W5/00', 'PENN WEST PC RV 2 8-8-82-15',
  56.0930237, -116.3195216,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  6.9,
  2698, 26619.69921875,
  '2003-11-15', '2025-12-01',
  0.9493, 18,
  ARRAY[744,672,734,693,634,706,677,715,637,688,720,696]::int[],
  ARRAY[8.5000,8.1000,7.7000,7.9000,8.3000,7.7000,7.4000,7.9000,7.6000,7.7000,7.3000,7.3000]::numeric[],
  ARRAY[1,1,0.9866,0.9625,0.8522,0.9806,0.9099,0.961,0.8847,0.9247,1,0.9355]::numeric[],
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
  '103090808215W500', '103/09-08-082-15W5/00', 'PENN WEST 103 SEAL 9-8-82-15',
  56.0931797, -116.3196836,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  6.7,
  2503, 14931.900390625,
  '2004-10-13', '2025-12-01',
  0.9428, 21,
  ARRAY[725,672,734,669,610,706,677,715,623,688,720,720]::int[],
  ARRAY[7.6000,7.6000,7.2000,7.4000,7.8000,7.2000,6.9000,7.5000,7.2000,7.2000,6.8000,6.9000]::numeric[],
  ARRAY[0.9745,1,0.9866,0.9292,0.8199,0.9806,0.9099,0.961,0.8653,0.9247,1,0.9677]::numeric[],
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
  '100080508215W500', '100/08-05-082-15W5/00', 'PENN WEST SEAL 8-5-82-15',
  56.0815008, -116.3256029,
  'Bluesky', 'SEAL',
  'Pumping', 'DOWN NOW', NULL,
  0,
  1181, 7494.39990234375,
  '2006-10-02', '2025-04-01',
  0.2659, 268,
  ARRAY[698,636,734,261,0,0,0,0,0,0,0,0]::int[],
  ARRAY[12.4000,12.4000,11.8000,12.1000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0.9382,0.9464,0.9866,0.3625,0,0,0,0,0,0,0,0]::numeric[],
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
  '100160508215W500', '100/16-05-082-15W5/00', 'PENN WEST SEAL 16-5-82-15',
  56.0818608, -116.3256049,
  'Bluesky', 'SEAL',
  'Pumping', 'DOWN NOW', NULL,
  0.1,
  1933, 18288.5,
  '2006-10-02', '2025-12-01',
  0.8976, 38,
  ARRAY[744,660,734,717,744,706,633,741,702,714,720,48]::int[],
  ARRAY[6.6000,6.6000,6.3000,6.4000,6.8000,6.2000,6.0000,6.5000,6.2000,6.2000,1.5000,1.6000]::numeric[],
  ARRAY[1,0.9821,0.9866,0.9958,1,0.9806,0.8508,0.996,0.975,0.9597,1,0.0645]::numeric[],
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
  '104090808215W500', '104/09-08-082-15W5/00', 'PENN WEST 104 SEAL 9-8-82-15',
  56.0987257, -116.3218605,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  5.6,
  1475, 14155.7998046875,
  '2006-08-21', '2025-12-01',
  0.9845, 6,
  ARRAY[739,672,734,717,720,706,738,738,684,730,720,726]::int[],
  ARRAY[3.8000,3.8000,3.6000,3.7000,3.9000,3.6000,3.5000,4.5000,4.6000,3.0000,5.5000,5.7000]::numeric[],
  ARRAY[0.9933,1,0.9866,0.9958,0.9677,0.9806,0.9919,0.9919,0.95,0.9812,1,0.9758]::numeric[],
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
