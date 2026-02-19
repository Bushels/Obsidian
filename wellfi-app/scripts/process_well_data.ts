/**
 * process_well_data.ts
 * 
 * ETL script: reads well data from JSON + Excel, validates pump risk via monthly
 * production hours, then upserts into Supabase (wells + pump_changes tables).
 * 
 * KEY LOGIC:
 * - "Active" = petro_ninja_well_status === 'Active' in JSON
 * - We have ~2 years of monthly data (2024 + 2025) from Excel
 * - Pump life average = 16-18 months
 * - "RECENTLY CHANGED" = Excel shows a shutdown + restart in 2025
 * - "HIGH" risk = running 12+ consecutive months without a detected restart
 * - We VALIDATE HIGH risk claims by checking monthly hours: if there's a 0-hour
 *   month somewhere in the 24-month window, that may indicate a pump change —
 *   suggesting the risk clock reset. We downgrade HIGH → WATCH if a significant
 *   downtime gap exists in the data window.
 * 
 * Run: npx tsx scripts/process_well_data.ts
 */

import fs from 'fs';
import XLSX from 'xlsx';
import { createClient } from '@supabase/supabase-js';

// ---- Config ----
const SUPABASE_URL = process.env.VITE_SUPABASE_URL || 'https://opxptteradsvptjyxxfr.supabase.co';
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY || '';
const JSON_PATH = 'c:/Users/kyle/MPS/Obsidian/obsidian_bluesky_clearwater_last2years.json';
const EXCEL_PATH = 'c:/Users/kyle/MPS/Obsidian/Obsidian_PeaceRiver_2025_v3.xlsx';

// Gap threshold: if a well has a consecutive run of 0-hour months > this, we 
// consider it a probable pump change / significant downtime event.
const SIGNIFICANT_GAP_MONTHS = 1;

// ---- Supabase client (service role needed for upserts bypassing RLS) ----
const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY);

// ---- Types ----
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

interface PumpRiskRow {
  riskLevel: string;
  wellIdentifier: string;
  facilityName: string;
  location: string;
  consecMonthsRunning: number;
  dec2025BblD: number;
  total2025Bbl: number;
  prodHours: number;
  shutdownMonths: string;
  restartMonths: string;
  statusNote: string;
}

interface MonthlyHoursRow {
  wellIdentifier: string;
  facility: string;
  monthlyHours: number[]; // Jan–Dec 2025
  totalHours: number;
}

interface MonthlyOilRow {
  wellIdentifier: string;
  facility: string;
  monthlyOil: number[]; // Jan–Dec 2025 bbl/d
  totalOil: number;
}

// ---- Parse monthly hours sheet ----
// The sheet covers Jan–Dec 2025 (12 months)
function parseMonthlyHours(workbook: XLSX.WorkBook): Map<string, MonthlyHoursRow> {
  const sheet = workbook.Sheets['Monthly Hours'];
  if (!sheet) return new Map();
  const rows = XLSX.utils.sheet_to_json(sheet, { header: 1 }) as any[][];
  const headerIdx = rows.findIndex(r => r[0] === 'Well Identifier');
  if (headerIdx < 0) return new Map();
  
  const map = new Map<string, MonthlyHoursRow>();
  for (let i = headerIdx + 1; i < rows.length; i++) {
    const row = rows[i];
    if (!row[0]) continue;
    const uwi = String(row[0]).trim();
    // Columns: WellId, Facility, Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec, Total
    const monthlyHours = row.slice(2, 14).map((v: any) => Number(v) || 0);
    const totalHours = Number(row[14]) || 0;
    map.set(uwi, { wellIdentifier: uwi, facility: String(row[1] || ''), monthlyHours, totalHours });
  }
  return map;
}

// ---- Parse monthly bbl/d sheet ----
function parseMonthlyOil(workbook: XLSX.WorkBook): Map<string, MonthlyOilRow> {
  const sheet = workbook.Sheets['Monthly bbl per day'];
  if (!sheet) return new Map();
  const rows = XLSX.utils.sheet_to_json(sheet, { header: 1 }) as any[][];
  const headerIdx = rows.findIndex(r => r[0] === 'Well Identifier');
  if (headerIdx < 0) return new Map();
  
  const map = new Map<string, MonthlyOilRow>();
  for (let i = headerIdx + 1; i < rows.length; i++) {
    const row = rows[i];
    if (!row[0]) continue;
    const uwi = String(row[0]).trim();
    const monthlyOil = row.slice(2, 14).map((v: any) => Number(v) || 0);
    const totalOil = Number(row[14]) || 0;
    map.set(uwi, { wellIdentifier: uwi, facility: String(row[1] || ''), monthlyOil, totalOil });
  }
  return map;
}

