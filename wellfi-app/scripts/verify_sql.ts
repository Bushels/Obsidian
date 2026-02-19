import fs from 'fs';
const sql = fs.readFileSync('supabase/seed_wells_only.sql', 'utf8');
const bad = sql.match(/ARRAY\[[^\]]*,,/);
console.log(bad ? 'BAD: ' + bad[0].slice(0,80) : 'CLEAN: No empty array slots found');
console.log('Total length:', sql.length);
