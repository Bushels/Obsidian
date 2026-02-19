import fs from 'fs';

// Combine remaining batch chunks into single files for faster upload
function combineChunks(prefix: string, count: number, skip: number, label: string) {
  const chunks: string[] = [];
  for (let i = skip + 1; i <= count; i++) {
    const pad = String(i).padStart(2, '0');
    const file = `supabase/chunks/${prefix}_${pad}.sql`;
    if (fs.existsSync(file)) {
      chunks.push(fs.readFileSync(file, 'utf8'));
    }
  }
  const combined = chunks.join('\n\n');
  const outFile = `supabase/chunks/${label}.sql`;
  fs.writeFileSync(outFile, combined);
  console.log(`${label}: ${chunks.length} chunks, ${combined.length} bytes`);
}

// b1_04 through b1_10 (already applied: b1_01, b1_02, b1_03)
combineChunks('b1', 10, 3, 'b1_rest');

// b2 all 10 chunks combined
combineChunks('b2', 10, 0, 'b2_all');

// b3 all 10 chunks combined
combineChunks('b3', 10, 0, 'b3_all');

// b4 all 10 chunks combined
combineChunks('b4', 10, 0, 'b4_all');

// b5 just 1 chunk
combineChunks('b5', 1, 0, 'b5_all');

console.log('Done');
