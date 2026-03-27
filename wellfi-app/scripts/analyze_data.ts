import XLSX from 'xlsx';

type SheetCell = string | number | boolean | null | undefined;
type SheetRow = SheetCell[];

// Load Excel
const excelPath = 'c:/Users/kyle/MPS/Obsidian/Obsidian_PeaceRiver_2025_v3.xlsx';
console.log(`Reading Excel: ${excelPath}`);

try {
  const workbook = XLSX.readFile(excelPath);
  
  // 1. Inspect "Pump Change Risk"
  const riskSheetName = 'Pump Change Risk';
  if (workbook.Sheets[riskSheetName]) {
    console.log(`\n--- Sheet: ${riskSheetName} ---`);
    const riskData = XLSX.utils.sheet_to_json(workbook.Sheets[riskSheetName], { header: 1 }) as SheetRow[];
    // Print first 5 rows
    riskData.slice(0, 5).forEach((row, i) => {
        console.log(`Row ${i}:`, JSON.stringify(row));
    });
  }

  // 2. Inspect "Monthly Hours"
  const hoursSheetName = 'Monthly Hours';
  if (workbook.Sheets[hoursSheetName]) {
    console.log(`\n--- Sheet: ${hoursSheetName} ---`);
    const hoursData = XLSX.utils.sheet_to_json(workbook.Sheets[hoursSheetName], { header: 1 }) as SheetRow[];
    // Print first 3 rows (headers + data)
    hoursData.slice(0, 3).forEach((row, i) => {
        console.log(`Row ${i}:`, JSON.stringify(row));
    });
  }
  
} catch (error: unknown) {
  console.error('Error reading Excel:', error);
}
