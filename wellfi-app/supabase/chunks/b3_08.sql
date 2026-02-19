INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100023208319W509', '100/02-32-083-19W5/09', 'OBE 100 HZ HARMONV 2-32-83-19',
  56.2483061, -116.9656137,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  70.4,
  30558, 24091.099609375,
  '2022-12-19', '2025-12-01',
  0.8154, 69,
  ARRAY[460,466,419,558,474,491,743,608,720,742,718,744]::int[],
  ARRAY[160.2000,121.5000,130.1000,125.3000,167.1000,129.1000,67.8000,99.3000,81.8000,84.6000,71.4000,70.4000]::numeric[],
  ARRAY[0.6183,0.6935,0.5632,0.775,0.6371,0.6819,0.9987,0.8172,1,0.9973,0.9972,1]::numeric[],
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
  '100033208319W509', '100/03-32-083-19W5/09', 'OBE 100 HZ HARMONV 3-32-83-19',
  56.2483061, -116.9659967,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  97.6,
  37777, 22925.80078125,
  '2023-03-14', '2025-12-01',
  0.8954, 37,
  ARRAY[744,670,499,553,495,532,743,693,720,733,718,744]::int[],
  ARRAY[102.8000,99.2000,157.5000,154.8000,182.4000,140.3000,82.3000,102.0000,110.0000,107.9000,100.1000,97.6000]::numeric[],
  ARRAY[1,0.997,0.6707,0.7681,0.6653,0.7389,0.9987,0.9315,1,0.9852,0.9972,1]::numeric[],
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
  '100043208319W509', '100/04-32-083-19W5/09', 'OBE 100 HZ HARMONV 4-32-83-19',
  56.2483061, -116.9664007,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  115,
  52271, 22472.19921875,
  '2023-08-25', '2025-12-01',
  0.9205, 28,
  ARRAY[744,665,642,548,565,560,743,673,720,742,718,744]::int[],
  ARRAY[195.0000,190.8000,153.4000,216.6000,206.4000,208.6000,142.0000,124.3000,122.1000,116.7000,115.1000,115.0000]::numeric[],
  ARRAY[1,0.9896,0.8629,0.7611,0.7594,0.7778,0.9987,0.9046,1,0.9973,0.9972,1]::numeric[],
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
  '106093208115W507', '106/09-32-081-15W5/07', 'OBE 106 HZ DAWSON 9-32-81-15',
  56.0638208, -116.3280382,
  'Bluesky', 'DAWSON',
  'Pumping', 'HIGH', 12,
  64.7,
  29455, 20157.19921875,
  '2022-08-28', '2025-12-01',
  0.9685, 12,
  ARRAY[744,672,712,717,674,706,710,741,708,730,712,658]::int[],
  ARRAY[99.8000,99.3000,63.8000,89.3000,93.8000,78.5000,75.8000,88.8000,84.5000,83.3000,69.4000,73.2000]::numeric[],
  ARRAY[1,1,0.957,0.9958,0.9059,0.9806,0.9543,0.996,0.9833,0.9812,0.9889,0.8844]::numeric[],
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
  '104083208115W509', '104/08-32-081-15W5/09', 'OBE 104 HZ DAWSON 8-32-81-15',
  56.0637308, -116.3280332,
  'Bluesky', 'DAWSON',
  'Pumping', 'HIGH', 12,
  54.4,
  26781, 16791.30078125,
  '2022-08-28', '2025-12-01',
  0.9648, 13,
  ARRAY[744,672,712,685,674,706,710,741,708,730,712,658]::int[],
  ARRAY[96.3000,84.6000,58.7000,91.6000,91.2000,86.0000,74.3000,75.4000,68.2000,65.9000,59.1000,61.5000]::numeric[],
  ARRAY[1,1,0.957,0.9514,0.9059,0.9806,0.9543,0.996,0.9833,0.9812,0.9889,0.8844]::numeric[],
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
