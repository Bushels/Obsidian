-- 006_operational_statuses.sql
-- Session 8: Engineer operational status tracking
-- Allows engineers to flag wells as Watch / Warning / Well Down
-- with optional pump change date range estimates.

CREATE TABLE operational_statuses (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  well_id           UUID NOT NULL REFERENCES wells(id) ON DELETE CASCADE,
  status            TEXT NOT NULL CHECK (status IN ('watch', 'warning', 'well_down')),
  set_by            TEXT NOT NULL,
  set_by_user_id    UUID REFERENCES auth.users(id),
  notes             TEXT,
  pump_change_start DATE,
  pump_change_end   DATE,
  is_active         BOOLEAN DEFAULT TRUE,
  created_at        TIMESTAMPTZ DEFAULT now(),
  updated_at        TIMESTAMPTZ DEFAULT now()
);

-- Only one active status per well at a time
CREATE UNIQUE INDEX idx_op_status_active_well
  ON operational_statuses (well_id) WHERE (is_active = TRUE);

-- Fast lookups for all active statuses
CREATE INDEX idx_op_status_active
  ON operational_statuses (is_active) WHERE (is_active = TRUE);

-- Auto-update updated_at timestamp
CREATE TRIGGER operational_statuses_updated_at
  BEFORE UPDATE ON operational_statuses
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Row Level Security
ALTER TABLE operational_statuses ENABLE ROW LEVEL SECURITY;

CREATE POLICY "authenticated_read_operational_statuses"
  ON operational_statuses FOR SELECT TO authenticated USING (true);

CREATE POLICY "authenticated_write_operational_statuses"
  ON operational_statuses FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- Enable realtime broadcasts
ALTER PUBLICATION supabase_realtime ADD TABLE operational_statuses;
