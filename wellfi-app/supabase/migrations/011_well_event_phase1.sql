-- 011_well_event_phase1.sql
-- Phase 1 foundation for the Well Event workflow:
-- canonical event model, fulfillment model, separate tool inventory,
-- audit log, scoped RLS, and atomic write RPCs.

CREATE TABLE well_events (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  well_id             UUID NOT NULL REFERENCES wells(id) ON DELETE CASCADE,
  operator_id         UUID NOT NULL REFERENCES operators(id) ON DELETE RESTRICT,
  state               TEXT NOT NULL CHECK (state IN ('watch', 'warning', 'down')),
  is_active           BOOLEAN NOT NULL DEFAULT TRUE,
  is_abrupt           BOOLEAN NOT NULL DEFAULT FALSE,
  support_requested   BOOLEAN NOT NULL DEFAULT TRUE,
  expected_down_date  DATE,
  expected_start_date DATE,
  expected_end_date   DATE,
  requested_tool_type TEXT,
  notes               TEXT,
  created_by_user_id  UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  created_by_name     TEXT NOT NULL,
  updated_by_user_id  UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  updated_by_name     TEXT,
  source_channel      TEXT NOT NULL DEFAULT 'app'
                      CHECK (source_channel IN ('app', 'slack', 'telegram', 'admin')),
  created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  cleared_at          TIMESTAMPTZ,
  cleared_by_user_id  UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  cleared_by_name     TEXT,

  CONSTRAINT well_events_date_window_chk CHECK (
    expected_start_date IS NULL
    OR expected_end_date IS NULL
    OR expected_start_date <= expected_end_date
  ),
  CONSTRAINT well_events_expected_date_mode_chk CHECK (
    expected_down_date IS NULL
    OR (expected_start_date IS NULL AND expected_end_date IS NULL)
  )
);

CREATE UNIQUE INDEX idx_well_events_active_well
  ON well_events (well_id)
  WHERE is_active = TRUE;

CREATE INDEX idx_well_events_operator_active
  ON well_events (operator_id, is_active);

CREATE INDEX idx_well_events_state_active
  ON well_events (state, is_active)
  WHERE is_active = TRUE;

CREATE INDEX idx_well_events_well
  ON well_events (well_id);

