import XLSX from 'xlsx';

type SheetCell = string | number | boolean | null | undefined;
type SheetRow = SheetCell[];

const excelPath = 'c:/Users/kyle/MPS/Obsidian/Obsidian_PeaceRiver_2025_v3.xlsx';
const workbook = XLSX.readFile(excelPath);

// ---- Pump Change Risk Sheet ----
const riskSheet = XLSX.utils.sheet_to_json(workbook.Sheets['Pump Change Risk'], { header: 1 }) as SheetRow[];
// Find the header row (row 4 based on earlier analysis)
const riskHeaderIdx = riskSheet.findIndex(row => row[0] === 'Risk Level');
const riskHeaders = riskSheet[riskHeaderIdx];
console.log('\n=== Pump Change Risk Headers ===');
console.log(riskHeaders);
// Print 10 data rows
console.log('\n=== Pump Change Risk Sample Rows ===');
for (let i = riskHeaderIdx + 1; i < Math.min(riskHeaderIdx + 11, riskSheet.length); i++) {
  const row = riskSheet[i];
  if (row.length > 0) {
    const obj: Record<string, SheetCell> = {};
    riskHeaders?.forEach((headerCell, idx) => {
      const header = String(headerCell ?? '').trim();
      if (header) {
        obj[header] = row[idx];
      }
    });
    console.log(JSON.stringify(obj));
  }
}

// ---- Monthly Hours Sheet ----
const hoursSheet = XLSX.utils.sheet_to_json(workbook.Sheets['Monthly Hours'], { header: 1 }) as SheetRow[];
const hoursHeaderIdx = hoursSheet.findIndex(row => row[0] === 'Well Identifier');
const hoursHeaders = hoursSheet[hoursHeaderIdx];
console.log('\n=== Monthly Hours Headers ===');
console.log(hoursHeaders?.map((headerCell) => String(headerCell ?? '').replace(/\r\n/g, ' ')));
// Print 3 data rows
console.log('\n=== Monthly Hours Sample Rows ===');
for (let i = hoursHeaderIdx + 1; i < Math.min(hoursHeaderIdx + 4, hoursSheet.length); i++) {
  const row = hoursSheet[i];
  if (row.length > 0) {
    const obj: Record<string, SheetCell> = {};
    hoursHeaders?.forEach((headerCell, idx) => {
      const header = String(headerCell ?? '').replace(/\r\n/g, ' ').trim();
      if (header) {
        obj[header] = row[idx];
      }
    });
    console.log(JSON.stringify(obj));
  }
}

// ---- Monthly Oil Sheet ----
const oilSheet = XLSX.utils.sheet_to_json(workbook.Sheets['Monthly bbl per day'], { header: 1 }) as SheetRow[];
const oilHeaderIdx = oilSheet.findIndex(row => row[0] === 'Well Identifier');
const oilHeaders = oilSheet[oilHeaderIdx];
console.log('\n=== Monthly bbl/d Headers ===');
console.log(oilHeaders?.map((headerCell) => String(headerCell ?? '').replace(/\r\n/g, ' ')));
// Print 3 data rows
console.log('\n=== Monthly bbl/d Sample Rows ===');
for (let i = oilHeaderIdx + 1; i < Math.min(oilHeaderIdx + 4, oilSheet.length); i++) {
  const row = oilSheet[i];
  if (row.length > 0) {
    const obj: Record<string, SheetCell> = {};
    oilHeaders?.forEach((headerCell, idx) => {
      const header = String(headerCell ?? '').replace(/\r\n/g, ' ').trim();
      if (header) {
        obj[header] = row[idx];
      }
    });
    console.log(JSON.stringify(obj));
  }
}
