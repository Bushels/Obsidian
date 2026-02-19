/**
 * generate_sql.ts  
 * 
 * Reads JSON + Excel and outputs SQL upsert statements to stdout.
 * Run: npx tsx scripts/generate_sql.ts > supabase/seed_welldata.sql
 */

import fs from 'fs';
import XLSX from 'xlsx';

const JSON_PATH = 'c:/Users/kyle/MPS/Obsidian/obsidian_bluesky_clearwater_last2years.json';
const EXCEL_PATH = 'c:/Users/kyle/MPS/Obsidian/Obsidian_PeaceRiver_2025_v3.xlsx';

interface WellJson {
  well_id: string;
  formatted_well_id: string;
  well_name: string;
  petro_ninja_well_status: string;
  well_status: string;
  producing_formation: string;
  field_name: string;
  surface_latitude: number;
  surface_longitude: number;
  cumulative_oil: number;
  on_production_date: string;
  last_production_date: string;
  last_oil_rate: number;
}

function parsePumpRisk(workbook: XLSX.WorkBook): Map<string, any> {
  const rows = XLSX.utils.sheet_to_json(workbook.Sheets['Pump Change Risk'], { header: 1 }) as any[][];
  const headerIdx = rows.findIndex(r => r[0] === 'Risk Level');
  const map = new Map<string, any>();
  for (let i = headerIdx + 1; i < rows.length; i++) {
    const row = rows[i];
    if (!row[1]) continue;
    const uwi = String(row[1]).trim();
    map.set(uwi, {
      riskLevel: String(row[0] || '').trim(),
      consecMonths: Number(row[4]) || 0,
      dec2025BblD: Number(row[5]) || 0,
      total2025Bbl: Number(row[6]) || 0,
      prodHours: Number(row[7]) || 0,
      shutdownMonths: String(row[8] || '').trim(),
      restartMonths: String(row[9] || '').trim(),
      statusNote: String(row[10] || '').trim(),
    });
  }
  return map;
}

function parseMonthlyHours(workbook: XLSX.WorkBook): Map<string, number[]> {
  const rows = XLSX.utils.sheet_to_json(workbook.Sheets['Monthly Hours'], { header: 1 }) as any[][];
  const headerIdx = rows.findIndex(r => r[0] === 'Well Identifier');
  const map = new Map<string, number[]>();
  if (headerIdx < 0) return map;
  for (let i = headerIdx + 1; i < rows.length; i++) {
    const row = rows[i];
    if (!row[0]) continue;
    const uwi = String(row[0]).trim();
    // Columns: WellId, Facility, Jan..Dec, Total — always produce 12 values
    const hrs = Array.from({ length: 12 }, (_, j) => {
      const v = row[2 + j];
      return v !== undefined && v !== null && v !== '' ? Number(v) : 0;
    });
    map.set(uwi, hrs);
  }
  return map;
}


function parseMonthlyOil(workbook: XLSX.WorkBook): Map<string, (number | null)[]> {
  const rows = XLSX.utils.sheet_to_json(workbook.Sheets['Monthly bbl per day'], { header: 1 }) as any[][];
  const headerIdx = rows.findIndex(r => r[0] === 'Well Identifier');
  const map = new Map<string, (number | null)[]>();
  if (headerIdx < 0) return map;
  for (let i = headerIdx + 1; i < rows.length; i++) {
    const row = rows[i];
    if (!row[0]) continue;
    const uwi = String(row[0]).trim();
    // Use null for missing/blank cells so we can render NULL in SQL arrays
    const oil = Array.from({ length: 12 }, (_, j) => {
      const v = row[2 + j];
      if (v === undefined || v === null || v === '') return null;
      const n = Number(v);
      return isNaN(n) ? null : n;
    });
    map.set(uwi, oil);
  }
  return map;
}

