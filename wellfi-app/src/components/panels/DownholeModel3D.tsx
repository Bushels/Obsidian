import { memo, useEffect, useMemo, useState } from 'react';
import { Maximize2, RotateCcw, ZoomIn, ZoomOut, FileEdit, Loader2 } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { toast } from 'sonner';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogFooter,
  DialogClose,
} from '@/components/ui/dialog';
import { FORMATION_POLYGONS } from '@/lib/formationData';
import { SCHEMATIC_DEPTHS, type SchematicDepthEntry } from '@/lib/schematicDepths';
import { supabase } from '@/lib/supabase';
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
  collarDepthM: number;
  collarLengthM: number;
  hasManualDepths: boolean;
  hasSchematicDepths: boolean;
  hasDatabaseDepths: boolean;
  depthSource: 'manual' | 'schematic' | 'estimated' | 'database';
  sourceFile: string | null;
}

interface FormationProfile {
  name: string;
  depthM: number;
  thicknessM: number;
}

interface ToolSegment {
  id: 'pump' | 'slotted_tag_bar' | 'wellfi_tool' | 'no_turn_tool' | 'collar';
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
  const defaultCollarDepthM = defaultNoTurnDepthM + 0.5;
  const defaultTotalDepthM = Math.max(formationDepthM + 120, defaultCollarDepthM + 24);
  const defaultPumpLengthM = 8.0;
  const defaultSlottedTagBarLengthM = 0.9;
  const defaultWellFiLengthM = 6.30;
  const defaultNoTurnLengthM = 0.6;
  const defaultCollarLengthM = 0.4;

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
  // Schematic doesn't visually distinguish collar usually, so null fallback
  // const schematicCollarDepthM: number | null = null; 

  const pumpLengthM = schematic?.pump?.length_m ?? defaultPumpLengthM;
  const slottedTagBarLengthM = schematic?.slotted_tag_bar?.length_m ?? defaultSlottedTagBarLengthM;
  const wellFiLengthM = schematic?.wellfi_tool?.length_m ?? defaultWellFiLengthM;
  const noTurnLengthM = schematic?.no_turn_tool?.length_m ?? defaultNoTurnLengthM;
  // Use default for collar length if not specified (conceptually)
  const collarLengthM = defaultCollarLengthM;

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

  // Database values (new columns)
  const dbPumpDepthM =
    well.pump_top_depth_m && well.pump_bottom_depth_m
      ? (well.pump_top_depth_m + well.pump_bottom_depth_m) / 2
      : null;
  const dbSlottedTagBarDepthM =
    well.slotted_tag_bar_top_depth_m && well.slotted_tag_bar_bottom_depth_m
      ? (well.slotted_tag_bar_top_depth_m + well.slotted_tag_bar_bottom_depth_m) / 2
      : null;
  const dbWellFiDepthM =
    well.wellfi_tool_top_depth_m && well.wellfi_tool_bottom_depth_m
      ? (well.wellfi_tool_top_depth_m + well.wellfi_tool_bottom_depth_m) / 2
      : null;
  const dbNoTurnDepthM =
    well.no_turn_tool_top_depth_m && well.no_turn_tool_bottom_depth_m
      ? (well.no_turn_tool_top_depth_m + well.no_turn_tool_bottom_depth_m) / 2
      : null;
  const dbCollarDepthM =
    well.collar_top_depth_m && well.collar_bottom_depth_m
      ? (well.collar_top_depth_m + well.collar_bottom_depth_m) / 2
      : null;

  let totalDepthM = manualTotalDepthM ?? schematicTotalDepthM ?? defaultTotalDepthM;
  let pumpDepthM = dbPumpDepthM ?? manualPumpDepthM ?? schematicPumpDepthM ?? defaultPumpDepthM;
  let slottedTagBarDepthM =
    dbSlottedTagBarDepthM ?? manualSlottedTagBarDepthM ?? schematicSlottedTagBarDepthM ?? defaultSlottedTagBarDepthM;
  let wellFiDepthM = dbWellFiDepthM ?? manualWellFiDepthM ?? schematicWellFiDepthM ?? defaultWellFiDepthM;
  let noTurnDepthM = dbNoTurnDepthM ?? manualNoTurnDepthM ?? schematicNoTurnDepthM ?? defaultNoTurnDepthM;
  let collarDepthM = dbCollarDepthM ?? defaultCollarDepthM;

