# WellFi Testing Protocol

This checklist is the release test for WellFi. It is written for operators, product owners, and engineers so everyone can confirm the same critical workflow before a change goes live.

## 1. Before You Start

- Confirm you are testing the correct environment.
- Confirm you have valid customer login credentials.
- Confirm the latest StackDX export, if used for this release, has been uploaded.
- Confirm Slack notifications are connected.
- If email alerts are enabled, confirm the email destination is configured.

## 2. Required System Checks

Run these commands from the project folder:

```bash
npm run build
npm run lint
```

Expected result:

- `build` must pass.
- `lint` should pass before release. If it does not, log the remaining issues and decide whether they are existing debt or a new regression.

## 3. Browser Smoke Test

Open the app in a real browser and confirm:

- Login works with an active customer account.
- The map loads without a blank screen.
- Well dots appear.
- Left sidebar, map, and right panel all render correctly.
- Search opens with `Ctrl+K` or `Cmd+K`.

## 4. Operator Viewer Workflow

Pick one operator viewer account and verify:

1. Log in and confirm the header shows the correct operator context.
2. Confirm the sidebar shows the operator overview card instead of admin-only widgets.
3. Confirm the map count looks operator-scoped, not global.
4. Apply formation and field filters and confirm counts remain scoped.
5. Open one well and confirm operational status and device actions are read-only.

## 5. Core Engineer Workflow

Pick a test well and verify:

1. Open the well from the map.
2. Change the operational status to `Watch`.
3. Save and confirm the panel updates correctly.
4. Change the status to `Warning`.
5. Save and confirm the panel updates correctly.
6. Change the status to `Well Down`.
7. Add notes and a pump change window.
8. Save and confirm the information persists after refresh.

## 6. Notification Test

After saving a test status:

- Confirm the Slack message arrives.
- Confirm the Slack button opens the correct well in the map.
- If email is enabled, confirm the email arrives with the correct well, status, notes, and link.
- If either channel fails, do not release until the failure is understood.

## 7. Search and Navigation

Verify:

- Search finds a well by name.
- Search finds a well by identifier.
- Selecting a result opens the correct well.
- Refreshing a deep link such as `/map?well_id=...` still opens the correct well after login.

## 8. Filters and Map Behavior

Verify:

- Risk filters narrow the map correctly.
- Formation filters narrow the map correctly.
- Field filters narrow the map correctly.
- `WellFi Only` and `Upcoming Only` work as expected.
- Opening a well from the upcoming list flies the map to the correct location.

## 9. Mobile Check

Verify on a phone-sized screen:

- Filter drawer opens and closes correctly.
- Well detail bottom sheet opens and closes correctly.
- Buttons are usable by touch.
- No panel is cut off or trapped off-screen.

## 10. Data Integrity Check

Confirm with one or two sample wells:

- Displayed well identity matches the uploaded data.
- Status changes remain attached to the correct well.
- Device assignment still shows correctly.
- No unexpected wells disappear after filtering or refresh.
- Operator viewers cannot see another operator's wells.

## 11. Release Decision

Release only when:

- The build passes.
- Critical browser checks pass.
- The engineer workflow passes.
- Notifications pass.
- Any known issues are documented and accepted.
