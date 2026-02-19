#!/usr/bin/env python3
"""
Extract downhole component depths from WellView PDF profiles/schematics and
generate src/lib/schematicDepths.ts.

Run:
  python3 scripts/extract_schematic_depths.py
"""

from __future__ import annotations

import json
import os
import re
import shutil
import subprocess
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable


ROOT = Path(__file__).resolve().parents[1]
OUTPUT_TS = ROOT / "src" / "lib" / "schematicDepths.ts"
DEFAULT_WELL_DATA_DIRS = [
  Path("/mnt/c/Users/kyle/OneDrive - MPS Welding Inc/Obsidian/Well Data"),
  Path("C:/Users/kyle/OneDrive - MPS Welding Inc/Obsidian/Well Data"),
]


def resolve_well_data_dir() -> Path:
  env_value = os.environ.get("WELL_DATA_DIR")
  if env_value:
    return Path(env_value)
  for candidate in DEFAULT_WELL_DATA_DIRS:
    if candidate.exists():
      return candidate
  return DEFAULT_WELL_DATA_DIRS[0]


def resolve_pdf_tool() -> str:
  env_value = os.environ.get("PDFTOTEXT_BIN")
  if env_value:
    return env_value

  which_tool = shutil.which("pdftotext")
  if which_tool:
    return which_tool

  fallback = "/usr/bin/pdftotext"
  return fallback


WELL_DATA_DIR = resolve_well_data_dir()
PDF_TOOL = resolve_pdf_tool()


@dataclass
class ComponentRange:
  name: str
  top_m: float
  bottom_m: float
  length_m: float


@dataclass
class SchematicDepthEntry:
  source_file: str
  source_uwi: str | None
  match_tokens: list[str]
  total_depth_m: float | None
  pump: ComponentRange | None
  slotted_tag_bar: ComponentRange | None
  no_turn_tool: ComponentRange | None
  wellfi_tool: ComponentRange | None


def normalize_token(value: str) -> str:
  return re.sub(r"[^A-Za-z0-9]", "", value).upper()


def token_stem(token: str) -> str:
  # Collapse well-event suffix (e.g. W509/W500 -> W5) for cross-source matching.
  return re.sub(r"(W[0-9])(?:[0-9]{2,3})$", r"\1", normalize_token(token))


def unique(values: Iterable[str]) -> list[str]:
  out: list[str] = []
  seen: set[str] = set()
  for value in values:
    if not value:
      continue
    if value in seen:
      continue
    seen.add(value)
    out.append(value)
  return out


def parse_pdf_text(pdf_path: Path) -> str:
  return subprocess.check_output(
    [PDF_TOOL, "-layout", str(pdf_path), "-"],
    text=True,
    encoding="utf-8",
    errors="ignore",
  )


def extract_uwi(text: str) -> str | None:
  m = re.search(r"(\d{3}/\d{2}-\d{2}-\d{3}-\d{2}W\d(?:/\d{2,3})?)", text)
  return m.group(1) if m else None


def extract_filename_token(pdf_name: str) -> str | None:
  normalized = normalize_token(pdf_name)
  m = re.search(r"(1\d{2}\d{2}\d{3}\d{2}W\d(?:[0-9]{2,3})?)", normalized)
  if m:
    return m.group(1)
  m = re.search(r"([0-9]{9,}W\d(?:[0-9]{2,3})?)", normalized)
  return m.group(1) if m else None


