import { memo, useEffect, useMemo, useState } from 'react';
import { Maximize2, RotateCcw, ZoomIn, ZoomOut } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
import { FORMATION_POLYGONS } from '@/lib/formationData';
import { SCHEMATIC_DEPTHS, type SchematicDepthEntry } from '@/lib/schematicDepths';
import type { Well } from '@/types';

interface DownholeModel3DProps {
  well: Well;
}

interface DownholePlacement {
  totalDepthM: number;
  pumpDepthM: number;
  pumpLengthM: number;
  slottedTagBarDepthM: number;
  slottedTagBarLengthM: number;
  wellFiDepthM: number;
  wellFiLengthM: number;
  noTurnDepthM: number;
  noTurnLengthM: number;
  hasManualDepths: boolean;
  hasSchematicDepths: boolean;
  depthSource: 'manual' | 'schematic' | 'estimated';
  sourceFile: string | null;
}

interface FormationProfile {
  name: string;
  depthM: number;
  thicknessM: number;
}

interface ToolSegment {
  id: 'pump' | 'slotted_tag_bar' | 'wellfi_tool' | 'no_turn_tool';
  label: string;
  depthM: number;
  lengthM: number;
  barClassName: string;
  dotClassName: string;
  labelClassName: string;
  status?: string;
}

interface RenderedTool extends ToolSegment {
  topPct: number;
  heightPct: number;
  centerPct: number;
}

interface FocusRange {
  topM: number;
  bottomM: number;
  spanM: number;
  hasCompressedTop: boolean;
  hasCompressedBottom: boolean;
}

interface SceneViewState {
  rotateX: number;
  rotateY: number;
  zoom: number;
}

type SceneMode = 'cutaway' | 'focused';

const FALLBACK_FORMATION_DEPTH_M = 640;
const FALLBACK_FORMATION_THICKNESS_M = 22;
const DEFAULT_VIEW: SceneViewState = { rotateX: 18, rotateY: -6, zoom: 1 };
const MIN_ZOOM = 0.88;
const MAX_ZOOM = 1.3;
const ZOOM_STEP = 0.08;
const FOCUS_TICK_COUNT = 5;
const SCENE_STYLE_TAG_ID = 'wellfi-downhole-scene-css';

function clamp(value: number, min: number, max: number): number {
  return Math.min(max, Math.max(min, value));
}

function firstDefined(values: Array<number | null>): number | null {
  for (const value of values) {
    if (value != null) return value;
  }
  return null;
}

function normalizeIdForMatch(value: string | null | undefined): string | null {
  if (!value) return null;
  const normalized = value.toUpperCase().replace(/[^A-Z0-9]/g, '');
  return normalized.length > 0 ? normalized : null;
}

function toWellStem(value: string): string {
  return value.replace(/(W[0-9])(?:[0-9]{2,3})$/, '$1');
}

function findSchematicEntry(well: Well): SchematicDepthEntry | null {
  const rawValues = [well.well_id, well.formatted_id ?? null];
  const normalizedCandidates = rawValues
    .map((v) => normalizeIdForMatch(v))
    .filter((v): v is string => !!v);
  if (normalizedCandidates.length === 0) return null;

  const candidateStems = new Set(normalizedCandidates.map(toWellStem));

  let fallbackMatch: SchematicDepthEntry | null = null;
  for (const entry of SCHEMATIC_DEPTHS) {
    const tokenSet = new Set(entry.match_tokens.map((t) => normalizeIdForMatch(t)).filter((t): t is string => !!t));
    if (tokenSet.size === 0) continue;
    const tokenStems = new Set(Array.from(tokenSet).map(toWellStem));

    // Exact match wins immediately.
    for (const candidate of normalizedCandidates) {
      if (tokenSet.has(candidate)) return entry;
    }

    // Stem match (event suffix differences) is used as fallback.
    for (const stem of candidateStems) {
      if (tokenStems.has(stem)) {
        fallbackMatch = entry;
      }
    }
  }

  return fallbackMatch;
}

function getFormationProfile(formation: Well['formation']): FormationProfile {
  if (!formation) {
    return {
      name: 'Estimated Formation',
      depthM: FALLBACK_FORMATION_DEPTH_M,
      thicknessM: FALLBACK_FORMATION_THICKNESS_M,
    };
  }
  const match = FORMATION_POLYGONS.find((f) => f.name === formation);
  if (!match) {
    return {
      name: 'Estimated Formation',
      depthM: FALLBACK_FORMATION_DEPTH_M,
      thicknessM: FALLBACK_FORMATION_THICKNESS_M,
    };
  }
  return {
    name: match.name,
    depthM: match.depth_m,
    thicknessM: match.thickness_m,
  };
}

function parseDepthTag(notes: string | null | undefined, key: string): number | null {
  if (!notes) return null;
  const safeKey = key.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  const regex = new RegExp(`(?:^|\\r?\\n)\\s*${safeKey}\\s*[:=]\\s*(-?\\d+(?:\\.\\d+)?)`, 'i');
  const match = notes.match(regex);
  if (!match) return null;
  const parsed = Number(match[1]);
  if (!Number.isFinite(parsed) || parsed <= 0) return null;
  return parsed;
}

