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

INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100053108318W509', '100/05-31-083-18W5/09', 'PENN WEST 5-31-83-18',
  56.23701, -116.8200661,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  18.2,
  7594, 48540.1015625,
  '2014-11-08', '2025-12-01',
  0.9968, 1,
  ARRAY[730,672,743,718,743,713,744,744,717,744,720,744]::int[],
  ARRAY[22.4000,23.7000,23.7000,24.4000,24.2000,23.7000,20.7000,19.5000,17.4000,16.6000,16.5000,18.2000]::numeric[],
  ARRAY[0.9812,1,0.9987,0.9972,0.9987,0.9903,1,1,0.9958,1,1,1]::numeric[],
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
  '102143008318W509', '102/14-30-083-18W5/09', 'PENN WEST 102 HZ SEAL HA 14-30-83-18',
  56.21793, -116.8359296,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  14.7,
  6115, 45616.80078125,
  '2015-01-20', '2025-12-01',
  1, NULL,
  ARRAY[744,672,744,720,744,720,744,744,720,744,720,744]::int[],
  ARRAY[26.8000,19.7000,18.9000,22.2000,27.2000,26.6000,8.5000,8.4000,5.5000,6.8000,16.1000,14.7000]::numeric[],
  ARRAY[1,1,1,1,1,1,1,1,1,1,1,1]::numeric[],
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
  '100041908318W509', '100/04-19-083-18W5/09', 'PENN WEST HZ SEAL HARMON  4-19-83-18',
  56.21793, -116.8360906,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  33,
  6194, 29121.69921875,
  '2015-01-17', '2025-12-01',
  0.911, 33,
  ARRAY[744,672,636,462,500,572,744,744,720,732,720,734]::int[],
  ARRAY[23.6000,20.1000,22.6000,26.6000,27.8000,16.2000,8.8000,8.6000,7.6000,10.5000,23.9000,33.4000]::numeric[],
  ARRAY[1,1,0.8548,0.6417,0.672,0.7944,1,1,1,0.9839,1,0.9866]::numeric[],
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
  '103143008318W509', '103/14-30-083-18W5/09', 'PENN WEST HZ SEAL HARMON 14-30-83-18',
  56.217929, -116.8362516,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'RECENTLY CHANGED', 7,
  1.3,
  3717, 25941.599609375,
  '2015-01-16', '2025-12-01',
  0.7725, 82,
  ARRAY[744,648,448,86,98,399,744,696,720,744,720,720]::int[],
  ARRAY[8.1000,6.5000,13.3000,62.8000,77.5000,24.0000,14.9000,14.1000,11.7000,16.0000,11.5000,1.3000]::numeric[],
  ARRAY[1,0.9643,0.6022,0.1194,0.1317,0.5542,1,0.9355,1,1,1,0.9677]::numeric[],
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
  '100163108318W509', '100/16-31-083-18W5/09', 'PENN WEST HZ 16-31-83-18',
  56.233614, -116.8187841,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  25,
  5342, 24878,
  '2015-03-26', '2025-12-01',
  0.9889, 4,
  ARRAY[744,672,744,719,726,718,744,740,720,672,720,744]::int[],
  ARRAY[16.9000,17.9000,17.2000,14.4000,11.4000,6.7000,4.5000,4.9000,11.4000,20.4000,27.7000,25.0000]::numeric[],
  ARRAY[1,1,1,0.9986,0.9758,0.9972,1,0.9946,1,0.9032,1,1]::numeric[],
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

INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '102143508218W509', '102/14-35-082-18W5/09', 'PENN WEST 102 HZ WALRUS 14-35-82-18',
  56.1408862, -116.7064747,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  30.7,
  14237, 98896.0078125,
  '2015-11-30', '2025-12-01',
  0.9983, NULL,
  ARRAY[744,662,744,720,744,720,744,744,715,744,720,744]::int[],
  ARRAY[48.0000,45.6000,44.1000,37.5000,41.5000,31.8000,32.0000,29.9000,39.0000,48.0000,41.3000,30.7000]::numeric[],
  ARRAY[1,0.9851,1,1,1,1,1,1,0.9931,1,1,1]::numeric[],
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
  '100143508218W509', '100/14-35-082-18W5/09', 'PENN WEST HZ WALRUS 14-35-82-18',
  56.1408862, -116.7067967,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  12,
  8318, 53524.30078125,
  '2015-11-27', '2025-12-01',
  0.9968, 1,
  ARRAY[744,663,727,720,744,720,742,744,720,744,720,744]::int[],
  ARRAY[17.0000,31.7000,34.3000,29.3000,31.0000,30.4000,24.0000,12.5000,18.0000,20.7000,14.7000,12.0000]::numeric[],
  ARRAY[1,0.9866,0.9772,1,1,1,0.9973,1,1,1,1,1]::numeric[],
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
  '100123508218W509', '100/12-35-082-18W5/09', 'PENN WEST HZ WALRUS 12-35-82-18',
  56.1408862, -116.7071177,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  23.4,
  10282, 39710.6015625,
  '2015-11-16', '2025-12-01',
  0.9999, NULL,
  ARRAY[744,671,744,720,744,720,744,744,720,744,720,744]::int[],
  ARRAY[33.9000,33.9000,32.5000,30.0000,32.1000,27.7000,25.4000,20.6000,27.5000,27.4000,24.0000,23.4000]::numeric[],
  ARRAY[1,0.9985,1,1,1,1,1,1,1,1,1,1]::numeric[],
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
  '100161208318W509', '100/16-12-083-18W5/09', 'PENN WEST HZ 102 PEACE R 16-12-83-18',
  56.1715441, -116.69449,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  13,
  5678, 22980.19921875,
  '2015-11-03', '2025-12-01',
  0.9429, 20,
  ARRAY[744,667,501,471,744,720,744,741,720,744,720,744]::int[],
  ARRAY[21.5000,21.2000,19.5000,23.9000,21.2000,16.2000,12.7000,13.0000,13.0000,13.5000,13.3000,13.0000]::numeric[],
  ARRAY[1,0.9926,0.6734,0.6542,1,1,1,0.996,1,1,1,1]::numeric[],
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
  '100163508218W509', '100/16-35-082-18W5/09', 'PENN WEST HZ PEACE RIVER 16-35-82-18',
  56.1715441, -116.694653,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  8.3,
  3322, 36877,
  '2015-11-03', '2025-12-01',
  0.9659, 10,
  ARRAY[733,639,737,697,733,712,737,665,720,624,720,744]::int[],
  ARRAY[10.6000,11.4000,11.0000,11.7000,11.3000,11.1000,11.2000,8.3000,3.5000,5.3000,8.8000,8.3000]::numeric[],
  ARRAY[0.9852,0.9509,0.9906,0.9681,0.9852,0.9889,0.9906,0.8938,1,0.8387,1,1]::numeric[],
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

INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100040108318W509', '100/04-01-083-18W5/09', 'PENN WEST HZ WALRUS 4-1-83-18',
  56.1727281, -116.7040231,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  72, 16469.69921875,
  '2016-02-05', '2025-01-01',
  0.0233, 357,
  ARRAY[204,0,0,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[8.4000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0.2742,0,0,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '104051308218W509', '104/05-13-082-18W5/09', 'PENN WEST HZ HARMONV 5-13-82-18',
  56.1163942, -116.6593397,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'HIGH', 12,
  51.8,
  30763, 78228.296875,
  '2017-02-28', '2025-12-01',
  0.9935, 2,
  ARRAY[742,672,743,711,738,694,744,744,707,744,720,744]::int[],
  ARRAY[90.3000,93.4000,91.6000,94.8000,96.5000,91.5000,93.2000,85.3000,90.8000,89.6000,50.3000,51.8000]::numeric[],
  ARRAY[0.9973,1,0.9987,0.9875,0.9919,0.9639,1,1,0.9819,1,1,1]::numeric[],
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
  '100021808217W509', '100/02-18-082-17W5/09', 'PENN WEST HZ DAWSON 2-18-82-17',
  56.1166452, -116.6507876,
  'Bluesky', 'DAWSON',
  'Pumping', 'HIGH', 12,
  0.9,
  4868, 8904.099609375,
  '2016-11-25', '2025-12-01',
  0.9991, NULL,
  ARRAY[741,672,743,718,743,719,744,744,720,744,720,744]::int[],
  ARRAY[18.2000,17.3000,18.1000,16.9000,17.3000,5.9000,14.9000,13.8000,18.0000,18.0000,0.9000,0.9000]::numeric[],
  ARRAY[0.996,1,0.9987,0.9972,0.9987,0.9986,1,1,1,1,1,1]::numeric[],
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
  '102151908217W509', '102/15-19-082-17W5/09', 'PENN WEST HZ WALRUS 15-19-82-17',
  56.1166442, -116.6503856,
  'Bluesky', 'DAWSON',
  'Pumping', 'RECENTLY CHANGED', 2,
  2.2,
  2259, 6805.7998046875,
  '2016-12-02', '2025-12-01',
  0.8191, 66,
  ARRAY[741,648,699,689,740,0,744,730,720,0,720,744]::int[],
  ARRAY[12.0000,9.7000,11.5000,12.8000,10.6000,NULL,11.3000,2.3000,2.2000,NULL,1.5000,2.2000]::numeric[],
  ARRAY[0.996,0.9643,0.9395,0.9569,0.9946,0,1,0.9812,1,0,1,1]::numeric[],
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
  '100151908217W509', '100/15-19-082-17W5/09', 'PENN WEST HZ WALRUS 15-19-82-17',
  56.1166442, -116.6503856,
  'Bluesky', 'DAWSON',
  'Pumping', 'HIGH', 12,
  0.4,
  2455, 9143.900390625,
  '2016-11-25', '2025-12-01',
  0.9977, 1,
  ARRAY[741,672,743,707,743,718,744,744,720,744,720,744]::int[],
  ARRAY[11.3000,11.3000,11.3000,11.0000,10.9000,3.0000,12.2000,3.3000,3.1000,2.9000,0.5000,0.4000]::numeric[],
  ARRAY[0.996,1,0.9987,0.9819,0.9987,0.9972,1,1,1,1,1,1]::numeric[],
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
  '100011908318W509', '100/01-19-083-18W5/09', 'PENN WEST HZ PEACE RIVER 1-19-83-18',
  56.218017, -116.8299975,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  3.2,
  3900, 22898,
  '2016-09-10', '2025-12-01',
  0.9911, 2,
  ARRAY[744,672,739,714,728,685,744,734,714,744,720,744]::int[],
  ARRAY[17.5000,13.0000,14.2000,17.5000,15.8000,9.0000,7.8000,10.0000,10.9000,6.1000,4.7000,3.2000]::numeric[],
  ARRAY[1,1,0.9933,0.9917,0.9785,0.9514,1,0.9866,0.9917,1,1,1]::numeric[],
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
  '102021908318W509', '102/02-19-083-18W5/09', 'PENN WEST HZ PEACE RIVER 2-19-83-18',
  56.218016, -116.8304005,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  9.5,
  2840, 23763.5,
  '2016-09-25', '2025-12-01',
  0.9957, 2,
  ARRAY[744,648,744,720,744,706,744,744,720,744,720,744]::int[],
  ARRAY[10.6000,10.7000,11.7000,10.8000,10.2000,7.9000,1.1000,3.3000,3.4000,4.5000,10.5000,9.5000]::numeric[],
  ARRAY[1,0.9643,1,1,1,0.9806,1,1,1,1,1,1]::numeric[],
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
  '100081908217W509', '100/08-19-082-17W5/09', 'PENN WEST HZ WALRUS 8-19-82-17',
  56.1134812, -116.6676558,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'HIGH', 12,
  6.4,
  5407, 14619.099609375,
  '2016-12-23', '2025-12-01',
  0.9997, NULL,
  ARRAY[744,672,744,720,741,720,744,744,720,744,720,744]::int[],
  ARRAY[33.6000,32.0000,33.4000,27.5000,10.1000,4.8000,5.1000,5.2000,6.7000,7.4000,6.8000,6.4000]::numeric[],
  ARRAY[1,1,1,1,0.996,1,1,1,1,1,1,1]::numeric[],
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
  '100011308218W509', '100/01-13-082-18W5/09', 'PENN WEST HZ HARMONV 1-13-82-18',
  56.1134812, -116.6680568,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'HIGH', 12,
  6.1,
  3038, 12639.900390625,
  '2016-12-15', '2025-12-01',
  0.9993, NULL,
  ARRAY[744,672,744,720,741,720,744,741,720,744,720,744]::int[],
  ARRAY[11.2000,13.3000,13.0000,8.8000,8.4000,6.9000,6.6000,6.2000,4.7000,7.8000,7.4000,6.1000]::numeric[],
  ARRAY[1,1,1,1,0.996,1,1,0.996,1,1,1,1]::numeric[],
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
  '102011308218W509', '102/01-13-082-18W5/09', 'PENN WEST 102 HZ HARMONV 1-13-82-18',
  56.1134812, -116.6688598,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'HIGH', 12,
  3.8,
  4900, 22707.80078125,
  '2016-12-14', '2025-12-01',
  0.9942, 2,
  ARRAY[744,672,725,720,741,696,744,744,720,739,720,744]::int[],
  ARRAY[15.9000,16.2000,19.3000,22.1000,13.0000,16.9000,20.5000,10.4000,9.5000,9.8000,5.2000,3.8000]::numeric[],
  ARRAY[1,1,0.9745,1,0.996,0.9667,1,1,1,0.9933,1,1]::numeric[],
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
