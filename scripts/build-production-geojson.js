const fs = require('fs');
const path = require('path');

const CSV_PATH = path.resolve(__dirname, '../Data/active_clearwater_bluesky_recent_prod_ab_sk.csv');
const OUT_PATH = path.resolve(__dirname, '../wellfi-app/public/data/bluesky-clearwater-production.geojson');

function parseCSVLine(line) {
  const result = [];
  let current = '';
  let inQuotes = false;
  for (let i = 0; i < line.length; i++) {
    if (line[i] === '"') { inQuotes = !inQuotes; }
    else if (line[i] === ',' && !inQuotes) { result.push(current.trim()); current = ''; }
    else { current += line[i]; }
  }
  result.push(current.trim());
  return result;
}

const raw = fs.readFileSync(CSV_PATH, 'utf8');
const lines = raw.split('\n').filter(l => l.trim());
const header = parseCSVLine(lines[0]);
const idx = Object.fromEntries(header.map((h, i) => [h, i]));

const features = [];

for (let i = 1; i < lines.length; i++) {
  const row = parseCSVLine(lines[i]);
  const formation = row[idx['producing_formation']] || '';
  const fluidType = row[idx['well_fluid_type']] || '';

  const isClearwater = formation.includes('Clearwater');
  const isBluesky = formation.includes('Bluesky');
  if (!isClearwater && !isBluesky) continue;
  if (fluidType !== 'Crude Oil' && fluidType !== 'Crude Bitumen') continue;

  const lat = parseFloat(row[idx['surface_latitude']]);
  const lng = parseFloat(row[idx['surface_longitude']]);
  if (isNaN(lat) || isNaN(lng)) continue;

  const canonicalFormation = isClearwater ? 'Clearwater' : 'Bluesky';

  features.push({
    type: 'Feature',
    geometry: { type: 'Point', coordinates: [lng, lat] },
    properties: {
      uwi: row[idx['uwi']] || '',
      operator: row[idx['operator_licensee']] || '',
      formation: canonicalFormation,
      field_name: row[idx['field_name']] || '',
      well_fluid_type: fluidType,
      well_status: row[idx['well_status']] || '',
      recent_oil: parseFloat(row[idx['recent_oil']]) || 0,
      cumulative_oil: parseFloat(row[idx['cumulative_oil']]) || 0,
      recent_gas: parseFloat(row[idx['recent_gas']]) || 0,
      recent_water: parseFloat(row[idx['recent_water']]) || 0,
      recent_steam_injection: parseFloat(row[idx['recent_steam_injection']]) || 0,
      last_production_date: row[idx['last_production_date']] || '',
      spud_date: row[idx['spud_date']] || '',
      op_status: 'normal',
    },
  });
}

const geojson = { type: 'FeatureCollection', features };
fs.writeFileSync(OUT_PATH, JSON.stringify(geojson));

console.log(`Written ${features.length} features to ${OUT_PATH}`);
console.log(`  Clearwater: ${features.filter(f => f.properties.formation === 'Clearwater').length}`);
console.log(`  Bluesky: ${features.filter(f => f.properties.formation === 'Bluesky').length}`);
console.log(`  File size: ${(fs.statSync(OUT_PATH).size / 1024 / 1024).toFixed(2)} MB`);