function resolveDownholePlacement(well: Well): DownholePlacement {
  const schematic = findSchematicEntry(well);
  const formationDepthM = Math.round(getFormationProfile(well.formation).depthM);
  const defaultPumpDepthM = Math.max(120, formationDepthM - 12);
  const defaultSlottedTagBarDepthM = defaultPumpDepthM + 1.3;
  const defaultWellFiDepthM = defaultSlottedTagBarDepthM + 0.65;
  const defaultNoTurnDepthM = defaultWellFiDepthM + 0.65;
  const defaultTotalDepthM = Math.max(formationDepthM + 120, defaultNoTurnDepthM + 24);
  const defaultPumpLengthM = 8.0;
  const defaultSlottedTagBarLengthM = 0.9;
  const defaultWellFiLengthM = 0.75;
  const defaultNoTurnLengthM = 0.6;

  const notes = well.wellfi_device?.notes;

  const schematicTotalDepthM = schematic?.total_depth_m ?? null;
  const schematicPumpDepthM = schematic?.pump
    ? (schematic.pump.top_m + schematic.pump.bottom_m) / 2
    : null;
  const schematicSlottedTagBarDepthM = schematic?.slotted_tag_bar
    ? (schematic.slotted_tag_bar.top_m + schematic.slotted_tag_bar.bottom_m) / 2
    : null;
  const schematicWellFiDepthM = schematic?.wellfi_tool
    ? (schematic.wellfi_tool.top_m + schematic.wellfi_tool.bottom_m) / 2
    : null;
  const schematicNoTurnDepthM = schematic?.no_turn_tool
    ? (schematic.no_turn_tool.top_m + schematic.no_turn_tool.bottom_m) / 2
    : null;

  const pumpLengthM = schematic?.pump?.length_m ?? defaultPumpLengthM;
  const slottedTagBarLengthM = schematic?.slotted_tag_bar?.length_m ?? defaultSlottedTagBarLengthM;
  const wellFiLengthM = schematic?.wellfi_tool?.length_m ?? defaultWellFiLengthM;
  const noTurnLengthM = schematic?.no_turn_tool?.length_m ?? defaultNoTurnLengthM;

  const manualTotalDepthM = firstDefined([
    parseDepthTag(notes, 'total_depth_m'),
    parseDepthTag(notes, 'td_m'),
  ]);
  const manualPumpDepthM = firstDefined([
    parseDepthTag(notes, 'pump_depth_m'),
    parseDepthTag(notes, 'pump_md_m'),
  ]);
  const manualSlottedTagBarDepthM = firstDefined([
    parseDepthTag(notes, 'slotted_tag_bar_depth_m'),
    parseDepthTag(notes, 'slotted_tag_bar_md_m'),
  ]);
  const manualWellFiDepthM = firstDefined([
    parseDepthTag(notes, 'wellfi_depth_m'),
    parseDepthTag(notes, 'wellfi_md_m'),
  ]);
  const manualNoTurnDepthM = firstDefined([
    parseDepthTag(notes, 'no_turn_depth_m'),
    parseDepthTag(notes, 'no_turn_md_m'),
  ]);

  let totalDepthM = manualTotalDepthM ?? schematicTotalDepthM ?? defaultTotalDepthM;
  let pumpDepthM = manualPumpDepthM ?? schematicPumpDepthM ?? defaultPumpDepthM;
  let slottedTagBarDepthM =
    manualSlottedTagBarDepthM ?? schematicSlottedTagBarDepthM ?? defaultSlottedTagBarDepthM;
  let wellFiDepthM = manualWellFiDepthM ?? schematicWellFiDepthM ?? defaultWellFiDepthM;
  let noTurnDepthM = manualNoTurnDepthM ?? schematicNoTurnDepthM ?? defaultNoTurnDepthM;

  if (manualWellFiDepthM == null && schematicWellFiDepthM == null) {
    const gap = noTurnDepthM - slottedTagBarDepthM;
    if (gap > 0.35) {
      wellFiDepthM = slottedTagBarDepthM + gap * 0.55;
    }
  }

  const minSpacing = 0.24;
  pumpDepthM = clamp(pumpDepthM, 60, totalDepthM - 12);
  slottedTagBarDepthM = Math.max(slottedTagBarDepthM, pumpDepthM + minSpacing);
  wellFiDepthM = Math.max(wellFiDepthM, slottedTagBarDepthM + minSpacing);
  noTurnDepthM = Math.max(noTurnDepthM, wellFiDepthM + minSpacing);
  totalDepthM = Math.max(totalDepthM, noTurnDepthM + 18);

  const hasManualDepths =
    manualTotalDepthM != null ||
    manualPumpDepthM != null ||
    manualSlottedTagBarDepthM != null ||
    manualWellFiDepthM != null ||
    manualNoTurnDepthM != null;

  const hasSchematicDepths =
    schematic != null &&
    (schematicTotalDepthM != null ||
      schematicPumpDepthM != null ||
      schematicSlottedTagBarDepthM != null ||
      schematicWellFiDepthM != null ||
      schematicNoTurnDepthM != null);

  const depthSource: DownholePlacement['depthSource'] =
    hasManualDepths ? 'manual' : hasSchematicDepths ? 'schematic' : 'estimated';

  return {
    totalDepthM,
    pumpDepthM,
    pumpLengthM,
    slottedTagBarDepthM,
    slottedTagBarLengthM,
    wellFiDepthM,
    wellFiLengthM,
    noTurnDepthM,
    noTurnLengthM,
    hasManualDepths,
    hasSchematicDepths,
    depthSource,
    sourceFile: schematic?.source_file ?? null,
  };
}

function formatDepth(depthM: number): string {
  return `${depthM.toFixed(1)} m`;
}

function toolTopDepth(tool: Pick<ToolSegment, 'depthM' | 'lengthM'>): number {
  return Math.max(0, tool.depthM - tool.lengthM / 2);
}

function toolBottomDepth(tool: Pick<ToolSegment, 'depthM' | 'lengthM'>): number {
  return tool.depthM + tool.lengthM / 2;
}

function formatDepthRange(tool: Pick<ToolSegment, 'depthM' | 'lengthM'>): string {
  return `${toolTopDepth(tool).toFixed(1)}-${toolBottomDepth(tool).toFixed(1)} m`;
}

function toolAccentColor(toolId: ToolSegment['id']): string {
  switch (toolId) {
    case 'pump':
      return '#facc15';
    case 'slotted_tag_bar':
      return '#7dd3fc';
    case 'wellfi_tool':
      return '#22d3ee';
    case 'no_turn_tool':
      return '#a5b4fc';
    default:
      return '#cbd5e1';
  }
}

function shortToolLabel(toolId: ToolSegment['id']): string {
  switch (toolId) {
    case 'slotted_tag_bar':
      return 'STB';
    case 'wellfi_tool':
      return 'WellFi';
    case 'no_turn_tool':
      return 'No-Turn';
    default:
      return 'Pump';
  }
}