function detectLastRestart(hrs: number[]): number {
  let inGap = false, lastRestart = -1;
  for (let i = 0; i < hrs.length; i++) {
    if (hrs[i] === 0) { inGap = true; }
    else if (inGap) { lastRestart = i; inGap = false; }
  }
  return lastRestart;
}

function parseRestartMonth(s: string): string | null {
  const months: Record<string,string> = {Jan:'01',Feb:'02',Mar:'03',Apr:'04',May:'05',Jun:'06',Jul:'07',Aug:'08',Sep:'09',Oct:'10',Nov:'11',Dec:'12'};
  const m = s.match(/\b(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\b/);
  return m ? `2025-${months[m[1]]}-01` : null;
}

function sqlStr(v: any): string {
  if (v === null || v === undefined) return 'NULL';
  if (typeof v === 'boolean') return v ? 'TRUE' : 'FALSE';
  if (typeof v === 'number') return isNaN(v) ? 'NULL' : String(v);
  if (Array.isArray(v)) return `ARRAY[${v.map(x => typeof x === 'number' ? (isNaN(x) ? 'NULL' : String(x)) : 'NULL').join(',')}]`;
  return `'${String(v).replace(/'/g, "''")}'`;
}

function main() {
  const jsonData: WellJson[] = JSON.parse(fs.readFileSync(JSON_PATH, 'utf8'));
  const workbook = XLSX.readFile(EXCEL_PATH);
  const riskMap = parsePumpRisk(workbook);
  const hoursMap = parseMonthlyHours(workbook);
  const oilMap = parseMonthlyOil(workbook);

  const activeWells = jsonData.filter(w =>
    w.petro_ninja_well_status === 'Active' ||
    w.well_status === 'Active' ||
    w.well_status === 'Pumping'
  );

  const monthMaxHours = [744, 672, 744, 720, 744, 720, 744, 744, 720, 744, 720, 744];
  const monthNames = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

  const pumpChangeInserts: string[] = [];
  const lines: string[] = [];
  lines.push('-- WellFi Well Data Seed');
  lines.push('-- Generated from JSON + Excel ETL');
  lines.push('-- Apply via Supabase MCP');
  lines.push('');

  for (const well of activeWells) {
    const uwi = well.well_id;
    const risk = riskMap.get(uwi);
    const hrs = hoursMap.get(uwi) ?? null;
    const oil = oilMap.get(uwi) ?? null;

    let riskLevel = 'LOW';
    let statusNote: string | null = null;
    let consecMonths = risk?.consecMonths ?? 0;

    if (risk) {
      const rl = risk.riskLevel.toUpperCase();
      if (rl.includes('RECENTLY CHANGED')) {
        riskLevel = 'RECENTLY CHANGED';
      } else if (rl.includes('HIGH')) {
        if (hrs) {
          const restartIdx = detectLastRestart(hrs);
          if (restartIdx >= 0) {
            riskLevel = 'WATCH';
            consecMonths = 12 - restartIdx;
            statusNote = `Downtime gap then restart detected in ${monthNames[restartIdx]} 2025 — months_running counter may be overstated; risk reclassified from HIGH to WATCH`;
          } else {
            riskLevel = 'HIGH';
          }
        } else {
          riskLevel = 'HIGH';
        }
      } else if (rl.includes('WATCH')) {
        riskLevel = 'WATCH';
      } else if (rl.includes('DOWN NOW')) {
        riskLevel = 'DOWN NOW';
      } else {
        riskLevel = 'LOW';
      }
    } else if (hrs) {
      const restartIdx = detectLastRestart(hrs);
      if (restartIdx >= 0) {
        riskLevel = 'RECENTLY CHANGED';
        consecMonths = 12 - restartIdx;
        statusNote = `Inferred pump change: hours gap + restart in ${monthNames[restartIdx]} 2025`;
      }
    }

    let totalActualHours = 0, totalMaxHours = 0, totalDowntimeDays = 0;
    if (hrs) {
      hrs.forEach((h, i) => {
        totalActualHours += h;
        totalMaxHours += monthMaxHours[i];
        totalDowntimeDays += Math.round((monthMaxHours[i] - h) / 24);
      });
    }
    const uptime = totalMaxHours > 0 ? +(totalActualHours / totalMaxHours).toFixed(4) : null;
    const monthlyUptime = hrs ? hrs.map((h, i) => +(h / monthMaxHours[i]).toFixed(4)) : null;

    const formation = well.producing_formation === 'Bluesky' ? 'Bluesky' :
                      well.producing_formation === 'Clearwater' ? 'Clearwater' : null;
    const wellStatus = well.well_status === 'Pumping' ? 'Pumping' : 'Operating';

    lines.push(`INSERT INTO wells (well_id, formatted_id, name, lat, lon, formation, field, well_status, risk_level, months_running, dec_rate_bbl_d, total_2025_bbl, cumulative_oil, on_production_date, last_production_date, annual_uptime_pct, total_downtime_days, monthly_hrs, monthly_oil, monthly_uptime, status_note)`);
    lines.push(`VALUES (`);
    lines.push(`  ${sqlStr(uwi)}, ${sqlStr(well.formatted_well_id)}, ${sqlStr(well.well_name)},`);
    lines.push(`  ${sqlStr(well.surface_latitude)}, ${sqlStr(well.surface_longitude)},`);
    lines.push(`  ${sqlStr(formation)}, ${sqlStr(well.field_name)},`);
    lines.push(`  ${sqlStr(wellStatus)}, ${sqlStr(riskLevel)}, ${sqlStr(consecMonths || null)},`);
    lines.push(`  ${sqlStr(risk?.dec2025BblD ?? well.last_oil_rate ?? null)},`);
    lines.push(`  ${sqlStr(risk?.total2025Bbl ?? null)}, ${sqlStr(well.cumulative_oil ?? null)},`);
    lines.push(`  ${sqlStr(well.on_production_date ?? null)}, ${sqlStr(well.last_production_date ?? null)},`);
    lines.push(`  ${sqlStr(uptime)}, ${sqlStr(totalDowntimeDays || null)},`);
    lines.push(`  ${hrs ? `ARRAY[${hrs.map(h => h).join(',')}]::int[]` : 'NULL'},`);
    lines.push(`  ${oil ? `ARRAY[${oil.map(x => x === null ? 'NULL' : x.toFixed(4)).join(',')}]::numeric[]` : 'NULL'},`);
    lines.push(`  ${monthlyUptime ? `ARRAY[${monthlyUptime.join(',')}]::numeric[]` : 'NULL'},`);
    lines.push(`  ${sqlStr(statusNote)}`);
    lines.push(`)`);
    lines.push(`ON CONFLICT (well_id) DO UPDATE SET`);
    lines.push(`  name = EXCLUDED.name, lat = EXCLUDED.lat, lon = EXCLUDED.lon,`);
    lines.push(`  formation = EXCLUDED.formation, field = EXCLUDED.field,`);
    lines.push(`  well_status = EXCLUDED.well_status, risk_level = EXCLUDED.risk_level,`);
    lines.push(`  months_running = EXCLUDED.months_running, dec_rate_bbl_d = EXCLUDED.dec_rate_bbl_d,`);
    lines.push(`  total_2025_bbl = EXCLUDED.total_2025_bbl, cumulative_oil = EXCLUDED.cumulative_oil,`);
    lines.push(`  on_production_date = EXCLUDED.on_production_date, last_production_date = EXCLUDED.last_production_date,`);
    lines.push(`  annual_uptime_pct = EXCLUDED.annual_uptime_pct, total_downtime_days = EXCLUDED.total_downtime_days,`);
    lines.push(`  monthly_hrs = EXCLUDED.monthly_hrs, monthly_oil = EXCLUDED.monthly_oil,`);
    lines.push(`  monthly_uptime = EXCLUDED.monthly_uptime, status_note = EXCLUDED.status_note,`);
    lines.push(`  updated_at = now();`);
    lines.push('');

    // pump_change entry
    if (riskLevel === 'HIGH') {
      const note = `Automated flag: ${consecMonths} consecutive months running. Avg pump life 16-18mo. No production gap detected in 2025 monthly hours.${risk?.statusNote ? ' ' + risk.statusNote : ''}`;
      pumpChangeInserts.push(`  -- HIGH risk well ${uwi}`);
      pumpChangeInserts.push(`  INSERT INTO pump_changes (well_id, status, flagged_by, notes, device_sourced)`);
      pumpChangeInserts.push(`  SELECT w.id, 'warning', 'system:data_import', ${sqlStr(note)}, FALSE`);
      pumpChangeInserts.push(`  FROM wells w WHERE w.well_id = ${sqlStr(uwi)}`);
      pumpChangeInserts.push(`  ON CONFLICT DO NOTHING;`);
    } else if (riskLevel === 'RECENTLY CHANGED') {
      let restartDate: string | null = null;
      if (risk?.restartMonths) restartDate = parseRestartMonth(risk.restartMonths);
      if (!restartDate && hrs) {
        const idx = detectLastRestart(hrs);
        if (idx >= 0) restartDate = `2025-${String(idx+1).padStart(2,'0')}-01`;
      }
      const note = `Inferred pump change. Shutdown: ${risk?.shutdownMonths || 'N/A'}, Restart: ${risk?.restartMonths || 'detected via hours'}. ${statusNote || ''}`;
      pumpChangeInserts.push(`  -- RECENTLY CHANGED well ${uwi}`);
      pumpChangeInserts.push(`  INSERT INTO pump_changes (well_id, status, flagged_by, actual_date, notes, device_sourced)`);
      pumpChangeInserts.push(`  SELECT w.id, 'completed', 'system:data_import', ${sqlStr(restartDate)}, ${sqlStr(note)}, FALSE`);
      pumpChangeInserts.push(`  FROM wells w WHERE w.well_id = ${sqlStr(uwi)}`);
      pumpChangeInserts.push(`  ON CONFLICT DO NOTHING;`);
    }
  }

  if (pumpChangeInserts.length > 0) {
    lines.push('-- Pump Change Records');
    lines.push('DO $$');
    lines.push('BEGIN');
    lines.push(pumpChangeInserts.join('\n'));
    lines.push('END $$;');
  }

  // Write to file
  const sql = lines.join('\n');
  fs.writeFileSync('supabase/seed_welldata.sql', sql);
  
  // Stats
  const counts: Record<string, number> = {};
  for (const well of activeWells) {
    const uwi = well.well_id;
    const risk = riskMap.get(uwi);
    const hrs = hoursMap.get(uwi) ?? null;
    let rl = 'LOW';
    if (risk) {
      const r = risk.riskLevel.toUpperCase();
      if (r.includes('RECENTLY CHANGED')) rl = 'RECENTLY CHANGED';
      else if (r.includes('HIGH')) {
        if (hrs && detectLastRestart(hrs) >= 0) rl = 'WATCH';
        else rl = 'HIGH';
      } else if (r.includes('WATCH')) rl = 'WATCH';
      else if (r.includes('DOWN NOW')) rl = 'DOWN NOW';
    } else if (hrs && detectLastRestart(hrs) >= 0) rl = 'RECENTLY CHANGED';
    counts[rl] = (counts[rl] || 0) + 1;
  }
  
  console.error('📊 Risk Summary:');
  Object.entries(counts).forEach(([k, v]) => console.error(`  ${k}: ${v}`));
  console.error(`\n✅ SQL written to supabase/seed_welldata.sql`);
  console.error(`   Total wells: ${activeWells.length}`);
  console.error(`   Pump changes: ${pumpChangeInserts.length / 5} records`);
}

main();
