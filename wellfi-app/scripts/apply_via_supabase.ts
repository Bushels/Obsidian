import fs from 'fs';
import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.SUPABASE_URL!;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_KEY!;

if (!SUPABASE_URL || !SUPABASE_SERVICE_KEY) {
  console.error('Set SUPABASE_URL and SUPABASE_SERVICE_KEY env vars');
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY);

async function applyBatch(batchFile: string) {
  const sql = fs.readFileSync(batchFile, 'utf8');
  
  // Split on double newline before INSERT
  const stmts = sql.split(/\n\nINSERT INTO/).filter(s => s.trim());
  const statements = stmts.map((s, i) => i === 0 ? s : 'INSERT INTO' + s);
  
  console.log(`[${batchFile}] ${statements.length} statements`);
  
  let ok = 0, fail = 0;
  for (const stmt of statements) {
    const { error } = await supabase.rpc('exec_sql', { sql: stmt }).single() as any;
    if (error) {
      // Try direct execute via REST admin
      const resp = await fetch(`${SUPABASE_URL}/rest/v1/rpc/exec_sql`, {
        method: 'POST',
        headers: {
          'apikey': SUPABASE_SERVICE_KEY,
          'Authorization': `Bearer ${SUPABASE_SERVICE_KEY}`,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ sql: stmt })
      });
      if (!resp.ok) {
        console.error('FAIL:', stmt.substring(0, 100), error);
        fail++;
      } else {
        ok++;
      }
    } else {
      ok++;
    }
  }
  console.log(`  ok=${ok} fail=${fail}`);
}

const batches = ['batch_001', 'batch_002', 'batch_003', 'batch_004', 'batch_005'];
for (const b of batches) {
  await applyBatch(`supabase/batches/${b}.sql`);
}