def extract_component_rows(text: str) -> list[ComponentRange]:
  # Typical line in WellView export:
  # "Slotted Tag Bar; 839.75-840.67; 0.92; ..."
  number = r"([0-9]+(?:\.[0-9]+)?)"
  row_re = re.compile(
    rf"(?:^|\n)\s*([^\n;]{{2,180}}(?:\n\s*[^\n;]{{1,180}}){{0,2}})\s*;\s*"
    rf"{number}\s*-\s*{number}\s*;\s*{number}",
    re.IGNORECASE,
  )

  rows: list[ComponentRange] = []
  for m in row_re.finditer(text):
    raw_name = " ".join(m.group(1).split())
    # Remove leading axis depth artifacts, e.g. "831.7 Stator ..."
    raw_name = re.sub(r"^\d+(?:\.\d+)?\s+", "", raw_name)
    top_m = float(m.group(2))
    bottom_m = float(m.group(3))
    length_m = float(m.group(4))
    rows.append(
      ComponentRange(
        name=raw_name,
        top_m=min(top_m, bottom_m),
        bottom_m=max(top_m, bottom_m),
        length_m=abs(length_m),
      )
    )

  deduped: dict[tuple[str, float, float], ComponentRange] = {}
  for row in rows:
    key = (row.name, row.top_m, row.bottom_m)
    deduped[key] = row
  return list(deduped.values())


def pick_component(
  rows: list[ComponentRange],
  name_patterns: list[str],
  min_length_m: float = 0.0,
  min_top_m: float = 0.0,
  reject_patterns: list[str] | None = None,
) -> ComponentRange | None:
  reject_patterns = reject_patterns or []
  candidates: list[ComponentRange] = []

  for row in rows:
    name = row.name
    if row.length_m < min_length_m:
      continue
    if row.top_m < min_top_m:
      continue
    if not any(re.search(p, name, re.IGNORECASE) for p in name_patterns):
      continue
    if any(re.search(p, name, re.IGNORECASE) for p in reject_patterns):
      continue
    candidates.append(row)

  if not candidates:
    return None

  # Select deepest matching component.
  candidates.sort(key=lambda r: (r.top_m, r.bottom_m, r.length_m), reverse=True)
  return candidates[0]


def extract_total_depth(text: str, component_rows: list[ComponentRange]) -> float | None:
  values = [float(v.replace(",", "")) for v in re.findall(r"\b\d{1,3}(?:,\d{3})*(?:\.\d+)\b", text)]
  # Keep realistic depth-like values; exclude pressures and tiny values.
  values = [v for v in values if 300.0 <= v <= 6000.0]
  max_candidate = max(values) if values else None

  max_component_bottom = max((row.bottom_m for row in component_rows), default=0.0)
  if max_candidate is None:
    return max_component_bottom + 120.0 if max_component_bottom > 0 else None
  return max(max_candidate, max_component_bottom + 30.0)


def to_dict_component(value: ComponentRange | None) -> dict[str, float | str] | None:
  if value is None:
    return None
  return {
    "name": value.name,
    "top_m": round(value.top_m, 2),
    "bottom_m": round(value.bottom_m, 2),
    "length_m": round(value.length_m, 2),
  }


def build_entry(pdf_path: Path) -> SchematicDepthEntry | None:
  text = parse_pdf_text(pdf_path)
  rows = extract_component_rows(text)
  if not rows:
    return None

  uwi = extract_uwi(text)
  filename_token = extract_filename_token(pdf_path.name)

  pump = pick_component(
    rows,
    name_patterns=[r"\bstator\b", r"\brotor\b", r"\bpump\b"],
    min_length_m=1.0,
    min_top_m=100.0,
    reject_patterns=[r"cement", r"casing", r"pressure", r"test", r"sweep", r"scav"],
  )
  slotted = pick_component(rows, [r"slotted\s+tag\s+bar"], min_length_m=0.3, min_top_m=100.0)
  no_turn = pick_component(rows, [r"no\s*turn\s+tool"], min_length_m=0.3, min_top_m=100.0)
  wellfi = pick_component(rows, [r"\bwellfi\b", r"wf[-\s]*tool"], min_length_m=0.2, min_top_m=100.0)

  if pump:
    pump = ComponentRange(
      name="Pump Section",
      top_m=pump.top_m,
      bottom_m=pump.bottom_m,
      length_m=pump.length_m,
    )
  if slotted:
    slotted = ComponentRange(
      name="Slotted Tag Bar",
      top_m=slotted.top_m,
      bottom_m=slotted.bottom_m,
      length_m=slotted.length_m,
    )
  if no_turn:
    no_turn = ComponentRange(
      name="No Turn Tool",
      top_m=no_turn.top_m,
      bottom_m=no_turn.bottom_m,
      length_m=no_turn.length_m,
    )
  if wellfi:
    wellfi = ComponentRange(
      name="WellFi Tool",
      top_m=wellfi.top_m,
      bottom_m=wellfi.bottom_m,
      length_m=wellfi.length_m,
    )

  # Skip files that don't give us actionable tool positions.
  if slotted is None and no_turn is None and pump is None and wellfi is None:
    return None

  tokens = unique([
    normalize_token(uwi) if uwi else "",
    token_stem(uwi) if uwi else "",
    normalize_token(filename_token) if filename_token else "",
    token_stem(filename_token) if filename_token else "",
  ])

  return SchematicDepthEntry(
    source_file=pdf_path.name,
    source_uwi=uwi,
    match_tokens=tokens,
    total_depth_m=extract_total_depth(text, rows),
    pump=pump,
    slotted_tag_bar=slotted,
    no_turn_tool=no_turn,
    wellfi_tool=wellfi,
  )


