import fs from 'fs';
const all = fs.readFileSync('supabase/seed_welldata.sql', 'utf8');
const splitAt = all.indexOf('-- Pump Change Records');
if (splitAt < 0) { console.error('No split found!'); process.exit(1); }
const wellsSql = all.slice(0, splitAt).trim();
const pumpSql = all.slice(splitAt).trim();
fs.writeFileSync('supabase/seed_wells_only.sql', wellsSql);
fs.writeFileSync('supabase/seed_pumps_only.sql', pumpSql);
console.log('Wells SQL:', wellsSql.length, 'bytes');
console.log('Pumps SQL:', pumpSql.length, 'bytes');
