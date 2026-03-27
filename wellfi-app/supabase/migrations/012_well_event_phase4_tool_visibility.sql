-- Phase 4 follow-up:
-- 1. let operators read only tools assigned to their active well events
-- 2. log fulfillment updates into the well activity timeline

CREATE POLICY "operators_read_assigned_tool_inventory"
  ON public.tool_inventory FOR SELECT TO authenticated
  USING (
    public.current_app_user_is_admin()
    OR EXISTS (
      SELECT 1
      FROM public.well_event_fulfillment AS fulfillment
      INNER JOIN public.well_events AS event
        ON event.id = fulfillment.well_event_id
      WHERE fulfillment.assigned_tool_id = tool_inventory.id
        AND event.is_active = TRUE
        AND event.operator_id = public.current_app_user_operator_id()
    )
  );

CREATE OR REPLACE FUNCTION public.log_well_event_fulfillment_update()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_event public.well_events%ROWTYPE;
  v_tool_serial TEXT;
BEGIN
  IF NEW.status IS NOT DISTINCT FROM OLD.status
     AND NEW.assigned_tool_id IS NOT DISTINCT FROM OLD.assigned_tool_id
     AND NEW.assigned_tech_name IS NOT DISTINCT FROM OLD.assigned_tech_name
     AND NEW.planned_service_date IS NOT DISTINCT FROM OLD.planned_service_date
     AND NEW.expected_downtime_hours IS NOT DISTINCT FROM OLD.expected_downtime_hours
     AND NEW.estimated_production_loss_bbl IS NOT DISTINCT FROM OLD.estimated_production_loss_bbl
     AND NEW.internal_notes IS NOT DISTINCT FROM OLD.internal_notes THEN
    RETURN NEW;
  END IF;

  SELECT *
  INTO v_event
  FROM public.well_events
  WHERE id = NEW.well_event_id;

  IF NOT FOUND THEN
    RETURN NEW;
  END IF;

  IF NEW.assigned_tool_id IS NOT NULL THEN
    SELECT serial_number
    INTO v_tool_serial
    FROM public.tool_inventory
    WHERE id = NEW.assigned_tool_id;
  END IF;

  PERFORM public.log_well_activity(
    p_well_id => v_event.well_id,
    p_operator_id => v_event.operator_id,
    p_activity_type => 'well_event_fulfillment_updated',
    p_source_table => 'well_event_fulfillment',
    p_source_record_id => NEW.id,
    p_actor_user_id => NEW.last_updated_by_user_id,
    p_actor_name => NEW.last_updated_by_name,
    p_occurred_at => NEW.updated_at,
    p_payload => jsonb_build_object(
      'fulfillment_status', NEW.status,
      'assigned_tool_serial', v_tool_serial,
      'assigned_tech_name', NEW.assigned_tech_name,
      'planned_service_date', NEW.planned_service_date,
      'expected_downtime_hours', NEW.expected_downtime_hours,
      'estimated_production_loss_bbl', NEW.estimated_production_loss_bbl,
      'notes', NEW.internal_notes
    )
  );

  RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION public.prevent_tool_inventory_service_override()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  IF NEW.status IN ('service', 'retired')
     AND EXISTS (
       SELECT 1
       FROM public.well_event_fulfillment
       WHERE assigned_tool_id = NEW.id
         AND status IN ('tool_reserved', 'scheduled', 'dispatched', 'on_site')
     ) THEN
    RAISE EXCEPTION 'Tool % cannot be moved to % while assigned to an active fulfillment', NEW.serial_number, NEW.status;
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS well_event_fulfillment_activity_log
  ON public.well_event_fulfillment;

CREATE TRIGGER well_event_fulfillment_activity_log
  AFTER UPDATE OF status, assigned_tool_id, assigned_tech_name, planned_service_date, expected_downtime_hours, estimated_production_loss_bbl, internal_notes
  ON public.well_event_fulfillment
  FOR EACH ROW
  EXECUTE FUNCTION public.log_well_event_fulfillment_update();

DROP TRIGGER IF EXISTS tool_inventory_status_override_guard
  ON public.tool_inventory;

CREATE TRIGGER tool_inventory_status_override_guard
  BEFORE UPDATE OF status
  ON public.tool_inventory
  FOR EACH ROW
  EXECUTE FUNCTION public.prevent_tool_inventory_service_override();
