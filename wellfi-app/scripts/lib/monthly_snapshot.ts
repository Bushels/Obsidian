export interface MonthlySnapshotRowLike {
  uwi?: unknown;
  operator_licensee?: unknown;
  last_production_date?: unknown;
  recent_oil?: unknown;
  recent_gas?: unknown;
  surface_latitude?: unknown;
  surface_longitude?: unknown;
}

export interface MonthlySnapshotDedupeSummary {
  totalRows: number;
  uniqueRows: number;
  duplicateRowsCollapsed: number;
  duplicateWellCount: number;
  sampleDuplicateWellIds: string[];
}

function normalizeText(value: unknown): string {
  return String(value ?? '').trim();
}

function normalizeUwi(value: unknown): string {
  return normalizeText(value).toUpperCase().replace(/[^A-Z0-9]/g, '');
}

function toNumber(value: unknown): number {
  const parsed = Number(value);
  return Number.isFinite(parsed) ? parsed : 0;
}

function parseDateScore(value: unknown): number {
  const text = normalizeText(value);
  if (!text) return Number.NEGATIVE_INFINITY;

  const parsed = Date.parse(text);
  return Number.isFinite(parsed) ? parsed : Number.NEGATIVE_INFINITY;
}

function hasCoordinates(row: MonthlySnapshotRowLike): boolean {
  const lat = toNumber(row.surface_latitude);
  const lon = toNumber(row.surface_longitude);
  return Number.isFinite(lat) && Number.isFinite(lon) && (lat !== 0 || lon !== 0);
}

function productionScore(row: MonthlySnapshotRowLike): number {
  return toNumber(row.recent_oil) + toNumber(row.recent_gas);
}

function compareRows(
  candidate: MonthlySnapshotRowLike,
  incumbent: MonthlySnapshotRowLike,
  candidateIndex: number,
  incumbentIndex: number,
): number {
  const dateDelta = parseDateScore(candidate.last_production_date) - parseDateScore(incumbent.last_production_date);
  if (dateDelta !== 0) {
    return dateDelta;
  }

  const productionDelta = productionScore(candidate) - productionScore(incumbent);
  if (productionDelta !== 0) {
    return productionDelta;
  }

  const coordDelta = Number(hasCoordinates(candidate)) - Number(hasCoordinates(incumbent));
  if (coordDelta !== 0) {
    return coordDelta;
  }

  const operatorDelta = normalizeText(candidate.operator_licensee).localeCompare(
    normalizeText(incumbent.operator_licensee),
  );
  if (operatorDelta !== 0) {
    return operatorDelta;
  }

  // Prefer the later row when all meaningful fields tie.
  return candidateIndex - incumbentIndex;
}

export function deriveSnapshotMonth<T extends MonthlySnapshotRowLike>(rows: T[]): string | null {
  let latestScore = Number.NEGATIVE_INFINITY;

  for (const row of rows) {
    const score = parseDateScore(row.last_production_date);
    if (score > latestScore) {
      latestScore = score;
    }
  }

  if (!Number.isFinite(latestScore)) {
    return null;
  }

  const latestDate = new Date(latestScore);
  const year = latestDate.getUTCFullYear();
  const month = String(latestDate.getUTCMonth() + 1).padStart(2, '0');
  return `${year}-${month}-01`;
}

export function dedupeMonthlySnapshotRows<T extends MonthlySnapshotRowLike>(rows: T[]): {
  rows: T[];
  summary: MonthlySnapshotDedupeSummary;
} {
  const winners = new Map<string, { row: T; index: number; duplicateCount: number }>();
  const uniqueRowsWithoutUwi: Array<{ row: T; index: number }> = [];

  rows.forEach((row, index) => {
    const wellId = normalizeUwi(row.uwi);

    if (!wellId) {
      uniqueRowsWithoutUwi.push({ row, index });
      return;
    }

    const existing = winners.get(wellId);
    if (!existing) {
      winners.set(wellId, { row, index, duplicateCount: 0 });
      return;
    }

    existing.duplicateCount += 1;

    if (compareRows(row, existing.row, index, existing.index) > 0) {
      winners.set(wellId, {
        row,
        index,
        duplicateCount: existing.duplicateCount,
      });
    }
  });

  const dedupedRows = [
    ...uniqueRowsWithoutUwi,
    ...[...winners.values()].map((entry) => ({ row: entry.row, index: entry.index })),
  ]
    .sort((left, right) => left.index - right.index)
    .map((entry) => entry.row);

  const duplicateEntries = [...winners.entries()].filter(([, entry]) => entry.duplicateCount > 0);

  return {
    rows: dedupedRows,
    summary: {
      totalRows: rows.length,
      uniqueRows: dedupedRows.length,
      duplicateRowsCollapsed: duplicateEntries.reduce(
        (sum, [, entry]) => sum + entry.duplicateCount,
        0,
      ),
      duplicateWellCount: duplicateEntries.length,
      sampleDuplicateWellIds: duplicateEntries.slice(0, 10).map(([wellId]) => wellId),
    },
  };
}
