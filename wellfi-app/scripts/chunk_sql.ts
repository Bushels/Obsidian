import fs from 'fs';

if (!fs.existsSync('supabase/chunks')) fs.mkdirSync('supabase/chunks');

const batches = [1, 2, 3, 4, 5];
const GROUP = 5; // statements per chunk

for (const b of batches) {
  const batchFile = `supabase/batches/batch_${String(b).padStart(3,'0')}.sql`;
  const sql = fs.readFileSync(batchFile, 'utf8');
  
  // Split on semicolon + double newline + INSERT
  const parts = sql.split(/;\n\n(?=INSERT)/);
  const stmts = parts.map((s, i) => i < parts.length - 1 ? s + ';' : s.replace(/;\s*$/, ';'));
  
  console.log(`Batch ${b}: ${stmts.length} statements`);
  
  for (let i = 0; i < stmts.length; i += GROUP) {
    const chunk = stmts.slice(i, i + GROUP).join('\n\n');
    const chunkNum = String(Math.floor(i/GROUP) + 1).padStart(2, '0');
    const outFile = `supabase/chunks/b${b}_${chunkNum}.sql`;
    fs.writeFileSync(outFile, chunk + '\n');
  }
}
console.log('Done chunking SQL files');
