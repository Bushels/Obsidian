# WellFi App User Walkthrough

This guide explains the main parts of the WellFi portal in plain language so engineers and operations staff can move through the system quickly.

The current system supports both:

- **MPS admin access** across provisioned operators
- **operator viewer access** limited to that company's wells

## 1. Logging In

Access is issued separately to approved customers. Enter your assigned username and password on the login page to open the operations dashboard.

## 2. Left Sidebar

The left side of the dashboard is the summary and navigation area.

### MPS Admin View

- **Dashboard Overview:** Shows the current scope, well counts, formation split, flagged wells, and upcoming work.
- **Production Deck:** Shows the latest monthly production snapshot for the current admin scope, with operator or formation breakdown, oil or gas toggle, and a WellFi cohort filter.
- **Action Items:** Lists flagged wells and active pump-change work so MPS can jump directly to the right well.
- **Risk Overview:** Summarizes the filtered risk and operational-status mix.
- **Inventory Overview:** Summarizes available WellFi equipment.
- **Filters:** Narrow the dashboard by risk, formation, field, WellFi installs, upcoming work, or production rate.

### Operator Viewer View

- **Operator Overview:** Shows the company scope, well counts, formation split, flagged wells, and upcoming work.
- **Action Items:** Lists the wells that need attention inside that company account.
- **No Production Analytics:** Operator viewers do not see MPS-only production charts or production heatmap controls.
- **Filters:** Narrow the dashboard without leaving the company scope.

## 3. Main Map

The center map is the operating view of the field.

- Click a well to inspect it.
- Zoom in to separate clusters and review individual locations.
- Use the search button or `Ctrl+K` / `Cmd+K` to jump directly to a well by name or identifier.
- Base well dots come from the live WellFi well list.
- Production heatmap/cloud comes from the latest monthly production snapshot.
- In MPS admin view, the operator selector scopes the dashboard and map to one operator when needed.
- In operator viewer view, the production heatmap controls are hidden so the map stays simpler.

## 4. Well Details Panel

When you select a well, the detail panel opens on the right side on desktop and as a bottom sheet on mobile.

This panel includes:

- well identity and operating context
- current engineer-assigned operational status
- assigned WellFi device information
- production and comparables views for MPS admin
- pump change planning and scheduling information

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
