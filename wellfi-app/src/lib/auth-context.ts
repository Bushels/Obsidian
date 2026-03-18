import { createContext, useContext } from 'react';
import type { Session } from '@supabase/supabase-js';

export type UserRole = 'admin' | 'viewer';

export interface AuthUser {
  id: string;
  username: string;
  displayName: string;
  role: UserRole;
  email: string;
  operatorId: string | null;
  operatorSlug: string | null;
  operatorDisplayName: string | null;
  basinScope: string | null;
}

export interface AuthContextValue {
  session: Session | null;
  user: AuthUser | null;
  isLoading: boolean;
  isAdmin: boolean;
  signIn: (username: string, password: string) => Promise<{ error: string | null }>;
  signOut: () => Promise<void>;
}

export const AuthContext = createContext<AuthContextValue | null>(null);

export function useAuth(): AuthContextValue {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error('useAuth must be used within AuthProvider');
  return ctx;
}
