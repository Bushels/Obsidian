import { LayerExtension } from '@deck.gl/core';

/**
 * FormationGlowExtension — deck.gl LayerExtension that produces a
 * bioluminescent deep-ocean effect on formation polygon layers.
 *
 * Features:
 * - 2D simplex noise + FBM for organic, fluid movement
 * - Caustic light refraction patterns (like sunlight through water)
 * - Bioluminescent glow spots that drift and pulse
 * - Formation-specific color palettes (Bluesky deep blue vs Clearwater teal)
 * - Subtle breathing animation and current streaks
 *
 * Uses GLSL shader injection via deck.gl's DECKGL_FILTER_COLOR hook.
 * The u_time uniform is updated each frame via performance.now() / 1000.
 */
export class FormationGlowExtension extends LayerExtension {
  static extensionName = 'FormationGlowExtension';

  getShaders(): Record<string, unknown> {
    return {
      inject: {
        'fs:#decl': FS_DECL,
        'fs:DECKGL_FILTER_COLOR': FS_FILTER_COLOR,
      },
    };
  }

  /* eslint-disable @typescript-eslint/no-explicit-any */
  draw(this: any, params: any, extension: any): void {
    const uniforms = (params.uniforms ?? {}) as Record<string, unknown>;
    uniforms['u_time'] = performance.now() / 1000;
    params.uniforms = uniforms;
    super.draw(params, extension);
  }
  /* eslint-enable @typescript-eslint/no-explicit-any */
}

// ---------------------------------------------------------------------------
// GLSL Fragment Shader Declarations
// All function names prefixed with wf_ to avoid collisions with deck.gl internals
// ---------------------------------------------------------------------------
const FS_DECL = `
uniform float u_time;

// ---- 2D Simplex Noise (Ashima Arts / Ian McEwan, MIT) ----
vec3 wf_mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec2 wf_mod289v2(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 wf_permute(vec3 x) { return wf_mod289(((x * 34.0) + 1.0) * x); }

float wf_snoise(vec2 v) {
  const vec4 C = vec4(0.211324865405187, 0.366025403784439,
                      -0.577350269189626, 0.024390243902439);
  vec2 i  = floor(v + dot(v, C.yy));
  vec2 x0 = v - i + dot(i, C.xx);
  vec2 i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
  vec4 x12 = x0.xyxy + C.xxzz;
  x12.xy -= i1;
  i = wf_mod289v2(i);
  vec3 p = wf_permute(wf_permute(i.y + vec3(0.0, i1.y, 1.0))
           + i.x + vec3(0.0, i1.x, 1.0));
  vec3 m = max(0.5 - vec3(dot(x0, x0), dot(x12.xy, x12.xy),
               dot(x12.zw, x12.zw)), 0.0);
  m = m * m;
  m = m * m;
  vec3 x = 2.0 * fract(p * C.www) - 1.0;
  vec3 h = abs(x) - 0.5;
  vec3 ox = floor(x + 0.5);
  vec3 a0 = x - ox;
  m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);
  vec3 g;
  g.x = a0.x * x0.x + h.x * x0.y;
  g.yz = a0.yz * x12.xz + h.yz * x12.yw;
  return 130.0 * dot(m, g);
}

// Fractal Brownian Motion — 4 octaves with domain rotation
float wf_fbm(vec2 p) {
  float v = 0.0;
  float a = 0.5;
  mat2 rot = mat2(0.8, 0.6, -0.6, 0.8);
  for (int i = 0; i < 4; i++) {
    v += a * wf_snoise(p);
    p = rot * p * 2.0;
    a *= 0.5;
  }
  return v;
}

// Caustic light refraction pattern
float wf_caustic(vec2 p, float t) {
  float c = 0.0;
  c += sin(p.x * 3.7 + t * 0.7) * sin(p.y * 4.1 - t * 0.4);
  c += sin(p.x * 2.3 - t * 0.5 + 1.7) * sin(p.y * 3.4 + t * 0.6 + 0.9);
  c += sin((p.x + p.y) * 2.8 + t * 0.3) * 0.5;
  return c * 0.33;
}
`;

