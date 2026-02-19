import fs from 'fs';

const sql = fs.readFileSync('supabase/seed_wells_only.sql', 'utf8');

// Split on the boundary between statements
const header = '-- WellFi Well Data Seed\n-- Generated from JSON + Excel ETL\n-- Apply via Supabase MCP\n\n';
const body = sql.replace(header, '');

// Each well INSERT is: INSERT INTO wells ... ON CONFLICT ... updated_at = now();\n\n
const stmts = body.split(/\n\n(?=INSERT INTO wells)/).filter(s => s.trim());
console.log(`Total statements: ${stmts.length}`);

// Create batches of 50
const BATCH_SIZE = 50;
const batches: string[] = [];
for (let i = 0; i < stmts.length; i += BATCH_SIZE) {
  const batch = stmts.slice(i, i + BATCH_SIZE).join('\n\n');
  batches.push(batch);
}

// Write batch files
if (!fs.existsSync('supabase/batches')) fs.mkdirSync('supabase/batches');
batches.forEach((b, i) => {
  fs.writeFileSync(`supabase/batches/batch_${String(i+1).padStart(3,'0')}.sql`, b + '\n');
});
console.log(`Written ${batches.length} batch files to supabase/batches/`);
console.log('Sizes:', batches.map((b, i) => `batch ${i+1}: ${b.length} bytes`).join(', '));
