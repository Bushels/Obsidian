import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';
import { corsHeaders } from '../_shared/cors.ts';

interface OperationalStatus {
  id: string;
  well_id: string;
  status: 'watch' | 'warning' | 'well_down';
  set_by: string;
  set_by_user_id: string | null;
  notes: string | null;
  pump_change_start: string | null;
  pump_change_end: string | null;
  is_active: boolean;
  created_at: string;
}

interface WellRecord {
  name: string | null;
  formatted_id: string | null;
  field: string | null;
  formation: string | null;
}

interface DeliveryResult {
  channel: 'slack' | 'email';
  success: boolean;
  detail: string;
}

const STATUS_LABELS: Record<OperationalStatus['status'], string> = {
  watch: 'Watch',
  warning: 'Warning',
  well_down: 'Well Down',
};

const STATUS_COLORS: Record<OperationalStatus['status'], string> = {
  watch: '#3B82F6',
  warning: '#EAB308',
  well_down: '#EF4444',
};

function normalizeAppUrl(appUrl: string): string {
  return appUrl.replace(/\/+$/, '');
}

function formatDate(value: string | null): string {
  if (!value) {
    return 'Not set';
  }

  const parsed = new Date(value);
  if (Number.isNaN(parsed.getTime())) {
    return value;
  }

  return parsed.toLocaleString('en-CA', {
    dateStyle: 'medium',
    timeStyle: 'short',
  });
}

function escapeHtml(value: string): string {
  return value
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#39;');
}

async function sendSlackNotification(webhookUrl: string, message: Record<string, unknown>) {
  const response = await fetch(webhookUrl, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(message),
  });

  if (!response.ok) {
    const body = await response.text();
    throw new Error(body || `Slack returned ${response.status}`);
  }
}

async function sendEmailNotification({
  apiKey,
  from,
  to,
  subject,
  html,
  text,
}: {
  apiKey: string;
  from: string;
  to: string;
  subject: string;
  html: string;
  text: string;
}) {
  const response = await fetch('https://api.resend.com/emails', {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${apiKey}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      from,
      to,
      subject,
      html,
      text,
    }),
  });

  if (!response.ok) {
    const body = await response.text();
    throw new Error(body || `Resend returned ${response.status}`);
  }
}