// ---------------------------------------------------------------------------
// GLSL Fragment Color Filter — Bioluminescent Deep-Ocean Effect
// ---------------------------------------------------------------------------
const FS_FILTER_COLOR = `
  // Screen-space noise coordinates (shift with panning = parallax effect)
  vec2 pos = gl_FragCoord.xy * 0.004;
  float t = u_time;

  // Detect formation type from normalized base color
  // Clearwater: [0, 212, 255, 80]/255 → r ≈ 0.0
  // Bluesky:    [30, 100, 220, 60]/255 → r ≈ 0.118
  bool isClearwater = color.r < 0.05;

  // ═══ DEEP OCEAN COLOR PALETTES ═══
  vec3 deepBase = isClearwater
    ? vec3(0.005, 0.03, 0.07)     // Clearwater: abyssal teal-black
    : vec3(0.008, 0.015, 0.09);   // Bluesky: abyssal navy

  vec3 midBase = isClearwater
    ? vec3(0.0, 0.10, 0.16)       // Clearwater: deep teal
    : vec3(0.015, 0.05, 0.20);    // Bluesky: deep blue

  vec3 brightBase = isClearwater
    ? vec3(0.0, 0.42, 0.55)       // Clearwater: bright teal
    : vec3(0.06, 0.20, 0.48);     // Bluesky: bright cobalt

  vec3 glowCol = isClearwater
    ? vec3(0.0, 0.83, 1.0)        // Clearwater: wellfi-cyan
    : vec3(0.10, 0.40, 1.0);      // Bluesky: electric blue

  // ═══ MULTI-LAYER ORGANIC FLOW ═══
  float flow1 = wf_fbm(pos + t * 0.035);
  float flow2 = wf_fbm(pos * 1.3 + vec2(t * 0.025, -t * 0.04) + 5.0);
  float flow3 = wf_fbm(pos * 0.7 - t * 0.015 + 10.0);

  float depthVar = (flow1 + flow2 * 0.7 + flow3 * 0.5) / 2.2;
  float dMix1 = smoothstep(-0.4, 0.5, depthVar);
  float dMix2 = smoothstep(0.1, 0.7, depthVar);

  vec3 ocean = mix(deepBase, midBase, dMix1);
  ocean = mix(ocean, brightBase, dMix2 * 0.45);

  // ═══ CAUSTIC LIGHT RAYS ═══
  float caust1 = wf_caustic(pos * 2.0, t);
  ocean += glowCol * smoothstep(0.15, 0.55, caust1) * 0.10;

  float caust2 = wf_caustic(pos * 4.5 + 3.0, t * 1.3);
  ocean += glowCol * smoothstep(0.2, 0.6, caust2) * 0.05;

  // ═══ BIOLUMINESCENT GLOW SPOTS ═══
  float bio1 = wf_snoise(pos * 5.0 + t * 0.07);
  float bio2 = wf_snoise(pos * 9.0 - t * 0.10 + 20.0);
  float bio3 = wf_snoise(pos * 14.0 + vec2(t * 0.05, t * 0.08) + 40.0);

  float bioGlow = smoothstep(0.50, 0.82, bio1) * 0.35;
  bioGlow += smoothstep(0.55, 0.88, bio2) * 0.20;
  bioGlow += smoothstep(0.62, 0.93, bio3) * 0.10;

  ocean += glowCol * bioGlow;

  // ═══ SLOW BREATHING PULSE ═══
  float breath = 0.5 + 0.5 * sin(t * 0.35 + flow1 * 2.5);
  ocean *= 1.0 + breath * 0.07;

  // ═══ CURRENT STREAKS ═══
  float streak = wf_snoise(vec2(pos.x * 0.8 + t * 0.02, pos.y * 6.0));
  ocean += glowCol * smoothstep(0.6, 0.95, streak) * 0.06;

  // ═══ FINAL COMPOSITION ═══
  color.rgb = ocean;

  // Alpha: moderate opacity with organic variation
  float alphaBase = isClearwater ? 0.50 : 0.42;
  float alphaPulse = sin(t * 0.45 + flow2 * 1.8) * 0.06;
  float alphaVar = wf_fbm(pos * 2.0 + t * 0.015) * 0.08;
  color.a = clamp(alphaBase + alphaPulse + alphaVar, 0.25, 0.65);
`;
