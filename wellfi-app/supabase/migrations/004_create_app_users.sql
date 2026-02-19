-- 004_create_app_users.sql
-- Create app_users table to store additional user profile info
-- Matches schema found in remote Supabase

CREATE TABLE IF NOT EXISTS app_users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  username TEXT UNIQUE,
  display_name TEXT,
  role TEXT CHECK (role IN ('admin', 'viewer')),
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Enable RLS
ALTER TABLE app_users ENABLE ROW LEVEL SECURITY;

-- Policies (matching implied logic from earlier 401s, ensuring auth users can read own data)
CREATE POLICY "Users can read own data" ON app_users
  FOR SELECT TO authenticated
  USING (auth.uid() = id);

-- Allow admins to read all? (Assuming logic based on role, but for now simple RLS)
-- If public read needed for username display:
-- CREATE POLICY "Public read usernames" ON app_users FOR SELECT TO authenticated USING (true);