serve(async (req: Request) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const payload = await req.json();
    const statusRecord = payload.record as Partial<OperationalStatus> | undefined;

    if (!statusRecord?.id || !statusRecord.well_id || !statusRecord.status) {
      return new Response(JSON.stringify({ error: 'Invalid operational status payload' }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    if (!statusRecord.is_active) {
      return new Response(JSON.stringify({ message: 'Status not active, ignoring' }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const supabase = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!,
    );

    const { data: well, error: wellError } = await supabase
      .from('wells')
      .select('name, formatted_id, field, formation')
      .eq('id', statusRecord.well_id)
      .single<WellRecord>();

    if (wellError || !well) {
      console.error('Error fetching well:', wellError);
      throw wellError ?? new Error('Well not found');
    }

    const appUrl = normalizeAppUrl(Deno.env.get('APP_URL') ?? 'https://wellfi.vercel.app');
    const slackWebhookUrl = Deno.env.get('SLACK_WEBHOOK_URL');
    const resendApiKey = Deno.env.get('RESEND_API_KEY');
    const notifyEmail = Deno.env.get('NOTIFY_EMAIL');
    const emailFrom = Deno.env.get('EMAIL_FROM') ?? 'WellFi <onboarding@resend.dev>';
    const status = statusRecord.status;
    const statusLabel = STATUS_LABELS[status];
    const wellName = well.name ?? well.formatted_id ?? 'Unknown Well';
    const wellIdentifier = well.formatted_id ? ` (${well.formatted_id})` : '';
    const wellLink = `${appUrl}/map?well_id=${encodeURIComponent(statusRecord.well_id)}`;
    const pumpWindow =
      statusRecord.pump_change_start || statusRecord.pump_change_end
        ? `${formatDate(statusRecord.pump_change_start ?? null)} to ${formatDate(
            statusRecord.pump_change_end ?? null,
          )}`
        : null;

    const attachmentBlocks: Record<string, unknown>[] = [];
    if (statusRecord.notes) {
      attachmentBlocks.push({
        type: 'section',
        text: {
          type: 'mrkdwn',
          text: `*Notes:*\n${statusRecord.notes}`,
        },
      });
    }
    if (pumpWindow) {
      attachmentBlocks.push({
        type: 'section',
        text: {
          type: 'mrkdwn',
          text: `*Pump Change Window:*\n${pumpWindow}`,
        },
      });
    }

    const slackMessage: Record<string, unknown> = {
      blocks: [
        {
          type: 'header',
          text: {
            type: 'plain_text',
            text: `Operational Status Update: ${statusLabel}`,
            emoji: true,
          },
        },
        {
          type: 'section',
          fields: [
            {
              type: 'mrkdwn',
              text: `*Well:*\n${wellName}${wellIdentifier}`,
            },
            {
              type: 'mrkdwn',
              text: `*Status:*\n${statusLabel}`,
            },
            {
              type: 'mrkdwn',
              text: `*Set By:*\n${statusRecord.set_by ?? 'Unknown'}`,
            },
            {
              type: 'mrkdwn',
              text: `*Field:*\n${well.field ?? 'N/A'}`,
            },
          ],
        },
        {
          type: 'actions',
          elements: [
            {
              type: 'button',
              text: {
                type: 'plain_text',
                text: 'View Well Details',
                emoji: true,
              },
              url: wellLink,
              action_id: 'view_well',
            },
          ],
        },
      ],
      attachments: [
        {
          color: STATUS_COLORS[status],
          blocks: attachmentBlocks,
        },
      ],
    };

    const safeWellName = escapeHtml(wellName);
    const safeWellIdentifier = escapeHtml(well.formatted_id ?? 'N/A');
    const safeField = escapeHtml(well.field ?? 'N/A');
    const safeFormation = escapeHtml(well.formation ?? 'N/A');
    const safeStatus = escapeHtml(statusLabel);
    const safeSetBy = escapeHtml(statusRecord.set_by ?? 'Unknown');
    const safeNotes = escapeHtml(statusRecord.notes ?? 'None provided');
    const safePumpWindow = escapeHtml(pumpWindow ?? 'Not scheduled');
    const safeLink = escapeHtml(wellLink);

    const emailSubject = `WellFi ${statusLabel}: ${wellName}`;
    const emailHtml = `
      <div style="font-family: Arial, sans-serif; color: #111827;">
        <h2 style="margin-bottom: 12px;">Operational Status Update</h2>
        <table style="border-collapse: collapse;">
          <tr><td style="padding: 4px 12px 4px 0;"><strong>Well</strong></td><td>${safeWellName}</td></tr>
          <tr><td style="padding: 4px 12px 4px 0;"><strong>Identifier</strong></td><td>${safeWellIdentifier}</td></tr>
          <tr><td style="padding: 4px 12px 4px 0;"><strong>Status</strong></td><td>${safeStatus}</td></tr>
          <tr><td style="padding: 4px 12px 4px 0;"><strong>Set By</strong></td><td>${safeSetBy}</td></tr>
          <tr><td style="padding: 4px 12px 4px 0;"><strong>Field</strong></td><td>${safeField}</td></tr>
          <tr><td style="padding: 4px 12px 4px 0;"><strong>Formation</strong></td><td>${safeFormation}</td></tr>
          <tr><td style="padding: 4px 12px 4px 0;"><strong>Pump Change Window</strong></td><td>${safePumpWindow}</td></tr>
          <tr><td style="padding: 4px 12px 4px 0;"><strong>Notes</strong></td><td>${safeNotes}</td></tr>
        </table>
        <p style="margin-top: 16px;">
          <a href="${safeLink}">Open this well in WellFi</a>
        </p>
      </div>
    `;
    const emailText = [
      'Operational Status Update',
      `Well: ${wellName}`,
      `Identifier: ${well.formatted_id ?? 'N/A'}`,
      `Status: ${statusLabel}`,
      `Set By: ${statusRecord.set_by ?? 'Unknown'}`,
      `Field: ${well.field ?? 'N/A'}`,
      `Formation: ${well.formation ?? 'N/A'}`,
      `Pump Change Window: ${pumpWindow ?? 'Not scheduled'}`,
      `Notes: ${statusRecord.notes ?? 'None provided'}`,
      `Open in WellFi: ${wellLink}`,
    ].join('\n');

    const results: DeliveryResult[] = [];

    if (slackWebhookUrl) {
      try {
        await sendSlackNotification(slackWebhookUrl, slackMessage);
        results.push({ channel: 'slack', success: true, detail: 'Delivered' });
      } catch (error) {
        const detail = error instanceof Error ? error.message : String(error);
        console.error('Failed to send Slack notification:', detail);
        results.push({ channel: 'slack', success: false, detail });
      }
    }

    if (resendApiKey && notifyEmail) {
      try {
        await sendEmailNotification({
          apiKey: resendApiKey,
          from: emailFrom,
          to: notifyEmail,
          subject: emailSubject,
          html: emailHtml,
          text: emailText,
        });
        results.push({ channel: 'email', success: true, detail: `Delivered to ${notifyEmail}` });
      } catch (error) {
        const detail = error instanceof Error ? error.message : String(error);
        console.error('Failed to send email notification:', detail);
        results.push({ channel: 'email', success: false, detail });
      }
    }

    if (results.length === 0) {
      return new Response(JSON.stringify({ error: 'No notification channels configured' }), {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const successes = results.filter((result) => result.success);
    if (successes.length === 0) {
      return new Response(
        JSON.stringify({
          error: 'All configured notification channels failed',
          deliveries: results,
        }),
        {
          status: 502,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        },
      );
    }

    return new Response(
      JSON.stringify({
        success: true,
        deliveries: results,
      }),
      {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      },
    );
  } catch (error) {
    console.error(error);
    return new Response(
      JSON.stringify({ error: error instanceof Error ? error.message : String(error) }),
      {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      },
    );
  }
});
