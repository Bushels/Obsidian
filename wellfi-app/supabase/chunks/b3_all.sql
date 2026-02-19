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
