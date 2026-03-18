# WellFi App User Walkthrough

This guide explains the main parts of the WellFi portal in plain language so engineers and operations staff can move through the system quickly.

## 1. Logging In

Access is issued separately to approved customers. Enter your assigned username and password on the login page to open the operations dashboard.

## 2. Left Sidebar

The left side of the dashboard is your summary and planning area.

- **Risk Overview:** Shows how many wells are currently in watch, warning, or other risk states.
- **Inventory Overview:** Summarizes available WellFi equipment.
- **Filters:** Narrow the map by risk, formation, field, WellFi installs, upcoming work, or production rate.
- **Upcoming Actions:** Lists wells with active or scheduled pump-change work so engineers can jump directly to them.

## 3. Main Map

The center map is the operating view of the field.

- Click a well to inspect it.
- Zoom in to separate clusters and review individual locations.
- Use the search button or `Ctrl+K` / `Cmd+K` to jump directly to a well by name or identifier.

## 4. Well Details Panel

When you select a well, the detail panel opens on the **right-hand side** on desktop and as a bottom sheet on mobile.

This panel includes:

- Well identity and operating context
- Current engineer-assigned operational status
- Assigned WellFi device information
- Production and comparables views
- Pump change planning and scheduling information

## 5. Recording a Well Status

If an engineer decides a pump should be monitored, scheduled, or taken offline:

1. Open the well.
2. Choose the appropriate status:
   - **Watch**
   - **Warning**
   - **Well Down**
3. Add notes and any pump change timing details.
4. Save the update.

The status is stored against that well and can trigger Slack notifications. Email notifications can also be enabled if configured by the administrator.
