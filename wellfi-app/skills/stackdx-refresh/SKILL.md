---
name: stackdx-data-pull
description: Pull well data from StackDX Maps using the StackDX AI (Orion-1) chat interface via browser automation. Use this skill whenever the user wants to refresh well data from StackDX, download well exports, query StackDX for well information, pull Clearwater/Bluesky data, or keep WellFi data current. Also use when the user mentions StackDX, PetroNinja data, or wants to export wells from a mapping platform.
---

# StackDX Data Pull

Pull filtered well data from StackDX Maps via the in-app AI agent (Orion-1). StackDX AI accepts natural language queries, applies filters server-side, and auto-downloads CSV exports to the browser's downloads folder.

## Key Facts

- **URL**: `maps.stackdx.com` (NOT `app.stackdx.com` — that URL shows an invitation wall)
- **Access method**: Claude in Chrome MCP browser automation (headless Playwright does NOT work — hits invitation page)
- **AI agent**: StackDX AI "Orion-1" — chat panel on the right side of the map interface
- **Credentials**: stored in `wellfi-app/.env.local` as `STACKDX_EMAIL` and `STACKDX_PASSWORD`
- **Account**: Derek Belle, Professional Plan
- **Auto-download**: The AI can trigger browser downloads directly — files land in the user's Downloads folder (`C:\Users\kyle\Downloads\`)
- **Export button**: The Jobs & Exports panel's Export button may be plan-restricted. Use the AI chat to trigger downloads instead.

## Workflow

### Step 1: Open StackDX Maps

Use Claude in Chrome to navigate to `maps.stackdx.com`. If not already logged in, the login flow uses Auth0:

1. Enter email in the "Email Address" textbox
2. Click "Continue"
3. Enter password in the "Password" textbox
4. Click "Continue"

After login, wait for the map and well table to load. The table shows "Wells" with columns like UWI, Licence Number, Province, Licensee, Field, Producing Formation, etc.

### Step 2: Open the AI Panel

Click the "StackDX AI" button in the toolbar below the map (or look for the chat icon in the top-right). The AI panel opens on the right side showing "StackDX AI Orion-1".

### Step 3: Write the Query

The prompt input is at the bottom of the AI panel. Type your query as natural language. The AI understands well data terminology and can filter by any column in the database.

**Effective query pattern:**

```
Download a CSV of all [status] wells in [provinces] with [formation]
producing formation that have [production filter]. Include [columns].
Auto-download the file.
```

The phrase "auto-download the file" is important — it tells the AI to trigger a browser download rather than just describing the export.

### Step 4: Submit and Wait

Press Enter to submit. Wait 10-15 seconds for the AI to process and trigger the download. The AI will respond with:
- Filter criteria it applied
- Column list
- Filename
- Confirmation that the download was triggered

### Step 5: Verify and Move

