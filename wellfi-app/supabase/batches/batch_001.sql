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

INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100010808215W500', '100/01-08-082-15W5/00', 'PENN WEST SEAL 1-8-82-15',
  56.0880898, -116.3244048,
  'Bluesky', 'SEAL',
  'Pumping', 'LOW', NULL,
  0,
  NULL, 16719.400390625,
  '2006-07-16', '2024-12-01',
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
  '103160808215W500', '103/16-08-082-15W5/00', 'PENN WEST 103 SEAL 16-8-82-15',
  56.0989337, -116.3215535,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  8.7,
  3295, 11979.7001953125,
  '2006-08-21', '2025-12-01',
  0.8963, 38,
  ARRAY[356,660,734,708,600,625,665,720,644,742,720,678]::int[],
  ARRAY[12.6000,9.5000,8.6000,7.8000,8.1000,8.6000,8.2000,9.4000,15.0000,14.9000,9.5000,9.6000]::numeric[],
  ARRAY[0.4785,0.9821,0.9866,0.9833,0.8065,0.8681,0.8938,0.9677,0.8944,0.9973,1,0.9113]::numeric[],
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
  '103090508215W500', '103/09-05-082-15W5/00', 'PENN WEST 103 SEAL 9-5-82-15',
  56.0817708, -116.3256049,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  15.5,
  3586, 22069.900390625,
  '2006-10-02', '2025-12-01',
  0.9803, 9,
  ARRAY[744,660,734,717,732,706,698,741,683,708,720,744]::int[],
  ARRAY[9.5000,9.5000,9.0000,9.3000,9.8000,9.0000,8.6000,9.3000,9.0000,8.9000,12.5000,15.5000]::numeric[],
  ARRAY[1,0.9821,0.9866,0.9958,0.9839,0.9806,0.9382,0.996,0.9486,0.9516,1,1]::numeric[],
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
  '100152408419W500', '100/15-24-084-19W5/00', 'PENN WEST PEACE RIVER 15-24-84-19',
  56.2886668, -116.8523369,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  1.5,
  2398, 24312.30078125,
  '2006-05-28', '2025-12-01',
  0.9726, 10,
  ARRAY[744,672,744,720,744,720,744,744,720,744,720,504]::int[],
  ARRAY[7.5000,5.8000,7.3000,6.9000,6.7000,7.3000,7.3000,7.3000,7.3000,6.8000,7.2000,2.3000]::numeric[],
  ARRAY[1,1,1,1,1,1,1,1,1,1,1,0.6774]::numeric[],
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
  '100162408419W500', '100/16-24-084-19W5/00', 'PENN WEST PEACE RIVER 16-24-84-19',
  56.2886668, -116.8518529,
  'Bluesky', 'UNDEFINED',
  'Operating', 'DOWN NOW', NULL,
  0,
  1049, 16685.30078125,
  '2006-05-28', '2025-07-01',
  0.5507, 164,
  ARRAY[744,672,744,720,744,720,480,0,0,0,0,0]::int[],
  ARRAY[4.5000,5.7000,5.5000,5.6000,4.7000,5.3000,5.4000,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[1,1,1,1,1,1,0.6452,0,0,0,0,0]::numeric[],
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
  '104152408419W500', '104/15-24-084-19W5/00', 'PENN WEST 103 PEACE RIV 15-24-84-19',
  56.2886668, -116.8521749,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  1530, 16732.69921875,
  '2006-05-28', '2025-10-01',
  0.789, 77,
  ARRAY[744,672,744,720,744,576,528,744,720,720,0,0]::int[],
  ARRAY[6.9000,6.5000,6.2000,5.7000,4.0000,2.4000,8.3000,4.6000,4.2000,4.5000,NULL,NULL]::numeric[],
  ARRAY[1,1,1,1,1,0.8,0.7097,1,1,0.9677,0,0]::numeric[],
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
  '100142408419W500', '100/14-24-084-19W5/00', 'PENN WEST PEACE RIVER 14-24-84-19',
  56.2886697, -116.862764,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  5.2,
  2112, 17928.599609375,
  '2006-12-05', '2025-12-01',
  1, NULL,
  ARRAY[744,672,744,720,744,720,744,744,720,744,720,744]::int[],
  ARRAY[6.3000,6.1000,6.9000,6.9000,6.5000,6.4000,5.2000,4.9000,5.2000,5.0000,5.1000,5.2000]::numeric[],
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
  '102142408419W500', '102/14-24-084-19W5/00', 'PENN WEST 102 PEACE RIV 6-24-84-19',
  56.2886697, -116.862925,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  8.2,
  2715, 19385.5,
  '2006-12-05', '2025-12-01',
  0.9699, 11,
  ARRAY[744,672,744,720,744,600,744,744,576,744,720,744]::int[],
  ARRAY[8.4000,7.5000,8.4000,7.6000,8.2000,8.4000,7.1000,6.0000,6.5000,7.8000,7.8000,8.2000]::numeric[],
  ARRAY[1,1,1,1,1,0.8333,1,1,0.8,1,1,1]::numeric[],
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
  '103142408419W500', '103/14-24-084-19W5/00', 'PENN WEST 103 PEACE RIV 14-24-84-19',
  56.2886697, -116.863086,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  1,
  1465, 14986.900390625,
  '2006-12-05', '2025-12-01',
  0.8826, 43,
  ARRAY[744,672,720,720,744,684,576,736,576,744,696,120]::int[],
  ARRAY[4.7000,4.5000,5.1000,4.4000,4.5000,3.9000,5.9000,4.2000,4.0000,4.3000,4.4000,6.3000]::numeric[],
  ARRAY[1,1,0.9677,1,1,0.95,0.7742,0.9892,0.8,1,0.9667,0.1613]::numeric[],
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
  '1W0132408419W500', '1W0/13-24-084-19W5/00', 'PENN WEST 103 PEACE RIV 13-24-84-19',
  56.2886717, -116.8726021,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'LOW', NULL,
  0,
  NULL, 13737,
  '2006-12-18', '2024-09-01',
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

INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100112608218W500', '100/11-26-082-18W5/00', 'PENN WEST WALRUS 11-26-82-18',
  56.1409571, -116.6649203,
  'Bluesky', 'UNDEFINED',
  'Operating', 'LOW', NULL,
  0,
  NULL, 367.7000122070312,
  '2008-11-10', '2013-06-01',
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
  '102052408218W502', '102/05-24-082-18W5/02', 'PENN WEST HZ HARMON 5-24-82-18',
  56.1407302, -116.6829395,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0.3,
  7241, 86514.5,
  '2010-04-26', '2025-12-01',
  0.9201, 29,
  ARRAY[744,595,702,720,744,720,715,744,720,744,720,192]::int[],
  ARRAY[21.4000,23.3000,21.2000,20.4000,20.9000,34.8000,26.7000,17.9000,18.6000,35.8000,1.5000,1.3000]::numeric[],
  ARRAY[1,0.8854,0.9435,1,1,1,0.961,1,1,1,1,0.2581]::numeric[],
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
  '100062408218W503', '100/06-24-082-18W5/03', 'PENN WEST HZ HARMON 6-24-82-18',
  56.1407302, -116.6827785,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  1.4,
  7069, 57136.19921875,
  '2010-04-23', '2025-12-01',
  0.9295, 25,
  ARRAY[744,658,734,720,744,720,715,736,720,744,715,192]::int[],
  ARRAY[32.5000,23.8000,21.6000,31.3000,23.3000,21.6000,20.3000,17.3000,23.9000,11.2000,6.5000,5.6000]::numeric[],
  ARRAY[1,0.9792,0.9866,1,1,1,0.961,0.9892,1,1,0.9931,0.2581]::numeric[],
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
  '103052408218W502', '103/05-24-082-18W5/02', 'PENN WEST HZ 103 HARMON  5-24-82-18',
  56.1404602, -116.6834215,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  4.5,
  9588, 85981.109375,
  '2010-11-30', '2025-12-01',
  0.9694, 11,
  ARRAY[741,668,505,720,744,720,744,744,720,744,720,722]::int[],
  ARRAY[36.8000,31.3000,25.6000,35.6000,36.4000,32.5000,28.5000,26.2000,22.0000,22.7000,22.4000,4.7000]::numeric[],
  ARRAY[0.996,0.994,0.6788,1,1,1,1,1,1,1,1,0.9704]::numeric[],
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
  '100040608317W502', '100/04-06-083-17W5/02', 'PENN WEST 102 HZ WALRUS 4-6-83-17',
  56.1427032, -116.6827784,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  29.6,
  11574, 43556.80078125,
  '2010-12-02', '2025-12-01',
  0.8981, 38,
  ARRAY[744,603,667,510,524,634,696,648,648,744,720,729]::int[],
  ARRAY[39.6000,41.1000,41.1000,49.2000,47.0000,37.1000,30.6000,29.3000,28.3000,23.7000,34.0000,30.2000]::numeric[],
  ARRAY[1,0.8973,0.8965,0.7083,0.7043,0.8806,0.9355,0.871,0.9,1,1,0.9798]::numeric[],
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
  '104093608218W509', '104/09-36-082-18W5/09', 'OBE HZ WALRUS 9-36-82-18',
  56.1422161, -116.6647632,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  7.2,
  6302, 29805.30078125,
  '2017-10-14', '2025-12-01',
  0.9943, 1,
  ARRAY[744,671,744,690,735,719,741,738,720,744,720,744]::int[],
  ARRAY[17.1000,20.7000,18.6000,16.6000,18.5000,20.5000,20.0000,18.3000,21.1000,18.8000,11.1000,7.2000]::numeric[],
  ARRAY[1,0.9985,1,0.9583,0.9879,0.9986,0.996,0.9919,1,1,1,1]::numeric[],
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
  '102043208318W509', '102/04-32-083-18W5/09', 'PENN WEST HZ PEACE RIVER 4-32-83-18',
  56.217826, -116.8201594,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'RECENTLY CHANGED', 6,
  10.2,
  3249, 23807.400390625,
  '2016-11-02', '2025-12-01',
  0.7627, 87,
  ARRAY[744,672,744,558,0,0,312,738,720,744,720,729]::int[],
  ARRAY[14.2000,14.7000,14.1000,13.2000,NULL,NULL,11.6000,11.9000,10.6000,5.9000,10.6000,10.4000]::numeric[],
  ARRAY[1,1,1,0.775,0,0,0.4194,0.9919,1,1,1,0.9798]::numeric[],
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
  '102042008318W509', '102/04-20-083-18W5/09', 'PENN WEST HZ PEACE RIVER 4-20-83-18',
  56.217827, -116.8203214,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'LOW', NULL,
  0,
  NULL, 8012.7001953125,
  '2016-11-04', '2024-08-01',
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
  '100132708415W508', '100/13-27-084-15W5/08', 'PENN WEST HZ SLAVE 13-27-84-15',
  56.3028422, -116.2806339,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  24.8,
  9015, 22172.19921875,
  '2014-02-14', '2025-12-01',
  0.9511, 19,
  ARRAY[744,672,744,672,744,720,744,726,702,744,392,728]::int[],
  ARRAY[27.3000,26.9000,27.2000,17.2000,27.8000,25.9000,26.7000,25.0000,26.9000,26.8000,29.5000,25.3000]::numeric[],
  ARRAY[1,1,1,0.9333,1,1,1,0.9758,0.975,1,0.5444,0.9785]::numeric[],
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
  '100143008318W502', '100/14-30-083-18W5/02', 'PENN WEST PEACE RIVER  14-30-83-18',
  56.217841, -116.8369876,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  3.4,
  1650, 16190.7001953125,
  '2011-04-03', '2025-12-01',
  0.968, 12,
  ARRAY[720,672,681,694,704,689,744,696,720,720,720,720]::int[],
  ARRAY[6.8000,6.0000,4.9000,5.3000,5.8000,5.2000,3.3000,4.1000,2.5000,2.9000,5.9000,3.6000]::numeric[],
  ARRAY[0.9677,1,0.9153,0.9639,0.9462,0.9569,1,0.9355,1,0.9677,1,0.9677]::numeric[],
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
  '100061908318W509', '100/06-19-083-18W5/09', 'PENN WEST 102 RE PEACE RV 6-19-83-18',
  56.217848, -116.8371436,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  6.5,
  2390, 2659.60009765625,
  '2013-11-29', '2025-12-01',
  0.9981, NULL,
  ARRAY[744,672,737,712,743,720,744,743,720,744,720,744]::int[],
  ARRAY[9.2000,6.2000,4.9000,8.5000,7.2000,6.4000,7.7000,6.4000,3.4000,5.9000,6.3000,6.5000]::numeric[],
  ARRAY[1,1,0.9906,0.9889,0.9987,1,1,0.9987,1,1,1,1]::numeric[],
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
  '103131908217W509', '103/13-19-082-17W5/09', 'PENN WEST 104 HZ WALRUS 13-19-82-17',
  56.1163032, -116.6589377,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  10.7,
  2067, 8385.2998046875,
  '2017-02-28', '2025-12-01',
  0.9979, NULL,
  ARRAY[744,672,738,713,742,720,744,741,720,744,720,744]::int[],
  ARRAY[4.9000,4.3000,3.3000,3.9000,3.2000,3.1000,3.2000,3.3000,6.6000,9.5000,12.0000,10.7000]::numeric[],
  ARRAY[1,1,0.9919,0.9903,0.9973,1,1,0.996,1,1,1,1]::numeric[],
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
  '104041808217W509', '104/04-18-082-17W5/09', 'PENN WEST 105 HZ DAWSON 4-18-82-17',
  56.1163032, -116.6587767,
  'Bluesky', 'DAWSON',
  'Pumping', 'HIGH', 12,
  11.3,
  3588, 15551.5,
  '2017-02-28', '2025-12-01',
  0.9118, 32,
  ARRAY[744,672,677,337,454,687,744,744,720,744,720,744]::int[],
  ARRAY[10.1000,10.3000,12.0000,13.3000,14.3000,12.6000,9.2000,9.2000,10.0000,8.8000,11.3000,11.3000]::numeric[],
  ARRAY[1,1,0.9099,0.4681,0.6102,0.9542,1,1,1,1,1,1]::numeric[],
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
  '102133108318W509', '102/13-31-083-18W5/09', 'PENN WEST 102 RE PEACE R 13-31-83-18',
  56.2455089, -116.820007,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  28.8,
  11674, 69434.296875,
  '2013-11-17', '2025-12-01',
  0.99, 3,
  ARRAY[693,640,739,720,744,720,744,744,720,744,720,744]::int[],
  ARRAY[31.3000,27.7000,24.5000,27.3000,29.2000,30.0000,28.1000,55.9000,38.7000,31.2000,34.3000,28.8000]::numeric[],
  ARRAY[0.9315,0.9524,0.9933,1,1,1,1,1,1,1,1,1]::numeric[],
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
  '100151208318W502', '100/15-12-083-18W5/02', 'PENN WEST PEACE RIVER 15-12-83-18',
  56.1725751, -116.7028121,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'LOW', NULL,
  0,
  NULL, 6226.2001953125,
  '2012-03-26', '2024-02-01',
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
  '100020108318W502', '100/02-01-083-18W5/02', 'PENN WEST PEACE RIVER 2-1-83-18',
  56.1725741, -116.7026221,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  21, 30120.900390625,
  '2012-03-26', '2025-01-01',
  0.0247, 356,
  ARRAY[216,0,0,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[2.4000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0.2903,0,0,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '102060108216W503', '102/06-01-082-16W5/03', 'PENN WEST 102 HZ SEAL 6-1-82-16',
  56.0868878, -116.3456859,
  'Bluesky', 'SEAL',
  'Pumping', 'WATCH', 11,
  30.4,
  10510, 7041.7998046875,
  '2012-05-14', '2025-12-01',
  0.8808, 43,
  ARRAY[132,360,686,716,744,720,744,744,720,744,720,686]::int[],
  ARRAY[14.1000,4.5000,14.1000,40.7000,38.8000,34.3000,31.7000,31.3000,31.3000,33.1000,55.2000,32.9000]::numeric[],
  ARRAY[0.1774,0.5357,0.922,0.9944,1,1,1,1,1,1,1,0.922]::numeric[],
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
  '104162408419W508', '104/16-24-084-19W5/08', 'PENN WEST 104 HZ PEACE R 16-24-84-19',
  56.2889668, -116.8514159,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  3083, 38096.58984375,
  '2012-03-30', '2025-11-01',
  0.8771, 45,
  ARRAY[737,658,744,720,744,720,744,744,720,744,408,0]::int[],
  ARRAY[10.5000,9.8000,10.6000,9.0000,9.6000,8.9000,9.9000,9.4000,8.4000,8.6000,12.3000,NULL]::numeric[],
  ARRAY[0.9906,0.9792,1,1,1,1,1,1,1,1,0.5667,0]::numeric[],
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
  '104052508419W509', '104/05-25-084-19W5/09', 'PENN WEST 103 HZ PEACE R 5-25-84-19',
  56.3126437, -116.8449145,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  21,
  8055, 28364.599609375,
  '2012-11-20', '2025-12-01',
  0.9606, 15,
  ARRAY[607,576,741,720,743,720,744,744,720,732,624,744]::int[],
  ARRAY[19.4000,24.2000,25.1000,24.0000,23.1000,27.2000,23.6000,22.8000,23.7000,22.5000,18.3000,21.0000]::numeric[],
  ARRAY[0.8159,0.8571,0.996,1,0.9987,1,1,1,1,0.9839,0.8667,1]::numeric[],
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
  '106132508419W508', '106/13-25-084-19W5/08', 'PENN WEST 105 HZ PEACE R 13-25-84-19',
  56.3127337, -116.8449145,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  9.9,
  4487, 29173.30078125,
  '2012-11-20', '2025-12-01',
  0.9821, 6,
  ARRAY[674,640,737,720,744,704,712,744,720,744,720,744]::int[],
  ARRAY[15.2000,15.4000,14.2000,8.7000,7.5000,11.3000,14.1000,14.1000,13.5000,14.0000,12.9000,9.9000]::numeric[],
  ARRAY[0.9059,0.9524,0.9906,1,1,0.9778,0.957,1,1,1,1,1]::numeric[],
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
  '105132408419W509', '105/13-24-084-19W5/09', 'PENN WEST 104 HZ PEACE R 13-24-84-19',
  56.2886717, -116.8713331,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  15.8,
  7110, 46227.1015625,
  '2012-12-23', '2025-12-01',
  0.9949, 2,
  ARRAY[719,655,741,720,744,720,744,744,720,744,720,744]::int[],
  ARRAY[20.1000,19.9000,20.7000,20.1000,21.0000,18.8000,19.6000,19.5000,19.7000,20.1000,19.6000,15.8000]::numeric[],
  ARRAY[0.9664,0.9747,0.996,1,1,1,1,1,1,1,1,1]::numeric[],
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
  '104162308419W508', '104/16-23-084-19W5/08', 'PENN WEST 104 PEACE RIVE 16-23-84-19',
  56.2886717, -116.8714941,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  16.7,
  6404, 33514.19921875,
  '2012-12-23', '2025-12-01',
  0.9759, 9,
  ARRAY[717,503,729,720,744,720,744,744,720,744,720,744]::int[],
  ARRAY[18.8000,7.1000,17.2000,16.0000,16.8000,17.1000,19.4000,18.8000,22.1000,21.3000,21.2000,16.7000]::numeric[],
  ARRAY[0.9637,0.7485,0.9798,1,1,1,1,1,1,1,1,1]::numeric[],
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
  '105142408419W509', '105/14-24-084-19W5/09', 'PENN WEST 105 HZ PEACE R 14-24-84-19',
  56.2886687, -116.862119,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  12.9,
  6203, 32407.69921875,
  '2012-11-28', '2025-12-01',
  0.9742, 9,
  ARRAY[739,643,744,720,744,720,744,744,720,744,720,552]::int[],
  ARRAY[17.3000,17.2000,18.1000,17.8000,18.2000,17.6000,18.0000,12.9000,18.6000,17.4000,19.0000,17.4000]::numeric[],
  ARRAY[0.9933,0.9568,1,1,1,1,1,1,1,1,1,0.7419]::numeric[],
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
  '106042508419W508', '106/04-25-084-19W5/08', 'PENN WEST 106 PEACE RIVER 4-25-84-19',
  56.3071167, -116.8449136,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  22.5,
  7055, 31722,
  '2013-02-11', '2025-12-01',
  0.9817, 7,
  ARRAY[744,672,619,702,728,719,744,744,720,744,720,744]::int[],
  ARRAY[18.3000,21.2000,22.4000,17.8000,14.7000,16.5000,22.1000,20.8000,19.0000,20.8000,20.6000,22.5000]::numeric[],
  ARRAY[1,1,0.832,0.975,0.9785,0.9986,1,1,1,1,1,1]::numeric[],
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
  '100082708218W509', '100/08-27-082-18W5/09', 'OBE REENTRY HZ WALR 8-27-82-18',
  56.1453652, -116.7225968,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'LOW', NULL,
  0,
  NULL, 7301.60009765625,
  '2017-08-29', '2024-11-01',
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
  '100163408218W509', '100/16-34-082-18W5/09', 'PENN WEST REENTRY HZ WAL 16-34-82-18',
  56.1453642, -116.7224388,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  44.3,
  12712, 34335.8984375,
  '2017-08-29', '2025-12-01',
  0.9978, 1,
  ARRAY[744,672,739,707,743,720,744,744,720,744,720,744]::int[],
  ARRAY[37.6000,38.4000,47.8000,39.9000,39.8000,11.8000,19.1000,37.0000,32.6000,27.4000,43.3000,44.3000]::numeric[],
  ARRAY[1,1,0.9933,0.9819,0.9987,1,1,1,1,1,1,1]::numeric[],
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
  '102020108318W508', '102/02-01-083-18W5/08', 'PENN WEST HZ PEACE RVR 2-1-83-18',
  56.1725811, -116.7037201,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  100, 27189.5,
  '2013-06-23', '2025-01-01',
  0.0233, 357,
  ARRAY[204,0,0,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[11.8000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
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
  '100153108217W509', '100/15-31-082-17W5/09', 'PENN WEST RE WALRUS 15-31-82-17',
  56.1611071, -116.6433326,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'RECENTLY CHANGED', 9,
  2.7,
  3047, 37100.19921875,
  '2013-12-01', '2025-12-01',
  0.8059, 71,
  ARRAY[35,624,76,469,725,715,744,744,720,744,720,744]::int[],
  ARRAY[64.3000,16.1000,9.7000,16.9000,13.3000,11.4000,11.5000,9.8000,9.3000,10.2000,3.1000,2.7000]::numeric[],
  ARRAY[0.047,0.9286,0.1022,0.6514,0.9745,0.9931,1,1,1,1,1,1]::numeric[],
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
  '104132308419W509', '104/13-23-084-19W5/09', 'PENN WEST HZ PEACE RVR 13-23-84-19',
  56.2891377, -116.8945684,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  21.2,
  7185, 55197.30078125,
  '2013-11-29', '2025-12-01',
  0.9963, 1,
  ARRAY[722,668,744,720,744,720,744,744,720,744,720,738]::int[],
  ARRAY[23.1000,22.2000,17.5000,12.1000,8.6000,11.6000,22.6000,23.5000,27.4000,25.2000,22.0000,21.4000]::numeric[],
  ARRAY[0.9704,0.994,1,1,1,1,1,1,1,1,1,0.9919]::numeric[],
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
  '104152308419W509', '104/15-23-084-19W5/09', 'PENN WEST 102 HZ PEACE R 15-23-84-19',
  56.2883167, -116.8836533,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  8.2,
  7146, 57365.30078125,
  '2013-10-24', '2025-12-01',
  0.9739, 10,
  ARRAY[738,636,744,720,744,720,744,744,720,557,720,744]::int[],
  ARRAY[32.1000,28.3000,28.3000,18.1000,12.8000,18.8000,20.2000,20.6000,29.0000,17.7000,7.6000,8.2000]::numeric[],
  ARRAY[0.9919,0.9464,1,1,1,1,1,1,1,0.7487,1,1]::numeric[],
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
