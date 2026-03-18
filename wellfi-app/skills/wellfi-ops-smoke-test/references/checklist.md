# WellFi Smoke Test Checklist

Use this checklist when the user asks for a browser validation pass.

## Core checks

1. Start the app and record the actual URL.
2. Load the login page or dashboard entry route.
3. Log in if credentials are available.
4. Confirm the main map loads.
5. Confirm header, left rail, and right panel shell render.
6. Confirm map controls are visible and usable.

## Action Items

1. Check whether `Action Items` renders at the top of the left sidebar.
2. Click the first flagged well.
3. Verify the right panel opens the matching well.
4. Click a second flagged well.
5. Verify the app stays on the second well and does not bounce between selections.

## Well details

1. Verify the well identity card shows the correct well.
2. Check operational status visibility.
3. Check device assignment or WellFi state.
4. Check pump-change status and progress UI if present.
5. If relevant, inspect the 3D panel and comparables widget load states.

## Map-specific checks

1. Confirm base map style switcher works.
2. Confirm Land, Glow, and LSD toggles respond.
3. If monitored alert dots are expected, hover one and verify the popup contents.
4. If no monitored alert dots appear, confirm whether the data state actually includes active WellFi devices.

## Report format

- Environment:
- URL:
- Credentials used:
- Checks completed:
- Failures found:
- Console or data gaps:
