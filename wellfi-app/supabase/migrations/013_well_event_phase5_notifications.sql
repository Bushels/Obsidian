-- Phase 5 webhook wiring for well event and fulfillment notifications.
-- This uses Supabase database webhooks to call the existing edge function.

DROP TRIGGER IF EXISTS notify_well_events_insert
  ON public.well_events;

CREATE TRIGGER notify_well_events_insert
  AFTER INSERT ON public.well_events
  FOR EACH ROW
  EXECUTE FUNCTION supabase_functions.http_request(
    'https://opxptteradsvptjyxxfr.supabase.co/functions/v1/notify-operational-status',
    'POST',
    '{"Content-Type":"application/json","x-wellfi-source":"db-webhook"}',
    '{}',
    '5000'
  );

DROP TRIGGER IF EXISTS notify_well_events_update
  ON public.well_events;

CREATE TRIGGER notify_well_events_update
  AFTER UPDATE OF state, is_active, cleared_at ON public.well_events
  FOR EACH ROW
  WHEN (
    OLD.state IS DISTINCT FROM NEW.state
    OR OLD.is_active IS DISTINCT FROM NEW.is_active
    OR OLD.cleared_at IS DISTINCT FROM NEW.cleared_at
  )
  EXECUTE FUNCTION supabase_functions.http_request(
    'https://opxptteradsvptjyxxfr.supabase.co/functions/v1/notify-operational-status',
    'POST',
    '{"Content-Type":"application/json","x-wellfi-source":"db-webhook"}',
    '{}',
    '5000'
  );

DROP TRIGGER IF EXISTS notify_well_event_fulfillment_update
  ON public.well_event_fulfillment;

CREATE TRIGGER notify_well_event_fulfillment_update
  AFTER UPDATE OF status, assigned_tool_id, planned_service_date ON public.well_event_fulfillment
  FOR EACH ROW
  WHEN (
    OLD.status IS DISTINCT FROM NEW.status
    OR OLD.assigned_tool_id IS DISTINCT FROM NEW.assigned_tool_id
    OR OLD.planned_service_date IS DISTINCT FROM NEW.planned_service_date
  )
  EXECUTE FUNCTION supabase_functions.http_request(
    'https://opxptteradsvptjyxxfr.supabase.co/functions/v1/notify-operational-status',
    'POST',
    '{"Content-Type":"application/json","x-wellfi-source":"db-webhook"}',
    '{}',
    '5000'
  );
