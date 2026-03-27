import type { Well } from '@/types';
import obe102HzFinalSurveyCsv from '@/assets/well-geometry/obe-102-hz-16-18-83-17-final-survey.csv?raw';

export interface TrajectoryPoint {
  md_m: number;
  inclination_deg: number;
  azimuth_deg: number;
  tvd_m: number;
  northing_offset_m: number;
  easting_offset_m: number;
  vertical_section_m: number;
}

export interface CompletionComponent {
  id: 'pump' | 'slotted_tag_bar' | 'wellfi_tool' | 'no_turn_tool' | 'collar';
  label: string;
  top_mkb: number;
  bottom_mkb: number;
  od_mm: number | null;
  note?: string;
}

export interface CompletionSnapshot {
  id: string;
  run_date: string;
  label: string;
  tubing_set_depth_mkb: number;
  source_note: string;
  components: CompletionComponent[];
}

export interface HighlightAnchor {
  snapshot_id: string;
  component_id: CompletionComponent['id'];
  edge: 'top' | 'bottom' | 'center';
  label: string;
}

export interface WellGeometryAsset {
  source_uwi: string;
  licence: string;
  well_name: string;
  match_tokens: string[];
  survey_name: string;
  survey_points: TrajectoryPoint[];
  completion_snapshots: CompletionSnapshot[];
  current_snapshot_id: string;
  highlight_anchor: HighlightAnchor;
  note?: string;
}

export interface InterpolatedTrajectoryPoint extends TrajectoryPoint {
  horizontal_offset_m: number;
}

export interface HighlightAnchorPoint {
  label: string;
  anchor_md_m: number;
  component: CompletionComponent;
  snapshot: CompletionSnapshot;
  trajectory: InterpolatedTrajectoryPoint | null;
}

const SURVEY_HEADER_PREFIX = ['MD', 'INCL', 'AZIMUTH', 'TVD', 'TVDSS', 'N(+)', 'E(+)', 'VS'];

function roundTo(value: number, digits = 3): number {
  return Number(value.toFixed(digits));
}

function normalizeToken(value: string | null | undefined): string | null {
  if (!value) return null;
  const normalized = value.toUpperCase().replace(/[^A-Z0-9]/g, '');
  return normalized.length > 0 ? normalized : null;
}

function tokenStem(value: string): string {
  return value.replace(/(W[0-9])(?:[0-9]{2,3})$/, '$1');
}

export function componentLengthM(component: CompletionComponent): number {
  return Math.max(0, component.bottom_mkb - component.top_mkb);
}

export function componentCenterM(component: CompletionComponent): number {
  return component.top_mkb + componentLengthM(component) / 2;
}

export function parseSurveyCsv(rawCsv: string): TrajectoryPoint[] {
  const lines = rawCsv.split(/\r?\n/);
  const headerIndex = lines.findIndex((line) => {
    const parts = line.split(',').map((part) => part.trim());
    return SURVEY_HEADER_PREFIX.every((token, index) => parts[index] === token);
  });

  if (headerIndex === -1) {
    throw new Error('Survey CSV header not found.');
  }

  const points: TrajectoryPoint[] = [];
  for (let index = headerIndex + 1; index < lines.length; index += 1) {
    const rawLine = lines[index].trim();
    if (!rawLine) continue;
    const parts = lines[index].split(',').map((part) => part.trim());
    if (parts.length < 8) continue;

    const md = Number(parts[0]);
    if (!Number.isFinite(md)) continue;

    const inclination = Number(parts[1]);
    const azimuth = Number(parts[2]);
    const tvd = Number(parts[3]);
    const northing = Number(parts[5]);
    const easting = Number(parts[6]);
    const verticalSection = Number(parts[7]);

    if (
      !Number.isFinite(inclination) ||
      !Number.isFinite(azimuth) ||
      !Number.isFinite(tvd) ||
      !Number.isFinite(northing) ||
      !Number.isFinite(easting) ||
      !Number.isFinite(verticalSection)
    ) {
      continue;
    }

    points.push({
      md_m: roundTo(md),
      inclination_deg: roundTo(inclination),
      azimuth_deg: roundTo(azimuth),
      tvd_m: roundTo(tvd),
      northing_offset_m: roundTo(northing),
      easting_offset_m: roundTo(easting),
      vertical_section_m: roundTo(verticalSection),
    });
  }

  if (points.length === 0) {
    throw new Error('Survey CSV contained no trajectory rows.');
  }

  return points;
}

