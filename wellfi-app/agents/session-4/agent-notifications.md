# Agent: agent-notifications — Notifications Edge Function
**Session:** 4 | **Precedence:** 1 | **Mode:** Parallel with agent-polish

---

## Pre-Start Checklist
1. Read `agents/MANIFEST.json`
2. Read `agents/STATUS.json` — Sessions 1, 2, AND 3 must all be `"completed"`
3. Read `supabase/migrations/001_initial_schema.sql` — understand pump_changes table
4. Write `agents/locks/agent-notifications.lock`
5. Check `agents/locks/agent-polish.lock` — no file conflict (you own `supabase/functions/`, they own `src/components/ui/`)

---

## Your Owned Files
```
supabase/functions/notify-pump-change/index.ts
supabase/functions/_shared/cors.ts
supabase/functions/_shared/types.ts
```

---

## Dependencies
```bash
# Supabase CLI must be installed: https://supabase.com/docs/guides/cli
supabase functions new notify-pump-change
```

---

## Tasks

### Task 1 — Shared Types
File: `supabase/functions/_shared/types.ts`

```typescript
// Types mirrored from src/types.ts for use in Deno Edge Functions
export interface PumpChangePayload {
  id: string;
  well_id: string;
  status: string;
  flagged_by: string;
  flagged_at: string;
  scheduled_date: string | null;
  notes: string | null;
  formation_pressure_kpa: number | null;
  pump_pressure_kpa: number | null;
  pump_speed_rpm: number | null;
}

export interface WellPayload {
  id: string;
  name: string | null;
  formatted_id: string | null;
  field: string | null;
  formation: string | null;
  lat: number;
  lon: number;
  months_running: number | null;
  risk_level: string | null;
}
```

### Task 2 — CORS Headers
File: `supabase/functions/_shared/cors.ts`
```typescript
export const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};
```

### Task 3 — Main Edge Function
File: `supabase/functions/notify-pump-change/index.ts`

**Trigger:** Database webhook on `pump_changes` INSERT.

