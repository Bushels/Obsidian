/**
 * Alberta Dominion Land Survey (DLS) / Legal Subdivision (LSD) Grid Generator
 *
 * Generates GeoJSON line features for township, section, and LSD grid lines
 * to overlay on a Mapbox GL map.
 *
 * Coordinate system:
 *   - 5th Meridian (W5M) at 114°W (-114.0)
 *   - Ranges numbered westward from the meridian
 *   - Townships numbered northward from baseline (49°N)
 *   - Township height ≈ 0.08689° lat (6 miles)
 *   - Range width varies with latitude (6 miles, adjusted for convergence)
 *   - Sections: 36 per township (6×6 snake from SE)
 *   - LSDs: 16 per section (4×4 snake from SE)
 *
 * Convention: "east edge" of Range R = W5M - (R-1) * rangeWidth
 *             "west edge" of Range R = W5M - R * rangeWidth
 */

import type { FeatureCollection, Feature, LineString, Point } from 'geojson';

// ---- Constants ---- //

const BASELINE_LAT = 49.0;
const W5M_LON = -114.0;
const TWP_HEIGHT_DEG = 0.08689;
const KM_PER_DEG_LAT = 111.32;
const TWP_WIDTH_KM = 9.656;

// ---- Helpers ---- //

/** Degrees of longitude per range at a given latitude */
function rangeWidthDeg(latDeg: number): number {
  const latRad = (latDeg * Math.PI) / 180;
  return TWP_WIDTH_KM / (KM_PER_DEG_LAT * Math.cos(latRad));
}

/** South edge latitude of township T */
function twpSouthLat(township: number): number {
  return BASELINE_LAT + (township - 1) * TWP_HEIGHT_DEG;
}

/**
 * East edge longitude of Range R at a given latitude.
 * Range 1 east edge = W5M (-114°), ranges extend westward (more negative).
 */
function rangeEastLon(range: number, latDeg: number): number {
  return W5M_LON - (range - 1) * rangeWidthDeg(latDeg);
}

/**
 * West edge (SW corner) longitude of Range R at a given latitude.
 */
function rangeWestLon(range: number, latDeg: number): number {
  return W5M_LON - range * rangeWidthDeg(latDeg);
}

/**
 * Section (col, row) from section number (1-36).
 * Section 1 = SE corner. Snake pattern: row 0 goes E→W, row 1 goes W→E, etc.
 * Returns col_from_west (0=west, 5=east), row (0=south, 5=north).
 */
function sectionPosition(sec: number): { col: number; row: number } {
  const row = Math.floor((sec - 1) / 6);
  const posInRow = (sec - 1) % 6;
  // Even rows (0,2,4): section counts east-to-west, so pos 0 = col 5 (east)
  const colFromWest = row % 2 === 0 ? 5 - posInRow : posInRow;
  return { col: colFromWest, row };
}

/**
 * LSD (col, row) from LSD number (1-16).
 * LSD 1 = SE corner. Snake pattern.
 * Returns col_from_west (0=west, 3=east), row (0=south, 3=north).
 */
function lsdPosition(lsd: number): { col: number; row: number } {
  const row = Math.floor((lsd - 1) / 4);
  const posInRow = (lsd - 1) % 4;
  // Even rows (0,2): LSD counts east-to-west, so pos 0 = col 3 (east)
  const colFromWest = row % 2 === 0 ? 3 - posInRow : posInRow;
  return { col: colFromWest, row };
}

// ---- Grid Line Types ---- //
export type GridLevel = 'township' | 'section' | 'lsd';

interface GridLineProps {
  level: GridLevel;
}

interface GridLabelProps {
  level: GridLevel;
  label: string;
  township: number;
  range: number;
  section?: number;
}

// ---- Grid Generator ---- //

