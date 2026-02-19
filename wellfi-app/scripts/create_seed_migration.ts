import fs from 'fs';

// Combine all batch files into one seed migration
const batches = [1, 2, 3, 4, 5].map(b =>
  fs.readFileSync(`supabase/batches/batch_${String(b).padStart(3,'0')}.sql`, 'utf8')
);

const combined = batches.join('\n\n');
const outFile = 'supabase/migrations/005_seed_wells.sql';
fs.writeFileSync(outFile, combined);
console.log(`Created ${outFile}: ${combined.length} bytes`);
console.log('Wells:', (combined.match(/INSERT INTO wells/g) || []).length);
