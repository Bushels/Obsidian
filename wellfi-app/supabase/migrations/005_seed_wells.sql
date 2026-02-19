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

INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '102062408218W509', '102/06-24-082-18W5/09', 'PENN WEST 102 HZ HARMONV 6-24-82-18',
  56.1118232, -116.68327,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'HIGH', 12,
  43.3,
  18219, 69077.296875,
  '2016-10-18', '2025-12-01',
  0.987, 4,
  ARRAY[744,645,729,720,744,720,710,712,720,744,714,744]::int[],
  ARRAY[55.1000,55.8000,53.2000,51.8000,53.0000,54.4000,53.5000,53.1000,48.1000,44.5000,41.9000,43.3000]::numeric[],
  ARRAY[1,0.9598,0.9798,1,1,1,0.9543,0.957,1,1,0.9917,1]::numeric[],
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
  '100162908318W509', '100/16-29-083-18W5/09', 'PENN WEST PEACE RIVER 16-29-83-18',
  56.229207, -116.7673236,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  16.1,
  4753, 8886.099609375,
  '2017-03-25', '2025-12-01',
  0.9735, 9,
  ARRAY[744,658,744,709,744,720,665,616,720,744,720,744]::int[],
  ARRAY[15.3000,15.8000,14.4000,15.2000,14.9000,13.4000,5.5000,5.6000,9.8000,14.9000,17.7000,16.1000]::numeric[],
  ARRAY[1,0.9792,1,0.9847,1,1,0.8938,0.828,1,1,1,1]::numeric[],
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
  '103133408318W509', '103/13-34-083-18W5/09', 'PENN WEST PEACE RIVER 13-34-83-18',
  56.229207, -116.7669206,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  13.1,
  4523, 8434.7998046875,
  '2017-04-10', '2025-12-01',
  0.9963, 2,
  ARRAY[744,652,732,720,744,720,744,744,720,744,720,744]::int[],
  ARRAY[17.1000,14.7000,14.8000,19.2000,17.4000,10.2000,12.1000,6.4000,4.5000,5.9000,14.1000,13.1000]::numeric[],
  ARRAY[1,0.9702,0.9839,1,1,1,1,1,1,1,1,1]::numeric[],
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
  '100092908318W509', '100/09-29-083-18W5/09', 'PENN WEST PEACE RIVER 9-29-83-18',
  56.229207, -116.7665186,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'WATCH', 11,
  9.2,
  4779, 3912.199951171875,
  '2017-05-04', '2025-12-01',
  0.9202, 30,
  ARRAY[115,658,744,720,706,720,744,726,720,744,720,744]::int[],
  ARRAY[57.6000,25.8000,25.3000,13.4000,16.5000,16.3000,11.7000,7.5000,7.5000,7.2000,10.5000,9.2000]::numeric[],
  ARRAY[0.1546,0.9792,1,1,0.9489,1,1,0.9758,1,1,1,1]::numeric[],
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
  '100022008318W509', '100/02-20-083-18W5/09', 'PENN WEST PEACE RIVER 2-20-83-18',
  56.21786, -116.8095383,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  13.8,
  5628, 13639.7001953125,
  '2017-04-28', '2025-12-01',
  0.8999, 37,
  ARRAY[744,672,622,491,453,586,744,715,720,720,720,696]::int[],
  ARRAY[15.4000,15.1000,18.2000,22.0000,24.9000,19.6000,16.5000,17.1000,15.4000,15.3000,16.3000,14.7000]::numeric[],
  ARRAY[1,1,0.836,0.6819,0.6089,0.8139,1,0.961,1,0.9677,1,0.9355]::numeric[],
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
  '100151908318W509', '100/15-19-083-18W5/09', 'PENN WEST PEACE RIVER 15-19-83-18',
  56.217858, -116.8091363,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'RECENTLY CHANGED', 4,
  5.8,
  1802, 12340,
  '2017-05-20', '2025-12-01',
  0.8281, 63,
  ARRAY[744,672,744,720,744,720,0,0,720,726,720,744]::int[],
  ARRAY[6.5000,6.0000,5.8000,6.5000,6.4000,5.9000,NULL,NULL,4.7000,5.8000,6.1000,5.8000]::numeric[],
  ARRAY[1,1,1,1,1,1,0,0,1,0.9758,1,1]::numeric[],
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
  '100023208318W509', '100/02-32-083-18W5/09', 'PENN WEST PEACE RIVER 2-32-83-18',
  56.217863, -116.8099413,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  6.9,
  2971, 14033.900390625,
  '2017-04-06', '2025-12-01',
  0.8935, 38,
  ARRAY[744,672,615,427,364,651,744,736,720,738,720,696]::int[],
  ARRAY[9.4000,9.5000,10.8000,14.8000,17.5000,10.0000,9.3000,7.7000,8.4000,7.6000,3.7000,7.4000]::numeric[],
  ARRAY[1,1,0.8266,0.5931,0.4892,0.9042,1,0.9892,1,0.9919,1,0.9355]::numeric[],
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
  '100033208318W509', '100/03-32-083-18W5/09', 'PENN WEST PEACE RIVER 3-32-83-18',
  56.217867, -116.8107453,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  7.2,
  1702, 14742,
  '2017-03-20', '2025-12-01',
  0.9968, NULL,
  ARRAY[744,672,740,712,735,713,744,744,720,744,720,744]::int[],
  ARRAY[2.6000,3.1000,3.1000,3.1000,3.1000,3.1000,3.3000,4.3000,5.6000,7.5000,9.9000,7.2000]::numeric[],
  ARRAY[1,1,0.9946,0.9889,0.9879,0.9903,1,1,1,1,1,1]::numeric[],
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
  '100163408318W509', '100/16-34-083-18W5/09', 'OBE HZ PEACE RIVER 16-34-83-18',
  56.229531, -116.7594515,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'WATCH', 11,
  7.7,
  5907, 17332.599609375,
  '2017-10-09', '2025-12-01',
  0.9207, 29,
  ARRAY[114,658,744,720,744,720,723,744,720,740,712,726]::int[],
  ARRAY[25.7000,19.8000,20.1000,23.0000,22.4000,20.6000,16.7000,15.6000,18.8000,13.0000,14.5000,7.9000]::numeric[],
  ARRAY[0.1532,0.9792,1,1,1,1,0.9718,1,1,0.9946,0.9889,0.9758]::numeric[],
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
  '103143408318W509', '103/14-34-083-18W5/09', 'OBE 102 HZ PEACE R 14-34-83-18',
  56.229533, -116.7602565,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  5,
  6310, 19873.5,
  '2017-09-16', '2025-12-01',
  0.9963, 1,
  ARRAY[744,664,744,720,744,720,744,744,720,744,720,720]::int[],
  ARRAY[22.8000,21.6000,22.0000,22.7000,24.9000,19.7000,14.3000,14.3000,15.3000,14.2000,11.3000,5.2000]::numeric[],
  ARRAY[1,0.9881,1,1,1,1,1,1,1,1,1,0.9677]::numeric[],
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
  '102143408318W509', '102/14-34-083-18W5/09', 'PENN WEST 102 HZ PEACE R 14-34-83-18',
  56.229532, -116.7598545,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  18.8,
  6002, 17282.599609375,
  '2017-09-21', '2025-12-01',
  0.9917, 3,
  ARRAY[706,664,744,720,744,720,744,744,720,744,693,744]::int[],
  ARRAY[24.7000,18.4000,10.0000,12.6000,16.8000,13.0000,13.6000,7.2000,16.4000,26.5000,21.7000,18.8000]::numeric[],
  ARRAY[0.9489,0.9881,1,1,1,1,1,1,1,1,0.9625,1]::numeric[],
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
  '100023508218W509', '100/02-35-082-18W5/09', 'OBE PENN WEST HZ WALRUS 4 2-35-82-18',
  56.1429681, -116.6591272,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  31.7,
  14558, 75057.796875,
  '2017-09-21', '2025-12-01',
  0.9892, 3,
  ARRAY[744,669,744,699,736,713,725,718,709,744,720,744]::int[],
  ARRAY[72.0000,76.2000,61.3000,45.6000,31.3000,11.0000,17.8000,41.2000,34.4000,33.3000,29.7000,31.7000]::numeric[],
  ARRAY[1,0.9955,1,0.9708,0.9892,0.9903,0.9745,0.9651,0.9847,1,1,1]::numeric[],
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
  '104113608218W509', '104/11-36-082-18W5/09', 'OBE HZ HARMON 11-36-82-18',
  56.1428372, -116.6823804,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  25.2,
  11022, 43300.80078125,
  '2017-10-29', '2025-12-01',
  0.9967, NULL,
  ARRAY[744,671,744,712,743,715,738,744,720,736,720,744]::int[],
  ARRAY[34.5000,28.8000,26.3000,26.6000,26.7000,30.5000,29.5000,30.0000,30.2000,37.4000,38.0000,25.2000]::numeric[],
  ARRAY[1,0.9985,1,0.9889,0.9987,0.9931,0.9919,1,1,0.9892,1,1]::numeric[],
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
  '104020808317W509', '104/02-08-083-17W5/09', 'OBE HZ WALRUS 2-8-83-17',
  56.1611101, -116.6447796,
  'Bluesky', 'CADOTTE',
  'Pumping', 'HIGH', 12,
  4.7,
  2617, 7161.7998046875,
  '2017-12-11', '2025-12-01',
  0.9986, NULL,
  ARRAY[744,672,741,714,742,719,744,744,720,744,720,744]::int[],
  ARRAY[7.8000,8.2000,8.6000,8.5000,9.9000,8.9000,9.8000,5.4000,4.6000,4.9000,5.0000,4.7000]::numeric[],
  ARRAY[1,1,0.996,0.9917,0.9973,0.9986,1,1,1,1,1,1]::numeric[],
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
  '102013108217W509', '102/01-31-082-17W5/09', 'PENN WEST HZ WALRU WALRUS 1-31-82-17',
  56.1611091, -116.6443776,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  12.3,
  4225, 10885.7001953125,
  '2017-12-09', '2025-12-01',
  0.9993, NULL,
  ARRAY[744,672,742,718,743,719,744,744,720,744,720,744]::int[],
  ARRAY[12.8000,10.9000,10.5000,11.5000,10.7000,10.9000,11.3000,11.2000,12.0000,12.3000,12.5000,12.3000]::numeric[],
  ARRAY[1,1,0.9973,0.9972,0.9987,0.9986,1,1,1,1,1,1]::numeric[],
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
  '100130508317W509', '100/13-05-083-17W5/09', 'OBE 103 HZ 13-5-83-17',
  56.1730361, -116.6760848,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  34.9,
  12980, 59402.1015625,
  '2018-02-20', '2025-12-01',
  0.9942, 2,
  ARRAY[744,672,744,720,744,689,744,744,720,744,700,744]::int[],
  ARRAY[56.1000,54.7000,44.8000,41.7000,39.9000,22.2000,21.7000,23.5000,30.3000,28.5000,31.3000,34.9000]::numeric[],
  ARRAY[1,1,1,1,1,0.9569,1,1,1,1,0.9722,1]::numeric[],
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
  '103113608218W509', '103/11-36-082-18W5/09', 'PENN WEST 103 HZ WALRUS 11-36-82-18',
  56.1730361, -116.6768898,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  75,
  32619, 91092.4921875,
  '2018-03-23', '2025-12-01',
  0.9949, 2,
  ARRAY[744,672,743,720,744,720,725,729,720,744,710,744]::int[],
  ARRAY[91.4000,105.3000,93.0000,92.6000,87.2000,89.8000,94.1000,90.4000,92.2000,89.3000,79.1000,75.0000]::numeric[],
  ARRAY[1,1,0.9987,1,1,1,0.9745,0.9798,1,1,0.9861,1]::numeric[],
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
  '102103608218W509', '102/10-36-082-18W5/09', 'PENN WEST 102 HZ 10-36-82-18',
  56.1730361, -116.6764868,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  51.1,
  19134, 61108.30078125,
  '2018-03-08', '2025-12-01',
  0.9989, NULL,
  ARRAY[744,672,744,719,742,715,742,744,720,744,720,744]::int[],
  ARRAY[66.2000,58.4000,47.4000,41.0000,47.6000,50.3000,57.2000,54.0000,50.4000,54.7000,51.5000,51.1000]::numeric[],
  ARRAY[1,1,1,0.9986,0.9973,0.9931,0.9973,1,1,1,1,1]::numeric[],
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
  '100040708317W509', '100/04-07-083-17W5/09', 'PENN WEST HZ WALRUS 4-7-83-17',
  56.1729731, -116.6604766,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  54.6,
  24460, 84717.296875,
  '2018-04-23', '2025-12-01',
  0.9999, NULL,
  ARRAY[744,672,743,720,744,720,744,744,720,744,720,744]::int[],
  ARRAY[70.9000,68.6000,74.8000,73.5000,70.8000,67.2000,74.0000,72.3000,66.1000,56.7000,54.6000,54.6000]::numeric[],
  ARRAY[1,1,0.9987,1,1,1,1,1,1,1,1,1]::numeric[],
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
  '103010508215W509', '103/01-05-082-15W5/09', 'OBE 103 HZ SEAL 1-5-82-15',
  56.0765788, -116.32664,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  22.6,
  9077, 19772.19921875,
  '2018-10-06', '2025-12-01',
  0.9124, 32,
  ARRAY[738,672,734,717,516,586,624,648,687,698,720,653]::int[],
  ARRAY[28.5000,28.5000,27.1000,27.9000,29.3000,27.1000,25.9000,28.0000,26.8000,26.9000,25.6000,25.8000]::numeric[],
  ARRAY[0.9919,1,0.9866,0.9958,0.6935,0.8139,0.8387,0.871,0.9542,0.9382,1,0.8777]::numeric[],
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
  '104080508215W509', '104/08-05-082-15W5/09', 'OBE 104 HZ SEAL 8-5-82-15',
  56.0766688, -116.32664,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  23.1,
  8755, 9414.7001953125,
  '2018-10-06', '2025-12-01',
  0.9434, 21,
  ARRAY[738,672,734,717,516,706,674,660,701,713,720,713]::int[],
  ARRAY[26.6000,26.6000,25.4000,26.0000,27.4000,25.3000,24.2000,26.1000,25.0000,25.1000,23.9000,24.1000]::numeric[],
  ARRAY[0.9919,1,0.9866,0.9958,0.6935,0.9806,0.9059,0.8871,0.9736,0.9583,1,0.9583]::numeric[],
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
  '100060808215W508', '100/06-08-082-15W5/08', 'OBE HZ 104 SEAL 6-8-82-15',
  56.0919898, -116.3244757,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  9.4,
  3588, 18583.599609375,
  '2019-02-26', '2025-12-01',
  0.9892, 4,
  ARRAY[744,672,734,717,720,706,706,741,720,742,720,743]::int[],
  ARRAY[10.4000,10.4000,9.9000,10.2000,10.7000,9.9000,9.4000,10.2000,9.8000,9.8000,9.3000,9.4000]::numeric[],
  ARRAY[1,1,0.9866,0.9958,0.9677,0.9806,0.9489,0.996,1,0.9973,1,0.9987]::numeric[],
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
  '105090808215W507', '105/09-08-082-15W5/07', 'OBE HZ 105 SEAL 9-8-82-15',
  56.0919818, -116.3246367,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  37.2,
  12693, 21240.599609375,
  '2019-02-26', '2025-12-01',
  0.9935, 2,
  ARRAY[744,672,734,717,744,706,720,741,720,742,720,743]::int[],
  ARRAY[30.1000,30.1000,28.7000,29.5000,32.8000,39.1000,37.4000,40.4000,38.7000,38.9000,36.9000,37.3000]::numeric[],
  ARRAY[1,1,0.9866,0.9958,1,0.9806,0.9677,0.996,1,0.9973,1,0.9987]::numeric[],
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
  '103151908217W509', '103/15-19-082-17W5/09', 'OBE HZ WALRUS 15-19-82-17',
  56.1519661, -116.6522849,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  87.4,
  39114, 47262.3984375,
  '2021-12-28', '2025-12-01',
  0.9995, NULL,
  ARRAY[744,672,744,720,744,720,744,740,720,744,720,744]::int[],
  ARRAY[118.9000,135.8000,129.7000,88.1000,118.6000,110.2000,112.1000,106.9000,102.6000,87.0000,90.8000,87.4000]::numeric[],
  ARRAY[1,1,1,1,1,1,1,0.9946,1,1,1,1]::numeric[],
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
  '104141908217W509', '104/14-19-082-17W5/09', 'OBE HZ WALRUS 14-19-82-17',
  56.1518071, -116.6525719,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  58.6,
  28558, 36121.8984375,
  '2021-12-28', '2025-12-01',
  0.9965, 1,
  ARRAY[744,672,744,720,738,720,744,734,720,744,705,744]::int[],
  ARRAY[104.8000,98.3000,96.8000,89.1000,86.1000,76.2000,77.4000,69.0000,65.0000,60.4000,61.3000,58.6000]::numeric[],
  ARRAY[1,1,1,1,0.9919,1,1,0.9866,1,1,0.9792,1]::numeric[],
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
  '104131908217W509', '104/13-19-082-17W5/09', 'OBE HZ WALRUS 13-19-82-17',
  56.1516491, -116.6528599,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  51.4,
  21688, 32770.8984375,
  '2021-12-28', '2025-12-01',
  0.9997, NULL,
  ARRAY[741,672,744,720,744,720,744,744,720,744,720,744]::int[],
  ARRAY[77.0000,72.3000,68.7000,59.2000,46.5000,53.6000,64.7000,51.1000,59.3000,56.8000,53.7000,51.4000]::numeric[],
  ARRAY[0.996,1,1,1,1,1,1,1,1,1,1,1]::numeric[],
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
  '104093508218W509', '104/09-35-082-18W5/09', 'OBE 102 HZ HARMON 9-35-82-18',
  56.1418182, -116.6832505,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  41.9,
  16711, 47383.1015625,
  '2022-01-01', '2025-12-01',
  0.9267, 27,
  ARRAY[744,535,694,523,578,657,715,744,720,744,720,744]::int[],
  ARRAY[58.5000,31.8000,43.6000,88.2000,66.6000,56.8000,50.3000,44.1000,60.7000,36.2000,24.7000,41.9000]::numeric[],
  ARRAY[1,0.7961,0.9328,0.7264,0.7769,0.9125,0.961,1,1,1,1,1]::numeric[],
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
  '100083408218W509', '100/08-34-082-18W5/09', 'OBE HZ 8-34-82-18',
  56.1474422, -116.7035196,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  21.3,
  16733, 13833.400390625,
  '2022-04-11', '2025-12-01',
  0.9508, 19,
  ARRAY[744,672,608,588,677,706,742,742,642,744,720,744]::int[],
  ARRAY[56.0000,54.0000,54.0000,52.3000,53.5000,55.2000,53.0000,55.5000,53.2000,40.1000,33.9000,21.3000]::numeric[],
  ARRAY[1,1,0.8172,0.8167,0.9099,0.9806,0.9973,0.9973,0.8917,1,1,1]::numeric[],
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
  '103032608218W509', '103/03-26-082-18W5/09', 'OBE 103 HZ 3-26-82-18',
  56.1474432, -116.7027946,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  67.2,
  31051, 19972.19921875,
  '2022-04-11', '2025-12-01',
  0.9642, 13,
  ARRAY[744,648,739,718,732,720,742,742,720,744,480,717]::int[],
  ARRAY[103.7000,114.6000,111.7000,106.8000,90.7000,70.2000,62.9000,91.0000,84.0000,65.3000,92.5000,69.7000]::numeric[],
  ARRAY[1,0.9643,0.9933,0.9972,0.9839,1,0.9973,0.9973,1,1,0.6667,0.9637]::numeric[],
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
  '100013208319W509', '100/01-32-083-19W5/09', 'OBE 100 HZ HARMONV 1-32-83-19',
  56.2483071, -116.9652097,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  97.8,
  39611, 23184.19921875,
  '2023-02-15', '2025-12-01',
  0.94, 22,
  ARRAY[743,598,744,666,584,562,743,688,720,730,718,738]::int[],
  ARRAY[112.9000,142.4000,112.7000,107.2000,130.1000,152.2000,116.4000,118.6000,104.1000,100.9000,105.0000,98.6000]::numeric[],
  ARRAY[0.9987,0.8899,1,0.925,0.7849,0.7806,0.9987,0.9247,1,0.9812,0.9972,0.9919]::numeric[],
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

INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)
VALUES (
  '100010608013W502', '100/01-06-080-13W5/02', 'WOODCOTE OIL HZ DAWSON 1-6-80-13',
  55.897111, -115.9820529,
  'Clearwater', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  12.3,
  6072, 6317.2998046875,
  '2022-09-04', '2025-12-01',
  0.9841, 4,
  ARRAY[742,663,744,714,744,712,744,737,720,744,694,663]::int[],
  ARRAY[25.8000,21.0000,19.4000,17.1000,17.1000,17.7000,15.7000,14.4000,13.2000,13.9000,13.4000,13.8000]::numeric[],
  ARRAY[0.9973,0.9866,1,0.9917,1,0.9889,1,0.9906,1,1,0.9639,0.8911]::numeric[],
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
  '105163208115W509', '105/16-32-081-15W5/09', 'OBE 105 HZ DAWSON 16-32-81-15',
  56.0707828, -116.3262371,
  'Bluesky', 'DAWSON',
  'Pumping', 'HIGH', 12,
  62.8,
  28622, 17865.30078125,
  '2022-08-30', '2025-12-01',
  0.9782, 8,
  ARRAY[744,672,734,717,732,706,713,726,686,729,720,690]::int[],
  ARRAY[72.4000,74.2000,91.9000,100.5000,105.5000,91.6000,63.2000,68.3000,73.2000,76.4000,75.9000,67.7000]::numeric[],
  ARRAY[1,1,0.9866,0.9958,0.9839,0.9806,0.9583,0.9758,0.9528,0.9798,1,0.9274]::numeric[],
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
  '106080508215W509', '106/08-05-082-15W5/09', 'OBE HZ SEAL 8-5-82-15',
  56.0812898, -116.3288869,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  67.1,
  19995, 10286.2001953125,
  '2022-09-14', '2025-12-01',
  0.984, 6,
  ARRAY[720,672,734,717,720,706,698,741,716,732,720,744]::int[],
  ARRAY[57.0000,57.1000,54.3000,55.8000,58.6000,54.2000,51.8000,55.9000,53.6000,53.8000,48.4000,67.1000]::numeric[],
  ARRAY[0.9677,1,0.9866,0.9958,0.9677,0.9806,0.9382,0.996,0.9944,0.9839,1,1]::numeric[],
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
  '106010808215W505', '106/01-08-082-15W5/05', 'OBE 106 HZ SEAL 1-8-82-15',
  56.0882138, -116.3240667,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  57.2,
  23600, 13534.5,
  '2022-10-15', '2025-12-01',
  0.9825, 6,
  ARRAY[719,672,734,717,744,706,696,741,720,742,720,696]::int[],
  ARRAY[55.8000,55.8000,38.2000,54.3000,63.8000,85.3000,80.2000,87.2000,76.4000,63.3000,68.2000,61.1000]::numeric[],
  ARRAY[0.9664,1,0.9866,0.9958,1,0.9806,0.9355,0.996,1,0.9973,1,0.9355]::numeric[],
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
  '108160508215W506', '108/16-05-082-15W5/06', 'OBE 108 HZ SEAL 16-5-82-15',
  56.0881238, -116.3240727,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  44.3,
  18752, 12737.599609375,
  '2022-10-15', '2025-12-01',
  0.9832, 6,
  ARRAY[719,672,734,717,744,706,702,741,720,742,720,696]::int[],
  ARRAY[54.5000,52.0000,49.5000,50.9000,53.4000,59.0000,55.8000,55.9000,55.4000,58.3000,34.9000,47.3000]::numeric[],
  ARRAY[0.9664,1,0.9866,0.9958,1,0.9806,0.9435,0.996,1,0.9973,1,0.9355]::numeric[],
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
  '103162908115W506', '103/16-29-081-15W5/06', 'OBE 103 HZ DAWSON 16-29-81-15',
  56.0554508, -116.3274703,
  'Bluesky', 'DAWSON',
  'Pumping', 'HIGH', 12,
  63.6,
  15057, 12222.2001953125,
  '2022-10-31', '2025-12-01',
  0.9435, 20,
  ARRAY[456,672,734,693,734,706,728,697,695,718,720,712]::int[],
  ARRAY[52.8000,60.9000,62.1000,27.3000,35.8000,33.1000,32.1000,38.3000,38.7000,39.0000,41.5000,66.5000]::numeric[],
  ARRAY[0.6129,1,0.9866,0.9625,0.9866,0.9806,0.9785,0.9368,0.9653,0.9651,1,0.957]::numeric[],
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
  '104092908115W506', '104/09-29-081-15W5/06', 'OBE 104 HZ DAWSON 9-29-81-15',
  56.0551888, -116.3273533,
  'Bluesky', 'DAWSON',
  'Pumping', 'HIGH', 12,
  61.8,
  22170, 14312,
  '2022-10-31', '2025-12-01',
  0.9703, 12,
  ARRAY[744,672,734,645,744,706,728,701,704,726,720,676]::int[],
  ARRAY[91.5000,72.8000,47.7000,37.8000,87.9000,76.3000,61.0000,58.3000,50.9000,46.8000,49.1000,68.0000]::numeric[],
  ARRAY[1,1,0.9866,0.8958,1,0.9806,0.9785,0.9422,0.9778,0.9758,1,0.9086]::numeric[],
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
  '100033208217W509', '100/03-32-082-17W5/09', 'OBE HZ WALRUS 3-32-82-17',
  56.16475, -116.6295363,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  17.6,
  8335, 7038.2001953125,
  '2023-02-28', '2025-12-01',
  0.9877, 4,
  ARRAY[744,672,742,714,743,621,744,744,720,744,720,744]::int[],
  ARRAY[32.5000,29.0000,27.2000,26.7000,27.0000,12.5000,22.6000,20.4000,22.6000,24.4000,13.6000,17.6000]::numeric[],
  ARRAY[1,1,0.9973,0.9917,0.9987,0.8625,1,1,1,1,1,1]::numeric[],
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
  '102033208217W509', '102/03-32-082-17W5/09', 'OBE 102 HZ WALRUS 3-32-82-17',
  56.164592, -116.6298233,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  18.7,
  5917, 4271.60009765625,
  '2023-02-28', '2025-12-01',
  0.9387, 21,
  ARRAY[744,672,593,620,662,705,744,744,710,744,541,744]::int[],
  ARRAY[19.6000,20.3000,19.7000,20.4000,21.8000,11.4000,17.5000,17.7000,18.6000,10.9000,10.1000,18.7000]::numeric[],
  ARRAY[1,1,0.797,0.8611,0.8898,0.9792,1,1,0.9861,1,0.7514,1]::numeric[],
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
  '100040908013W500', '100/04-09-080-13W5/00', 'WOODCOTE OIL HZ GIFT 4-9-80-13',
  55.897141, -115.9818319,
  'Clearwater', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  19,
  7909, 5386.10009765625,
  '2023-01-03', '2025-12-01',
  0.986, 4,
  ARRAY[742,663,744,714,744,712,744,737,720,744,694,679]::int[],
  ARRAY[29.0000,24.5000,22.4000,20.6000,20.6000,21.2000,22.2000,21.6000,19.9000,20.8000,20.1000,20.8000]::numeric[],
  ARRAY[0.9973,0.9866,1,0.9917,1,0.9889,1,0.9906,1,1,0.9639,0.9126]::numeric[],
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
  '100120407815W502', '100/12-04-078-15W5/02', 'WOODCOTE OIL HZ PEAVINE 12-4-78-15',
  55.7330579, -116.2461723,
  'Clearwater', 'UNDEFINED',
  'Pumping', 'LOW', NULL,
  0,
  NULL, 870.5999755859375,
  '2023-01-24', '2024-02-01',
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
  '100011708317W509', '100/01-17-083-17W5/09', 'OBE SEAL HV SOUTH HZ 1-17-83-17',
  56.1726801, -116.6499034,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  35.4,
  14423, 7351.2998046875,
  '2023-02-18', '2025-12-01',
  0.9919, 3,
  ARRAY[744,663,738,704,728,711,742,743,720,744,708,744]::int[],
  ARRAY[47.6000,51.8000,38.7000,37.8000,47.5000,50.5000,49.2000,34.3000,29.0000,29.1000,28.1000,35.4000]::numeric[],
  ARRAY[1,0.9866,0.9919,0.9778,0.9785,0.9875,0.9973,0.9987,1,1,0.9833,1]::numeric[],
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
  '100143008216W509', '100/14-30-082-16W5/09', 'OBE HZ SEAL 14-30-82-16',
  56.128296, -116.5003793,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  61.4,
  20896, 12186.400390625,
  '2023-02-10', '2025-12-01',
  0.9934, 2,
  ARRAY[744,672,743,720,744,717,744,744,679,744,709,742]::int[],
  ARRAY[86.2000,62.6000,49.0000,53.3000,56.4000,61.8000,55.3000,51.0000,52.7000,52.2000,49.1000,61.5000]::numeric[],
  ARRAY[1,1,0.9987,1,1,0.9958,1,1,0.9431,1,0.9847,0.9973]::numeric[],
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
  '100121507815W500', '100/12-15-078-15W5/00', 'WOODCOTE OIL HZ PEAVINE 12-15-78-15',
  55.7627479, -116.2185468,
  'Clearwater', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  693, 658,
  '2023-03-01', '2025-03-01',
  0.0221, 357,
  ARRAY[0,0,194,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[NULL,NULL,85.7000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0,0,0.2608,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '102022008316W509', '102/02-20-083-16W5/09', 'OBE 102 HZ 2-20-83-16',
  56.2173679, -116.4848973,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'LOW', NULL,
  0,
  NULL, 316.2000122070312,
  '2023-01-31', '2025-12-01',
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
  '100133008216W509', '100/13-30-082-16W5/09', 'OBE HZ SEAL 13-30-82-16',
  56.128296, -116.5007823,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  74.8,
  32297, 15068.2998046875,
  '2023-11-19', '2025-12-01',
  0.9955, 1,
  ARRAY[733,666,730,720,744,720,744,744,720,744,720,736]::int[],
  ARRAY[112.9000,109.0000,98.3000,75.2000,66.7000,101.4000,101.8000,86.4000,82.7000,78.6000,80.0000,75.6000]::numeric[],
  ARRAY[0.9852,0.9911,0.9812,1,1,1,1,1,1,1,1,0.9892]::numeric[],
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
  '1S0013008217W509', '1S0/01-30-082-17W5/09', 'OBE 100 HZ WALRUS 1-30-82-17',
  56.1483221, -116.6356347,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  19,
  16581, 12148.2998046875,
  '2023-04-24', '2025-12-01',
  0.9973, 1,
  ARRAY[744,672,744,720,744,720,744,744,720,744,720,720]::int[],
  ARRAY[70.5000,57.1000,56.2000,52.5000,52.0000,50.8000,49.3000,46.5000,41.5000,29.3000,21.0000,19.6000]::numeric[],
  ARRAY[1,1,1,1,1,1,1,1,1,1,1,0.9677]::numeric[],
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
  '1S0042908217W509', '1S0/04-29-082-17W5/09', 'OBE HZ WALRUS 4-29-82-17',
  56.1483221, -116.6352327,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  33.7,
  13909, 9272.2001953125,
  '2023-04-24', '2025-12-01',
  1, NULL,
  ARRAY[744,672,744,720,744,720,744,744,720,744,720,744]::int[],
  ARRAY[46.1000,44.6000,42.7000,41.5000,44.4000,36.8000,34.6000,35.1000,38.0000,27.2000,33.0000,33.7000]::numeric[],
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
  '1S0032908217W509', '1S0/03-29-082-17W5/09', 'OBE HZ WALRUS 3-29-82-17',
  56.1483221, -116.6348297,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  43.6,
  19590, 11214.7001953125,
  '2023-08-10', '2025-12-01',
  0.9994, NULL,
  ARRAY[744,672,744,718,742,719,744,744,720,744,720,744]::int[],
  ARRAY[69.6000,63.2000,58.2000,55.9000,56.5000,55.0000,52.1000,50.4000,52.7000,44.6000,43.3000,43.6000]::numeric[],
  ARRAY[1,1,1,0.9972,0.9973,0.9986,1,1,1,1,1,1]::numeric[],
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
  '100101508013W500', '100/10-15-080-13W5/00', 'WOODCOTE OIL HZ SEAL 10-15-80-13',
  55.954113, -115.9423702,
  'Clearwater', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  3044, 3065.39990234375,
  '2023-01-28', '2025-03-01',
  0.0973, 330,
  ARRAY[0,516,336,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[NULL,86.0000,85.3000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0,0.7679,0.4516,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '104160808215W509', '104/16-08-082-15W5/09', 'OBE 104 HZ SEAL 16-8-82-15',
  56.0986747, -116.3216115,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  39.5,
  21160, 9067.900390625,
  '2024-01-20', '2025-12-01',
  0.9336, 25,
  ARRAY[739,672,734,717,654,706,734,482,708,730,720,582]::int[],
  ARRAY[71.9000,71.0000,67.6000,69.5000,72.9000,67.4000,64.5000,65.3000,52.1000,43.1000,49.7000,50.4000]::numeric[],
  ARRAY[0.9933,1,0.9866,0.9958,0.879,0.9806,0.9866,0.6478,0.9833,0.9812,1,0.7823]::numeric[],
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
  '100040908012W500', '100/04-09-080-12W5/00', 'WOODCOTE OIL HZ SEAL 4-9-80-12',
  55.911469, -115.7990644,
  'Clearwater', 'SEAL',
  'Pumping', 'HIGH', 12,
  22.9,
  5682, 1985.199951171875,
  '2023-12-24', '2025-12-01',
  0.9817, 7,
  ARRAY[625,672,744,720,744,696,744,744,720,744,720,727]::int[],
  ARRAY[10.2000,13.0000,13.1000,13.9000,13.5000,11.5000,14.8000,13.7000,18.8000,18.2000,25.1000,23.5000]::numeric[],
  ARRAY[0.8401,1,1,1,1,0.9667,1,1,1,1,1,0.9772]::numeric[],
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
  '102143008216W509', '102/14-30-082-16W5/09', 'OBE 102 HZ SEAL 14-30-82-16',
  56.128116, -116.5007013,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  126.3,
  49412, 20847,
  '2023-11-20', '2025-12-01',
  0.9881, 3,
  ARRAY[734,641,722,712,722,716,744,744,720,744,713,744]::int[],
  ARRAY[155.7000,152.7000,147.7000,131.4000,130.3000,132.2000,138.1000,134.7000,131.1000,133.4000,132.3000,126.3000]::numeric[],
  ARRAY[0.9866,0.9539,0.9704,0.9889,0.9704,0.9944,1,1,1,1,0.9903,1]::numeric[],
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
  '100141808216W509', '100/14-18-082-16W5/09', 'OBE 100 HZ SEAL 14-18-82-16',
  56.128116, -116.5003793,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  18.4,
  9111, 7448.39990234375,
  '2023-11-20', '2025-12-01',
  0.975, 10,
  ARRAY[742,629,717,588,744,720,744,744,720,744,705,744]::int[],
  ARRAY[33.5000,21.7000,15.2000,27.1000,29.5000,24.6000,30.7000,26.3000,27.5000,27.3000,24.6000,18.4000]::numeric[],
  ARRAY[0.9973,0.936,0.9637,0.8167,1,1,1,1,1,1,0.9792,1]::numeric[],
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
  '100121808216W509', '100/12-18-082-16W5/09', 'OBE HZ SEAL 12-18-82-16',
  56.128296, -116.5000573,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  12.7,
  10274, 5051.7998046875,
  '2023-11-20', '2025-12-01',
  0.9546, 17,
  ARRAY[744,639,554,656,721,690,723,740,720,744,707,724]::int[],
  ARRAY[29.6000,29.1000,28.3000,32.4000,31.0000,28.3000,25.8000,28.2000,50.7000,38.3000,18.7000,13.1000]::numeric[],
  ARRAY[1,0.9509,0.7446,0.9111,0.9691,0.9583,0.9718,0.9946,1,1,0.9819,0.9731]::numeric[],
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
  '102082708218W509', '102/08-27-082-18W5/09', 'OBE HZ 102 WALRUS 8-27-82-18',
  56.1358553, -116.7467693,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  65.7,
  45754, 24243.599609375,
  '2024-03-29', '2025-12-01',
  0.9894, 3,
  ARRAY[738,670,744,720,670,717,744,740,716,744,720,744]::int[],
  ARRAY[231.0000,206.9000,208.2000,168.8000,131.2000,91.8000,90.5000,88.1000,76.6000,77.1000,90.5000,65.7000]::numeric[],
  ARRAY[0.9919,0.997,1,1,0.9005,0.9958,1,0.9946,0.9944,1,1,1]::numeric[],
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
  '103012708218W509', '103/01-27-082-18W5/09', 'OBE HZ WALRUS 1-27-82-18',
  56.1358553, -116.7464473,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  64.4,
  48127, 23344,
  '2024-03-29', '2025-12-01',
  0.9914, 3,
  ARRAY[743,670,744,720,744,717,683,740,716,744,720,744]::int[],
  ARRAY[234.9000,227.7000,199.5000,156.5000,152.0000,131.1000,71.1000,86.2000,95.5000,93.7000,85.1000,64.4000]::numeric[],
  ARRAY[0.9987,0.997,1,1,1,0.9958,0.918,0.9946,0.9944,1,1,1]::numeric[],
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
  '102153008216W509', '102/15-30-082-16W5/09', 'OBE HZ SEAL 15-30-82-16',
  56.127769, -116.4892232,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  43.5,
  18417, 4773.60009765625,
  '2024-04-23', '2025-12-01',
  0.9984, 1,
  ARRAY[732,672,744,720,744,720,744,742,720,744,720,744]::int[],
  ARRAY[56.2000,52.5000,48.9000,57.4000,47.1000,57.7000,51.0000,48.8000,53.8000,42.9000,47.4000,43.5000]::numeric[],
  ARRAY[0.9839,1,1,1,1,1,1,0.9973,1,1,1,1]::numeric[],
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
  '100163008216W509', '100/16-30-082-16W5/09', 'OBE HZ SEAL 16-30-82-16',
  56.127769, -116.4889012,
  'Bluesky', 'SEAL',
  'Pumping', 'DOWN NOW', NULL,
  0,
  11, 1114.099975585938,
  '2024-04-23', '2025-09-01',
  0.0274, 355,
  ARRAY[240,0,0,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[1.1000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0.3226,0,0,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '100101808216W509', '100/10-18-082-16W5/09', 'OBE HZ SEAL 10-18-82-16',
  56.127409, -116.4892232,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  26.1,
  18682, 8734.900390625,
  '2024-04-23', '2025-12-01',
  0.9879, 4,
  ARRAY[744,672,744,720,744,720,744,742,720,744,616,744]::int[],
  ARRAY[114.1000,92.0000,77.6000,40.0000,39.8000,32.1000,42.9000,41.2000,45.8000,42.5000,25.7000,26.1000]::numeric[],
  ARRAY[1,1,1,1,1,1,1,0.9973,1,1,0.8556,1]::numeric[],
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
  '100091808216W509', '100/09-18-082-16W5/09', 'OBE HZ SEAL 9-18-82-16',
  56.127409, -116.4889012,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  25.8,
  8613, 4094.300048828125,
  '2024-04-23', '2025-12-01',
  0.9674, 12,
  ARRAY[500,656,738,720,744,704,742,742,720,744,720,744]::int[],
  ARRAY[57.1000,50.4000,32.1000,13.9000,15.6000,12.9000,14.5000,13.9000,21.0000,24.3000,23.8000,25.8000]::numeric[],
  ARRAY[0.672,0.9762,0.9919,1,1,0.9778,0.9973,0.9973,1,1,1,1]::numeric[],
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
  '103153008216W509', '103/15-30-082-16W5/09', 'OBE HZ SEAL 15-30-82-16',
  56.127589, -116.4892222,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  77.2,
  35090, 11735.900390625,
  '2024-04-23', '2025-12-01',
  0.9973, 1,
  ARRAY[730,672,736,720,744,720,744,742,720,744,720,744]::int[],
  ARRAY[98.5000,107.2000,98.3000,98.5000,101.8000,110.3000,106.8000,102.3000,81.5000,91.9000,83.4000,77.2000]::numeric[],
  ARRAY[0.9812,1,0.9892,1,1,1,1,0.9973,1,1,1,1]::numeric[],
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
  '102163008216W509', '102/16-30-082-16W5/09', 'OBE 102 SEAL 16-30-82-16',
  56.127589, -116.4889012,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  58,
  15735, 5460.39990234375,
  '2024-04-23', '2025-12-01',
  0.9995, NULL,
  ARRAY[744,670,744,720,744,720,744,742,720,744,720,744]::int[],
  ARRAY[41.1000,38.1000,45.9000,52.7000,40.6000,37.5000,40.8000,35.0000,36.3000,55.2000,35.5000,58.0000]::numeric[],
  ARRAY[1,0.997,1,1,1,1,1,0.9973,1,1,1,1]::numeric[],
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
  '100131908317W509', '100/13-19-083-17W5/09', 'OBE 100 HZ 13-19-83-17',
  56.20058, -116.6837623,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'LOW', 9,
  72.3,
  26634, 4234.39990234375,
  '2025-04-14', '2025-12-01',
  0.7162, 104,
  ARRAY[0,0,0,408,744,720,742,744,720,732,720,744]::int[],
  ARRAY[NULL,NULL,NULL,155.6000,133.9000,115.9000,139.3000,96.8000,94.8000,69.9000,61.3000,72.3000]::numeric[],
  ARRAY[0,0,0,0.5667,1,1,0.9973,1,1,0.9839,1,1]::numeric[],
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
  '102141908317W509', '102/14-19-083-17W5/09', 'OBE 102 HZ 14-19-83-17',
  56.200581, -116.6834403,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'LOW', 9,
  78.2,
  34389, 5467.39990234375,
  '2025-04-14', '2025-12-01',
  0.7067, 106,
  ARRAY[0,0,0,408,744,711,742,686,696,740,720,744]::int[],
  ARRAY[NULL,NULL,NULL,91.5000,242.5000,145.1000,147.6000,244.9000,94.2000,77.1000,64.0000,78.2000]::numeric[],
  ARRAY[0,0,0,0.5667,1,0.9875,0.9973,0.922,0.9667,0.9946,1,1]::numeric[],
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
  '100151908317W509', '100/15-19-083-17W5/09', 'OBE 100 HZ 15-19-83-17',
  56.200401, -116.6834383,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  113.8,
  62143, 17413.30078125,
  '2024-08-23', '2025-12-01',
  0.9764, 8,
  ARRAY[744,624,694,716,744,624,742,744,720,744,713,744]::int[],
  ARRAY[292.8000,239.1000,302.4000,243.8000,183.9000,139.4000,93.1000,105.3000,140.3000,126.2000,125.0000,113.8000]::numeric[],
  ARRAY[1,0.9286,0.9328,0.9944,1,0.8667,0.9973,1,1,1,0.9903,1]::numeric[],
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
  '100131708317W509', '100/13-17-083-17W5/09', 'OBE 100 HZ 13-17-83-17',
  56.185457, -116.6593543,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'LOW', 9,
  164.4,
  56240, 8941.5,
  '2025-04-14', '2025-12-01',
  0.6995, 110,
  ARRAY[0,0,0,404,744,718,744,744,583,740,707,744]::int[],
  ARRAY[NULL,NULL,NULL,326.4000,283.5000,303.4000,240.8000,168.8000,190.1000,169.5000,177.9000,164.4000]::numeric[],
  ARRAY[0,0,0,0.5611,1,0.9972,1,1,0.8097,0.9946,0.9819,1]::numeric[],
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
  '100141708317W509', '100/14-17-083-17W5/09', 'OBE 100 HZ 14-17-83-17',
  56.185277, -116.6593533,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  158.3,
  65082, 17346.599609375,
  '2024-08-03', '2025-12-01',
  0.9737, 9,
  ARRAY[624,672,742,716,744,715,744,744,720,744,621,744]::int[],
  ARRAY[222.9000,221.8000,220.4000,197.0000,239.1000,157.4000,154.5000,168.3000,161.6000,152.7000,146.6000,158.3000]::numeric[],
  ARRAY[0.8387,1,0.9973,0.9944,1,0.9931,1,1,1,1,0.8625,1]::numeric[],
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
  '100132908216W509', '100/13-29-082-16W5/09', 'OBE 100 HZ SEAL 13-29-82-16',
  56.1219969, -116.4689893,
  'Bluesky', 'SEAL',
  'Pumping', 'HIGH', 12,
  121.8,
  43879, 10668.900390625,
  '2024-08-04', '2025-12-01',
  0.9588, 15,
  ARRAY[740,672,736,720,596,609,707,735,718,744,716,706]::int[],
  ARRAY[116.8000,152.5000,122.6000,96.8000,150.6000,129.4000,132.6000,114.4000,116.0000,118.1000,134.0000,128.4000]::numeric[],
  ARRAY[0.9946,1,0.9892,1,0.8011,0.8458,0.9503,0.9879,0.9972,1,0.9944,0.9489]::numeric[],
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
  '100021608216W509', '100/02-16-082-16W5/09', 'OBE 100 HZ SEAL 2-16-82-16',
  56.1197909, -116.4403563,
  'Bluesky', 'SEAL',
  'Pumping', 'RECENTLY CHANGED', 9,
  62.4,
  16823, 4626.2001953125,
  '2024-08-26', '2025-12-01',
  0.758, 88,
  ARRAY[625,0,0,279,605,720,744,744,720,744,720,739]::int[],
  ARRAY[101.9000,NULL,NULL,40.0000,111.6000,71.2000,52.1000,42.6000,47.5000,38.2000,42.6000,62.8000]::numeric[],
  ARRAY[0.8401,0,0,0.3875,0.8132,1,1,1,1,1,1,0.9933]::numeric[],
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
  '100031608216W509', '100/03-16-082-16W5/09', 'OBE 100 HZ SEAL 3-16-82-16',
  56.1197909, -116.4406783,
  'Bluesky', 'SEAL',
  'Pumping', 'LOW', 9,
  79.8,
  23322, 3707.89990234375,
  '2025-04-19', '2025-12-01',
  0.6997, 109,
  ARRAY[0,0,0,282,726,718,744,744,720,742,720,733]::int[],
  ARRAY[NULL,NULL,NULL,54.8000,185.2000,109.0000,72.3000,59.3000,76.4000,79.2000,84.1000,81.0000]::numeric[],
  ARRAY[0,0,0,0.3917,0.9758,0.9972,1,1,1,0.9973,1,0.9852]::numeric[],
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
  '102132208419W509', '102/13-22-084-19W5/09', 'OBE 102 HZ 13-22-84-19',
  56.2867787, -116.9230309,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  1486, 414,
  '2024-11-04', '2025-02-01',
  0.1108, 325,
  ARRAY[700,271,0,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[34.6000,42.2000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0.9409,0.4033,0,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '103132208419W509', '103/13-22-084-19W5/09', 'OBE 103 HZ 13-22-84-19',
  56.2869587, -116.9230309,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  61.5,
  32440, 6292.2998046875,
  '2024-11-04', '2025-12-01',
  0.9731, 9,
  ARRAY[568,652,744,697,735,720,744,744,720,744,712,744]::int[],
  ARRAY[154.2000,131.2000,136.4000,78.0000,90.8000,84.8000,88.0000,88.6000,71.6000,62.9000,65.0000,61.5000]::numeric[],
  ARRAY[0.7634,0.9702,1,0.9681,0.9879,1,1,1,1,1,0.9889,1]::numeric[],
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
  '102162108419W509', '102/16-21-084-19W5/09', 'OBE 102 HZ 16-21-84-19',
  56.2867787, -116.9233539,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  467, 74.19999694824219,
  '2024-11-04', '2025-02-01',
  0.0749, 337,
  ARRAY[39,617,0,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[5.4000,17.8000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0.0524,0.9182,0,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '100161208317W509', '100/16-12-083-17W5/09', 'OBE 100 HZ 16-12-83-17',
  56.171749, -116.5379514,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  386, 67.80000305175781,
  '2024-12-14', '2025-04-01',
  0.1177, 322,
  ARRAY[0,595,436,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[NULL,2.9000,17.3000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0,0.8854,0.586,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '100151208317W509', '100/15-12-083-17W5/09', 'OBE 100 HZ 15-12-83-17',
  56.17184, -116.5382294,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'RECENTLY CHANGED', 3,
  5.2,
  4461, 820.0999755859375,
  '2024-12-14', '2025-12-01',
  0.5805, 153,
  ARRAY[240,428,740,570,708,267,0,0,0,668,720,744]::int[],
  ARRAY[12.0000,36.0000,56.7000,45.9000,14.1000,8.7000,NULL,NULL,NULL,4.6000,1.9000,5.2000]::numeric[],
  ARRAY[0.3226,0.6369,0.9946,0.7917,0.9516,0.3708,0,0,0,0.8978,1,1]::numeric[],
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
  '100160608316W509', '100/16-06-083-16W5/09', 'OBE 100 HZ 16-6-83-16',
  56.171594, -116.5381154,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  54.7,
  12763, 2029.199951171875,
  '2025-01-09', '2025-12-01',
  0.9288, 25,
  ARRAY[529,644,572,716,576,716,739,744,692,744,720,744]::int[],
  ARRAY[57.6000,67.8000,6.8000,44.9000,8.0000,14.3000,11.5000,9.2000,9.2000,83.4000,78.9000,54.7000]::numeric[],
  ARRAY[0.711,0.9583,0.7688,0.9944,0.7742,0.9944,0.9933,1,0.9611,1,1,1]::numeric[],
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
  '100090608316W509', '100/09-06-083-16W5/09', 'OBE 100 HZ 9-6-83-16',
  56.171685, -116.5383924,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  62.9,
  36809, 5852.2001953125,
  '2025-01-09', '2025-12-01',
  0.9349, 23,
  ARRAY[428,495,740,720,708,716,742,744,694,739,720,744]::int[],
  ARRAY[115.2000,140.1000,191.1000,179.0000,102.0000,78.2000,100.7000,120.2000,96.0000,62.3000,59.2000,62.9000]::numeric[],
  ARRAY[0.5753,0.7366,0.9946,1,0.9516,0.9944,0.9973,1,0.9639,0.9933,1,1]::numeric[],
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
  '100082908218W509', '100/08-29-082-18W5/09', 'OBE SEAL 100 HZ 8-29-82-18',
  56.1360343, -116.7464473,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  137.3,
  75407, 13825.2998046875,
  '2024-10-16', '2025-12-01',
  0.9936, 2,
  ARRAY[730,648,740,715,744,717,742,740,720,744,720,744]::int[],
  ARRAY[216.3000,287.9000,264.7000,212.1000,205.4000,227.5000,231.9000,215.4000,203.0000,185.2000,117.0000,137.3000]::numeric[],
  ARRAY[0.9812,0.9643,0.9946,0.9931,1,0.9958,0.9973,0.9946,1,1,1,1]::numeric[],
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
  '100012908218W509', '100/01-29-082-18W5/09', 'OBE SEAL 100 HZ 1-29-82-18',
  56.1360343, -116.7467683,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'HIGH', 12,
  88.7,
  32215, 5878,
  '2024-10-16', '2025-12-01',
  0.9855, 5,
  ARRAY[730,640,744,720,744,717,744,666,720,744,720,744]::int[],
  ARRAY[54.8000,37.4000,45.8000,86.1000,125.7000,102.2000,106.1000,122.7000,110.1000,96.8000,95.2000,88.7000]::numeric[],
  ARRAY[0.9812,0.9524,1,1,1,0.9958,1,0.8952,1,1,1,1]::numeric[],
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
  '100083108319W509', '100/08-31-083-19W5/09', 'OBE 100 HZ HARMONV 8-31-83-19',
  56.2421073, -117.010627,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  504, 80.0999984741211,
  '2025-01-11', '2025-03-01',
  0.0909, 332,
  ARRAY[0,573,223,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[NULL,8.6000,32.2000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0,0.8527,0.2997,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '100093108319W509', '100/09-31-083-19W5/09', 'OBE 100 HZ HARMONV 9-31-83-19',
  56.2422683, -117.010482,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  0,
  1, 0.1000000014901161,
  '2024-12-18', '2025-02-01',
  0.0106, 361,
  ARRAY[93,0,0,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[0.2000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0.125,0,0,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '100103108319W509', '100/10-31-083-19W5/09', 'OBE 102 HZ 10-31-83-19',
  56.2423483, -117.010771,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'DOWN NOW', NULL,
  0,
  14, 2.200000047683716,
  '2024-12-18', '2025-03-01',
  0.0184, 358,
  ARRAY[0,157,4,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[NULL,2.0000,3.8000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0,0.2336,0.0054,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '102041108114W509', '102/04-11-081-14W5/09', 'OBE 102 HZ DAWSON 4-11-81-14',
  56.0160618, -116.087428,
  'Bluesky', 'DAWSON',
  'Pumping', 'WATCH', 10,
  164,
  50727, 8065,
  '2025-03-04', '2025-12-01',
  0.8147, 68,
  ARRAY[0,0,664,700,714,718,742,732,707,719,697,744]::int[],
  ARRAY[NULL,NULL,23.6000,263.7000,183.9000,135.8000,159.0000,263.8000,202.8000,144.9000,154.5000,164.0000]::numeric[],
  ARRAY[0,0,0.8925,0.9722,0.9597,0.9972,0.9973,0.9839,0.9819,0.9664,0.9681,1]::numeric[],
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
  '100011608114W509', '100/01-16-081-14W5/09', 'OBE 100 HZ DAWSON 1-16-81-14',
  56.0159279, -116.087461,
  'Bluesky', 'DAWSON',
  'Pumping', 'DOWN NOW', NULL,
  0,
  6151, 978,
  '2025-03-06', '2025-09-01',
  0.2877, 260,
  ARRAY[0,0,0,0,0,694,736,698,392,0,0,0]::int[],
  ARRAY[NULL,NULL,NULL,NULL,NULL,82.4000,61.2000,53.5000,20.6000,NULL,NULL,NULL]::numeric[],
  ARRAY[0,0,0,0,0,0.9639,0.9892,0.9382,0.5444,0,0,0]::numeric[],
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
  '100161808516W509', '100/16-18-085-16W5/09', 'OBE 100 HZ NAMPA 16-18-85-16',
  56.359242, -116.4988657,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'DOWN NOW', NULL,
  4.2,
  259, 41.20000076293945,
  '2025-01-31', '2025-12-01',
  0.0761, 337,
  ARRAY[0,0,480,0,0,0,0,0,0,0,0,187]::int[],
  ARRAY[NULL,NULL,6.4000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16.8000]::numeric[],
  ARRAY[0,0,0.6452,0,0,0,0,0,0,0,0,0.2513]::numeric[],
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
  '100081408117W509', '100/08-14-081-17W5/09', 'OBE 100 HZ DAWSON 8-14-81-17',
  56.0262552, -116.5675164,
  'Bluesky', 'DAWSON',
  'Pumping', 'DOWN NOW', NULL,
  0,
  1058, 168.1999969482422,
  '2025-02-05', '2025-12-01',
  0.1071, 326,
  ARRAY[0,442,496,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[NULL,2.0000,49.4000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0,0.6577,0.6667,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '100160808218W509', '100/16-08-082-18W5/09', 'OBE 100 HZ HARMONV 16-8-82-18',
  56.0991394, -116.7459458,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'DOWN NOW', NULL,
  0,
  2842, 451.8999938964844,
  '2025-03-31', '2025-10-01',
  0.3877, 223,
  ARRAY[0,0,0,701,614,0,0,733,720,628,0,0]::int[],
  ARRAY[NULL,NULL,NULL,29.6000,10.7000,NULL,NULL,20.3000,23.3000,14.7000,NULL,NULL]::numeric[],
  ARRAY[0,0,0,0.9736,0.8253,0,0,0.9852,1,0.8441,0,0]::numeric[],
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
  '100161008218W509', '100/16-10-082-18W5/09', 'OBE 100 HZ HARMONV 16-10-82-18',
  56.0991384, -116.7456238,
  'Bluesky', 'HARMON VALLEY',
  'Pumping', 'LOW', 9,
  51.7,
  18263, 2903.60009765625,
  '2025-03-31', '2025-12-01',
  0.7385, 94,
  ARRAY[0,0,0,664,734,720,744,738,696,740,696,737]::int[],
  ARRAY[NULL,NULL,NULL,104.2000,97.3000,64.1000,36.8000,94.7000,68.0000,56.3000,38.6000,52.2000]::numeric[],
  ARRAY[0,0,0,0.9222,0.9866,1,1,0.9919,0.9667,0.9946,0.9667,0.9906]::numeric[],
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
  '100152608117W508', '100/15-26-081-17W5/08', 'OBE 100 HZ DAWSON 15-26-81-17',
  56.0524302, -116.567248,
  'Bluesky', 'DAWSON',
  'Pumping', 'DOWN NOW', NULL,
  0,
  561, 89.19999694824219,
  '2025-02-20', '2025-12-01',
  0.0745, 338,
  ARRAY[0,216,437,0,0,0,0,0,0,0,0,0]::int[],
  ARRAY[NULL,0.1000,30.7000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL]::numeric[],
  ARRAY[0,0.3214,0.5874,0,0,0,0,0,0,0,0,0]::numeric[],
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
  '100161508216W509', '100/16-15-082-16W5/09', 'OBE 100 HZ SEAL 16-15-82-16',
  56.1199709, -116.4406783,
  'Bluesky', 'SEAL',
  'Pumping', 'LOW', 8,
  270.9,
  71517, 11370.2998046875,
  '2025-04-19', '2025-12-01',
  0.6669, 121,
  ARRAY[0,0,0,0,710,720,744,744,720,744,720,740]::int[],
  ARRAY[NULL,NULL,NULL,NULL,379.1000,379.4000,298.8000,299.6000,261.5000,241.3000,221.6000,272.4000]::numeric[],
  ARRAY[0,0,0,0,0.9543,1,1,1,1,1,1,0.9946]::numeric[],
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
  '100131808317W509', '100/13-18-083-17W5/09', 'OBE 100 HZ SEAL HV SOUTH 13-18-83-17',
  56.186332, -116.6802246,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'LOW', 5,
  204.4,
  32818, 5217.7001953125,
  '2025-07-28', '2025-12-01',
  0.4045, 217,
  ARRAY[0,0,0,0,0,0,0,739,717,743,600,744]::int[],
  ARRAY[NULL,NULL,NULL,NULL,NULL,NULL,NULL,274.4000,230.5000,233.7000,156.6000,204.4000]::numeric[],
  ARRAY[0,0,0,0,0,0,0,0.9933,0.9958,0.9987,0.8333,1]::numeric[],
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
  '100141808317W509', '100/14-18-083-17W5/09', 'OBE 100 HZ SEAL HV SOUTH 14-18-83-17',
  56.186153, -116.6802266,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'LOW', 5,
  222,
  53339, 8480.2001953125,
  '2025-07-28', '2025-12-01',
  0.3968, 220,
  ARRAY[0,0,0,0,0,0,0,743,719,742,720,552]::int[],
  ARRAY[NULL,NULL,NULL,NULL,NULL,NULL,NULL,462.2000,450.3000,330.5000,281.3000,299.2000]::numeric[],
  ARRAY[0,0,0,0,0,0,0,0.9987,0.9986,0.9973,1,0.7419]::numeric[],
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
  '100021908317W509', '100/02-19-083-17W5/09', 'OBE 100 HZ SEAL HV SOUTH 2-19-83-17',
  56.186152, -116.6799046,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'RECENTLY CHANGED', 5,
  272,
  78009, 14190.599609375,
  '2025-05-03', '2025-12-01',
  0.5747, 155,
  ARRAY[0,0,0,0,663,720,96,722,701,672,720,740]::int[],
  ARRAY[NULL,NULL,NULL,NULL,451.1000,492.8000,366.2000,403.6000,341.2000,332.9000,314.5000,273.5000]::numeric[],
  ARRAY[0,0,0,0,0.8911,1,0.129,0.9704,0.9736,0.9032,1,0.9946]::numeric[],
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
  '102161808317W509', '102/16-18-083-17W5/09', 'OBE 102 HZ 16-18-83-17',
  56.185591, -116.6596773,
  'Bluesky', 'UNDEFINED',
  'Pumping', 'LOW', 9,
  211.5,
  75081, 11937,
  '2025-04-14', '2025-12-01',
  0.704, 108,
  ARRAY[0,0,0,404,744,720,731,654,715,738,717,744]::int[],
  ARRAY[NULL,NULL,NULL,265.9000,408.8000,315.2000,286.0000,320.2000,341.5000,239.8000,232.1000,211.5000]::numeric[],
  ARRAY[0,0,0,0.5611,1,1,0.9825,0.879,0.9931,0.9919,0.9958,1]::numeric[],
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