Check `C:\Users\kyle\Downloads\` for the new CSV file. Copy it to the project's `Data/` directory for processing.

## Query Examples

### Active oil-producing Clearwater/Bluesky wells (oil only)

```
Download a CSV of all active non-thermal wells in Alberta and Saskatchewan
producing from the Clearwater or Bluesky formations that have had oil
production greater than 0 in the last 6 months. Include UWI,
operator/licensee, producing formation, field name, well status, surface
latitude, surface longitude, last oil production rate, cumulative oil
production, last production date, and spud date. Auto-download the file.
```

Result: ~6,518 wells (conventional oil producers only)

### All active Clearwater/Bluesky wells (oil + bitumen + gas)

```
Download a CSV of all active wells in Alberta and Saskatchewan with
Clearwater or Bluesky producing formation that have has_recent_production
= true. Do not filter by oil specifically. Include UWI, operator/licensee,
producing formation, field name, well status, well fluid type, surface
latitude, surface longitude, last oil production rate, cumulative oil
production, recent oil, recent gas, recent water, recent steam injection,
last production date, and spud date. Auto-download the file.
```

Result: ~9,189 wells (oil + bitumen + gas + water injectors)

### Single operator pull

```
Download a CSV of all active wells operated by Obsidian Energy Ltd. in
Alberta with Clearwater or Bluesky producing formation. Include UWI,
producing formation, field name, well status, well fluid type, surface
latitude, surface longitude, recent oil, last production date, and spud
date. Auto-download the file.
```

## Data Model Gotchas

### Bitumen vs Oil
StackDX rolls bitumen volumes into the `recent_oil` / `last_oil_production_rate` columns — they are NOT distinguishable by production volume. To identify bitumen wells, request the `well_fluid_type` column (maps to `petro_ninja_well_fluid`):
- **Oil** — conventional heavy/light oil wells
- **Crude Bitumen** — thermal/in-situ SAGD/CSS wells (Imperial, CNRL, Cenovus)
- **Gas** — natural gas producers (Peyto, Tourmaline in the Deep Basin)
- **Water** — injection wells supporting thermal operations

### Thermal Well Reporting
In-situ thermal operators (Imperial Oil, Cenovus, CNRL's Upgrading division) report bitumen production per-well in Petrinex, but the fluid is classified as "Crude Bitumen" not "Oil". A query for `oil production > 0` will miss these wells. Use `has_recent_production = true` to capture everything.

### Operator Aliases
- **Canadian Natural Upgrading Limited** = **Canadian Natural Resources Limited** (same entity, merge under CNRL)
- **Long Run Exploration Ltd.** — defunct (receivership March 2025, Orphan Well Association). Wells being liquidated.
- **Harvest Operations Corp.** — legacy operator, wells transferred to current operators

### Formation Context
- **Clearwater** — produces heavy oil in Peace River region (northern Alberta)
- **Bluesky** — produces heavy oil in Peace River BUT also gas in the Deep Basin (western Alberta). Peyto/Tourmaline Bluesky wells are gas wells, not oil.

## Available AI Commands

Type `/help` in the AI prompt to see available commands:

| Command | Description | Plan |
|---------|-------------|------|
| `/help` | List commands | All |
| `/clear` | Clear chat history | All |
| `/view-zoom` | Current zoom level | All |
| `/set-zoom` | Set zoom level | All |
| `/export-geojson` | Export current layer as GeoJSON | All |
| `/set-theme` | Set app theme | All |
| `/test-connection` | Connection info | All |
| `/god-mode` | Activate god mode | All |
| `/sql` | Direct SQL queries | Upgraded |
| `/print-map` | Print current map | Upgraded |

## Table Filters

The well table below the map has built-in column filters. Useful for quick exploration before querying the AI:

1. Click "FILTERS" in the toolbar
2. Select column (e.g., "Producing Formation"), operator ("contains"), and value ("Clearwater")
3. Click "Add filter" for additional conditions (AND logic)
4. The filter count badge shows on the FILTERS button

Note: Table filters use AND logic — you cannot do "Clearwater OR Bluesky" with two filter rows. Use the AI for OR queries.

## File Locations

| File | Purpose |
|------|---------|
| `wellfi-app/.env.local` | StackDX credentials (gitignored) |
| `wellfi-app/.codex/stackdx-jobs.local.json` | Job config for Playwright automation (legacy) |
| `Data/active_clearwater_bluesky_wells_ab_sk_last6mo.csv` | Latest well export |
| `Data/active_bluesky_clearwater_wells_AB_SK.csv` | Old basin CSV (Sept 2025 vintage, 11,764 wells) |
| `Data/operator_inventory_clearwater_bluesky.md` | Operator inventory summary |

## Legacy: Playwright Automation

The `scripts/stackdx_refresh.ts` script exists for headless Playwright automation but currently does NOT work because `app.stackdx.com` requires a workspace invitation that the browser session cannot bypass. The working approach is Claude in Chrome to `maps.stackdx.com`. The Playwright script may be updated to target `maps.stackdx.com` in the future.