  // Use database lengths if available implies using db depths
  const finalPumpLengthM =
    well.pump_top_depth_m && well.pump_bottom_depth_m
      ? Math.abs(well.pump_bottom_depth_m - well.pump_top_depth_m)
      : pumpLengthM;
  const finalSlottedTagBarLengthM =
    well.slotted_tag_bar_top_depth_m && well.slotted_tag_bar_bottom_depth_m
      ? Math.abs(well.slotted_tag_bar_bottom_depth_m - well.slotted_tag_bar_top_depth_m)
      : slottedTagBarLengthM;
  const finalWellFiLengthM =
    well.wellfi_tool_top_depth_m && well.wellfi_tool_bottom_depth_m
      ? Math.abs(well.wellfi_tool_bottom_depth_m - well.wellfi_tool_top_depth_m)
      : wellFiLengthM;
  const finalNoTurnLengthM =
    well.no_turn_tool_top_depth_m && well.no_turn_tool_bottom_depth_m
      ? Math.abs(well.no_turn_tool_bottom_depth_m - well.no_turn_tool_top_depth_m)
      : noTurnLengthM;
  const finalCollarLengthM =
    well.collar_top_depth_m && well.collar_bottom_depth_m
      ? Math.abs(well.collar_bottom_depth_m - well.collar_top_depth_m)
      : collarLengthM;

  if (manualWellFiDepthM == null && schematicWellFiDepthM == null) {
    const gap = noTurnDepthM - slottedTagBarDepthM;
    if (gap > 0.35) {
      wellFiDepthM = slottedTagBarDepthM + gap * 0.55;
    }
  }

  const minSpacing = 0.24;
  pumpDepthM = clamp(pumpDepthM, 60, totalDepthM - 12);

  // If we don't have explicit DB or manual values, enforce spacing constraint
  if (!dbSlottedTagBarDepthM && !manualSlottedTagBarDepthM) {
    slottedTagBarDepthM = Math.max(slottedTagBarDepthM, pumpDepthM + minSpacing);
  }
  if (!dbWellFiDepthM && !manualWellFiDepthM) {
    wellFiDepthM = Math.max(wellFiDepthM, slottedTagBarDepthM + minSpacing);
  }
  if (!dbNoTurnDepthM && !manualNoTurnDepthM) {
    noTurnDepthM = Math.max(noTurnDepthM, wellFiDepthM + minSpacing);
  }
  if (!dbCollarDepthM) {
    collarDepthM = Math.max(collarDepthM, noTurnDepthM + minSpacing);
  }
  
  // User correction: Nothing past the last collar.
  // We only extend TD if manual/schematic TD is deeper. Otherwise, TD is effectively the bottom of collar.
  // We add a tiny buffer just for visual containment if needed, but not 24m/12m of rat hole.
  // Actually, let's keep TD slightly below for visual framing, but ensure string visual stops.
  totalDepthM = Math.max(totalDepthM, collarDepthM + collarLengthM + 2);

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

  const hasDatabaseDepths =
    dbPumpDepthM != null ||
    dbSlottedTagBarDepthM != null ||
    dbWellFiDepthM != null ||
    dbNoTurnDepthM != null ||
    dbCollarDepthM != null;

  const depthSource: DownholePlacement['depthSource'] =
    hasDatabaseDepths ? 'database' : hasManualDepths ? 'manual' : hasSchematicDepths ? 'schematic' : 'estimated';