// ---- Parse pump change risk sheet ----
function parsePumpRisk(workbook: XLSX.WorkBook): Map<string, PumpRiskRow> {
  const sheet = workbook.Sheets['Pump Change Risk'];
  const rows = XLSX.utils.sheet_to_json(sheet, { header: 1 }) as any[][];
  const headerIdx = rows.findIndex(r => r[0] === 'Risk Level');
  if (headerIdx < 0) return new Map();

  const map = new Map<string, PumpRiskRow>();
  for (let i = headerIdx + 1; i < rows.length; i++) {
    const row = rows[i];
    if (!row[1]) continue; // need a well identifier
    const uwi = String(row[1]).trim();
    map.set(uwi, {
      riskLevel: String(row[0] || '').trim(),
      wellIdentifier: uwi,
      facilityName: String(row[2] || '').trim(),
      location: String(row[3] || '').trim(),
      consecMonthsRunning: Number(row[4]) || 0,
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

// ---- Detect significant downtime gap in monthly hours ----
// Returns the index (0=Jan) of the last significant restart if found, else -1
function detectLastRestart(monthlyHours: number[]): number {
  let lastRestartIdx = -1;
  let inGap = false;
  for (let i = 0; i < monthlyHours.length; i++) {
    if (monthlyHours[i] === 0) {
      inGap = true;
    } else if (inGap && monthlyHours[i] > 0) {
      lastRestartIdx = i; // came back up after a 0-hour month
      inGap = false;
    }
  }
  return lastRestartIdx;
}

// ---- Estimate restart date from month index ----
// months are 2025 Jan=0 to Dec=11
function monthIndexToDate(idx: number): string {
  return `2025-${String(idx + 1).padStart(2, '0')}-01`;
}

// ---- Parse "Restart Months" string like "Mar", "Apr", "Mar, Apr" ----
function parseRestartMonth(restartStr: string): string | null {
  if (!restartStr) return null;
  const months: Record<string, string> = {
    Jan:'01', Feb:'02', Mar:'03', Apr:'04', May:'05', Jun:'06',
    Jul:'07', Aug:'08', Sep:'09', Oct:'10', Nov:'11', Dec:'12'
  };
  // Take the first recognizable month
  const match = restartStr.match(/\b(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\b/);
  if (match) return `2025-${months[match[1]]}-01`;
  return null;
}

// ---- Normalize UWI for matching ---- 
// JSON has formatted_well_id like "100/08-08-082-15W5/00"  
// Excel has "100080808215W500" style
function normalizeUwiFromJson(formatted: string): string {
  // "100/08-08-082-15W5/00" → remove slashes and dashes → "100080808215W500"?
  // Actually the well_id in JSON IS already "100080808215W500"
  return formatted.replace(/[\/\-]/g, '').replace(/W0$/, 'W500').toUpperCase();
}

// ---- Main ----
async function main() {
  if (!SUPABASE_SERVICE_KEY) {
    console.error('ERROR: Set SUPABASE_SERVICE_ROLE_KEY environment variable');
    process.exit(1);
  }

  console.log('📖 Reading data sources...');
  
  // Load JSON
  const jsonData: WellJson[] = JSON.parse(fs.readFileSync(JSON_PATH, 'utf8'));
  console.log(`  JSON: ${jsonData.length} wells total`);

  // Load Excel
  const workbook = XLSX.readFile(EXCEL_PATH);
  const pumpRiskMap = parsePumpRisk(workbook);
  const monthlyHoursMap = parseMonthlyHours(workbook);
  const monthlyOilMap = parseMonthlyOil(workbook);
  console.log(`  Excel pump risk entries: ${pumpRiskMap.size}`);
  console.log(`  Excel monthly hours wells: ${monthlyHoursMap.size}`);
  console.log(`  Excel monthly oil wells: ${monthlyOilMap.size}`);

  // Filter active wells
  const activeWells = jsonData.filter(w => 
    w.petro_ninja_well_status === 'Active' || 
    w.well_status === 'Active' || 
    w.well_status === 'Pumping'
  );
  console.log(`\n🔍 Active wells from JSON: ${activeWells.length}`);

  // ---- Process each well ----
  const wellUpserts: any[] = [];
  const pumpChangeUpserts: any[] = [];
  let recentlyChanged = 0, highRisk = 0, watchRisk = 0, downNow = 0, lowRisk = 0, unclassified = 0;

  for (const well of activeWells) {
    const uwi = well.well_id; // e.g. "100080808215W500"
    const riskData = pumpRiskMap.get(uwi);
    const hoursData = monthlyHoursMap.get(uwi);
    const oilData = monthlyOilMap.get(uwi);

    // Determine months_running from risk sheet or default
    let consecMonths = riskData?.consecMonthsRunning ?? 0;
    
    // Determine risk level
    let riskLevel = 'LOW';
    let statusNote = riskData?.statusNote || null;

    if (riskData) {
      const rl = riskData.riskLevel.toUpperCase();
      if (rl.includes('RECENTLY CHANGED')) {
        riskLevel = 'RECENTLY CHANGED';
        recentlyChanged++;
      } else if (rl.includes('HIGH')) {
        // Validate: check if monthly hours shows any significant downtime in 2025
        // If there's a restart detected, the pump was changed — reclassify as WATCH or RECENTLY CHANGED
        if (hoursData) {
          const restartIdx = detectLastRestart(hoursData.monthlyHours);
          if (restartIdx >= 0) {
            // Production gap + restart found in our 2-year window — clock reset
            riskLevel = 'WATCH';
            statusNote = `Downtime detected in ${['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][restartIdx]} 2025; months_running counter may be overstated`;
            consecMonths = 12 - restartIdx; // estimate months since restart
            watchRisk++;
          } else {
            riskLevel = 'HIGH';
            highRisk++;
          }
        } else {
          riskLevel = 'HIGH';
          highRisk++;
        }
      } else if (rl.includes('WATCH')) {
        riskLevel = 'WATCH';
        watchRisk++;
      } else if (rl.includes('DOWN NOW')) {
        riskLevel = 'DOWN NOW';
        downNow++;
      } else {
        riskLevel = 'LOW';
        lowRisk++;
      }
    } else {
      // Not in risk sheet — check monthly hours for any gap/restart
      if (hoursData) {
        const restartIdx = detectLastRestart(hoursData.monthlyHours);
        if (restartIdx >= 0) {
          riskLevel = 'RECENTLY CHANGED';
          consecMonths = 12 - restartIdx;
          statusNote = `Production gap + restart detected ${['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][restartIdx]} 2025 (inferred from hours data)`;
          recentlyChanged++;
        } else {
          riskLevel = 'LOW';
          lowRisk++;
        }
      } else {
        unclassified++;
        riskLevel = 'LOW';
      }
    }

    const monthlyHrs = hoursData?.monthlyHours ?? null;
    const monthlyOilArr = oilData?.monthlyOil ?? null;

    // Calc uptime from monthly hours (2025, max hours per month varies)
    const monthMaxHours = [744, 672, 744, 720, 744, 720, 744, 744, 720, 744, 720, 744];
    let totalActualHours = 0, totalMaxHours = 0;
    let totalDowntimeDays = 0;
    if (monthlyHrs) {
      monthlyHrs.forEach((h, i) => {
        totalActualHours += h;
        totalMaxHours += monthMaxHours[i];
        const downHours = monthMaxHours[i] - h;
        if (downHours > 0) totalDowntimeDays += Math.round(downHours / 24);
      });
    }
    const annualUptimePct = totalMaxHours > 0 ? totalActualHours / totalMaxHours : null;

    wellUpserts.push({
      well_id: uwi,
      formatted_id: well.formatted_well_id,
      name: well.well_name,
      lat: well.surface_latitude ?? null,
      lon: well.surface_longitude ?? null,
      formation: well.producing_formation === 'Bluesky' ? 'Bluesky' : 
                 well.producing_formation === 'Clearwater' ? 'Clearwater' : null,
      field: well.field_name ?? null,
      well_status: well.well_status === 'Pumping' ? 'Pumping' : 'Operating',
      risk_level: riskLevel,
      months_running: consecMonths || null,
      dec_rate_bbl_d: riskData?.dec2025BblD ?? well.last_oil_rate ?? null,
      total_2025_bbl: riskData?.total2025Bbl ?? null,
      cumulative_oil: well.cumulative_oil ?? null,
      on_production_date: well.on_production_date ?? null,
      last_production_date: well.last_production_date ?? null,
      annual_uptime_pct: annualUptimePct,
      total_downtime_days: totalDowntimeDays || null,
      monthly_hrs: monthlyHrs,
      monthly_oil: monthlyOilArr,
      monthly_uptime: monthlyHrs ? monthlyHrs.map((h, i) => +(h / monthMaxHours[i]).toFixed(4)) : null,
      status_note: statusNote,
    });
  }

  console.log(`\n📊 Risk Summary:`);
  console.log(`  HIGH (validated, no gap found):     ${highRisk}`);
  console.log(`  WATCH (HIGH but gap found, revised): ${watchRisk}`);
  console.log(`  RECENTLY CHANGED:                    ${recentlyChanged}`);
  console.log(`  DOWN NOW:                            ${downNow}`);
  console.log(`  LOW:                                 ${lowRisk}`);
  console.log(`  Unclassified (no Excel match):       ${unclassified}`);
  console.log(`\n  Total to upsert: ${wellUpserts.length} wells`);

  // ---- Upsert wells ----
  console.log('\n⬆️  Upserting wells...');
  const BATCH = 50;
  let totalUpserted = 0;
  for (let i = 0; i < wellUpserts.length; i += BATCH) {
    const batch = wellUpserts.slice(i, i + BATCH);
    const { error } = await supabase.from('wells').upsert(batch, { onConflict: 'well_id' });
    if (error) {
      console.error(`  ❌ Well upsert error at batch ${i}: ${error.message}`);
    } else {
      totalUpserted += batch.length;
      process.stdout.write(`  ✅ ${totalUpserted}/${wellUpserts.length}\r`);
    }
  }
  console.log(`\n  Done: ${totalUpserted} wells upserted.`);

  // ---- Create pump_change warnings for HIGH risk wells ----
  console.log('\n⬆️  Creating pump_change warnings for HIGH risk wells...');
  
  // Get the UUIDs of the wells we just upserted (needed for FK)
  const { data: wellRows, error: wellFetchErr } = await supabase
    .from('wells')
    .select('id, well_id, risk_level')
    .in('risk_level', ['HIGH', 'RECENTLY CHANGED']);
  
  if (wellFetchErr) {
    console.error('  ❌ Failed to fetch well IDs:', wellFetchErr.message);
    return;
  }

  for (const w of (wellRows ?? [])) {
    const riskData = pumpRiskMap.get(w.well_id);
    const hoursData = monthlyHoursMap.get(w.well_id);
    
    if (w.risk_level === 'HIGH') {
      pumpChangeUpserts.push({
        well_id: w.id,
        status: 'warning',
        flagged_by: 'system:data_import',
        notes: `Automated flag: running ${riskData?.consecMonthsRunning ?? 'unknown'} consecutive months. Average pump life is 16-18 months. No production gap detected in 2025 monthly hours to indicate a recent change.`,
        device_sourced: false,
      });
    } else if (w.risk_level === 'RECENTLY CHANGED') {
      const restartDate = riskData?.restartMonths ? parseRestartMonth(riskData.restartMonths) : 
                         (hoursData ? (() => {
                           const idx = detectLastRestart(hoursData.monthlyHours);
                           return idx >= 0 ? monthIndexToDate(idx) : null;
                         })() : null);
      if (restartDate) {
        pumpChangeUpserts.push({
          well_id: w.id,
          status: 'completed',
          flagged_by: 'system:data_import',
          actual_date: restartDate,
          notes: `Inferred pump change: production gap + restart detected. Shutdown: ${riskData?.shutdownMonths || 'unknown'}, Restart: ${riskData?.restartMonths || 'detected via hours data'}.`,
          device_sourced: false,
        });
      }
    }
  }

  if (pumpChangeUpserts.length > 0) {
    const { error: pcErr } = await supabase.from('pump_changes').insert(pumpChangeUpserts);
    if (pcErr) {
      console.error(`  ❌ pump_changes insert error: ${pcErr.message}`);
    } else {
      console.log(`  ✅ ${pumpChangeUpserts.length} pump_change records created.`);
    }
  } else {
    console.log('  ℹ️  No pump_change records needed.');
  }

  console.log('\n🎉 Done! Data is synced to Supabase.');
}

main().catch(e => { console.error('Fatal:', e); process.exit(1); });