def format_ts(entries: list[SchematicDepthEntry]) -> str:
  payload = []
  for entry in entries:
    payload.append(
      {
        "source_file": entry.source_file,
        "source_uwi": entry.source_uwi,
        "match_tokens": entry.match_tokens,
        "total_depth_m": round(entry.total_depth_m, 2) if entry.total_depth_m is not None else None,
        "pump": to_dict_component(entry.pump),
        "slotted_tag_bar": to_dict_component(entry.slotted_tag_bar),
        "no_turn_tool": to_dict_component(entry.no_turn_tool),
        "wellfi_tool": to_dict_component(entry.wellfi_tool),
      }
    )

  json_blob = json.dumps(payload, indent=2)
  return (
    "// Auto-generated by scripts/extract_schematic_depths.py. Do not edit manually.\n"
    "export interface SchematicComponentRange {\n"
    "  name: string;\n"
    "  top_m: number;\n"
    "  bottom_m: number;\n"
    "  length_m: number;\n"
    "}\n\n"
    "export interface SchematicDepthEntry {\n"
    "  source_file: string;\n"
    "  source_uwi: string | null;\n"
    "  match_tokens: string[];\n"
    "  total_depth_m: number | null;\n"
    "  pump: SchematicComponentRange | null;\n"
    "  slotted_tag_bar: SchematicComponentRange | null;\n"
    "  no_turn_tool: SchematicComponentRange | null;\n"
    "  wellfi_tool: SchematicComponentRange | null;\n"
    "}\n\n"
    f"export const SCHEMATIC_DEPTHS: SchematicDepthEntry[] = {json_blob};\n"
  )


def main() -> None:
  if not WELL_DATA_DIR.exists():
    raise FileNotFoundError(f"Well data directory not found: {WELL_DATA_DIR}")
  if shutil.which(PDF_TOOL) is None and not Path(PDF_TOOL).exists():
    raise FileNotFoundError(f"pdftotext not found at: {PDF_TOOL}")

  # Be tolerant to naming differences from vendor exports and manual renames.
  name_pattern = re.compile(
    r"(downhole.*well.*profile|well.*profile|dh.*schematic|downhole.*schematic|schematic)",
    re.IGNORECASE,
  )
  pdfs = [pdf for pdf in sorted(WELL_DATA_DIR.glob("*.pdf")) if name_pattern.search(pdf.name)]
  entries: list[SchematicDepthEntry] = []
  for pdf in pdfs:
    try:
      entry = build_entry(pdf)
      if entry:
        entries.append(entry)
    except Exception as exc:  # noqa: BLE001
      print(f"Skipping {pdf.name}: {exc}")

  OUTPUT_TS.write_text(format_ts(entries), encoding="utf-8")
  print(f"Generated {OUTPUT_TS} with {len(entries)} entries")
  for entry in entries:
    print(f"- {entry.source_file}: tokens={entry.match_tokens}")


if __name__ == "__main__":
  main()