const OBE_102_HZ_GEOMETRY: WellGeometryAsset = {
  source_uwi: '102/16-18-083-17W5/09',
  licence: '0517936',
  well_name: 'OBE 102 HZ 16-18-83-17',
  match_tokens: [
    '102161808317W509',
    '102161808317W5',
    '102/16-18-083-17W5/09',
    '102/16-18-083-17W5',
    'OBE 102 HZ 16-18-83-17',
  ],
  survey_name: 'OBE 102 Hz Cadotte (13-8) 16-18-83-17 Final Survey L01.csv',
  survey_points: parseSurveyCsv(obe102HzFinalSurveyCsv),
  completion_snapshots: [
    {
      id: '2025-09-01-production-string',
      run_date: '2025-09-01',
      label: 'Current production string',
      tubing_set_depth_mkb: 833.50,
      source_note: 'Updated with WellFi 60.3 mm section between tag bar and NTT. Original WellView set depth was 828.62 mKB; WellFi section adds 4.877 m.',
      components: [
        {
          id: 'pump',
          label: 'Stator / Pump',
          top_mkb: 818.69,
          bottom_mkb: 826.83,
          od_mm: 88.9,
          note: 'LSI 54-1500 stator',
        },
        {
          id: 'slotted_tag_bar',
          label: 'Slotted Tag Bar',
          top_mkb: 826.83,
          bottom_mkb: 827.87,
          od_mm: 88.9,
          note: 'Current 88.9 mm tag bar',
        },
        {
          id: 'wellfi_tool',
          label: 'WellFi (60.3 mm)',
          top_mkb: 827.87,
          bottom_mkb: 832.75,
          od_mm: 60.3,
          note: '16 ft section, sensor port at 829.39 mKB (5 ft below tag bar)',
        },
        {
          id: 'no_turn_tool',
          label: 'No-Turn Tool',
          top_mkb: 832.75,
          bottom_mkb: 833.35,
          od_mm: 203.6,
          note: 'DTA XB 8 5/8"',
        },
        {
          id: 'collar',
          label: 'Collar',
          top_mkb: 833.35,
          bottom_mkb: 833.50,
          od_mm: 88.9,
        },
      ],
    },
  ],
  current_snapshot_id: '2025-09-01-production-string',
  highlight_anchor: {
    snapshot_id: '2025-09-01-production-string',
    component_id: 'wellfi_tool',
    edge: 'center',
    label: 'WellFi sensor port (829.39 mKB)',
  },
  note: 'Uses the final survey CSV for trajectory and the current WellView production string for completion placement.',
};

export const WELL_GEOMETRY_ASSETS: WellGeometryAsset[] = [OBE_102_HZ_GEOMETRY];