  return {
    totalDepthM,
    pumpDepthM,
    pumpLengthM: finalPumpLengthM,
    slottedTagBarDepthM,
    slottedTagBarLengthM: finalSlottedTagBarLengthM,
    wellFiDepthM,
    wellFiLengthM: finalWellFiLengthM,
    noTurnDepthM,
    noTurnLengthM: finalNoTurnLengthM,
    collarDepthM,
    collarLengthM: finalCollarLengthM,
    hasManualDepths,
    hasSchematicDepths,
    hasDatabaseDepths,
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
    case 'collar':
      return '#cbd5e1';
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
    case 'collar':
      return 'Collar';
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
    @keyframes wellfi-led-blink {
      0%, 100% { opacity: 0.4; }
      50% { opacity: 1; }
    }
    @keyframes wellfi-data-stream {
      from { stroke-dashoffset: 40; }
      to { stroke-dashoffset: 0; }
    }
    @keyframes wellfi-flare {
      0% { opacity: 0.5; transform: scale(0.9); }
      50% { opacity: 1; transform: scale(1.1); }
      100% { opacity: 0.5; transform: scale(0.9); }
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
    {
      id: 'collar',
      label: 'Collar',
      depthM: placement.collarDepthM,
      lengthM: placement.collarLengthM,
      barClassName: 'bg-gradient-to-b from-slate-300 to-slate-500 border-slate-100/80',
      dotClassName: 'bg-slate-300',
      labelClassName: 'text-slate-100',
    },
  ];
}

function DownholeModel3DComponent({ well }: DownholeModel3DProps) {
  const [expandedOpen, setExpandedOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [view, setView] = useState<SceneViewState>(DEFAULT_VIEW);
  const [sceneMode, setSceneMode] = useState<SceneMode>('cutaway');
  const [isSaving, setIsSaving] = useState(false);
  
  // Local state for the edit form
  const [formData, setFormData] = useState({
    pump_top_depth_m: '',
    pump_bottom_depth_m: '',
    slotted_tag_bar_top_depth_m: '',
    slotted_tag_bar_bottom_depth_m: '',
    wellfi_tool_top_depth_m: '',
    wellfi_tool_bottom_depth_m: '',
    no_turn_tool_top_depth_m: '',
    no_turn_tool_bottom_depth_m: '',
    collar_top_depth_m: '',
    collar_bottom_depth_m: '',
  });

  useEffect(() => {
    injectSceneStyleTag();
  }, []);

  const placement = useMemo(() => resolveDownholePlacement(well), [well]);

  useEffect(() => {
    // Determine the current "best" values to populate the form initially
    // We use the calculated values from placement to imply the current top/bottom
    // For simplicity, we can load from the 'well' object strictly, or fallback to the placement logic.
    // Let's fallback to placement logic to pre-fill with defaults if DB is empty.
    
    // Helper to format or empty
    const fmt = (v: number | null | undefined) => (v != null ? v.toFixed(2) : '');

    // If well has DB values, use them. Else use placement values.
    // NOTE: placement has 'center' depth and 'length'. We need top/bottom.
    const getTop = (depth: number, length: number) => depth - length / 2;
    const getBot = (depth: number, length: number) => depth + length / 2;

    setFormData({
      pump_top_depth_m: fmt(well.pump_top_depth_m ?? getTop(placement.pumpDepthM, placement.pumpLengthM)),
      pump_bottom_depth_m: fmt(well.pump_bottom_depth_m ?? getBot(placement.pumpDepthM, placement.pumpLengthM)),
      slotted_tag_bar_top_depth_m: fmt(well.slotted_tag_bar_top_depth_m ?? getTop(placement.slottedTagBarDepthM, placement.slottedTagBarLengthM)),
      slotted_tag_bar_bottom_depth_m: fmt(well.slotted_tag_bar_bottom_depth_m ?? getBot(placement.slottedTagBarDepthM, placement.slottedTagBarLengthM)),
      wellfi_tool_top_depth_m: fmt(well.wellfi_tool_top_depth_m ?? getTop(placement.wellFiDepthM, placement.wellFiLengthM)),
      wellfi_tool_bottom_depth_m: fmt(well.wellfi_tool_bottom_depth_m ?? getBot(placement.wellFiDepthM, placement.wellFiLengthM)),
      no_turn_tool_top_depth_m: fmt(well.no_turn_tool_top_depth_m ?? getTop(placement.noTurnDepthM, placement.noTurnLengthM)),
      no_turn_tool_bottom_depth_m: fmt(well.no_turn_tool_bottom_depth_m ?? getBot(placement.noTurnDepthM, placement.noTurnLengthM)),
      collar_top_depth_m: fmt(well.collar_top_depth_m ?? getTop(placement.collarDepthM, placement.collarLengthM)),
      collar_bottom_depth_m: fmt(well.collar_bottom_depth_m ?? getBot(placement.collarDepthM, placement.collarLengthM)),
    });
  }, [well, placement, editOpen]); // Reset when opening dialog or well changes

  async function handleSaveConfiguration() {
    setIsSaving(true);
    try {
      // Convert empty strings to null, parse numbers
      const parse = (v: string) => (v === '' ? null : Number(v));
      
      const payload = {
        pump_top_depth_m: parse(formData.pump_top_depth_m),
        pump_bottom_depth_m: parse(formData.pump_bottom_depth_m),
        slotted_tag_bar_top_depth_m: parse(formData.slotted_tag_bar_top_depth_m),
        slotted_tag_bar_bottom_depth_m: parse(formData.slotted_tag_bar_bottom_depth_m),
        wellfi_tool_top_depth_m: parse(formData.wellfi_tool_top_depth_m),
        wellfi_tool_bottom_depth_m: parse(formData.wellfi_tool_bottom_depth_m),
        no_turn_tool_top_depth_m: parse(formData.no_turn_tool_top_depth_m),
        no_turn_tool_bottom_depth_m: parse(formData.no_turn_tool_bottom_depth_m),
        collar_top_depth_m: parse(formData.collar_top_depth_m),
        collar_bottom_depth_m: parse(formData.collar_bottom_depth_m),
      };

      const { error } = await supabase
        .from('wells' as never)
        .update(payload as never)
        .eq('id', well.id);

      if (error) throw error;
      
      toast.success('Configuration saved');
      setEditOpen(false);
      // Note: React Query or parent state needs to refresh 'well' prop to see changes immediately.
      // Assuming parent handles cache invalidation or real-time subscription.
      // If not, a full page reload might be needed or a callback prop.
      window.location.reload(); // Simple brute force refresh for this task context as I don't see the parent data fetching logic
    } catch (err) {
      console.error(err);
      toast.error('Failed to save configuration');
    } finally {
      setIsSaving(false);
    }
  }
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
            {/* Metallic Cylindrical Gradients (Left-to-Right lighting) */}
            <linearGradient id={`${patternIdBase}-gold-metal`} x1="0%" y1="0%" x2="100%" y2="0%">
              <stop offset="0%" stopColor="#854d0e" />
              <stop offset="15%" stopColor="#facc15" />
              <stop offset="40%" stopColor="#ca8a04" />
              <stop offset="60%" stopColor="#eab308" />
              <stop offset="85%" stopColor="#fef08a" />
              <stop offset="100%" stopColor="#713f12" />
            </linearGradient>

            <linearGradient id={`${patternIdBase}-steely-blue`} x1="0%" y1="0%" x2="100%" y2="0%">
              <stop offset="0%" stopColor="#0f172a" />
              <stop offset="20%" stopColor="#38bdf8" />
              <stop offset="45%" stopColor="#0369a1" />
              <stop offset="75%" stopColor="#e0f2fe" />
              <stop offset="100%" stopColor="#0c4a6e" />
            </linearGradient>

            <linearGradient id={`${patternIdBase}-dark-composite`} x1="0%" y1="0%" x2="100%" y2="0%">
              <stop offset="0%" stopColor="#020617" />
              <stop offset="25%" stopColor="#1e293b" />
              <stop offset="50%" stopColor="#334155" />
              <stop offset="75%" stopColor="#1e293b" />
              <stop offset="100%" stopColor="#020617" />
            </linearGradient>

            <linearGradient id={`${patternIdBase}-purple-steel`} x1="0%" y1="0%" x2="100%" y2="0%">
              <stop offset="0%" stopColor="#312e81" />
              <stop offset="20%" stopColor="#818cf8" />
              <stop offset="50%" stopColor="#4338ca" />
              <stop offset="80%" stopColor="#e0e7ff" />
              <stop offset="100%" stopColor="#1e1b4b" />
            </linearGradient>

            <linearGradient id={`${patternIdBase}-rough-steel`} x1="0%" y1="0%" x2="100%" y2="0%">
              <stop offset="0%" stopColor="#334155" />
              <stop offset="25%" stopColor="#94a3b8" />
              <stop offset="50%" stopColor="#64748b" />
              <stop offset="80%" stopColor="#cbd5e1" />
              <stop offset="100%" stopColor="#1e293b" />
            </linearGradient>

            <linearGradient id={`${patternIdBase}-casing-grad`} x1="0%" y1="0%" x2="100%" y2="0%">
              <stop offset="0%" stopColor="#1e293b" />
              <stop offset="10%" stopColor="#0f172a" />
              <stop offset="90%" stopColor="#0f172a" />
              <stop offset="100%" stopColor="#1e293b" />
            </linearGradient>
             <linearGradient id={`${patternIdBase}-inner-grad`} x1="0%" y1="0%" x2="100%" y2="0%">
              <stop offset="0%" stopColor="#020617" />
              <stop offset="20%" stopColor="#020617" />
              <stop offset="50%" stopColor="#0f172a" />
              <stop offset="80%" stopColor="#020617" />
              <stop offset="100%" stopColor="#020617" />
            </linearGradient>

             <linearGradient id={`${patternIdBase}-tubing-grad`} x1="0%" y1="0%" x2="100%" y2="0%">
              <stop offset="0%" stopColor="#0f172a" />
              <stop offset="30%" stopColor="#334155" />
              <stop offset="50%" stopColor="#475569" />
              <stop offset="70%" stopColor="#334155" />
              <stop offset="100%" stopColor="#0f172a" />
            </linearGradient>

            <pattern id={casingPatternId} width="12" height="12" patternUnits="userSpaceOnUse">
               <path d="M-1,1 l2,-2 M0,12 l12,-12 M11,13 l2,-2" stroke="#334155" strokeWidth="0.5" strokeOpacity="0.3" />
            </pattern>
            
            <filter id={`${patternIdBase}-glow`}>
              <feGaussianBlur stdDeviation="2.5" result="coloredBlur"/>
              <feMerge>
                <feMergeNode in="coloredBlur"/>
                <feMergeNode in="SourceGraphic"/>
              </feMerge>
            </filter>
            
             <filter id={`${patternIdBase}-metal-shine`}>
                 <feSpecularLighting result="specOut" specularExponent="25" lightingColor="#ffffff">
                    <fePointLight x="400" y="-800" z="400"/>
                 </feSpecularLighting>
                 <feComposite in="SourceGraphic" in2="specOut" operator="arithmetic" k1="0" k2="1" k3="1" k4="0"/>
            </filter>

            <filter id={`${patternIdBase}-drop-shadow`} x="-20%" y="-20%" width="140%" height="140%">
              <feDropShadow dx="8" dy="12" stdDeviation="6" floodColor="#000000" floodOpacity="0.65" />
            </filter>
            
            <filter id={`${patternIdBase}-inner-shadow`}>
              <feOffset dx="0" dy="0"/>
              <feGaussianBlur stdDeviation="3" result="offset-blur"/>
              <feComposite operator="out" in="SourceGraphic" in2="offset-blur" result="inverse"/>
              <feFlood floodColor="black" floodOpacity="0.8" result="color"/>
              <feComposite operator="in" in="color" in2="inverse" result="shadow"/>
              <feComposite operator="over" in="shadow" in2="SourceGraphic"/>
            </filter>
          </defs>

          {/* Casing Background */}
          <rect x="388" y="42" width="224" height="620" rx="4" fill={`url(#${patternIdBase}-casing-grad)`} stroke="#475569" strokeWidth="2" />
           {/* Cement/Formation Context */}
          <rect x="370" y="42" width="18" height="620" fill={`url(#${casingPatternId})`} opacity="0.6" />
          <rect x="612" y="42" width="18" height="620" fill={`url(#${casingPatternId})`} opacity="0.6" />

           {/* Inner Wellbore Dark Background */}
          <rect x="406" y="48" width="188" height="608" rx="2" fill={`url(#${patternIdBase}-inner-grad)`} />
          
          {/* Tubing String (Dynamic Length) */}
          {(() => {
             // Find visual bottom of the stack
             const lastBody = cutawayBodies[cutawayBodies.length - 1];
             const tubingBottomY = lastBody ? lastBody.centerY + lastBody.height / 2 : 608;
             const tubingTopY = 48;
             return (
               <g filter={`url(#${patternIdBase}-drop-shadow)`}>
                 <rect 
                   x="484" 
                   y={tubingTopY} 
                   width="32" 
                   height={Math.max(0, tubingBottomY - tubingTopY)} 
                   fill={`url(#${patternIdBase}-tubing-grad)`} 
                 />
                 <rect 
                   x="484" 
                   y={tubingTopY} 
                   width="32" 
                   height={Math.max(0, tubingBottomY - tubingTopY)} 
                   fill="none"
                   stroke="#1e293b"
                   strokeWidth="1"
                 />
               </g>
             );
          })()}


          {formationVisible && (
            <rect
              x="430"
              y={cutawayTrackTop + (formationTopPct / 100) * cutawayTrackSpan}
              width="140"
              height={(formationHeightPct / 100) * cutawayTrackSpan}
              rx="4"
              fill="none"
              stroke="#38bdf8"
              strokeDasharray="4 4"
              strokeOpacity="0.4"
            />
          )}

          {cutawayBodies.map(({ tool, centerY, height, width }) => {
            const halfH = height / 2;
            const halfW = width / 2;

            if (tool.id === 'pump') {
              return (
                <g key={tool.id} transform={`translate(500 ${centerY})`} filter={`url(#${patternIdBase}-drop-shadow)`}>
                  {/* Stator Body */}
                  <rect
                    x={-halfW}
                    y={-halfH}
                    width={width}
                    height={height}
                    rx="6"
                    fill={`url(#${patternIdBase}-gold-metal)`}
                    stroke="#713f12"
                    strokeWidth="1"
                    filter={`url(#${patternIdBase}-metal-shine)`}
                  />
                  {/* Helical Details */}
                   <path 
                     d={`M${-halfW} ${-halfH+10} Q0 ${-halfH+20} ${halfW} ${-halfH+10} 
                        M${-halfW} ${-halfH+30} Q0 ${-halfH+40} ${halfW} ${-halfH+30}
                        M${-halfW} ${-halfH+50} Q0 ${-halfH+60} ${halfW} ${-halfH+50}
                        M${-halfW} ${-halfH+70} Q0 ${-halfH+80} ${halfW} ${-halfH+70}
                        ${height > 100 ? `M${-halfW} ${-halfH+90} Q0 ${-halfH+100} ${halfW} ${-halfH+90}` : ''}
                        `} 
                     stroke="#713f12" 
                     strokeWidth="2" 
                     opacity="0.3" 
                     fill="none" 
                   />
                   
                   {/* Top/Bottom Couplings */}
                   <rect x={-halfW-2} y={-halfH} width={width+4} height="12" rx="2" fill="#ca8a04" stroke="#713f12" />
                   <rect x={-halfW-2} y={halfH-12} width={width+4} height="12" rx="2" fill="#ca8a04" stroke="#713f12" />

                   {/* Label */}
                   <text y="4" textAnchor="middle" fill="#451a03" fontSize="10" fontWeight="800" opacity="0.6">STATOR</text>
                </g>
              );
            }

            if (tool.id === 'slotted_tag_bar') {
              return (
                <g key={tool.id} transform={`translate(500 ${centerY})`} filter={`url(#${patternIdBase}-drop-shadow)`}>
                  <rect
                    x={-halfW}
                    y={-halfH}
                    width={width}
                    height={height}
                    rx="4"
                    fill={`url(#${patternIdBase}-steely-blue)`}
                    stroke="#0c4a6e"
                     filter={`url(#${patternIdBase}-metal-shine)`}
                  />
                  {/* Slots */}
                  {[...Array(6)].map((_, i) => (
                    <g key={i} transform={`translate(0 ${-halfH + 16 + i * 12})`}>
                       <rect x={-halfW + 8} y="0" width="10" height="6" rx="3" fill="#020617" filter={`url(#${patternIdBase}-inner-shadow)`} />
                       <rect x={-5} y="0" width="10" height="6" rx="3" fill="#020617" filter={`url(#${patternIdBase}-inner-shadow)`} />
                       <rect x={halfW - 18} y="0" width="10" height="6" rx="3" fill="#020617" filter={`url(#${patternIdBase}-inner-shadow)`} />
                    </g>
                  ))}
                   <rect x={-halfW} y={halfH-8} width={width} height="8" fill="#0369a1" />
                   <path d={`M${-halfW} ${halfH} L0 ${halfH+12} L${halfW} ${halfH} Z`} fill="#0369a1" />
                </g>
              );
            }

            if (tool.id === 'wellfi_tool') {
              return (
                <g key={tool.id} transform={`translate(500 ${centerY})`} filter={`url(#${patternIdBase}-drop-shadow)`}>
                   {/* Main Housing */}
                  <rect
                    x={-halfW}
                    y={-halfH}
                    width={width}
                    height={height}
                    rx="8"
                    fill={`url(#${patternIdBase}-dark-composite)`}
                    stroke="#334155"
                    strokeWidth="1.5"
                    filter={`url(#${patternIdBase}-metal-shine)`}
                  />
                  
                  {/* Sensor Bands - Glowing */}
                  <rect x={-halfW-2} y={-halfH + height*0.2} width={width+4} height="6" fill="#06b6d4" filter={`url(#${patternIdBase}-glow)`} />
                  <rect x={-halfW-2} y={-halfH + height*0.5} width={width+4} height="6" fill="#06b6d4" filter={`url(#${patternIdBase}-glow)`} />
                  <rect x={-halfW-2} y={-halfH + height*0.8} width={width+4} height="6" fill="#06b6d4" filter={`url(#${patternIdBase}-glow)`} />

                  {/* Electronics Module Detail */}
                  <rect 
                    x={-width*0.3} 
                    y={-halfH + 10} 
                    width={width*0.6} 
                    height={height - 20} 
                    rx="4" 
                    fill="#0f172a" 
                    stroke="#38bdf8" 
                    strokeOpacity="0.4"
                    opacity="0.9" 
                    filter={`url(#${patternIdBase}-inner-shadow)`}
                  />

                  {/* Animated Data Stream Elements inside the module */}
                  <line 
                    x1="0" y1={-halfH + 15} 
                    x2="0" y2={halfH - 15} 
                    stroke="#22d3ee" 
                    strokeWidth="2" 
                    strokeDasharray="4 8"
                    style={{ animation: 'wellfi-data-stream 1.5s linear infinite' }}
                  />
                  {/* Blinking LEDs */}
                  <circle cx={-width*0.15} cy={-halfH + 20} r="1.5" fill="#f43f5e" style={{ animation: 'wellfi-led-blink 1s steps(2, start) infinite' }} />
                  <circle cx={-width*0.15} cy={-halfH + 26} r="1.5" fill="#10b981" style={{ animation: 'wellfi-led-blink 2.5s steps(2, start) infinite' }} />
                  <circle cx={-width*0.15} cy={-halfH + 32} r="1.5" fill="#3b82f6" style={{ animation: 'wellfi-led-blink 0.8s steps(2, start) infinite' }} />
                  
                  {/* Glowing text label */}
                  <g filter={`url(#${patternIdBase}-glow)`}>
                    <text x="0" y="4" textAnchor="middle" fontSize="10" fontWeight="900" fill="#22d3ee" style={{ letterSpacing: '1px' }}>WELLFI</text>
                  </g>
                  <text x="0" y="4" textAnchor="middle" fontSize="10" fontWeight="900" fill="#ffffff" style={{ letterSpacing: '1px' }}>WELLFI</text>
                </g>
              );
            }

            if (tool.id === 'no_turn_tool') {
               return (
                <g key={tool.id} transform={`translate(500 ${centerY})`}>
                  {/* Mandrel */}
                  <rect
                    x={-halfW + 10}
                    y={-halfH}
                    width={width - 20}
                    height={height}
                    rx="2"
                    fill={`url(#${patternIdBase}-purple-steel)`}
                    stroke="#1e1b4b"
                  />
                  
                  {/* Fins / Anchors */}
                  <path d={`M${-halfW+10} ${-halfH+10} L${-halfW-5} ${-halfH+20} L${-halfW-5} ${halfH-20} L${-halfW+10} ${halfH-10} Z`} fill="#4338ca" stroke="#312e81" />
                  <path d={`M${halfW-10} ${-halfH+10} L${halfW+5} ${-halfH+20} L${halfW+5} ${halfH-20} L${halfW-10} ${halfH-10} Z`} fill="#4338ca" stroke="#312e81" />
                  
                  {/* Teeth on Fins */}
                  <path d={`M${-halfW-5} ${-halfH+20} L${-halfW-8} ${-halfH+25} L${-halfW-5} ${-halfH+30}`} stroke="#818cf8" strokeWidth="2" fill="none" />
                  <path d={`M${halfW+5} ${-halfH+20} L${halfW+8} ${-halfH+25} L${halfW+5} ${-halfH+30}`} stroke="#818cf8" strokeWidth="2" fill="none" />
                </g>
               )
            }
            
             if (tool.id === 'collar') {
              return (
                <g key={tool.id} transform={`translate(500 ${centerY})`}>
                  <rect
                    x={-halfW}
                    y={-halfH}
                    width={width}
                    height={height}
                    rx="2"
                    fill={`url(#${patternIdBase}-rough-steel)`}
                    stroke="#1e293b"
                  />
                  {/* Thread/Joint Lines */}
                  <line x1={-halfW} y1={-halfH+10} x2={halfW} y2={-halfH+10} stroke="#475569" strokeWidth="2" />
                  <line x1={-halfW} y1={halfH-10} x2={halfW} y2={halfH-10} stroke="#475569" strokeWidth="2" />
                  
                  {/* Heavy Wall Indication */}
                  <rect x={-halfW+6} y={-halfH} width="4" height={height} fill="#0f172a" opacity="0.3" />
                  <rect x={halfW-10} y={-halfH} width="4" height={height} fill="#0f172a" opacity="0.3" />
                </g>
              );
            }

            return null; // Should not happen
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
          <CardTitle className="text-sm font-semibold uppercase tracking-wide text-muted-foreground flex items-center gap-2">
            Downhole 3D View
            <Button
              variant="outline"
              size="icon"
              className="h-6 w-6 text-slate-400 hover:text-slate-200 border-slate-700/50 hover:bg-slate-800"
              onClick={() => setEditOpen(true)}
              title="Edit Configuration"
            >
              <FileEdit className="h-3 w-3" />
            </Button>
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
              : placement.depthSource === 'database'
                ? 'Depths explicitly configured in database.'
                : 'Depths estimated from formation profile. Add install depth tags, import schematic PDFs, or configure manually.'}
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

      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="max-w-2xl border-slate-700 bg-slate-950 text-slate-100">
          <DialogHeader>
            <DialogTitle>Edit Downhole Equipment</DialogTitle>
            <DialogDescription>
              Configure the exact top and bottom depths for each tool. These values will override schematic and estimated depths.
            </DialogDescription>
          </DialogHeader>
          <div className="grid gap-6 py-4">
            <div className="grid grid-cols-[1fr_120px_120px] gap-4 items-end">
              <div className="text-sm font-medium text-slate-400 pb-2">Component</div>
              <div className="text-sm font-medium text-slate-400 pb-2">Top Depth (m)</div>
              <div className="text-sm font-medium text-slate-400 pb-2">Bottom Depth (m)</div>

              <div className="flex items-center gap-2">
                <div className="h-3 w-3 rounded-full bg-amber-400" />
                <Label htmlFor="pump-top" className="text-slate-200">Stator / Pump</Label>
              </div>
              <Input
                id="pump-top"
                type="number"
                step="0.01"
                className="h-8 bg-slate-900 border-slate-700"
                value={formData.pump_top_depth_m}
                onChange={(e) => setFormData({ ...formData, pump_top_depth_m: e.target.value })}
              />
              <Input
                id="pump-bottom"
                type="number"
                step="0.01"
                className="h-8 bg-slate-900 border-slate-700"
                value={formData.pump_bottom_depth_m}
                onChange={(e) => setFormData({ ...formData, pump_bottom_depth_m: e.target.value })}
              />

              <div className="flex items-center gap-2">
                <div className="h-3 w-3 rounded-full bg-sky-300" />
                <Label htmlFor="stb-top" className="text-slate-200">Slotted Tag Bar</Label>
              </div>
              <Input
                id="stb-top"
                type="number"
                step="0.01"
                className="h-8 bg-slate-900 border-slate-700"
                value={formData.slotted_tag_bar_top_depth_m}
                onChange={(e) => setFormData({ ...formData, slotted_tag_bar_top_depth_m: e.target.value })}
              />
              <Input
                id="stb-bottom"
                type="number"
                step="0.01"
                className="h-8 bg-slate-900 border-slate-700"
                value={formData.slotted_tag_bar_bottom_depth_m}
                onChange={(e) => setFormData({ ...formData, slotted_tag_bar_bottom_depth_m: e.target.value })}
              />

              <div className="flex items-center gap-2">
                <div className="h-3 w-3 rounded-full bg-gray-400" />
                <Label htmlFor="wellfi-top" className="text-slate-200">WellFi Tool</Label>
              </div>
              <Input
                id="wellfi-top"
                type="number"
                step="0.01"
                className="h-8 bg-slate-900 border-slate-700"
                value={formData.wellfi_tool_top_depth_m}
                onChange={(e) => setFormData({ ...formData, wellfi_tool_top_depth_m: e.target.value })}
              />
              <Input
                id="wellfi-bottom"
                type="number"
                step="0.01"
                className="h-8 bg-slate-900 border-slate-700"
                value={formData.wellfi_tool_bottom_depth_m}
                onChange={(e) => setFormData({ ...formData, wellfi_tool_bottom_depth_m: e.target.value })}
              />

              <div className="flex items-center gap-2">
                <div className="h-3 w-3 rounded-full bg-indigo-300" />
                <Label htmlFor="noturn-top" className="text-slate-200">No Turn Tool</Label>
              </div>
              <Input
                id="noturn-top"
                type="number"
                step="0.01"
                className="h-8 bg-slate-900 border-slate-700"
                value={formData.no_turn_tool_top_depth_m}
                onChange={(e) => setFormData({ ...formData, no_turn_tool_top_depth_m: e.target.value })}
              />
              <Input
                id="noturn-bottom"
                type="number"
                step="0.01"
                className="h-8 bg-slate-900 border-slate-700"
                value={formData.no_turn_tool_bottom_depth_m}
                onChange={(e) => setFormData({ ...formData, no_turn_tool_bottom_depth_m: e.target.value })}
              />

              <div className="flex items-center gap-2">
                <div className="h-3 w-3 rounded-full bg-slate-300" />
                <Label htmlFor="collar-top" className="text-slate-200">Collar</Label>
              </div>
              <Input
                id="collar-top"
                type="number"
                step="0.01"
                className="h-8 bg-slate-900 border-slate-700"
                value={formData.collar_top_depth_m}
                onChange={(e) => setFormData({ ...formData, collar_top_depth_m: e.target.value })}
              />
              <Input
                id="collar-bottom"
                type="number"
                step="0.01"
                className="h-8 bg-slate-900 border-slate-700"
                value={formData.collar_bottom_depth_m}
                onChange={(e) => setFormData({ ...formData, collar_bottom_depth_m: e.target.value })}
              />
            </div>
          </div>
          <DialogFooter>
            <DialogClose asChild>
              <Button variant="ghost">Cancel</Button>
            </DialogClose>
            <Button onClick={handleSaveConfiguration} disabled={isSaving}>
              {isSaving && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
              Save Changes
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </Card>
  );
}

export default memo(DownholeModel3DComponent);
