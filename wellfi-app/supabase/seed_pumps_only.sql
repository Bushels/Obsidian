-- Pump Change Records
DO $$
BEGIN
  -- HIGH risk well 100080808215W500
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100080808215W500'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103090808215W500
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103090808215W500'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 104090808215W500
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '104090808215W500'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103160808215W500
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103160808215W500'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103090508215W500
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103090508215W500'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100152408419W500
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100152408419W500'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100142408419W500
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100142408419W500'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102142408419W500
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102142408419W500'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100162608415W500
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100162608415W500'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100092608415W507
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100092608415W507'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103080808215W500
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103080808215W500'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103052408218W502
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103052408218W502'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100040608317W502
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100040608317W502'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 104093608218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '104093608218W509'
  ON CONFLICT DO NOTHING;
  -- RECENTLY CHANGED well 102043208318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, actual_date, notes, device_sourced)
  SELECT w.id, 'completed', 'system:data_import', '2025-07-01', 'Inferred pump change. Shutdown: May, Restart: Jul. ', FALSE
  FROM wells w WHERE w.well_id = '102043208318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100132708415W508
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100132708415W508'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100143008318W502
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100143008318W502'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100061908318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100061908318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103131908217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103131908217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 104041808217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '104041808217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102133108318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102133108318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 104052508419W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '104052508419W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 106132508419W508
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '106132508419W508'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 105132408419W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '105132408419W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 104162308419W508
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '104162308419W508'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 105142408419W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '105142408419W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 106042508419W508
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '106042508419W508'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100163408218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100163408218W509'
  ON CONFLICT DO NOTHING;
  -- RECENTLY CHANGED well 100153108217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, actual_date, notes, device_sourced)
  SELECT w.id, 'completed', 'system:data_import', '2025-02-01', 'Inferred pump change. Shutdown: Mar, Restart: Feb, Apr. ', FALSE
  FROM wells w WHERE w.well_id = '100153108217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 104132308419W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '104132308419W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 104152308419W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '104152308419W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 105132508419W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '105132508419W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100162208419W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100162208419W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100093108318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100093108318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103043108318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103043108318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100053108318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100053108318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102143008318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102143008318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100041908318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100041908318W509'
  ON CONFLICT DO NOTHING;
  -- RECENTLY CHANGED well 103143008318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, actual_date, notes, device_sourced)
  SELECT w.id, 'completed', 'system:data_import', '2025-06-01', 'Inferred pump change. Shutdown: Apr, Restart: Jun. ', FALSE
  FROM wells w WHERE w.well_id = '103143008318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100163108318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100163108318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102163008318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102163008318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100043008318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100043008318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102122408218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102122408218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102092308218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102092308218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100142208419W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100142208419W509'
  ON CONFLICT DO NOTHING;
  -- RECENTLY CHANGED well 100013308218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, actual_date, notes, device_sourced)
  SELECT w.id, 'completed', 'system:data_import', '2025-06-01', 'Inferred pump change. Shutdown: May, Restart: Jun. ', FALSE
  FROM wells w WHERE w.well_id = '100013308218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100083308218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100083308218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100121908217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100121908217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102123608218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102123608218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102113608218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102113608218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102143508218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102143508218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100143508218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100143508218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100123508218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100123508218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100161208318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100161208318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100163508218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100163508218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102040508317W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102040508317W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103143108217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103143108217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100140808317W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100140808317W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102153108217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102153108217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102143108217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102143108217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100160808317W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100160808317W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 1W0133108217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '1W0133108217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 1W0130808317W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '1W0130808317W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100150708317W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100150708317W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102150708317W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102150708317W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 104123608218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '104123608218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103123608218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103123608218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102140708317W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102140708317W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100150108318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100150108318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 104051308218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '104051308218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100021808217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100021808217W509'
  ON CONFLICT DO NOTHING;
  -- RECENTLY CHANGED well 102151908217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, actual_date, notes, device_sourced)
  SELECT w.id, 'completed', 'system:data_import', '2025-07-01', 'Inferred pump change. Shutdown: Jun, Oct, Restart: Jul, Nov. ', FALSE
  FROM wells w WHERE w.well_id = '102151908217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100151908217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100151908217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100011908318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100011908318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102021908318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102021908318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100081908217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100081908217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100011308218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100011308218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102011308218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102011308218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102082508218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102082508218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103082408218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103082408218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100031308218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100031308218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100041308218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100041308218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 104052408218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '104052408218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102062408218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102062408218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100162908318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100162908318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103133408318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103133408318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100022008318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100022008318W509'
  ON CONFLICT DO NOTHING;
  -- RECENTLY CHANGED well 100151908318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, actual_date, notes, device_sourced)
  SELECT w.id, 'completed', 'system:data_import', '2025-09-01', 'Inferred pump change. Shutdown: Jul, Restart: Sep. ', FALSE
  FROM wells w WHERE w.well_id = '100151908318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100023208318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100023208318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100033208318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100033208318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103143408318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103143408318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102143408318W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102143408318W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100023508218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100023508218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 104113608218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '104113608218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 104020808317W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '104020808317W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102013108217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102013108217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100130508317W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100130508317W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103113608218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103113608218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102103608218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102103608218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100040708317W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100040708317W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103010508215W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103010508215W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 104080508215W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '104080508215W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100060808215W508
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100060808215W508'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 105090808215W507
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '105090808215W507'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103151908217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103151908217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 104141908217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '104141908217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 104131908217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '104131908217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 104093508218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '104093508218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100083408218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100083408218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103032608218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103032608218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100013208319W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100013208319W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100023208319W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100023208319W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100033208319W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100033208319W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100043208319W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100043208319W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 106093208115W507
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '106093208115W507'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 104083208115W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '104083208115W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100010608013W502
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100010608013W502'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 105163208115W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '105163208115W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 106080508215W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '106080508215W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 106010808215W505
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '106010808215W505'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 108160508215W506
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '108160508215W506'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103162908115W506
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103162908115W506'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 104092908115W506
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '104092908115W506'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100033208217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100033208217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102033208217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102033208217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100040908013W500
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100040908013W500'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100011708317W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100011708317W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100143008216W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100143008216W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100133008216W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100133008216W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 1S0013008217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '1S0013008217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 1S0042908217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '1S0042908217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 1S0032908217W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '1S0032908217W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 104160808215W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '104160808215W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100040908012W500
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100040908012W500'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102143008216W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102143008216W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100141808216W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100141808216W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100121808216W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100121808216W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102082708218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102082708218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103012708218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103012708218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102153008216W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102153008216W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100101808216W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100101808216W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100091808216W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100091808216W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103153008216W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103153008216W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 102163008216W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '102163008216W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100151908317W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100151908317W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100141708317W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100141708317W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100132908216W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100132908216W509'
  ON CONFLICT DO NOTHING;
  -- RECENTLY CHANGED well 100021608216W509
  INSERT INTO pump_changes (well_id, status, flagged_by, actual_date, notes, device_sourced)
  SELECT w.id, 'completed', 'system:data_import', '2025-04-01', 'Inferred pump change. Shutdown: Feb, Restart: Apr. ', FALSE
  FROM wells w WHERE w.well_id = '100021608216W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 103132208419W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '103132208419W509'
  ON CONFLICT DO NOTHING;
  -- RECENTLY CHANGED well 100151208317W509
  INSERT INTO pump_changes (well_id, status, flagged_by, actual_date, notes, device_sourced)
  SELECT w.id, 'completed', 'system:data_import', '2025-10-01', 'Inferred pump change. Shutdown: Jul, Restart: Oct. ', FALSE
  FROM wells w WHERE w.well_id = '100151208317W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100160608316W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100160608316W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100090608316W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100090608316W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100082908218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100082908218W509'
  ON CONFLICT DO NOTHING;
  -- HIGH risk well 100012908218W509
  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)
  SELECT w.id, 'warning', 'system:data_import', 'Automated flag: 12 consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours. Running 12+ months (no shutdown in 2025) — likely at or past pump change window', FALSE
  FROM wells w WHERE w.well_id = '100012908218W509'
  ON CONFLICT DO NOTHING;
  -- RECENTLY CHANGED well 100021908317W509
  INSERT INTO pump_changes (well_id, status, flagged_by, actual_date, notes, device_sourced)
  SELECT w.id, 'completed', 'system:data_import', '2025-05-01', 'Inferred pump change. Shutdown: Jul, Restart: May, Aug. ', FALSE
  FROM wells w WHERE w.well_id = '100021908317W509'
  ON CONFLICT DO NOTHING;
END $$;