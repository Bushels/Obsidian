import { useState, useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '@/lib/auth';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';

const loginSchema = z.object({
  username: z.string().min(1, 'Username is required'),
  password: z.string().min(1, 'Password is required'),
});

type LoginFormData = z.infer<typeof loginSchema>;

// ── Geological contour paths ────────────────────────────────────
const CONTOURS = [
  { d: 'M-100,70 C100,50 300,90 500,65 S800,45 1000,80 L1300,60', o: 0.06, delay: 0 },
  { d: 'M-100,140 C80,120 260,160 440,130 S720,110 980,150 L1300,135', o: 0.05, delay: -2 },
  { d: 'M-100,210 C120,185 320,230 520,200 S780,175 1020,220 L1300,205', o: 0.08, delay: -5 },
  { d: 'M-100,290 C90,265 280,310 480,280 S740,255 960,300 L1300,285', o: 0.07, delay: -1 },
  { d: 'M-100,360 C110,340 300,380 500,355 S760,335 1000,370 L1300,355', o: 0.05, delay: -4 },
  { d: 'M-100,430 C70,410 250,450 450,425 S710,405 940,445 L1300,430', o: 0.06, delay: -3 },
  { d: 'M-100,500 C100,480 290,520 490,495 S750,475 980,515 L1300,500', o: 0.09, delay: -6 },
  { d: 'M-100,570 C80,550 270,590 470,565 S730,545 960,585 L1300,570', o: 0.05, delay: -2 },
  { d: 'M-100,640 C110,620 310,660 510,635 S770,615 1000,655 L1300,640', o: 0.04, delay: -7 },
  { d: 'M-100,710 C90,695 280,725 480,705 S740,690 960,720 L1300,710', o: 0.06, delay: -1 },
  { d: 'M-100,770 C100,755 295,785 495,765 S755,750 985,780 L1300,770', o: 0.03, delay: -4 },
];

// ── Animated counter hook ───────────────────────────────────────
function useCounter(target: number, duration = 2200) {
  const [count, setCount] = useState(0);

  useEffect(() => {
    const start = performance.now();
    let raf: number;
    const tick = (now: number) => {
      const t = Math.min((now - start) / duration, 1);
      setCount(Math.round(target * (1 - Math.pow(1 - t, 3))));
      if (t < 1) raf = requestAnimationFrame(tick);
    };
    raf = requestAnimationFrame(tick);
    return () => cancelAnimationFrame(raf);
  }, [target, duration]);

  return count;
}

// ── Main component ──────────────────────────────────────────────
export default function LoginPage() {
  const navigate = useNavigate();
  const { signIn } = useAuth();
  const [error, setError] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [phase, setPhase] = useState<'idle' | 'auth' | 'granted'>('idle');
  const [ready, setReady] = useState(false);
  const wells = useCounter(211, 2400);

  // 3D Tilt State
  const [tilt, setTilt] = useState({ x: 0, y: 0 });

  const handleMouseMove = (e: React.MouseEvent<HTMLDivElement>) => {
    const rect = e.currentTarget.getBoundingClientRect();
    const x = e.clientX - rect.left - rect.width / 2;
    const y = e.clientY - rect.top - rect.height / 2;
    // Calculate rotation: max 10 degrees to keep it subtle and premium
    setTilt({ x: -(y / rect.height) * 10, y: (x / rect.width) * 10 });
  };

  const handleMouseLeave = () => {
    setTilt({ x: 0, y: 0 });
  };

  useEffect(() => {
    requestAnimationFrame(() => setReady(true));
  }, []);

  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<LoginFormData>({
    resolver: zodResolver(loginSchema),
  });

  const onSubmit = async (data: LoginFormData) => {
    setIsLoading(true);
    setError(null);
    setPhase('auth');

    try {
      const { error: authError } = await signIn(data.username, data.password);
      if (authError) {
        setError(authError);
        setPhase('idle');
        return;
      }
      setPhase('granted');
      setTimeout(() => navigate('/map'), 700);
    } catch {
      setError('Connection failed. Please retry.');
      setPhase('idle');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen relative overflow-hidden" style={{ background: '#020817' }}>
      {/* ── Layer 1: Ambient mesh gradient ── */}
      <div className="login-mesh absolute inset-0" />

      {/* ── Layer 2: Geological contour lines ── */}
      <svg
        className="absolute inset-0 w-full h-full"
        viewBox="0 0 1200 800"
        preserveAspectRatio="none"
      >
        {CONTOURS.map((c, i) => (
          <path
            key={i}
            d={c.d}
            stroke={`rgba(0,212,255,${c.o})`}
            strokeWidth="1"
            fill="none"
            strokeDasharray="8 14"
            className="login-contour"
            style={{ animationDelay: `${c.delay}s` }}
          />
        ))}
      </svg>

      {/* ── Layer 3: Coordinate grid ── */}
      <div className="login-grid absolute inset-0 pointer-events-none" />

      {/* ── Layer 4: Radar scan line ── */}
      <div className="login-scan absolute left-0 right-0 h-px pointer-events-none" />

      {/* ── Content ── */}
      <div className="relative z-10 min-h-screen flex flex-col lg:flex-row items-stretch">

        {/* ════ Left: Branding ════ */}
        <div className="flex-1 flex flex-col items-center justify-center relative px-6 py-16 lg:py-0">
          {/* Sonar rings */}
          <div className="absolute inset-0 flex items-center justify-center pointer-events-none overflow-hidden">
            {[0, 1, 2, 3, 4].map((i) => (
              <div
                key={i}
                className="login-sonar absolute rounded-full"
                style={{
                  width: 280,
                  height: 280,
                  border: '1px solid rgba(0,212,255,0.12)',
                  animationDelay: `${i * 1.8}s`,
                }}
              />
            ))}
            <div
              className="w-2 h-2 rounded-full bg-wellfi-cyan"
              style={{ boxShadow: '0 0 20px rgba(0,212,255,0.5)' }}
            />
          </div>

          <div className="relative z-10 text-center">
            {/* Wordmark */}
            <div
              className={`transition-all duration-1000 ease-out ${
                ready ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-8'
              }`}
            >
              <h1 className="font-syne text-5xl sm:text-6xl lg:text-7xl xl:text-8xl font-extrabold tracking-tight text-white leading-none select-none">
                Well
                <span className="login-glow text-wellfi-cyan">Fi</span>
              </h1>
              <div className="h-px w-24 mx-auto mt-5 bg-gradient-to-r from-transparent via-wellfi-cyan/40 to-transparent" />
            </div>

            {/* Tagline */}
            <p
              className={`mt-5 text-[11px] sm:text-xs tracking-[0.35em] uppercase text-gray-500 font-mono transition-all duration-1000 ease-out ${
                ready ? 'opacity-100 translate-y-0 delay-300' : 'opacity-0 translate-y-6'
              }`}
              style={{ transitionDelay: ready ? '300ms' : '0ms' }}
            >
              Deep Earth Intelligence
            </p>

            {/* Stats */}
            <div
              className={`mt-10 flex items-center justify-center gap-6 sm:gap-8 transition-all duration-1000 ease-out ${
                ready ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-6'
              }`}
              style={{ transitionDelay: ready ? '500ms' : '0ms' }}
            >
              <div className="text-center">
                <div className="text-lg sm:text-xl font-mono font-bold text-white tabular-nums">
                  {wells}
                </div>
                <div className="text-[9px] text-gray-600 uppercase tracking-widest mt-0.5">
                  Active Wells
                </div>
              </div>
              <div className="w-px h-7 bg-gray-800" />
              <div className="text-center">
                <div className="text-lg sm:text-xl font-mono font-bold text-white">2</div>
                <div className="text-[9px] text-gray-600 uppercase tracking-widest mt-0.5">
                  Formations
                </div>
              </div>
              <div className="w-px h-7 bg-gray-800" />
              <div className="text-center">
                <div className="flex items-center justify-center gap-1.5">
                  <div className="w-1.5 h-1.5 rounded-full bg-emerald-500 login-pulse-dot" />
                  <div className="text-lg sm:text-xl font-mono font-bold text-white">LIVE</div>
                </div>
                <div className="text-[9px] text-gray-600 uppercase tracking-widest mt-0.5">
                  Monitoring
                </div>
              </div>
            </div>

            {/* Location */}
            <div
              className={`mt-8 transition-all duration-1000 ease-out ${
                ready ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4'
              }`}
              style={{ transitionDelay: ready ? '700ms' : '0ms' }}
            >
              <span className="inline-flex items-center gap-2 px-3 py-1 rounded-full border border-gray-800/40 bg-gray-900/20 text-[10px] text-gray-600 font-mono tracking-wide">
                56.16°N &nbsp;116.63°W — Peace River, Alberta
              </span>
            </div>
          </div>
        </div>

        {/* ════ Right: Sign-in ════ */}
        <div 
          className="lg:w-[460px] xl:w-[500px] flex items-center justify-center px-6 py-12 lg:py-0 lg:pr-12 xl:pr-20"
          style={{ perspective: '1200px' }}
          onMouseMove={handleMouseMove}
          onMouseLeave={handleMouseLeave}
        >
          <div
            className={`w-full max-w-[380px] transition-all duration-1000 ease-out ${
              ready ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'
            }`}
            style={{ transitionDelay: ready ? '200ms' : '0ms' }}
          >
            {/* 3D Tilt Wrapper */}
            <div 
              style={{ 
                transform: `rotateX(${tilt.x}deg) rotateY(${tilt.y}deg)`,
                transformStyle: 'preserve-3d'
              }}
              className="spring-transition"
            >
              {/* Card */}
              <div className="login-card-glow rounded-2xl">
                <div 
                  className="relative glass-panel rounded-2xl p-7 sm:p-8"
                  style={{ transform: 'translateZ(20px)' }}
                >
                  {/* Header */}
                  <div className="mb-7">
                  <div className="flex items-center gap-2 mb-3">
                    <div className="w-0.5 h-3.5 rounded-full bg-wellfi-cyan" />
                    <span className="text-[9px] tracking-[0.3em] uppercase text-gray-500 font-mono">
                      Secure Access
                    </span>
                  </div>
                  <h2 className="text-lg font-syne font-semibold text-white">
                    Operations Portal
                  </h2>
                  <p className="text-[13px] text-gray-500 mt-1">
                    Authenticate to access real-time monitoring
                  </p>
                </div>

                {/* Form */}
                <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
                  <div className="space-y-1.5">
                    <Label
                      htmlFor="username"
                      className="text-[10px] text-gray-400 uppercase tracking-[0.15em] font-mono"
                    >
                      Operator ID
                    </Label>
                    <Input
                      id="username"
                      type="text"
                      placeholder="username"
                      autoComplete="username"
                      className="h-10 bg-[#0d1320]/80 border-gray-800/60 text-white placeholder:text-gray-700 focus-visible:ring-1 focus-visible:ring-wellfi-cyan/40 focus-visible:border-wellfi-cyan/40 rounded-lg text-sm font-mono transition-all duration-300"
                      {...register('username')}
                    />
                    {errors.username && (
                      <p className="text-[11px] text-red-400/90 font-mono">
                        {errors.username.message}
                      </p>
                    )}
                  </div>

                  <div className="space-y-1.5">
                    <Label
                      htmlFor="password"
                      className="text-[10px] text-gray-400 uppercase tracking-[0.15em] font-mono"
                    >
                      Access Key
                    </Label>
                    <Input
                      id="password"
                      type="password"
                      placeholder="••••••••"
                      autoComplete="current-password"
                      className="h-10 bg-[#0d1320]/80 border-gray-800/60 text-white placeholder:text-gray-700 focus-visible:ring-1 focus-visible:ring-wellfi-cyan/40 focus-visible:border-wellfi-cyan/40 rounded-lg text-sm font-mono transition-all duration-300"
                      {...register('password')}
                    />
                    {errors.password && (
                      <p className="text-[11px] text-red-400/90 font-mono">
                        {errors.password.message}
                      </p>
                    )}
                  </div>

                  {/* Error */}
                  {error && (
                    <div className="flex items-start gap-2 px-3 py-2.5 rounded-lg bg-red-950/20 border border-red-900/20">
                      <div className="w-1 h-1 rounded-full bg-red-500 mt-1.5 shrink-0 animate-pulse" />
                      <p className="text-[11px] text-red-400/80 font-mono leading-relaxed">
                        {error}
                      </p>
                    </div>
                  )}

                  {/* Submit */}
                  <button
                    type="submit"
                    disabled={isLoading || phase === 'granted'}
                    className={`
                      w-full h-10 rounded-lg text-xs font-bold tracking-[0.15em] uppercase font-mono
                      transition-all duration-300 relative overflow-hidden mt-2
                      ${
                        phase === 'granted'
                          ? 'bg-emerald-500/15 text-emerald-400 border border-emerald-500/25'
                          : phase === 'auth'
                            ? 'bg-wellfi-cyan/10 text-wellfi-cyan border border-wellfi-cyan/20'
                            : 'bg-wellfi-cyan text-[#020817] hover:shadow-[0_0_30px_rgba(0,212,255,0.25)] active:scale-[0.98]'
                      }
                      disabled:cursor-wait
                    `}
                  >
                    {phase === 'auth' && (
                      <div className="login-btn-shimmer absolute inset-0" />
                    )}
                    <span className="relative">
                      {phase === 'idle' && 'Initialize Session'}
                      {phase === 'auth' && 'Authenticating\u2026'}
                      {phase === 'granted' && '\u25CF  Access Granted'}
                    </span>
                  </button>
                </form>

                {/* Footer */}
                <div className="mt-7 pt-5 border-t border-gray-800/30 flex items-center justify-between">
                  <span className="text-[9px] text-gray-700 font-mono tracking-wider uppercase">
                    Obsidian Energy
                  </span>
                  <span className="text-[9px] text-gray-800 font-mono">v2.0</span>
                </div>
              </div>
            </div>
          </div>
        </div>
        </div>
      </div>
    </div>
  );
}
