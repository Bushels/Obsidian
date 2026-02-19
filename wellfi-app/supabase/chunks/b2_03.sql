INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '102163008318W509', '102/16-30-083-18W5/09', 'PENN WEST 102 HZ 16-30-83-18',
  56.217814, -116.8209974,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  14.4,
  6173, 16087,
  '2015-01-30', '2025-12-01',
  0.9927, 2,
  ARRAY[736,672,744,719,734,690,744,744,720,744,720,729]::int[],
  ARRAY[19.4000,19.5000,18.0000,7.7000,16.0000,18.0000,17.0000,22.2000,19.2000,20.2000,12.4000,14.7000]::numeric[],
  ARRAY[0.9892,1,1,0.9986,0.9866,0.9583,1,1,1,1,1,0.9798]::numeric[],
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
  '100043008318W509', '100/04-30-083-18W5/09', 'PENN WEST HZ PEACE R 4-30-83-18',
  56.217815, -116.8211174,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  6.9,
  3139, 15333,
  '2015-01-28', '2025-12-01',
  0.997, 1,
  ARRAY[738,672,744,719,741,720,744,743,720,744,720,729]::int[],
  ARRAY[10.1000,10.7000,11.7000,13.2000,10.2000,6.8000,6.5000,6.7000,7.2000,6.3000,7.2000,7.0000]::numeric[],
  ARRAY[0.9919,1,1,0.9986,0.996,1,1,0.9987,1,1,1,0.9798]::numeric[],
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
  '102122408218W509', '102/12-24-082-18W5/09', 'PENN WEST SEAL HV SOUTH 12-24-82-18',
  56.1428842, -116.6832604,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  66.1,
  29200, 86650.203125,
  '2015-03-14', '2025-12-01',
  0.9763, 8,
  ARRAY[732,666,744,710,743,547,738,744,720,744,720,744]::int[],
  ARRAY[92.1000,77.7000,82.1000,76.0000,61.6000,43.8000,90.0000,100.8000,102.6000,104.1000,76.3000,66.1000]::numeric[],
  ARRAY[0.9839,0.9911,1,0.9861,0.9987,0.7597,0.9919,1,1,1,1,1]::numeric[],
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
  '102092308218W509', '102/09-23-082-18W5/09', 'PENN WEST SEAL HV SOUTH 9-23-82-18',
  56.1428842, -116.6834214,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  86.8,
  23329, 83293.5078125,
  '2015-03-14', '2025-12-01',
  0.9325, 25,
  ARRAY[744,617,742,709,659,631,722,744,504,648,720,729]::int[],
  ARRAY[65.0000,53.5000,56.3000,58.4000,53.9000,61.3000,66.4000,70.5000,63.1000,83.8000,97.2000,88.6000]::numeric[],
  ARRAY[1,0.9182,0.9973,0.9847,0.8858,0.8764,0.9704,1,0.7,0.871,1,0.9798]::numeric[],
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
  '100142208419W509', '100/14-22-084-19W5/09', 'PENN WEST HZ PEACE R 14-22-84-19',
  56.2876047, -116.9081986,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  8.3,
  7599, 34898.69921875,
  '2015-07-31', '2025-12-01',
  0.9202, 29,
  ARRAY[744,672,744,720,695,696,740,554,720,744,720,312]::int[],
  ARRAY[23.9000,23.7000,23.5000,22.0000,24.5000,23.4000,24.3000,24.5000,22.6000,21.1000,17.2000,19.7000]::numeric[],
  ARRAY[1,1,1,1,0.9341,0.9667,0.9946,0.7446,1,1,1,0.4194]::numeric[],
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
