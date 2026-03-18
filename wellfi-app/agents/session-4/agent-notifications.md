# Agent: agent-notifications - Operational Status Notifications
**Session:** 4 | **Precedence:** 1 | **Mode:** Parallel with agent-polish

---

## Scope

This agent owns the notification pipeline for engineer-assigned operational statuses.

## Owned Files

```text
supabase/functions/notify-operational-status/index.ts
supabase/functions/_shared/cors.ts
supabase/functions/_shared/types.ts
```

## Trigger

- Database webhook on `operational_statuses`
- Event: `INSERT`
- Process only rows where `is_active = true`

## Notification Rules

- Slack is the primary notification channel.
- Email is optional and may be enabled in addition to Slack.
- Notifications must include:
  - well name / identifier
  - status label
  - engineer who set the status
  - notes, when present
  - pump change window, when present
  - deep link to `/map?well_id=...`

## Environment Secrets

```bash
supabase secrets set SLACK_WEBHOOK_URL=https://hooks.slack.com/services/xxx
supabase secrets set RESEND_API_KEY=re_xxx
supabase secrets set NOTIFY_EMAIL=team@example.com
supabase secrets set EMAIL_FROM="WellFi Notifications <notifications@example.com>"
supabase secrets set APP_URL=https://wellfi.vercel.app
```

## Deployment

```bash
supabase functions deploy notify-operational-status
```

## Verification

1. Insert or create a test operational status from the UI.
2. Confirm Slack receives the notification.
3. Confirm the Slack link opens the correct well.
4. If email is enabled, confirm the email content matches the Slack alert.
5. Confirm the function reports failure if every configured delivery channel fails.