function boundsToTwpRange(
  bounds: { west: number; south: number; east: number; north: number },
): { twpMin: number; twpMax: number; rngMin: number; rngMax: number } {
  const twpMin = Math.max(1, Math.floor((bounds.south - BASELINE_LAT) / TWP_HEIGHT_DEG));
  const twpMax = Math.ceil((bounds.north - BASELINE_LAT) / TWP_HEIGHT_DEG) + 2;

  const midLat = (bounds.south + bounds.north) / 2;
  const rw = rangeWidthDeg(midLat);

  // bounds.east is less negative (further east), bounds.west is more negative (further west)
  // Range number = how many range widths west of the meridian
  const rngFromEast = Math.max(1, Math.floor((W5M_LON - bounds.east) / rw));
  const rngFromWest = Math.ceil((W5M_LON - bounds.west) / rw) + 2;

  return {
    twpMin: Math.max(1, twpMin),
    twpMax,
    rngMin: Math.max(1, rngFromEast),
    rngMax: rngFromWest,
  };
}

/**
 * Generate township grid lines and labels for the visible area.
 */
export function generateTownshipGrid(
  bounds: { west: number; south: number; east: number; north: number },
): { lines: FeatureCollection<LineString, GridLineProps>; labels: FeatureCollection<Point, GridLabelProps> } {
  const { twpMin, twpMax, rngMin, rngMax } = boundsToTwpRange(bounds);
  const lines: Feature<LineString, GridLineProps>[] = [];
  const labels: Feature<Point, GridLabelProps>[] = [];

  // Horizontal lines (township boundaries — constant latitude)
  for (let t = twpMin; t <= twpMax + 1; t++) {
    const lat = twpSouthLat(t);
    if (lat < bounds.south - 0.2 || lat > bounds.north + 0.2) continue;
    lines.push({
      type: 'Feature',
      properties: { level: 'township' },
      geometry: {
        type: 'LineString',
        coordinates: [[bounds.west - 0.1, lat], [bounds.east + 0.1, lat]],
      },
    });
  }

  // Vertical lines (range boundaries)
  // Each range boundary is a line of constant "range edge" that varies with latitude
  // We need boundaries at: east edge of rngMin, ..., west edge of rngMax
  // East edge of range R = W5M - (R-1) * rw(lat)
  // This means: range boundary between R-1 and R is at W5M - (R-1) * rw(lat)
  for (let r = rngMin; r <= rngMax + 1; r++) {
    const pts: [number, number][] = [];
    for (let lat = bounds.south - 0.1; lat <= bounds.north + 0.2; lat += 0.02) {
      pts.push([rangeEastLon(r, lat), lat]);
    }
    const finalLat = bounds.north + 0.2;
    pts.push([rangeEastLon(r, finalLat), finalLat]);

    if (pts.length >= 2) {
      lines.push({
        type: 'Feature',
        properties: { level: 'township' },
        geometry: { type: 'LineString', coordinates: pts },
      });
    }
  }

  // Labels at center of each visible township
  for (let t = twpMin; t <= twpMax; t++) {
    const centerLat = twpSouthLat(t) + TWP_HEIGHT_DEG / 2;
    for (let r = rngMin; r <= rngMax; r++) {
      const rw = rangeWidthDeg(centerLat);
      // Center lon = midpoint between east and west edges
      const eastEdge = rangeEastLon(r, centerLat);
      const centerLon = eastEdge - rw / 2;
      if (centerLon < bounds.west || centerLon > bounds.east || centerLat < bounds.south || centerLat > bounds.north) continue;
      labels.push({
        type: 'Feature',
        properties: {
          level: 'township',
          label: `Twp ${t} Rge ${r} W5`,
          township: t,
          range: r,
        },
        geometry: { type: 'Point', coordinates: [centerLon, centerLat] },
      });
    }
  }

  return {
    lines: { type: 'FeatureCollection', features: lines },
    labels: { type: 'FeatureCollection', features: labels },
  };
}