function injectSceneStyleTag(): void {
  if (typeof document === 'undefined') return;
  if (document.getElementById(SCENE_STYLE_TAG_ID)) return;
  const style = document.createElement('style');
  style.id = SCENE_STYLE_TAG_ID;
  style.textContent = `
    @keyframes wellfi-downhole-sweep {
      0% { transform: translateX(-42%) skewX(-18deg); opacity: 0; }
      20% { opacity: 0.18; }
      60% { opacity: 0.24; }
      100% { transform: translateX(260%) skewX(-18deg); opacity: 0; }
    }
    @keyframes wellfi-tool-pulse {
      0% { box-shadow: 0 0 0 0 rgba(34,211,238,0.55); }
      70% { box-shadow: 0 0 0 12px rgba(34,211,238,0); }
      100% { box-shadow: 0 0 0 0 rgba(34,211,238,0); }
    }
    @keyframes wellfi-bore-drift {
      0% { transform: translateY(0px); }
      50% { transform: translateY(-1px); }
      100% { transform: translateY(0px); }
    }
  `;
  document.head.appendChild(style);
}

function buildFocusRange(tools: ToolSegment[], totalDepthM: number): FocusRange {
  const stackTop = Math.min(...tools.map((tool) => tool.depthM - tool.lengthM / 2));
  const stackBottom = Math.max(...tools.map((tool) => tool.depthM + tool.lengthM / 2));
  const stackSpan = Math.max(stackBottom - stackTop, 8);
  const padding = clamp(stackSpan * 1.35, 12, 45);
  const topM = clamp(stackTop - padding, 0, Math.max(totalDepthM - 20, 0));
  const bottomM = clamp(stackBottom + padding, topM + 20, totalDepthM);
  return {
    topM,
    bottomM,
    spanM: Math.max(bottomM - topM, 20),
    hasCompressedTop: topM > 0.5,
    hasCompressedBottom: bottomM < totalDepthM - 0.5,
  };
}

function toFocusPct(depthM: number, focus: FocusRange): number {
  return clamp(((depthM - focus.topM) / focus.spanM) * 100, 0, 100);
}

function toRenderedTools(tools: ToolSegment[], focus: FocusRange): RenderedTool[] {
  return tools.map((tool) => {
    const centerPct = toFocusPct(tool.depthM, focus);
    const rawHeightPct = (tool.lengthM / focus.spanM) * 100;
    const heightPct = clamp(Math.max(rawHeightPct, 8), 8, 24);
    const topPct = clamp(centerPct - heightPct / 2, 1, 99 - heightPct);
    return {
      ...tool,
      topPct,
      heightPct,
      centerPct,
    };
  });
}

function buildToolStack(placement: DownholePlacement, hasInstalledWellFi: boolean): ToolSegment[] {
  return [
    {
      id: 'pump',
      label: 'Pump',
      depthM: placement.pumpDepthM,
      lengthM: placement.pumpLengthM,
      barClassName: 'bg-gradient-to-b from-amber-300 to-amber-500 border-amber-100/80',
      dotClassName: 'bg-amber-400',
      labelClassName: 'text-amber-100',
    },
    {
      id: 'slotted_tag_bar',
      label: 'Slotted Tag Bar',
      depthM: placement.slottedTagBarDepthM,
      lengthM: placement.slottedTagBarLengthM,
      barClassName: 'bg-gradient-to-b from-sky-200 to-sky-400 border-sky-100/80',
      dotClassName: 'bg-sky-300',
      labelClassName: 'text-sky-100',
    },
    {
      id: 'wellfi_tool',
      label: 'WellFi Tool',
      depthM: placement.wellFiDepthM,
      lengthM: placement.wellFiLengthM,
      barClassName: hasInstalledWellFi
        ? 'bg-gradient-to-b from-cyan-300 to-cyan-500 border-cyan-100/90'
        : 'bg-gradient-to-b from-slate-300 to-slate-500 border-slate-200/70',
      dotClassName: hasInstalledWellFi ? 'bg-cyan-300' : 'bg-slate-400',
      labelClassName: hasInstalledWellFi ? 'text-cyan-100' : 'text-slate-100',
      status: hasInstalledWellFi ? 'Installed' : 'Planned',
    },
    {
      id: 'no_turn_tool',
      label: 'No-Turn Tool',
      depthM: placement.noTurnDepthM,
      lengthM: placement.noTurnLengthM,
      barClassName: 'bg-gradient-to-b from-indigo-300 to-indigo-500 border-indigo-100/80',
      dotClassName: 'bg-indigo-300',
      labelClassName: 'text-indigo-100',
    },
  ];
}