CREATE TABLE tool_inventory (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  serial_number TEXT NOT NULL UNIQUE,
  tool_type   TEXT NOT NULL,
  model       TEXT,
  status      TEXT NOT NULL DEFAULT 'in_stock'
              CHECK (status IN ('in_stock', 'reserved', 'deployed', 'service', 'retired')),
  notes       TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_tool_inventory_status
  ON tool_inventory (status);

CREATE INDEX idx_tool_inventory_type
  ON tool_inventory (tool_type);

CREATE TABLE well_event_fulfillment (
  id                            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  well_event_id                 UUID NOT NULL REFERENCES well_events(id) ON DELETE CASCADE,
  status                        TEXT NOT NULL DEFAULT 'unassigned'
                                CHECK (status IN (
                                  'unassigned',
                                  'tool_reserved',
                                  'scheduled',
                                  'dispatched',
                                  'on_site',
                                  'completed',
                                  'cancelled'
                                )),
  assigned_tool_id              UUID REFERENCES tool_inventory(id) ON DELETE RESTRICT,
  assigned_tech_user_id         UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  assigned_tech_name            TEXT,
  planned_service_date          DATE,
  expected_downtime_hours       NUMERIC,
  estimated_production_loss_bbl NUMERIC,
  internal_notes                TEXT,
  last_updated_by_user_id       UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  last_updated_by_name          TEXT,
  created_at                    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at                    TIMESTAMPTZ NOT NULL DEFAULT now(),
  completed_at                  TIMESTAMPTZ,

  CONSTRAINT well_event_fulfillment_one_per_event UNIQUE (well_event_id),
  CONSTRAINT well_event_fulfillment_nonnegative_chk CHECK (
    (expected_downtime_hours IS NULL OR expected_downtime_hours >= 0)
    AND (estimated_production_loss_bbl IS NULL OR estimated_production_loss_bbl >= 0)
  ),
  CONSTRAINT well_event_fulfillment_completed_at_chk CHECK (
    (status = 'completed' AND completed_at IS NOT NULL)
    OR (status <> 'completed' AND completed_at IS NULL)
  )
);

CREATE INDEX idx_well_event_fulfillment_status
  ON well_event_fulfillment (status);

CREATE INDEX idx_well_event_fulfillment_planned_date
  ON well_event_fulfillment (planned_service_date);

CREATE INDEX idx_well_event_fulfillment_assigned_tool
  ON well_event_fulfillment (assigned_tool_id)
  WHERE assigned_tool_id IS NOT NULL;

CREATE UNIQUE INDEX idx_well_event_fulfillment_active_tool
  ON well_event_fulfillment (assigned_tool_id)
  WHERE assigned_tool_id IS NOT NULL
    AND status IN ('tool_reserved', 'scheduled', 'dispatched', 'on_site');

CREATE TABLE well_event_audit_log (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  well_event_id  UUID REFERENCES well_events(id) ON DELETE SET NULL,
  well_id        UUID NOT NULL REFERENCES wells(id) ON DELETE RESTRICT,
  actor_user_id  UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  actor_name     TEXT NOT NULL,
  actor_role     TEXT NOT NULL,
  action         TEXT NOT NULL,
  from_state     TEXT,
  to_state       TEXT,
  source_channel TEXT NOT NULL,
  payload        JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_well_event_audit_log_event
  ON well_event_audit_log (well_event_id);

CREATE INDEX idx_well_event_audit_log_well
  ON well_event_audit_log (well_id);

CREATE INDEX idx_well_event_audit_log_created
  ON well_event_audit_log (created_at DESC);

CREATE TABLE well_activity_log (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  well_id        UUID NOT NULL REFERENCES wells(id) ON DELETE RESTRICT,
  operator_id    UUID NOT NULL REFERENCES operators(id) ON DELETE RESTRICT,
  activity_type  TEXT NOT NULL,
  source_table   TEXT NOT NULL,
  source_record_id UUID,
  actor_user_id  UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  actor_name     TEXT,
  occurred_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  payload        JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_well_activity_log_well_occurred
  ON well_activity_log (well_id, occurred_at DESC);

CREATE INDEX idx_well_activity_log_operator_occurred
  ON well_activity_log (operator_id, occurred_at DESC);

CREATE INDEX idx_well_activity_log_type_occurred
  ON well_activity_log (activity_type, occurred_at DESC);

CREATE OR REPLACE FUNCTION public.sync_well_event_operator_id()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_operator_id UUID;
BEGIN
  SELECT operator_id
  INTO v_operator_id
  FROM public.wells
  WHERE id = NEW.well_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Well % not found', NEW.well_id;
  END IF;

  IF v_operator_id IS NULL THEN
    RAISE EXCEPTION 'Well % has no operator scope', NEW.well_id;
  END IF;

  NEW.operator_id := v_operator_id;
  RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION public.well_event_state_rank(p_state TEXT)
RETURNS INTEGER
LANGUAGE sql
IMMUTABLE
AS $$
  SELECT CASE p_state
    WHEN 'watch' THEN 1
    WHEN 'warning' THEN 2
    WHEN 'down' THEN 3
    ELSE 0
  END;
$$;

CREATE OR REPLACE FUNCTION public.log_well_activity(
  p_well_id UUID,
  p_activity_type TEXT,
  p_source_table TEXT,
  p_operator_id UUID DEFAULT NULL,
  p_source_record_id UUID DEFAULT NULL,
  p_actor_user_id UUID DEFAULT NULL,
  p_actor_name TEXT DEFAULT NULL,
  p_occurred_at TIMESTAMPTZ DEFAULT now(),
  p_payload JSONB DEFAULT '{}'::jsonb
)
RETURNS public.well_activity_log
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_operator_id UUID;
  v_log_row public.well_activity_log%ROWTYPE;
BEGIN
  IF p_activity_type IS NULL OR NULLIF(TRIM(p_activity_type), '') IS NULL THEN
    RAISE EXCEPTION 'Activity type is required';
  END IF;

  IF p_source_table IS NULL OR NULLIF(TRIM(p_source_table), '') IS NULL THEN
    RAISE EXCEPTION 'Source table is required';
  END IF;

  IF p_operator_id IS NULL THEN
    SELECT operator_id
    INTO v_operator_id
    FROM public.wells
    WHERE id = p_well_id;

    IF NOT FOUND OR v_operator_id IS NULL THEN
      RAISE EXCEPTION 'Unable to resolve operator scope for well %', p_well_id;
    END IF;
  ELSE
    v_operator_id := p_operator_id;
  END IF;

  INSERT INTO public.well_activity_log (
    well_id,
    operator_id,
    activity_type,
    source_table,
    source_record_id,
    actor_user_id,
    actor_name,
    occurred_at,
    payload
  ) VALUES (
    p_well_id,
    v_operator_id,
    TRIM(p_activity_type),
    TRIM(p_source_table),
    p_source_record_id,
    p_actor_user_id,
    NULLIF(TRIM(COALESCE(p_actor_name, '')), ''),
    p_occurred_at,
    COALESCE(p_payload, '{}'::jsonb)
  )
  RETURNING *
  INTO v_log_row;

  RETURN v_log_row;
END;
$$;

CREATE OR REPLACE FUNCTION public.log_wellfi_device_activity()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_actor_id UUID := auth.uid();
  v_actor_name TEXT;
BEGIN
  IF v_actor_id IS NOT NULL THEN
    SELECT COALESCE(NULLIF(TRIM(display_name), ''), NULLIF(TRIM(username), ''), NULL)
    INTO v_actor_name
    FROM public.app_users
    WHERE id = v_actor_id;
  END IF;

  IF TG_OP = 'INSERT' AND NEW.is_active = TRUE THEN
    PERFORM public.log_well_activity(
      p_well_id => NEW.well_id,
      p_activity_type => 'wellfi_installed',
      p_source_table => 'wellfi_devices',
      p_source_record_id => NEW.id,
      p_actor_user_id => v_actor_id,
      p_actor_name => COALESCE(v_actor_name, NEW.installed_by, 'Unknown User'),
      p_occurred_at => COALESCE(NEW.installed_at, NEW.created_at),
      p_payload => jsonb_build_object(
        'serial_number', NEW.serial_number,
        'firmware_version', NEW.firmware_version,
        'pump_speed_rpm', NEW.pump_speed_rpm,
        'formation_pressure_kpa', NEW.formation_pressure_kpa,
        'pump_intake_pressure_kpa', NEW.pump_intake_pressure_kpa,
        'target_surface_pressure_kpa', NEW.target_surface_pressure_kpa,
        'notes', NEW.notes
      )
    );
  ELSIF TG_OP = 'UPDATE'
    AND OLD.is_active = TRUE
    AND NEW.is_active = FALSE THEN
    PERFORM public.log_well_activity(
      p_well_id => NEW.well_id,
      p_activity_type => 'wellfi_deactivated',
      p_source_table => 'wellfi_devices',
      p_source_record_id => NEW.id,
      p_actor_user_id => v_actor_id,
      p_actor_name => COALESCE(v_actor_name, NEW.installed_by, 'Unknown User'),
      p_occurred_at => now(),
      p_payload => jsonb_build_object(
        'serial_number', NEW.serial_number,
        'firmware_version', NEW.firmware_version
      )
    );
  END IF;

  RETURN COALESCE(NEW, OLD);
END;
$$;

CREATE OR REPLACE FUNCTION public.sync_tool_inventory_status_from_fulfillment()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_next_status TEXT;
  v_tool_status TEXT;
BEGIN
  IF TG_OP IN ('UPDATE', 'DELETE')
     AND OLD.assigned_tool_id IS NOT NULL
     AND (
       TG_OP = 'DELETE'
       OR NEW.assigned_tool_id IS DISTINCT FROM OLD.assigned_tool_id
       OR NEW.status IN ('completed', 'cancelled', 'unassigned')
     ) THEN
    UPDATE public.tool_inventory
    SET status = 'in_stock'
    WHERE id = OLD.assigned_tool_id
      AND status NOT IN ('service', 'retired')
      AND NOT EXISTS (
        SELECT 1
        FROM public.well_event_fulfillment
        WHERE assigned_tool_id = OLD.assigned_tool_id
          AND id <> OLD.id
          AND status IN ('tool_reserved', 'scheduled', 'dispatched', 'on_site')
      );
  END IF;

  IF TG_OP IN ('INSERT', 'UPDATE') AND NEW.assigned_tool_id IS NOT NULL THEN
    SELECT status
    INTO v_tool_status
    FROM public.tool_inventory
    WHERE id = NEW.assigned_tool_id
    FOR UPDATE;

    IF NOT FOUND THEN
      RAISE EXCEPTION 'Assigned tool % not found', NEW.assigned_tool_id;
    END IF;

    IF v_tool_status IN ('service', 'retired') THEN
      RAISE EXCEPTION 'Tool % is not assignable while status is %', NEW.assigned_tool_id, v_tool_status;
    END IF;

    v_next_status := CASE NEW.status
      WHEN 'tool_reserved' THEN 'reserved'
      WHEN 'scheduled' THEN 'reserved'
      WHEN 'dispatched' THEN 'deployed'
      WHEN 'on_site' THEN 'deployed'
      ELSE 'in_stock'
    END;

    UPDATE public.tool_inventory
    SET status = v_next_status
    WHERE id = NEW.assigned_tool_id;
  END IF;

  RETURN COALESCE(NEW, OLD);
END;
$$;

CREATE TRIGGER well_events_operator_id_sync
  BEFORE INSERT
  ON well_events
  FOR EACH ROW
  EXECUTE FUNCTION public.sync_well_event_operator_id();

CREATE TRIGGER well_events_updated_at
  BEFORE UPDATE ON well_events
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER tool_inventory_updated_at
  BEFORE UPDATE ON tool_inventory
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER well_event_fulfillment_updated_at
  BEFORE UPDATE ON well_event_fulfillment
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER well_event_fulfillment_tool_status_sync
  AFTER INSERT OR UPDATE OF assigned_tool_id, status OR DELETE
  ON well_event_fulfillment
  FOR EACH ROW
  EXECUTE FUNCTION public.sync_tool_inventory_status_from_fulfillment();

CREATE TRIGGER wellfi_devices_activity_log
  AFTER INSERT OR UPDATE OF is_active
  ON wellfi_devices
  FOR EACH ROW
  EXECUTE FUNCTION public.log_wellfi_device_activity();

ALTER TABLE well_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE tool_inventory ENABLE ROW LEVEL SECURITY;
ALTER TABLE well_event_fulfillment ENABLE ROW LEVEL SECURITY;
ALTER TABLE well_event_audit_log ENABLE ROW LEVEL SECURITY;
ALTER TABLE well_activity_log ENABLE ROW LEVEL SECURITY;

CREATE POLICY "operators_read_well_events"
  ON well_events FOR SELECT TO authenticated
  USING (
    public.current_app_user_is_admin()
    OR well_events.operator_id = public.current_app_user_operator_id()
  );

CREATE POLICY "operators_read_well_event_fulfillment"
  ON well_event_fulfillment FOR SELECT TO authenticated
  USING (
    public.current_app_user_is_admin()
    OR EXISTS (
      SELECT 1
      FROM public.well_events
      WHERE well_events.id = well_event_fulfillment.well_event_id
        AND well_events.operator_id = public.current_app_user_operator_id()
    )
  );

CREATE POLICY "admin_manage_well_event_fulfillment"
  ON well_event_fulfillment FOR ALL TO authenticated
  USING (public.current_app_user_is_admin())
  WITH CHECK (public.current_app_user_is_admin());

CREATE POLICY "admin_manage_tool_inventory"
  ON tool_inventory FOR ALL TO authenticated
  USING (public.current_app_user_is_admin())
  WITH CHECK (public.current_app_user_is_admin());

CREATE POLICY "operators_read_well_event_audit_log"
  ON well_event_audit_log FOR SELECT TO authenticated
  USING (
    public.current_app_user_is_admin()
    OR EXISTS (
      SELECT 1
      FROM public.wells
      WHERE wells.id = well_event_audit_log.well_id
        AND wells.operator_id = public.current_app_user_operator_id()
    )
  );

CREATE POLICY "operators_read_well_activity_log"
  ON well_activity_log FOR SELECT TO authenticated
  USING (
    public.current_app_user_is_admin()
    OR well_activity_log.operator_id = public.current_app_user_operator_id()
  );

CREATE POLICY "admin_manage_well_activity_log"
  ON well_activity_log FOR ALL TO authenticated
  USING (public.current_app_user_is_admin())
  WITH CHECK (public.current_app_user_is_admin());

CREATE OR REPLACE FUNCTION public.set_well_event(
  p_well_id UUID,
  p_state TEXT,
  p_is_abrupt BOOLEAN DEFAULT NULL,
  p_support_requested BOOLEAN DEFAULT NULL,
  p_expected_down_date DATE DEFAULT NULL,
  p_expected_start_date DATE DEFAULT NULL,
  p_expected_end_date DATE DEFAULT NULL,
  p_requested_tool_type TEXT DEFAULT NULL,
  p_notes TEXT DEFAULT NULL,
  p_source_channel TEXT DEFAULT 'app'
)
RETURNS public.well_events
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_actor_id UUID := auth.uid();
  v_actor_name TEXT;
  v_actor_role TEXT;
  v_actor_operator_id UUID;
  v_target_operator_id UUID;
  v_existing_event public.well_events%ROWTYPE;
  v_new_event public.well_events%ROWTYPE;
  v_existing_fulfillment public.well_event_fulfillment%ROWTYPE;
  v_action TEXT;
  v_effective_is_abrupt BOOLEAN;
  v_effective_support_requested BOOLEAN;
  v_effective_expected_down_date DATE;
  v_effective_expected_start_date DATE;
  v_effective_expected_end_date DATE;
  v_effective_requested_tool_type TEXT;
  v_effective_notes TEXT;
BEGIN
  IF v_actor_id IS NULL THEN
    RAISE EXCEPTION 'Authentication required';
  END IF;

  IF p_state NOT IN ('watch', 'warning', 'down') THEN
    RAISE EXCEPTION 'Invalid well event state: %', p_state;
  END IF;

  IF p_source_channel NOT IN ('app', 'slack', 'telegram', 'admin') THEN
    RAISE EXCEPTION 'Invalid source channel: %', p_source_channel;
  END IF;

  SELECT
    COALESCE(NULLIF(TRIM(display_name), ''), NULLIF(TRIM(username), ''), 'Unknown User'),
    role,
    operator_id
  INTO v_actor_name, v_actor_role, v_actor_operator_id
  FROM public.app_users
  WHERE id = v_actor_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Authenticated user % is missing from app_users', v_actor_id;
  END IF;

  SELECT operator_id
  INTO v_target_operator_id
  FROM public.wells
  WHERE id = p_well_id
  FOR UPDATE;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Well % not found', p_well_id;
  END IF;

  IF v_target_operator_id IS NULL THEN
    RAISE EXCEPTION 'Well % has no operator scope', p_well_id;
  END IF;

  IF NOT public.current_app_user_is_admin() THEN
    IF v_actor_role <> 'viewer' THEN
      RAISE EXCEPTION 'Only operator viewers or admins can set well events';
    END IF;

    IF v_actor_operator_id IS DISTINCT FROM v_target_operator_id THEN
      RAISE EXCEPTION 'You cannot manage events for wells outside your operator scope';
    END IF;
  END IF;

  SELECT *
  INTO v_existing_event
  FROM public.well_events
  WHERE well_id = p_well_id
    AND is_active = TRUE
  FOR UPDATE;

  IF FOUND THEN
    SELECT *
    INTO v_existing_fulfillment
    FROM public.well_event_fulfillment
    WHERE well_event_id = v_existing_event.id
    FOR UPDATE;
  END IF;

  v_effective_is_abrupt := COALESCE(p_is_abrupt, v_existing_event.is_abrupt, FALSE);
  v_effective_support_requested := COALESCE(p_support_requested, v_existing_event.support_requested, TRUE);
  v_effective_expected_down_date := COALESCE(p_expected_down_date, v_existing_event.expected_down_date);
  v_effective_expected_start_date := COALESCE(p_expected_start_date, v_existing_event.expected_start_date);
  v_effective_expected_end_date := COALESCE(p_expected_end_date, v_existing_event.expected_end_date);
  v_effective_requested_tool_type := COALESCE(NULLIF(TRIM(p_requested_tool_type), ''), v_existing_event.requested_tool_type);
  v_effective_notes := COALESCE(NULLIF(TRIM(p_notes), ''), v_existing_event.notes);

  IF v_effective_expected_start_date IS NOT NULL
     AND v_effective_expected_end_date IS NOT NULL
     AND v_effective_expected_start_date > v_effective_expected_end_date THEN
    RAISE EXCEPTION 'Expected start date must be on or before expected end date';
  END IF;

  IF v_effective_expected_down_date IS NOT NULL
     AND (v_effective_expected_start_date IS NOT NULL OR v_effective_expected_end_date IS NOT NULL) THEN
    RAISE EXCEPTION 'Provide either an expected down date or a date window, not both';
  END IF;

  IF v_existing_event.id IS NOT NULL THEN
    IF v_existing_event.state = p_state THEN
      v_action := 'update';
    ELSIF public.well_event_state_rank(p_state) > public.well_event_state_rank(v_existing_event.state) THEN
      v_action := 'escalate';
    ELSE
      v_action := 'deescalate';
    END IF;

    IF v_existing_fulfillment.status = 'completed' AND v_action <> 'update' THEN
      RAISE EXCEPTION 'Clear the current event before reopening it after a completed fulfillment';
    END IF;

    UPDATE public.well_events
    SET
      state = p_state,
      is_abrupt = v_effective_is_abrupt,
      support_requested = v_effective_support_requested,
      expected_down_date = v_effective_expected_down_date,
      expected_start_date = v_effective_expected_start_date,
      expected_end_date = v_effective_expected_end_date,
      requested_tool_type = v_effective_requested_tool_type,
      notes = v_effective_notes,
      updated_by_user_id = v_actor_id,
      updated_by_name = v_actor_name,
      source_channel = p_source_channel
    WHERE id = v_existing_event.id
    RETURNING *
    INTO v_new_event;

    IF v_existing_fulfillment.id IS NULL THEN
      INSERT INTO public.well_event_fulfillment (
        well_event_id,
        status,
        last_updated_by_user_id,
        last_updated_by_name
      ) VALUES (
        v_new_event.id,
        'unassigned',
        v_actor_id,
        v_actor_name
      );
    END IF;

    INSERT INTO public.well_event_audit_log (
      well_event_id,
      well_id,
      actor_user_id,
      actor_name,
      actor_role,
      action,
      from_state,
      to_state,
      source_channel,
      payload
    ) VALUES (
      v_new_event.id,
      p_well_id,
      v_actor_id,
      v_actor_name,
      v_actor_role,
      'update',
      v_existing_event.state,
      v_new_event.state,
      p_source_channel,
      jsonb_build_object(
        'is_abrupt', v_effective_is_abrupt,
        'support_requested', v_effective_support_requested,
        'expected_down_date', v_effective_expected_down_date,
        'expected_start_date', v_effective_expected_start_date,
        'expected_end_date', v_effective_expected_end_date,
        'requested_tool_type', v_effective_requested_tool_type,
        'notes', v_effective_notes
      )
    );

    PERFORM public.log_well_activity(
      p_well_id => p_well_id,
      p_operator_id => v_target_operator_id,
      p_activity_type => CASE v_action
        WHEN 'update' THEN 'well_event_updated'
        WHEN 'escalate' THEN 'well_event_escalated'
        WHEN 'deescalate' THEN 'well_event_deescalated'
        ELSE 'well_event_updated'
      END,
      p_source_table => 'well_events',
      p_source_record_id => v_new_event.id,
      p_actor_user_id => v_actor_id,
      p_actor_name => v_actor_name,
      p_occurred_at => now(),
      p_payload => jsonb_build_object(
        'state', v_new_event.state,
        'is_abrupt', v_effective_is_abrupt,
        'support_requested', v_effective_support_requested,
        'expected_down_date', v_effective_expected_down_date,
        'expected_start_date', v_effective_expected_start_date,
        'expected_end_date', v_effective_expected_end_date,
        'requested_tool_type', v_effective_requested_tool_type,
        'notes', v_effective_notes
      )
    );

    RETURN v_new_event;
  END IF;

  INSERT INTO public.well_events (
    well_id,
    operator_id,
    state,
    is_active,
    is_abrupt,
    support_requested,
    expected_down_date,
    expected_start_date,
    expected_end_date,
    requested_tool_type,
    notes,
    created_by_user_id,
    created_by_name,
    updated_by_user_id,
    updated_by_name,
    source_channel
  ) VALUES (
    p_well_id,
    v_target_operator_id,
    p_state,
    TRUE,
    v_effective_is_abrupt,
    v_effective_support_requested,
    v_effective_expected_down_date,
    v_effective_expected_start_date,
    v_effective_expected_end_date,
    v_effective_requested_tool_type,
    v_effective_notes,
    v_actor_id,
    v_actor_name,
    v_actor_id,
    v_actor_name,
    p_source_channel
  )
  RETURNING *
  INTO v_new_event;

  v_action := 'create';

  INSERT INTO public.well_event_fulfillment (
    well_event_id,
    status,
    last_updated_by_user_id,
    last_updated_by_name
  ) VALUES (
    v_new_event.id,
    'unassigned',
    v_actor_id,
    v_actor_name
  );

  INSERT INTO public.well_event_audit_log (
    well_event_id,
    well_id,
    actor_user_id,
    actor_name,
    actor_role,
    action,
    from_state,
    to_state,
    source_channel,
    payload
  ) VALUES (
    v_new_event.id,
    p_well_id,
    v_actor_id,
    v_actor_name,
    v_actor_role,
    v_action,
    v_existing_event.state,
    v_new_event.state,
    p_source_channel,
    jsonb_build_object(
      'is_abrupt', v_effective_is_abrupt,
      'support_requested', v_effective_support_requested,
      'expected_down_date', v_effective_expected_down_date,
      'expected_start_date', v_effective_expected_start_date,
      'expected_end_date', v_effective_expected_end_date,
      'requested_tool_type', v_effective_requested_tool_type,
      'notes', v_effective_notes
    )
  );

  PERFORM public.log_well_activity(
    p_well_id => p_well_id,
    p_operator_id => v_target_operator_id,
    p_activity_type => 'well_event_created',
    p_source_table => 'well_events',
    p_source_record_id => v_new_event.id,
    p_actor_user_id => v_actor_id,
    p_actor_name => v_actor_name,
    p_occurred_at => v_new_event.created_at,
    p_payload => jsonb_build_object(
      'state', v_new_event.state,
      'is_abrupt', v_effective_is_abrupt,
      'support_requested', v_effective_support_requested,
      'expected_down_date', v_effective_expected_down_date,
      'expected_start_date', v_effective_expected_start_date,
      'expected_end_date', v_effective_expected_end_date,
      'requested_tool_type', v_effective_requested_tool_type,
      'notes', v_effective_notes
    )
  );

  RETURN v_new_event;
END;
$$;

CREATE OR REPLACE FUNCTION public.clear_well_event(
  p_well_id UUID,
  p_source_channel TEXT DEFAULT 'app'
)
RETURNS public.well_events
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_actor_id UUID := auth.uid();
  v_actor_name TEXT;
  v_actor_role TEXT;
  v_actor_operator_id UUID;
  v_target_operator_id UUID;
  v_active_event public.well_events%ROWTYPE;
  v_fulfillment public.well_event_fulfillment%ROWTYPE;
BEGIN
  IF v_actor_id IS NULL THEN
    RAISE EXCEPTION 'Authentication required';
  END IF;

  IF p_source_channel NOT IN ('app', 'slack', 'telegram', 'admin') THEN
    RAISE EXCEPTION 'Invalid source channel: %', p_source_channel;
  END IF;

  SELECT
    COALESCE(NULLIF(TRIM(display_name), ''), NULLIF(TRIM(username), ''), 'Unknown User'),
    role,
    operator_id
  INTO v_actor_name, v_actor_role, v_actor_operator_id
  FROM public.app_users
  WHERE id = v_actor_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Authenticated user % is missing from app_users', v_actor_id;
  END IF;

  SELECT operator_id
  INTO v_target_operator_id
  FROM public.wells
  WHERE id = p_well_id
  FOR UPDATE;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Well % not found', p_well_id;
  END IF;

  IF v_target_operator_id IS NULL THEN
    RAISE EXCEPTION 'Well % has no operator scope', p_well_id;
  END IF;

  IF NOT public.current_app_user_is_admin() THEN
    IF v_actor_role <> 'viewer' THEN
      RAISE EXCEPTION 'Only operator viewers or admins can clear well events';
    END IF;

    IF v_actor_operator_id IS DISTINCT FROM v_target_operator_id THEN
      RAISE EXCEPTION 'You cannot manage events for wells outside your operator scope';
    END IF;
  END IF;

  SELECT *
  INTO v_active_event
  FROM public.well_events
  WHERE well_id = p_well_id
    AND is_active = TRUE
  FOR UPDATE;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'No active well event found for well %', p_well_id;
  END IF;

  UPDATE public.well_events
  SET
    is_active = FALSE,
    updated_by_user_id = v_actor_id,
    updated_by_name = v_actor_name,
    cleared_at = now(),
    cleared_by_user_id = v_actor_id,
    cleared_by_name = v_actor_name
  WHERE id = v_active_event.id
  RETURNING *
  INTO v_active_event;

  SELECT *
  INTO v_fulfillment
  FROM public.well_event_fulfillment
  WHERE well_event_id = v_active_event.id
  FOR UPDATE;

  IF FOUND AND v_fulfillment.status NOT IN ('completed', 'cancelled') THEN
    UPDATE public.well_event_fulfillment
    SET
      status = 'cancelled',
      last_updated_by_user_id = v_actor_id,
      last_updated_by_name = v_actor_name
    WHERE id = v_fulfillment.id;
  END IF;

  INSERT INTO public.well_event_audit_log (
    well_event_id,
    well_id,
    actor_user_id,
    actor_name,
    actor_role,
    action,
    from_state,
    to_state,
    source_channel,
    payload
  ) VALUES (
    v_active_event.id,
    p_well_id,
    v_actor_id,
    v_actor_name,
    v_actor_role,
    'clear',
    v_active_event.state,
    NULL,
    p_source_channel,
    '{}'::jsonb
  );

  PERFORM public.log_well_activity(
    p_well_id => p_well_id,
    p_operator_id => v_target_operator_id,
    p_activity_type => 'well_event_cleared',
    p_source_table => 'well_events',
    p_source_record_id => v_active_event.id,
    p_actor_user_id => v_actor_id,
    p_actor_name => v_actor_name,
    p_occurred_at => COALESCE(v_active_event.cleared_at, now()),
    p_payload => jsonb_build_object(
      'state', v_active_event.state
    )
  );

  RETURN v_active_event;
END;
$$;

REVOKE ALL ON FUNCTION public.set_well_event(
  UUID,
  TEXT,
  BOOLEAN,
  BOOLEAN,
  DATE,
  DATE,
  DATE,
  TEXT,
  TEXT,
  TEXT
) FROM PUBLIC;

GRANT EXECUTE ON FUNCTION public.set_well_event(
  UUID,
  TEXT,
  BOOLEAN,
  BOOLEAN,
  DATE,
  DATE,
  DATE,
  TEXT,
  TEXT,
  TEXT
) TO authenticated;

GRANT EXECUTE ON FUNCTION public.set_well_event(
  UUID,
  TEXT,
  BOOLEAN,
  BOOLEAN,
  DATE,
  DATE,
  DATE,
  TEXT,
  TEXT,
  TEXT
) TO service_role;

REVOKE ALL ON FUNCTION public.clear_well_event(UUID, TEXT) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.clear_well_event(UUID, TEXT) TO authenticated;
GRANT EXECUTE ON FUNCTION public.clear_well_event(UUID, TEXT) TO service_role;

ALTER PUBLICATION supabase_realtime ADD TABLE well_events;
ALTER PUBLICATION supabase_realtime ADD TABLE well_event_fulfillment;
ALTER PUBLICATION supabase_realtime ADD TABLE tool_inventory;
ALTER PUBLICATION supabase_realtime ADD TABLE well_event_audit_log;
ALTER PUBLICATION supabase_realtime ADD TABLE well_activity_log;