/**
 * Generate section grid lines within visible townships.
 */
export function generateSectionGrid(
  bounds: { west: number; south: number; east: number; north: number },
): { lines: FeatureCollection<LineString, GridLineProps>; labels: FeatureCollection<Point, GridLabelProps> } {
  const { twpMin, twpMax, rngMin, rngMax } = boundsToTwpRange(bounds);
  const lines: Feature<LineString, GridLineProps>[] = [];
  const labels: Feature<Point, GridLabelProps>[] = [];

  const secHeight = TWP_HEIGHT_DEG / 6;

  for (let t = twpMin; t <= twpMax; t++) {
    const tSouthLat = twpSouthLat(t);
    const tCenterLat = tSouthLat + TWP_HEIGHT_DEG / 2;

    for (let r = rngMin; r <= rngMax; r++) {
      const rw = rangeWidthDeg(tCenterLat);
      const tWestLon = rangeWestLon(r, tCenterLat); // SW corner longitude
      const secWidth = rw / 6;

      // Horizontal section lines (5 interior lines per township)
      for (let row = 1; row <= 5; row++) {
        const lat = tSouthLat + row * secHeight;
        if (lat < bounds.south - 0.02 || lat > bounds.north + 0.02) continue;
        lines.push({
          type: 'Feature',
          properties: { level: 'section' },
          geometry: {
            type: 'LineString',
            coordinates: [
              [tWestLon, lat],
              [tWestLon + rw, lat], // west to east
            ],
          },
        });
      }

      // Vertical section lines (5 interior lines per township)
      for (let col = 1; col <= 5; col++) {
        const lon = tWestLon + col * secWidth;
        if (lon < bounds.west - 0.02 || lon > bounds.east + 0.02) continue;
        lines.push({
          type: 'Feature',
          properties: { level: 'section' },
          geometry: {
            type: 'LineString',
            coordinates: [
              [lon, tSouthLat],
              [lon, tSouthLat + TWP_HEIGHT_DEG],
            ],
          },
        });
      }

      // Section labels
      for (let sec = 1; sec <= 36; sec++) {
        const { col, row } = sectionPosition(sec);
        const cLat = tSouthLat + (row + 0.5) * secHeight;
        const cLon = tWestLon + (col + 0.5) * secWidth;
        if (cLon < bounds.west || cLon > bounds.east || cLat < bounds.south || cLat > bounds.north) continue;
        labels.push({
          type: 'Feature',
          properties: {
            level: 'section',
            label: String(sec),
            township: t,
            range: r,
            section: sec,
          },
          geometry: { type: 'Point', coordinates: [cLon, cLat] },
        });
      }
    }
  }

  return {
    lines: { type: 'FeatureCollection', features: lines },
    labels: { type: 'FeatureCollection', features: labels },
  };
}

/**
 * Generate LSD grid lines within visible sections.
 */
