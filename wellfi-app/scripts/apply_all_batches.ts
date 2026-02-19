/**
 * apply_all_batches.ts
 * Reads all 5 batch SQL files and applies them to Supabase
 * via the Management API's database query endpoint.
 * 
 * Usage: SUPABASE_ACCESS_TOKEN=your_token npx tsx scripts/apply_all_batches.ts
 */
import fs from 'fs';

const PROJECT_REF = 'opxptteradsvptjyxxfr';
const ACCESS_TOKEN = process.env.SUPABASE_ACCESS_TOKEN;

if (!ACCESS_TOKEN) {
  console.error('Set SUPABASE_ACCESS_TOKEN env var (from supabase.com account settings)');
  process.exit(1);
}

const BASE_URL = `https://api.supabase.com/v1/projects/${PROJECT_REF}/database/query`;

async function runQuery(sql: string, label: string) {
  const resp = await fetch(BASE_URL, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${ACCESS_TOKEN}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ query: sql })
  });
  
  if (!resp.ok) {
    const body = await resp.text();
    throw new Error(`[${label}] HTTP ${resp.status}: ${body}`);
  }
  
  const data = await resp.json();
  if (data && data.error) {
    throw new Error(`[${label}] SQL error: ${data.error}`);
  }
  return data;
}

const chunks: string[] = [];
for (let b = 1; b <= 5; b++) {
  const batchFile = `supabase/batches/batch_${String(b).padStart(3,'0')}.sql`;
  const sql = fs.readFileSync(batchFile, 'utf8');
  // Split into 10-statement chunks  
  const parts = sql.split(/;\n\n(?=INSERT)/);
  const stmts = parts.map((s, i) => i < parts.length - 1 ? s + ';' : s.replace(/;\s*$/, ';'));
  
  const GROUP = 10;
  for (let i = 0; i < stmts.length; i += GROUP) {
    chunks.push(stmts.slice(i, i + GROUP).join('\n\n'));
  }
}

console.log(`Total chunks to apply: ${chunks.length}`);

let succeeded = 0, failed = 0;
for (let i = 0; i < chunks.length; i++) {
  const label = `chunk ${i+1}/${chunks.length}`;
  try {
    await runQuery(chunks[i], label);
    succeeded++;
    if (i % 5 === 0) process.stdout.write(`\r${label} ✓`);
  } catch (err) {
    failed++;
    console.error(`\n[FAIL] ${err}`);
  }
}

console.log(`\n\nDone: ${succeeded} succeeded, ${failed} failed`);