export function findWellGeometryAsset(well: Pick<Well, 'well_id' | 'formatted_id' | 'name'>): WellGeometryAsset | null {
  const rawCandidates = [well.well_id, well.formatted_id ?? null, well.name ?? null];
  const normalizedCandidates = rawCandidates
    .map((value) => normalizeToken(value))
    .filter((value): value is string => !!value);

  if (normalizedCandidates.length === 0) return null;

  const candidateStems = new Set(normalizedCandidates.map(tokenStem));
  let fallbackMatch: WellGeometryAsset | null = null;

  for (const asset of WELL_GEOMETRY_ASSETS) {
    const normalizedTokens = asset.match_tokens
      .map((value) => normalizeToken(value))
      .filter((value): value is string => !!value);

    if (normalizedTokens.length === 0) continue;

    const tokenSet = new Set(normalizedTokens);
    const tokenStems = new Set(normalizedTokens.map(tokenStem));

    for (const candidate of normalizedCandidates) {
      if (tokenSet.has(candidate)) return asset;
    }

    for (const stem of candidateStems) {
      if (tokenStems.has(stem)) {
        fallbackMatch = asset;
      }
    }
  }

  return fallbackMatch;
}

export function getCompletionSnapshot(asset: WellGeometryAsset, snapshotId: string): CompletionSnapshot | null {
  return asset.completion_snapshots.find((snapshot) => snapshot.id === snapshotId) ?? null;
}

export function getCurrentCompletionSnapshot(asset: WellGeometryAsset): CompletionSnapshot | null {
  return getCompletionSnapshot(asset, asset.current_snapshot_id);
}

export function findCompletionComponent(
  snapshot: CompletionSnapshot | null,
  componentId: CompletionComponent['id'],
): CompletionComponent | null {
  if (!snapshot) return null;
  return snapshot.components.find((component) => component.id === componentId) ?? null;
}

export function interpolateTrajectoryPoint(
  points: readonly TrajectoryPoint[],
  targetMdM: number,
): InterpolatedTrajectoryPoint | null {
  if (points.length === 0) return null;

  if (targetMdM <= points[0].md_m) {
    const first = points[0];
    return {
      ...first,
      horizontal_offset_m: roundTo(Math.hypot(first.northing_offset_m, first.easting_offset_m)),
    };
  }

  const last = points[points.length - 1];
  if (targetMdM >= last.md_m) {
    return {
      ...last,
      horizontal_offset_m: roundTo(Math.hypot(last.northing_offset_m, last.easting_offset_m)),
    };
  }

  for (let index = 0; index < points.length - 1; index += 1) {
    const left = points[index];
    const right = points[index + 1];

    if (targetMdM < left.md_m || targetMdM > right.md_m) continue;

    const span = right.md_m - left.md_m;
    const ratio = span === 0 ? 0 : (targetMdM - left.md_m) / span;
    const interpolate = (start: number, end: number) => roundTo(start + (end - start) * ratio);
    const northing = interpolate(left.northing_offset_m, right.northing_offset_m);
    const easting = interpolate(left.easting_offset_m, right.easting_offset_m);

    return {
      md_m: roundTo(targetMdM),
      inclination_deg: interpolate(left.inclination_deg, right.inclination_deg),
      azimuth_deg: interpolate(left.azimuth_deg, right.azimuth_deg),
      tvd_m: interpolate(left.tvd_m, right.tvd_m),
      northing_offset_m: northing,
      easting_offset_m: easting,
      vertical_section_m: interpolate(left.vertical_section_m, right.vertical_section_m),
      horizontal_offset_m: roundTo(Math.hypot(northing, easting)),
    };
  }

  return null;
}

export function getHighlightAnchorPoint(asset: WellGeometryAsset): HighlightAnchorPoint | null {
  const snapshot = getCompletionSnapshot(asset, asset.highlight_anchor.snapshot_id);
  const component = findCompletionComponent(snapshot, asset.highlight_anchor.component_id);
  if (!snapshot || !component) return null;

  const anchorMdM =
    asset.highlight_anchor.edge === 'top'
      ? component.top_mkb
      : asset.highlight_anchor.edge === 'center'
        ? componentCenterM(component)
        : component.bottom_mkb;

  return {
    label: asset.highlight_anchor.label,
    anchor_md_m: roundTo(anchorMdM),
    component,
    snapshot,
    trajectory: interpolateTrajectoryPoint(asset.survey_points, anchorMdM),
  };
}