export function generateLSDGrid(
  bounds: { west: number; south: number; east: number; north: number },
): { lines: FeatureCollection<LineString, GridLineProps>; labels: FeatureCollection<Point, GridLabelProps> } {
  const { twpMin, twpMax, rngMin, rngMax } = boundsToTwpRange(bounds);
  const lines: Feature<LineString, GridLineProps>[] = [];
  const labels: Feature<Point, GridLabelProps>[] = [];

  const secHeight = TWP_HEIGHT_DEG / 6;
  const lsdHeight = secHeight / 4;

  for (let t = twpMin; t <= twpMax; t++) {
    const tSouthLat = twpSouthLat(t);
    const tCenterLat = tSouthLat + TWP_HEIGHT_DEG / 2;

    for (let r = rngMin; r <= rngMax; r++) {
      const rw = rangeWidthDeg(tCenterLat);
      const tWestLon = rangeWestLon(r, tCenterLat);
      const secWidth = rw / 6;
      const lsdWidth = secWidth / 4;

      for (let sec = 1; sec <= 36; sec++) {
        const { col: sCol, row: sRow } = sectionPosition(sec);
        const secSouthLat = tSouthLat + sRow * secHeight;
        const secWestLon = tWestLon + sCol * secWidth;

        // Skip sections entirely outside bounds
        if (
          secWestLon + secWidth < bounds.west - 0.01 ||
          secWestLon > bounds.east + 0.01 ||
          secSouthLat + secHeight < bounds.south - 0.01 ||
          secSouthLat > bounds.north + 0.01
        ) continue;

        // Interior horizontal LSD lines (3 per section)
        for (let row = 1; row <= 3; row++) {
          const lat = secSouthLat + row * lsdHeight;
          lines.push({
            type: 'Feature',
            properties: { level: 'lsd' },
            geometry: {
              type: 'LineString',
              coordinates: [
                [secWestLon, lat],
                [secWestLon + secWidth, lat],
              ],
            },
          });
        }

        // Interior vertical LSD lines (3 per section)
        for (let col = 1; col <= 3; col++) {
          const lon = secWestLon + col * lsdWidth;
          lines.push({
            type: 'Feature',
            properties: { level: 'lsd' },
            geometry: {
              type: 'LineString',
              coordinates: [
                [lon, secSouthLat],
                [lon, secSouthLat + secHeight],
              ],
            },
          });
        }

        // LSD labels
        for (let lsd = 1; lsd <= 16; lsd++) {
          const { col: lCol, row: lRow } = lsdPosition(lsd);
          const cLat = secSouthLat + (lRow + 0.5) * lsdHeight;
          const cLon = secWestLon + (lCol + 0.5) * lsdWidth;
          if (cLon < bounds.west || cLon > bounds.east || cLat < bounds.south || cLat > bounds.north) continue;
          labels.push({
            type: 'Feature',
            properties: {
              level: 'lsd',
              label: String(lsd),
              township: t,
              range: r,
              section: sec,
            },
            geometry: { type: 'Point', coordinates: [cLon, cLat] },
          });
        }
      }
    }
  }

  return {
    lines: { type: 'FeatureCollection', features: lines },
    labels: { type: 'FeatureCollection', features: labels },
  };
}

/** Empty GeoJSON feature collection */
function emptyFC<G extends LineString | Point, P>(): FeatureCollection<G, P> {
  return { type: 'FeatureCollection', features: [] };
}

/**
 * Master function: generate all grid layers appropriate for the current zoom level.
 *
 * - Zoom < 10:  township grid only
 * - Zoom 10-12: township + section grids
 * - Zoom >= 13: township + section + LSD grids
 */
export function generateDLSGrid(
  bounds: { west: number; south: number; east: number; north: number },
  zoom: number,
): {
  townshipLines: FeatureCollection<LineString, GridLineProps>;
  townshipLabels: FeatureCollection<Point, GridLabelProps>;
  sectionLines: FeatureCollection<LineString, GridLineProps>;
  sectionLabels: FeatureCollection<Point, GridLabelProps>;
  lsdLines: FeatureCollection<LineString, GridLineProps>;
  lsdLabels: FeatureCollection<Point, GridLabelProps>;
} {
  const twp = generateTownshipGrid(bounds);

  const sec = zoom >= 10
    ? generateSectionGrid(bounds)
    : { lines: emptyFC<LineString, GridLineProps>(), labels: emptyFC<Point, GridLabelProps>() };

  const lsd = zoom >= 13
    ? generateLSDGrid(bounds)
    : { lines: emptyFC<LineString, GridLineProps>(), labels: emptyFC<Point, GridLabelProps>() };

  return {
    townshipLines: twp.lines,
    townshipLabels: twp.labels,
    sectionLines: sec.lines,
    sectionLabels: sec.labels,
    lsdLines: lsd.lines,
    lsdLabels: lsd.labels,
  };
}
