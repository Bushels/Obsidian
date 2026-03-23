-- 010_monthly_snapshot_currency.sql
-- Tracks latest monthly snapshot currency on each well and records sync runs.

ALTER TABLE public.wells
  ADD COLUMN IF NOT EXISTS latest_production_snapshot_month DATE,
  ADD COLUMN IF NOT EXISTS latest_production_snapshot_status TEXT NOT NULL DEFAULT 'unknown'
    CHECK (latest_production_snapshot_status IN ('present', 'missing', 'unknown'));

CREATE INDEX IF NOT EXISTS idx_wells_latest_production_snapshot_month
  ON public.wells (latest_production_snapshot_month);

CREATE INDEX IF NOT EXISTS idx_wells_latest_production_snapshot_status
  ON public.wells (latest_production_snapshot_status);

CREATE TABLE IF NOT EXISTS public.monthly_production_sync_runs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  snapshot_month DATE NOT NULL,
  input_path TEXT NOT NULL,
  report_path TEXT,
  source_row_count INTEGER NOT NULL DEFAULT 0,
  unique_snapshot_rows INTEGER NOT NULL DEFAULT 0,
  duplicate_rows_collapsed INTEGER NOT NULL DEFAULT 0,
  zero_production_rows INTEGER NOT NULL DEFAULT 0,
  overlay_feature_count INTEGER NOT NULL DEFAULT 0,
  total_manifest_operators INTEGER NOT NULL DEFAULT 0,
  total_provisioned_operators INTEGER NOT NULL DEFAULT 0,
  total_updated_wells INTEGER NOT NULL DEFAULT 0,
  total_zeroed_missing_wells INTEGER NOT NULL DEFAULT 0,
  total_new_snapshot_wells INTEGER NOT NULL DEFAULT 0,
  total_cross_operator_snapshot_wells INTEGER NOT NULL DEFAULT 0,
  total_skipped_unprovisioned_operators INTEGER NOT NULL DEFAULT 0,
  generated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE public.monthly_production_sync_runs ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "admin_read_monthly_production_sync_runs" ON public.monthly_production_sync_runs;
CREATE POLICY "admin_read_monthly_production_sync_runs"
  ON public.monthly_production_sync_runs FOR SELECT TO authenticated
  USING (public.current_app_user_is_admin());

DROP POLICY IF EXISTS "service_role_manage_monthly_production_sync_runs" ON public.monthly_production_sync_runs;
CREATE POLICY "service_role_manage_monthly_production_sync_runs"
  ON public.monthly_production_sync_runs FOR ALL TO service_role
  USING (true)
  WITH CHECK (true);

CREATE INDEX IF NOT EXISTS idx_monthly_production_sync_runs_snapshot_month
  ON public.monthly_production_sync_runs (snapshot_month DESC, generated_at DESC);

CREATE OR REPLACE FUNCTION public.apply_monthly_production_updates(payload jsonb)
RETURNS integer
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  updated_count integer := 0;
BEGIN
  WITH incoming AS (
    SELECT DISTINCT ON (well_id)
      well_id,
      dec_rate_bbl_d,
      cumulative_oil,
      last_production_date,
      latest_production_snapshot_month,
      latest_production_snapshot_status
    FROM (
      SELECT
        NULLIF(BTRIM(item ->> 'well_id'), '') AS well_id,
        NULLIF(BTRIM(item ->> 'dec_rate_bbl_d'), '')::numeric AS dec_rate_bbl_d,
        NULLIF(BTRIM(item ->> 'cumulative_oil'), '')::numeric AS cumulative_oil,
        NULLIF(BTRIM(item ->> 'last_production_date'), '')::date AS last_production_date,
        NULLIF(BTRIM(item ->> 'latest_production_snapshot_month'), '')::date AS latest_production_snapshot_month,
        CASE
          WHEN NULLIF(BTRIM(item ->> 'latest_production_snapshot_status'), '') IN ('present', 'missing', 'unknown')
            THEN NULLIF(BTRIM(item ->> 'latest_production_snapshot_status'), '')
          ELSE NULL
        END AS latest_production_snapshot_status
      FROM jsonb_array_elements(COALESCE(payload, '[]'::jsonb)) AS item
    ) parsed
    WHERE well_id IS NOT NULL
    ORDER BY well_id
  ),
  updated AS (
    UPDATE public.wells AS wells
    SET
      dec_rate_bbl_d = COALESCE(incoming.dec_rate_bbl_d, wells.dec_rate_bbl_d),
      cumulative_oil = COALESCE(incoming.cumulative_oil, wells.cumulative_oil),
      last_production_date = COALESCE(incoming.last_production_date, wells.last_production_date),
      latest_production_snapshot_month = COALESCE(
        incoming.latest_production_snapshot_month,
        wells.latest_production_snapshot_month
      ),
      latest_production_snapshot_status = COALESCE(
        incoming.latest_production_snapshot_status,
        wells.latest_production_snapshot_status
      )
    FROM incoming
    WHERE wells.well_id = incoming.well_id
    RETURNING 1
  )
  SELECT COUNT(*) INTO updated_count
  FROM updated;

  RETURN updated_count;
END;
$$;

REVOKE ALL ON FUNCTION public.apply_monthly_production_updates(jsonb) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.apply_monthly_production_updates(jsonb) FROM anon;
REVOKE ALL ON FUNCTION public.apply_monthly_production_updates(jsonb) FROM authenticated;
GRANT EXECUTE ON FUNCTION public.apply_monthly_production_updates(jsonb) TO service_role;
