-- 009_monthly_production_update_only.sql
-- Hardens the monthly production sync so it can only update existing wells.

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
      last_production_date
    FROM (
      SELECT
        NULLIF(BTRIM(item ->> 'well_id'), '') AS well_id,
        NULLIF(BTRIM(item ->> 'dec_rate_bbl_d'), '')::numeric AS dec_rate_bbl_d,
        NULLIF(BTRIM(item ->> 'cumulative_oil'), '')::numeric AS cumulative_oil,
        NULLIF(BTRIM(item ->> 'last_production_date'), '')::date AS last_production_date
      FROM jsonb_array_elements(COALESCE(payload, '[]'::jsonb)) AS item
    ) parsed
    WHERE well_id IS NOT NULL
    ORDER BY well_id
  ),
  updated AS (
    UPDATE public.wells AS wells
    SET
      dec_rate_bbl_d = incoming.dec_rate_bbl_d,
      cumulative_oil = incoming.cumulative_oil,
      last_production_date = incoming.last_production_date
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
