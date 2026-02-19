import { createContext, useContext, useEffect, useState, useCallback } from 'react';
import type { ReactNode } from 'react';
import type { Session, User } from '@supabase/supabase-js';
import { supabase } from '@/lib/supabase';

export type UserRole = 'admin' | 'viewer';

export interface AuthUser {
  id: string;
  username: string;
  displayName: string;
  role: UserRole;
  email: string;
}

interface AuthContextValue {
  session: Session | null;
  user: AuthUser | null;
  isLoading: boolean;
  isAdmin: boolean;
  signIn: (username: string, password: string) => Promise<{ error: string | null }>;
  signOut: () => Promise<void>;
}

const AuthContext = createContext<AuthContextValue | null>(null);

/** Map username to the email format Supabase Auth expects */
function usernameToEmail(username: string): string {
  return `${username.toLowerCase()}@wellfi.local`;
}

/** Fetch role info from app_users table */
async function fetchAppUser(authUser: User): Promise<AuthUser | null> {
  try {
    const { data, error } = await supabase
      .from('app_users' as never)
      .select('username, display_name, role')
      .eq('id', authUser.id)
      .single();

    if (error || !data) return null;

    const row = data as { username: string; display_name: string; role: UserRole };
    return {
      id: authUser.id,
      username: row.username,
      displayName: row.display_name,
      role: row.role,
      email: authUser.email ?? '',
    };
  } catch (err) {
    console.error('[WellFi] fetchAppUser error:', err);
    return null;
  }
}

export function AuthProvider({ children }: { children: ReactNode }) {
  const [session, setSession] = useState<Session | null>(null);
  const [user, setUser] = useState<AuthUser | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    let mounted = true;

    // Use onAuthStateChange with INITIAL_SESSION event — this is the
    // Supabase-recommended approach. It fires once immediately with the
    // current session (or null), then again on every auth state change.
    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      async (event, currentSession) => {
        if (!mounted) return;

        setSession(currentSession);

        if (currentSession?.user) {
          // Use setTimeout to avoid Supabase client deadlock:
          // onAuthStateChange callbacks that call Supabase methods
          // synchronously can deadlock. Deferring to the next tick fixes this.
          setTimeout(async () => {
            if (!mounted) return;
            const appUser = await fetchAppUser(currentSession.user);
            if (mounted) {
              setUser(appUser);
              setIsLoading(false);
            }
          }, 0);
        } else {
          setUser(null);
          setIsLoading(false);
        }

        // INITIAL_SESSION means we've loaded the stored session (or lack thereof)
        if (event === 'INITIAL_SESSION') {
          // If no session, mark loading done immediately (setTimeout above handles the session case)
          if (!currentSession) {
            setIsLoading(false);
          }
        }
      },
    );

    // Safety timeout: if auth never resolves within 5 seconds, stop loading
    const timeout = setTimeout(() => {
      if (mounted) {
        console.warn('[WellFi] Auth init timed out — proceeding without session');
        setIsLoading(false);
      }
    }, 5000);

    return () => {
      mounted = false;
      clearTimeout(timeout);
      subscription.unsubscribe();
    };
  }, []);

  const signIn = useCallback(async (username: string, password: string) => {
    const email = usernameToEmail(username);
    const { error } = await supabase.auth.signInWithPassword({ email, password });
    if (error) {
      return { error: 'Invalid username or password' };
    }
    return { error: null };
  }, []);

  const signOut = useCallback(async () => {
    await supabase.auth.signOut();
    setSession(null);
    setUser(null);
  }, []);

  const isAdmin = user?.role === 'admin';

  return (
    <AuthContext.Provider value={{ session, user, isLoading, isAdmin, signIn, signOut }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth(): AuthContextValue {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error('useAuth must be used within AuthProvider');
  return ctx;
}