**Implementation:**
```typescript
import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';
import { corsHeaders } from '../_shared/cors.ts';

serve(async (req: Request) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const payload = await req.json();
    const pumpChange = payload.record;  // The new pump_changes row

    // 1. Fetch well details
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
    );
    const { data: well } = await supabase
      .from('wells')
      .select('name, formatted_id, field, formation, lat, lon, months_running, risk_level')
      .eq('id', pumpChange.well_id)
      .single();

    // 2. Build notification content
    const scheduled = pumpChange.scheduled_date
      ? new Date(pumpChange.scheduled_date).toLocaleDateString('en-CA')
      : 'Not yet scheduled';
    const appUrl = Deno.env.get('APP_URL') ?? 'https://wellfi.vercel.app';

    // 3. Send Email via Resend
    const RESEND_KEY = Deno.env.get('RESEND_API_KEY');
    const NOTIFY_EMAIL = Deno.env.get('NOTIFY_EMAIL');
    if (RESEND_KEY && NOTIFY_EMAIL) {
      await fetch('https://api.resend.com/emails', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${RESEND_KEY}` },
        body: JSON.stringify({
          from: 'WellFi <notifications@wellfi.obsidian.ca>',
          to: NOTIFY_EMAIL,
          subject: `⚠️ Pump Change Flagged: ${well?.name ?? pumpChange.well_id}`,
          html: `
            <h2>Pump Change Warning</h2>
            <table>
              <tr><td><strong>Well:</strong></td><td>${well?.name} (${well?.formatted_id})</td></tr>
              <tr><td><strong>Field:</strong></td><td>${well?.field} — ${well?.formation}</td></tr>
              <tr><td><strong>Risk Level:</strong></td><td>${well?.risk_level}</td></tr>
              <tr><td><strong>Months Running:</strong></td><td>${well?.months_running ?? 'Unknown'}</td></tr>
              <tr><td><strong>Scheduled Date:</strong></td><td>${scheduled}</td></tr>
              <tr><td><strong>Flagged By:</strong></td><td>${pumpChange.flagged_by}</td></tr>
              <tr><td><strong>Formation Pressure:</strong></td><td>${pumpChange.formation_pressure_kpa ?? '—'} kPa</td></tr>
              <tr><td><strong>Pump Pressure:</strong></td><td>${pumpChange.pump_pressure_kpa ?? '—'} kPa</td></tr>
              <tr><td><strong>Notes:</strong></td><td>${pumpChange.notes ?? '—'}</td></tr>
            </table>
            <p><a href="${appUrl}/map?well=${pumpChange.well_id}">View on WellFi Map →</a></p>
          `
        })
      });
    }

    // 4. Send Slack notification
    const SLACK_WEBHOOK = Deno.env.get('SLACK_WEBHOOK_URL');
    if (SLACK_WEBHOOK) {
      await fetch(SLACK_WEBHOOK, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          blocks: [
            {
              type: 'header',
              text: { type: 'plain_text', text: `⚠️ Pump Change Flagged` }
            },
            {
              type: 'section',
              fields: [
                { type: 'mrkdwn', text: `*Well:*\n${well?.name}` },
                { type: 'mrkdwn', text: `*Field:*\n${well?.field}` },
                { type: 'mrkdwn', text: `*Risk:*\n${well?.risk_level}` },
                { type: 'mrkdwn', text: `*Months Running:*\n${well?.months_running ?? 'Unknown'}` },
                { type: 'mrkdwn', text: `*Scheduled:*\n${scheduled}` },
                { type: 'mrkdwn', text: `*Flagged By:*\n${pumpChange.flagged_by}` },
              ]
            },
            {
              type: 'section',
              text: { type: 'mrkdwn', text: `Formation: ${pumpChange.formation_pressure_kpa ?? '—'} kPa | Pump: ${pumpChange.pump_pressure_kpa ?? '—'} kPa` }
            },
            {
              type: 'actions',
              elements: [{
                type: 'button',
                text: { type: 'plain_text', text: 'View on Map' },
                url: `${appUrl}/map?well=${pumpChange.well_id}`,
                style: 'primary'
              }]
            }
          ]
        })
      });
    }

    // 5. Mark notification as sent
    await supabase
      .from('pump_changes')
      .update({ notification_sent: true })
      .eq('id', pumpChange.id);

    return new Response(JSON.stringify({ success: true }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    });

  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    });
  }
});
```

### Task 4 — Register the Webhook
In Supabase Dashboard → Database → Webhooks → Create webhook:
- Name: `notify_pump_change`
- Table: `pump_changes`
- Events: `INSERT`
- URL: `https://[project-ref].supabase.co/functions/v1/notify-pump-change`

Document this step in `agents/proposals/agent-notifications-completion.md` so coordinator can run it.

### Task 5 — Environment Secrets
Run via Supabase CLI:
```bash
supabase secrets set RESEND_API_KEY=re_xxx
supabase secrets set SLACK_WEBHOOK_URL=https://hooks.slack.com/xxx
supabase secrets set NOTIFY_EMAIL=team@obsidian.ca
supabase secrets set APP_URL=https://wellfi.vercel.app
```

Document exact commands in completion report.

### Task 6 — Deploy Function
```bash
supabase functions deploy notify-pump-change
```

---

## Completion
1. Update lock file → `"completed"`
2. Update `agents/STATUS.json`: set `sessions.4.agents.agent-notifications` → `"completed"`
3. Create `agents/proposals/agent-notifications-completion.md` with:
   - Webhook registration steps (requires Supabase Dashboard — manual)
   - Secrets to set
   - Test procedure: insert a test pump_change row and verify email + Slack

**FROZEN FILES — DO NOT TOUCH:** `src/types.ts`, `src/lib/supabase.ts`
**DO NOT TOUCH:** `src//**` (entire frontend), `agents/**` except your lock and completion files
