import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { Toaster } from '@/components/ui/sonner';
import { AuthProvider, useAuth } from '@/lib/auth';
import LoginPage from '@/pages/LoginPage';
import { lazy, Suspense, Component } from 'react';
import type { ReactNode } from 'react';

const MapPage = lazy(() => import('@/pages/MapPage'));

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 1000 * 60 * 2, // 2 minutes
      retry: 1,
    },
  },
});

/** Global error boundary so rendering crashes are visible instead of blank screen */
class ErrorBoundary extends Component<{ children: ReactNode }, { error: Error | null }> {
  constructor(props: { children: ReactNode }) {
    super(props);
    this.state = { error: null };
  }

  static getDerivedStateFromError(error: Error) {
    return { error };
  }

  componentDidCatch(error: Error, info: React.ErrorInfo) {
    console.error('[WellFi] Render crash:', error, info.componentStack);
  }

  render() {
    if (this.state.error) {
      return (
        <div className="h-screen flex items-center justify-center bg-gray-950 px-4">
          <div className="text-center max-w-md">
            <h1 className="text-red-400 text-lg font-semibold mb-2">Something went wrong</h1>
            <p className="text-gray-400 text-sm mb-4">{this.state.error.message}</p>
            <button
              className="px-4 py-2 rounded bg-wellfi-cyan text-black text-sm font-medium hover:bg-wellfi-cyan/90"
              onClick={() => window.location.reload()}
            >
              Reload
            </button>
          </div>
        </div>
      );
    }
    return this.props.children;
  }
}

/** Loading fallback for lazy-loaded routes */
function LoadingFallback() {
  return (
    <div className="h-screen flex items-center justify-center bg-gray-950">
      <div className="text-gray-400 text-sm">Loading...</div>
    </div>
  );
}

/** Redirect to login if not authenticated */
function ProtectedRoute({ children }: { children: ReactNode }) {
  const { session, isLoading } = useAuth();

  if (isLoading) {
    return (
      <div className="h-screen flex items-center justify-center bg-gray-950">
        <div className="text-gray-400 text-sm">Loading...</div>
      </div>
    );
  }

  if (!session) {
    return <Navigate to="/" replace />;
  }

  return <>{children}</>;
}

/** Redirect to map if already authenticated */
function PublicRoute({ children }: { children: ReactNode }) {
  const { session, isLoading } = useAuth();

  if (isLoading) {
    return (
      <div className="h-screen flex items-center justify-center bg-gray-950">
        <div className="text-gray-400 text-sm">Loading...</div>
      </div>
    );
  }

  if (session) {
    return <Navigate to="/map" replace />;
  }

  return <>{children}</>;
}

function App() {
  return (
    <ErrorBoundary>
      <QueryClientProvider client={queryClient}>
        <AuthProvider>
          <BrowserRouter>
            <Routes>
              <Route path="/" element={<PublicRoute><LoginPage /></PublicRoute>} />
              <Route path="/map" element={<ProtectedRoute><Suspense fallback={<LoadingFallback />}><MapPage /></Suspense></ProtectedRoute>} />
            </Routes>
          </BrowserRouter>
          <Toaster theme="dark" position="top-right" richColors />
        </AuthProvider>
      </QueryClientProvider>
    </ErrorBoundary>
  );
}

export default App;