function DownholeModel3DComponent({ well }: DownholeModel3DProps) {
  const [expandedOpen, setExpandedOpen] = useState(false);
  const [view, setView] = useState<SceneViewState>(DEFAULT_VIEW);
  const [sceneMode, setSceneMode] = useState<SceneMode>('cutaway');

  useEffect(() => {
    injectSceneStyleTag();
  }, []);

  const placement = useMemo(() => resolveDownholePlacement(well), [well]);
  const formation = useMemo(() => getFormationProfile(well.formation), [well.formation]);
  const hasInstalledWellFi = !!well.wellfi_device;

  const tools = useMemo(
    () => buildToolStack(placement, hasInstalledWellFi),
    [placement, hasInstalledWellFi],
  );
  const focus = useMemo(
    () => buildFocusRange(tools, placement.totalDepthM),
    [tools, placement.totalDepthM],
  );
  const renderedTools = useMemo(
    () => toRenderedTools(tools, focus),
    [tools, focus],
  );
  const focusTicks = useMemo(
    () =>
      Array.from({ length: FOCUS_TICK_COUNT }, (_, idx) => (
        focus.topM + (focus.spanM * idx) / (FOCUS_TICK_COUNT - 1)
      )),
    [focus],
  );

  const formationTopM = formation.depthM - formation.thicknessM / 2;
  const formationBottomM = formation.depthM + formation.thicknessM / 2;
  const visibleFormationTopM = Math.max(formationTopM, focus.topM);
  const visibleFormationBottomM = Math.min(formationBottomM, focus.bottomM);
  const formationVisible = visibleFormationBottomM > visibleFormationTopM;
  const formationTopPct = toFocusPct(visibleFormationTopM, focus);
  const formationHeightPct = clamp(((visibleFormationBottomM - visibleFormationTopM) / focus.spanM) * 100, 2, 18);
  const cutawayTrackTop = 110;
  const cutawayTrackBottom = 620;
  const cutawayTrackSpan = cutawayTrackBottom - cutawayTrackTop;
  const patternIdBase = useMemo(
    () => `downhole-${well.id.replace(/[^a-zA-Z0-9]/g, '').slice(0, 14) || 'well'}`,
    [well.id],
  );

  function nudgeZoom(amount: number): void {
    setView((prev) => ({
      ...prev,
      zoom: clamp(prev.zoom + amount, MIN_ZOOM, MAX_ZOOM),
    }));
  }

  function resetView(): void {
    setView((prev) => ({
      ...prev,
      rotateX: DEFAULT_VIEW.rotateX,
      rotateY: DEFAULT_VIEW.rotateY,
      zoom: DEFAULT_VIEW.zoom,
    }));
  }

  function handlePointerMove(event: React.PointerEvent<HTMLDivElement>): void {
    const rect = event.currentTarget.getBoundingClientRect();
    if (rect.width <= 0 || rect.height <= 0) return;
    const x = (event.clientX - rect.left) / rect.width;
    const y = (event.clientY - rect.top) / rect.height;
    const rotateX = clamp(24 - y * 16, 9, 25);
    const rotateY = clamp((x - 0.5) * 20, -12, 12);

    setView((prev) => {
      if (Math.abs(prev.rotateX - rotateX) < 0.2 && Math.abs(prev.rotateY - rotateY) < 0.2) {
        return prev;
      }
      return { ...prev, rotateX, rotateY };
    });
  }

  function handlePointerLeave(): void {
    setView((prev) => ({
      ...prev,
      rotateX: DEFAULT_VIEW.rotateX,
      rotateY: DEFAULT_VIEW.rotateY,
    }));
  }

  const sceneTransform = `translateX(-50%) perspective(1100px) rotateX(${view.rotateX}deg) rotateY(${view.rotateY}deg) scale(${view.zoom})`;

  function renderCutawayScene(heightClassName: string) {
    const casingPatternId = `${patternIdBase}-casing-lines`;
    const pumpRibPatternId = `${patternIdBase}-pump-ribs`;
    const slotPatternId = `${patternIdBase}-slots`;
    const rawCenterYs = renderedTools.map(
      (tool) => cutawayTrackTop + (tool.centerPct / 100) * cutawayTrackSpan,
    );
    const spreadCenterYs = [...rawCenterYs];
    const minGap = 48;
    for (let i = 1; i < spreadCenterYs.length; i++) {
      spreadCenterYs[i] = Math.max(spreadCenterYs[i], spreadCenterYs[i - 1] + minGap);
    }
    const overflow = spreadCenterYs[spreadCenterYs.length - 1] - (cutawayTrackBottom - 16);
    if (overflow > 0) {
      for (let i = 0; i < spreadCenterYs.length; i++) spreadCenterYs[i] -= overflow;
    }
    const cutawayBodies = renderedTools.map((tool, idx) => {
      const centerY = spreadCenterYs[idx];
      if (tool.id === 'pump') {
        const height = clamp(tool.lengthM * 9.2, 46, 132);
        const width = clamp(height * 0.72, 78, 112);
        return { tool, centerY, height, width };
      }
      if (tool.id === 'slotted_tag_bar') {
        const height = clamp(tool.lengthM * 16.5, 30, 74);
        const width = clamp(height * 1.45, 64, 88);
        return { tool, centerY, height, width };
      }
      if (tool.id === 'wellfi_tool') {
        const height = clamp(tool.lengthM * 17.0, 32, 78);
        const width = clamp(height * 1.38, 70, 92);
        return { tool, centerY, height, width };
      }
      const height = clamp(tool.lengthM * 16.5, 30, 72);
      const width = clamp(height * 1.36, 64, 86);
      return { tool, centerY, height, width };
    });

    return (
      <div
        className={`relative ${heightClassName} rounded-xl border border-slate-700/70 overflow-hidden bg-[radial-gradient(circle_at_20%_0%,rgba(34,211,238,0.18),transparent_40%),linear-gradient(180deg,#0a1224_0%,#020617_100%)]`}
        onPointerMove={handlePointerMove}
        onPointerLeave={handlePointerLeave}
      >
        <svg
          viewBox="0 0 1000 700"
          className="absolute inset-0 h-full w-full"
          preserveAspectRatio="none"
        >
          <defs>
            <linearGradient id={`${patternIdBase}-casing-grad`} x1="0%" y1="0%" x2="100%" y2="0%">
              <stop offset="0%" stopColor="#0f172a" />
              <stop offset="22%" stopColor="#334155" />
              <stop offset="50%" stopColor="#64748b" />
              <stop offset="78%" stopColor="#334155" />
              <stop offset="100%" stopColor="#0f172a" />
            </linearGradient>
            <linearGradient id={`${patternIdBase}-inner-grad`} x1="0%" y1="0%" x2="100%" y2="0%">
              <stop offset="0%" stopColor="#020617" />
              <stop offset="50%" stopColor="#0f172a" />
              <stop offset="100%" stopColor="#020617" />
            </linearGradient>
            <linearGradient id={`${patternIdBase}-tubing-grad`} x1="0%" y1="0%" x2="100%" y2="0%">
              <stop offset="0%" stopColor="#0f172a" />
              <stop offset="50%" stopColor="#1e293b" />
              <stop offset="100%" stopColor="#0f172a" />
            </linearGradient>
            <linearGradient id={`${patternIdBase}-pump-grad`} x1="0%" y1="0%" x2="0%" y2="100%">
              <stop offset="0%" stopColor="#fde047" />
              <stop offset="60%" stopColor="#eab308" />
              <stop offset="100%" stopColor="#a16207" />
            </linearGradient>
            <linearGradient id={`${patternIdBase}-wellfi-grad`} x1="0%" y1="0%" x2="0%" y2="100%">
              <stop offset="0%" stopColor="#67e8f9" />
              <stop offset="52%" stopColor="#06b6d4" />
              <stop offset="100%" stopColor="#155e75" />
            </linearGradient>
            <linearGradient id={`${patternIdBase}-noturn-grad`} x1="0%" y1="0%" x2="0%" y2="100%">
              <stop offset="0%" stopColor="#c4b5fd" />
              <stop offset="58%" stopColor="#818cf8" />
              <stop offset="100%" stopColor="#4338ca" />
            </linearGradient>
            <pattern id={casingPatternId} width="16" height="16" patternUnits="userSpaceOnUse">
              <path d="M0 8 H16" stroke="#cbd5e1" strokeOpacity="0.12" strokeWidth="1" />
            </pattern>
            <pattern id={pumpRibPatternId} width="8" height="8" patternUnits="userSpaceOnUse">
              <path d="M0 0 L8 8 M-4 4 L4 12 M4 -4 L12 4" stroke="#fef9c3" strokeOpacity="0.22" strokeWidth="1" />
            </pattern>
            <pattern id={slotPatternId} width="10" height="10" patternUnits="userSpaceOnUse">
              <rect x="3.2" y="1.3" width="3.6" height="7.4" rx="1.2" fill="#020617" fillOpacity="0.72" />
            </pattern>
          </defs>

          <rect x="388" y="42" width="224" height="620" rx="112" fill={`url(#${patternIdBase}-casing-grad)`} stroke="#94a3b8" strokeOpacity="0.55" />
          <rect x="406" y="58" width="188" height="588" rx="94" fill={`url(#${patternIdBase}-inner-grad)`} />
          <rect x="422" y="72" width="156" height="560" rx="78" fill={`url(#${casingPatternId})`} />
          <rect x="468" y="76" width="64" height="552" rx="32" fill={`url(#${patternIdBase}-tubing-grad)`} stroke="#64748b" strokeOpacity="0.5" />
          <line x1="500" x2="500" y1="76" y2="628" stroke="#94a3b8" strokeOpacity="0.22" strokeWidth="1" />

          {formationVisible && (
            <rect
              x="430"
              y={cutawayTrackTop + (formationTopPct / 100) * cutawayTrackSpan}
              width="140"
              height={(formationHeightPct / 100) * cutawayTrackSpan}
              rx="16"
              fill="#38bdf8"
              fillOpacity="0.22"
              stroke="#7dd3fc"
              strokeOpacity="0.48"
            />
          )}

          {cutawayBodies.slice(1).map((body, idx) => {
            const previous = cutawayBodies[idx];
            const previousBottomY = previous.centerY + previous.height / 2;
            const currentTopY = body.centerY - body.height / 2;
            if (currentTopY <= previousBottomY + 1) return null;
            return (
              <g key={`connector-${previous.tool.id}-${body.tool.id}`}>
                <rect
                  x="494.5"
                  y={previousBottomY}
                  width="11"
                  height={currentTopY - previousBottomY}
                  rx="5.5"
                  fill="#334155"
                  fillOpacity="0.95"
                  stroke="#64748b"
                  strokeOpacity="0.65"
                />
                <rect x="489" y={previousBottomY - 4} width="22" height="8" rx="4" fill="#475569" />
                <rect x="489" y={currentTopY - 4} width="22" height="8" rx="4" fill="#475569" />
              </g>
            );
          })}

          {cutawayBodies.map(({ tool, centerY, height, width }) => {
            const halfH = height / 2;
            const halfW = width / 2;

            if (tool.id === 'pump') {
              return (
                <g key={tool.id} transform={`translate(500 ${centerY})`}>
                  <rect
                    x={-halfW}
                    y={-halfH}
                    width={width}
                    height={height}
                    rx={Math.max(16, width * 0.2)}
                    fill={`url(#${patternIdBase}-pump-grad)`}
                    stroke="#fef08a"
                    strokeOpacity="0.78"
                  />
                  <rect
                    x={-halfW + 8}
                    y={-halfH + 12}
                    width={width - 16}
                    height={Math.max(height - 24, 18)}
                    rx="10"
                    fill={`url(#${pumpRibPatternId})`}
                  />
                  <rect x={-halfW - 2} y={-halfH + 7} width={width + 4} height="8" rx="4" fill="#fef9c3" fillOpacity="0.38" />
                  <rect x={-halfW - 2} y={halfH - 15} width={width + 4} height="8" rx="4" fill="#fef9c3" fillOpacity="0.3" />
                  <circle cx={-width * 0.24} cy="0" r="3" fill="#fef3c7" fillOpacity="0.62" />
                  <circle cx={width * 0.24} cy="0" r="3" fill="#fef3c7" fillOpacity="0.62" />
                </g>
              );
            }

            if (tool.id === 'slotted_tag_bar') {
              return (
                <g key={tool.id} transform={`translate(500 ${centerY})`}>
                  <rect
                    x={-halfW}
                    y={-halfH}
                    width={width}
                    height={height}
                    rx={Math.max(9, width * 0.16)}
                    fill="#bae6fd"
                    fillOpacity="0.92"
                    stroke="#e0f2fe"
                    strokeOpacity="0.84"
                  />
                  <rect
                    x={-halfW + 6}
                    y={-halfH + 6}
                    width={width - 12}
                    height={Math.max(height - 12, 10)}
                    rx="8"
                    fill={`url(#${slotPatternId})`}
                  />
                  <ellipse cx="0" cy={-halfH + 4} rx={Math.max(halfW - 5, 12)} ry="3.4" fill="#e0f2fe" fillOpacity="0.34" />
                  <ellipse cx="0" cy={halfH - 4} rx={Math.max(halfW - 5, 12)} ry="3.4" fill="#bae6fd" fillOpacity="0.28" />
                </g>
              );
            }

            if (tool.id === 'wellfi_tool') {
              return (
                <g key={tool.id} transform={`translate(500 ${centerY})`}>
                  <rect
                    x={-halfW}
                    y={-halfH}
                    width={width}
                    height={height}
                    rx={Math.max(12, width * 0.18)}
                    fill={`url(#${patternIdBase}-wellfi-grad)`}
                    stroke="#a5f3fc"
                    strokeOpacity="0.9"
                  />
                  <rect x={-halfW - 3} y={-halfH + 8} width={width + 6} height="8" rx="4" fill="#0e7490" fillOpacity="0.8" />
                  <rect x={-halfW - 3} y={halfH - 16} width={width + 6} height="8" rx="4" fill="#0e7490" fillOpacity="0.8" />
                  <rect
                    x={-Math.max(width * 0.22, 16)}
                    y={-Math.max(height * 0.14, 6)}
                    width={Math.max(width * 0.44, 32)}
                    height={Math.max(height * 0.28, 12)}
                    rx="6"
                    fill="#cffafe"
                    fillOpacity="0.82"
                    stroke="#67e8f9"
                    strokeOpacity="0.72"
                  />
                  <text x="0" y="3" textAnchor="middle" fontSize="8" fontWeight="700" fill="#164e63">WF</text>
                </g>
              );
            }

            return (
              <g key={tool.id} transform={`translate(500 ${centerY})`}>
                <rect
                  x={-halfW}
                  y={-halfH}
                  width={width}
                  height={height}
                  rx={Math.max(10, width * 0.16)}
                  fill={`url(#${patternIdBase}-noturn-grad)`}
                  stroke="#ddd6fe"
                  strokeOpacity="0.85"
                />
                <polygon points={`${-halfW},-11 ${-halfW - 16},-6 ${-halfW},0`} fill="#a5b4fc" fillOpacity="0.8" transform={`translate(0 ${-halfH * 0.22})`} />
                <polygon points={`${-halfW},11 ${-halfW - 16},6 ${-halfW},0`} fill="#a5b4fc" fillOpacity="0.8" transform={`translate(0 ${halfH * 0.22})`} />
                <polygon points={`${halfW},-11 ${halfW + 16},-6 ${halfW},0`} fill="#a5b4fc" fillOpacity="0.8" transform={`translate(0 ${-halfH * 0.22})`} />
                <polygon points={`${halfW},11 ${halfW + 16},6 ${halfW},0`} fill="#a5b4fc" fillOpacity="0.8" transform={`translate(0 ${halfH * 0.22})`} />
                <rect x={-Math.max(width * 0.36, 18)} y="-4" width={Math.max(width * 0.72, 36)} height="8" rx="4" fill="#c7d2fe" fillOpacity="0.52" />
              </g>
            );
          })}

          {cutawayBodies.map(({ tool, centerY, width }) => {
            const calloutX = 768;
            const calloutY = clamp(centerY - 25, 72, 614);
            const leadStartX = 500 + width / 2 + 8;
            const accent = toolAccentColor(tool.id);
            return (
              <g key={`callout-${tool.id}`}>
                <path d={`M${leadStartX} ${centerY} H${calloutX - 16}`} stroke={accent} strokeOpacity="0.62" strokeWidth="1.5" />
                <circle cx={leadStartX} cy={centerY} r="2.6" fill={accent} fillOpacity="0.88" />
                <rect
                  x={calloutX}
                  y={calloutY}
                  width="190"
                  height="50"
                  rx="8"
                  fill="#020617"
                  fillOpacity="0.78"
                  stroke={accent}
                  strokeOpacity="0.55"
                />
                <text x={calloutX + 10} y={calloutY + 16} fontSize="10.5" fontWeight="700" fill={accent}>
                  {tool.label}
                </text>
                <text x={calloutX + 10} y={calloutY + 30} fontSize="9.5" fill="#cbd5e1">
                  {toolTopDepth(tool).toFixed(1)}-{toolBottomDepth(tool).toFixed(1)} m
                </text>
                <text x={calloutX + 10} y={calloutY + 42} fontSize="9" fill="#94a3b8">
                  Length {tool.lengthM.toFixed(2)} m
                </text>
              </g>
            );
          })}

          {focus.hasCompressedTop && (
            <g transform="translate(500 96)" stroke="#cbd5e1" strokeOpacity="0.75" strokeWidth="2" fill="none">
              <path d="M-15 -8 L-5 0 L5 -8 L15 0" />
              <path d="M-15 4 L-5 12 L5 4 L15 12" />
            </g>
          )}

          {focus.hasCompressedBottom && (
            <g transform="translate(500 634)" stroke="#cbd5e1" strokeOpacity="0.75" strokeWidth="2" fill="none">
              <path d="M-15 -8 L-5 0 L5 -8 L15 0" />
              <path d="M-15 4 L-5 12 L5 4 L15 12" />
            </g>
          )}
        </svg>

        <div className="pointer-events-none absolute left-3 top-3 flex max-w-[64%] flex-wrap gap-1.5">
          <span className="rounded-md border border-slate-500/60 bg-slate-950/70 px-2 py-1 text-[10px] uppercase tracking-wider text-slate-200">
            Cutaway Realistic
          </span>
          <span className="rounded-md border border-cyan-400/40 bg-cyan-950/45 px-2 py-1 text-[10px] uppercase tracking-wider text-cyan-200">
            Focus {Math.round(focus.topM)}-{Math.round(focus.bottomM)}m
          </span>
        </div>

        {focus.hasCompressedTop && (
          <div className="pointer-events-none absolute left-1/2 top-11 -translate-x-1/2 rounded-full border border-slate-600/70 bg-slate-900/85 px-3 py-1 text-[10px] text-slate-300">
            0-{Math.round(focus.topM)}m tubing compressed
          </div>
        )}

        {focus.hasCompressedBottom && (
          <div className="pointer-events-none absolute bottom-3 left-1/2 -translate-x-1/2 rounded-full border border-slate-600/70 bg-slate-900/85 px-3 py-1 text-[10px] text-slate-300">
            {Math.round(focus.bottomM)}-{Math.round(placement.totalDepthM)}m tubing compressed
          </div>
        )}

        <div className="absolute inset-y-3 left-3 w-16">
          {focusTicks.map((depthM, idx) => (
            <div
              key={idx}
              className="absolute left-0 right-0 -translate-y-1/2"
              style={{ top: `${toFocusPct(depthM, focus)}%` }}
            >
              <div className="h-px bg-slate-500/70" />
              <span className="absolute -top-2 left-0 text-[10px] tabular-nums text-slate-300/90">
                {Math.round(depthM)}m
              </span>
            </div>
          ))}
        </div>

        <div className="pointer-events-none absolute bottom-3 left-3 rounded-md border border-slate-700/70 bg-slate-950/70 px-2 py-1 text-[10px] text-slate-300">
          Realistic cross-section with exploded hardware callouts from schematic depths
        </div>
      </div>
    );
  }

  function renderFocusedScene(heightClassName: string) {
    return (
      <div
        className={`relative ${heightClassName} rounded-xl border border-slate-700/70 overflow-hidden bg-[radial-gradient(circle_at_40%_0%,rgba(14,165,233,0.20),transparent_38%),radial-gradient(circle_at_85%_100%,rgba(56,189,248,0.12),transparent_42%),linear-gradient(180deg,#0b1324_0%,#020617_100%)]`}
        onPointerMove={handlePointerMove}
        onPointerLeave={handlePointerLeave}
      >
        <div
          className="pointer-events-none absolute inset-y-0 -left-1/2 w-1/3 bg-gradient-to-r from-transparent via-cyan-200/30 to-transparent"
          style={{ animation: 'wellfi-downhole-sweep 8.5s ease-in-out infinite' }}
        />

        <div className="pointer-events-none absolute left-3 top-3 flex max-w-[58%] flex-wrap gap-1.5">
          <span className="rounded-md border border-slate-600/60 bg-slate-950/65 px-2 py-1 text-[10px] uppercase tracking-wider text-slate-300">
            {formation.name}
          </span>
          <span className="rounded-md border border-cyan-400/40 bg-cyan-950/45 px-2 py-1 text-[10px] uppercase tracking-wider text-cyan-200">
            Focus {Math.round(focus.topM)}-{Math.round(focus.bottomM)}m
          </span>
        </div>

        {focus.hasCompressedTop && (
          <div className="pointer-events-none absolute left-1/2 top-11 -translate-x-1/2 rounded-full border border-slate-600/70 bg-slate-900/85 px-3 py-1 text-[10px] text-slate-300">
            0-{Math.round(focus.topM)}m tubing compressed
          </div>
        )}

        {focus.hasCompressedBottom && (
          <div className="pointer-events-none absolute bottom-3 left-1/2 -translate-x-1/2 rounded-full border border-slate-600/70 bg-slate-900/85 px-3 py-1 text-[10px] text-slate-300">
            {Math.round(focus.bottomM)}-{Math.round(placement.totalDepthM)}m tubing compressed
          </div>
        )}

        <div className="absolute inset-y-3 left-3 w-16">
          {focusTicks.map((depthM, idx) => (
            <div
              key={idx}
              className="absolute left-0 right-0 -translate-y-1/2"
              style={{ top: `${toFocusPct(depthM, focus)}%` }}
            >
              <div className="h-px bg-slate-500/70" />
              <span className="absolute -top-2 left-0 text-[10px] tabular-nums text-slate-300/90">
                {Math.round(depthM)}m
              </span>
            </div>
          ))}
        </div>

        <div
          className="absolute inset-y-4 left-1/2 w-[32%] min-w-[128px] max-w-[220px] transition-transform duration-200 will-change-transform"
          style={{
            transform: sceneTransform,
            animation: 'wellfi-bore-drift 4.2s ease-in-out infinite',
          }}
        >
          <div className="absolute inset-0 rounded-[999px] border border-slate-500/75 bg-gradient-to-r from-slate-950 via-slate-700 to-slate-950 shadow-[inset_-16px_0_24px_rgba(0,0,0,0.45),inset_14px_0_24px_rgba(255,255,255,0.09),0_6px_16px_rgba(0,0,0,0.35)]" />

          {formationVisible && (
            <div
              className="absolute left-[16%] right-[16%] rounded-full border border-sky-300/35 bg-sky-400/15"
              style={{
                top: `${formationTopPct}%`,
                height: `${formationHeightPct}%`,
              }}
            />
          )}

          <div className="absolute inset-y-0 left-1/2 w-px -translate-x-1/2 bg-white/10" />

          {renderedTools.map((tool) => (
            <div
              key={tool.id}
              className={`absolute left-1/2 w-[72%] -translate-x-1/2 rounded-md border shadow-[0_4px_14px_rgba(0,0,0,0.45)] ${tool.barClassName}`}
              style={{
                top: `${tool.topPct}%`,
                height: `${tool.heightPct}%`,
                animation: tool.id === 'wellfi_tool' && hasInstalledWellFi ? 'wellfi-tool-pulse 2.8s ease-out infinite' : undefined,
              }}
            >
              <span className="absolute inset-0 flex items-center justify-center px-1 text-[9px] font-semibold tracking-wide text-slate-950/80">
                {shortToolLabel(tool.id)}
              </span>
            </div>
          ))}
        </div>

        <div className="pointer-events-none absolute right-3 top-3 w-[88px] rounded-md border border-slate-600/70 bg-slate-950/70 p-2">
          <div className="text-[9px] uppercase tracking-wider text-slate-300">Depth Context</div>
          <div className="relative mt-1 h-32">
            <div className="absolute bottom-0 left-1/2 top-0 w-2 -translate-x-1/2 rounded-full bg-slate-700/80" />
            <div
              className="absolute left-1/2 w-3 -translate-x-1/2 rounded-full border border-cyan-300/70 bg-cyan-400/30"
              style={{
                top: `${(focus.topM / placement.totalDepthM) * 100}%`,
                height: `${(focus.spanM / placement.totalDepthM) * 100}%`,
              }}
            />
            {tools.map((tool) => (
              <div
                key={tool.id}
                className={`absolute left-1/2 h-2.5 w-2.5 -translate-x-1/2 -translate-y-1/2 rounded-full border border-slate-900/70 ${tool.dotClassName}`}
                style={{ top: `${(tool.depthM / placement.totalDepthM) * 100}%` }}
              />
            ))}
          </div>
          <div className="mt-1 flex items-center justify-between text-[9px] tabular-nums text-slate-400">
            <span>0m</span>
            <span>{Math.round(placement.totalDepthM)}m</span>
          </div>
          <div className="mt-1 text-center text-[9px] text-cyan-200">Zoomed Band</div>
        </div>

        <div className="absolute bottom-10 right-3 w-44 space-y-1">
          {renderedTools.map((tool) => (
            <div key={tool.id} className="rounded border border-slate-600/70 bg-slate-950/75 px-1.5 py-1 text-[10px]">
              <div className={`font-medium ${tool.labelClassName}`}>{tool.label}</div>
              <div className="tabular-nums text-slate-300">{formatDepthRange(tool)}</div>
              <div className="text-[9px] text-slate-400">
                Center {tool.depthM.toFixed(1)}m | L {tool.lengthM.toFixed(2)}m
              </div>
              {tool.status && (
                <div className="text-[9px] uppercase tracking-wide text-slate-400">{tool.status}</div>
              )}
            </div>
          ))}
        </div>

        {focus.hasCompressedTop && (
          <div className="pointer-events-none absolute left-1/2 top-16 h-4 w-7 -translate-x-1/2 text-slate-300/70">
            <svg viewBox="0 0 28 16" className="h-full w-full fill-none stroke-current stroke-[1.5]">
              <path d="M2 3 L8 7 L14 3 L20 7 L26 3" />
              <path d="M2 9 L8 13 L14 9 L20 13 L26 9" />
            </svg>
          </div>
        )}

        {focus.hasCompressedBottom && (
          <div className="pointer-events-none absolute bottom-8 left-1/2 h-4 w-7 -translate-x-1/2 text-slate-300/70">
            <svg viewBox="0 0 28 16" className="h-full w-full fill-none stroke-current stroke-[1.5]">
              <path d="M2 3 L8 7 L14 3 L20 7 L26 3" />
              <path d="M2 9 L8 13 L14 9 L20 13 L26 9" />
            </svg>
          </div>
        )}

        <div className="pointer-events-none absolute bottom-3 left-3 rounded-md border border-slate-700/70 bg-slate-950/70 px-2 py-1 text-[10px] text-slate-300">
          Non-tubing components are magnified for visibility
        </div>
      </div>
    );
  }

  return (
    <Card>
      <CardHeader className="pb-2 pt-3 px-4">
        <div className="flex flex-wrap items-center justify-between gap-3">
          <CardTitle className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">
            Downhole 3D View
          </CardTitle>
          <div className="flex items-center gap-2">
            <div className="inline-flex h-8 items-center rounded-md border border-slate-700/70 bg-slate-900/70 p-0.5">
              <button
                type="button"
                onClick={() => setSceneMode('cutaway')}
                className={`rounded px-2 py-1 text-[10px] font-semibold uppercase tracking-wide transition-colors ${
                  sceneMode === 'cutaway'
                    ? 'bg-cyan-400/30 text-cyan-100'
                    : 'text-slate-400 hover:text-slate-200'
                }`}
                aria-pressed={sceneMode === 'cutaway'}
              >
                Cutaway
              </button>
              <button
                type="button"
                onClick={() => setSceneMode('focused')}
                className={`rounded px-2 py-1 text-[10px] font-semibold uppercase tracking-wide transition-colors ${
                  sceneMode === 'focused'
                    ? 'bg-cyan-400/30 text-cyan-100'
                    : 'text-slate-400 hover:text-slate-200'
                }`}
                aria-pressed={sceneMode === 'focused'}
              >
                Technical
              </button>
            </div>
            <Button type="button" variant="ghost" size="sm" className="h-8 px-2" onClick={() => nudgeZoom(-ZOOM_STEP)}>
              <ZoomOut className="h-3.5 w-3.5" />
            </Button>
            <Button type="button" variant="ghost" size="sm" className="h-8 px-2" onClick={() => nudgeZoom(ZOOM_STEP)}>
              <ZoomIn className="h-3.5 w-3.5" />
            </Button>
            <Button type="button" variant="ghost" size="sm" className="h-8 px-2" onClick={resetView}>
              <RotateCcw className="h-3.5 w-3.5" />
            </Button>
            <Button type="button" variant="ghost" size="sm" className="h-8 px-2" onClick={() => setExpandedOpen(true)}>
              <Maximize2 className="h-3.5 w-3.5" />
            </Button>
          </div>
        </div>
      </CardHeader>
      <CardContent className="space-y-3 px-4 pb-3">
        {sceneMode === 'cutaway' ? renderCutawayScene('h-80') : renderFocusedScene('h-80')}

        <div className="space-y-1.5">
          {tools.map((tool) => (
            <div
              key={tool.id}
              className="flex items-center justify-between rounded-md border border-slate-700/60 bg-slate-900/40 px-2.5 py-1.5"
            >
              <div className="flex items-center gap-2">
                <span className={`inline-block h-2.5 w-2.5 rounded-full ${tool.dotClassName}`} />
                <div>
                  <div className="text-xs font-medium text-slate-100">{tool.label}</div>
                  <div className="text-[10px] tabular-nums text-slate-400">{formatDepthRange(tool)} | L {tool.lengthM.toFixed(2)}m</div>
                </div>
                {tool.status && (
                  <span className="rounded bg-slate-800 px-1.5 py-0.5 text-[10px] uppercase tracking-wide text-slate-300">
                    {tool.status}
                  </span>
                )}
              </div>
              <span className="text-xs tabular-nums text-slate-300">{formatDepth(tool.depthM)}</span>
            </div>
          ))}
        </div>

        <p className="text-[11px] text-slate-400">
          {placement.depthSource === 'manual'
            ? 'Depths sourced from WellFi install notes.'
            : placement.depthSource === 'schematic'
              ? `Depths sourced from schematic: ${placement.sourceFile ?? 'Well profile PDF'}.`
              : 'Depths estimated from formation profile. Add install depth tags or import schematic PDFs for exact placement.'}
        </p>
      </CardContent>

      <Dialog open={expandedOpen} onOpenChange={setExpandedOpen}>
        <DialogContent className="max-w-5xl border-slate-700 bg-slate-950 text-slate-100">
          <DialogHeader>
            <DialogTitle>Downhole 3D View - {well.name ?? well.well_id}</DialogTitle>
            <DialogDescription>
              {sceneMode === 'cutaway'
                ? 'Cutaway realistic mode highlights hardware geometry and suppresses long tubing sections.'
                : 'Technical mode shows exact depth relationships in a compressed focused interval.'}
            </DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            {sceneMode === 'cutaway' ? renderCutawayScene('h-[72vh]') : renderFocusedScene('h-[72vh]')}
          </div>
        </DialogContent>
      </Dialog>
    </Card>
  );
}

export default memo(DownholeModel3DComponent);
