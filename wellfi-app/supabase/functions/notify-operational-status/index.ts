import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';
import { corsHeaders } from '../_shared/cors.ts';

type WebhookEventType = 'INSERT' | 'UPDATE' | 'DELETE';
type WellEventState = 'watch' | 'warning' | 'down';
type FulfillmentStatus =
  | 'unassigned'
  | 'tool_reserved'
  | 'scheduled'
  | 'dispatched'
  | 'on_site'
  | 'completed'
  | 'cancelled';

interface TableWebhookPayload<T> {
  type: WebhookEventType;
  table: string;
  schema: string;
  record: T | null;
  old_record: T | null;
}

interface OperationalStatus {
  id: string;
  well_id: string;
  status: 'watch' | 'warning' | 'well_down';
  set_by: string;
  notes: string | null;
  pump_change_start: string | null;
  pump_change_end: string | null;
  is_active: boolean;
}

interface WellEventRecord {
  id: string;
  well_id: string;
  operator_id: string;
  state: WellEventState;
  is_active: boolean;
  is_abrupt: boolean;
  support_requested: boolean;
  expected_down_date: string | null;
  expected_start_date: string | null;
  expected_end_date: string | null;
  requested_tool_type: string | null;
  notes: string | null;
  created_by_name: string;
  updated_by_name: string | null;
  source_channel: 'app' | 'slack' | 'telegram' | 'admin';
  created_at: string;
  updated_at: string;
  cleared_at: string | null;
  cleared_by_name: string | null;
}

interface WellEventFulfillmentRecord {
  id: string;
  well_event_id: string;
  status: FulfillmentStatus;
  assigned_tool_id: string | null;
  assigned_tech_name: string | null;
  planned_service_date: string | null;
  expected_downtime_hours: number | null;
  estimated_production_loss_bbl: number | null;
  internal_notes: string | null;
  last_updated_by_name: string | null;
}

interface WellRecord {
  id: string;
  well_id: string;
  name: string | null;
  formatted_id: string | null;
  field: string | null;
  formation: string | null;
  operator_id: string | null;
}

interface OperatorRecord {
  id: string;
  display_name: string;
}

interface ToolRecord {
  id: string;
  serial_number: string;
  tool_type: string;
}

interface DeliveryResult {
  channel: 'slack' | 'email';
  success: boolean;
  detail: string;
}

interface NotificationDetail {
  label: string;
  value: string;
}

interface NotificationContext {
  title: string;
  color: string;
  actorName: string;
  notes: string | null;
  well: WellRecord;
  operatorName: string | null;
  details: NotificationDetail[];
}

const EVENT_STATE_LABELS: Record<string, string> = {
  watch: 'Watch',
  warning: 'Warning',
  down: 'Down',
  well_down: 'Well Down',
};

const EVENT_STATE_COLORS: Record<string, string> = {
  watch: '#3B82F6',
  warning: '#EAB308',
  down: '#EF4444',
  well_down: '#EF4444',
};

const FULFILLMENT_LABELS: Record<FulfillmentStatus, string> = {
  unassigned: 'Unassigned',
  tool_reserved: 'Tool Reserved',
  scheduled: 'Scheduled',
  dispatched: 'Dispatched',
  on_site: 'On Site',
  completed: 'Completed',
  cancelled: 'Cancelled',
};

const FULFILLMENT_COLORS: Record<FulfillmentStatus, string> = {
  unassigned: '#94A3B8',
  tool_reserved: '#22C55E',
  scheduled: '#0EA5E9',
  dispatched: '#8B5CF6',
  on_site: '#F97316',
  completed: '#14B8A6',
  cancelled: '#64748B',
};

function normalizeAppUrl(appUrl: string): string {
  return appUrl.replace(/\/+$/, '');
}

function formatDate(value: string | null): string {
  if (!value) return 'Not set';

  const parsed = parseDateInput(value);
  if (Number.isNaN(parsed.getTime())) {
    return value;
  }

  return parsed.toLocaleDateString('en-CA', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
  });
}

function formatDateTime(value: string | null): string {
  if (!value) return 'Not set';

  const parsed = new Date(value);
  if (Number.isNaN(parsed.getTime())) {
    return value;
  }

  return parsed.toLocaleString('en-CA', {
    dateStyle: 'medium',
    timeStyle: 'short',
  });
}

function parseDateInput(value: string): Date {
  const trimmed = value.trim();
  const dateOnlyMatch = trimmed.match(/^(\d{4})-(\d{2})-(\d{2})$/);

  if (dateOnlyMatch) {
    const [, year, month, day] = dateOnlyMatch;
    return new Date(Number(year), Number(month) - 1, Number(day));
  }

  return new Date(trimmed);
}

function escapeHtml(value: string): string {
  return value
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#39;');
}

function eventRank(state: string | null | undefined): number {
  if (state === 'watch') return 1;
  if (state === 'warning') return 2;
  if (state === 'down' || state === 'well_down') return 3;
  return 0;
}

function labelEventState(state: string | null | undefined): string {
  if (!state) return 'Unknown';
  return EVENT_STATE_LABELS[state] ?? state;
}

function buildWindowLabel(record: WellEventRecord): string | null {
  if (record.expected_down_date) {
    return formatDate(record.expected_down_date);
  }

  if (record.expected_start_date || record.expected_end_date) {
    return `${formatDate(record.expected_start_date)} to ${formatDate(record.expected_end_date)}`;
  }

  return null;
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

async function loadWellContext(supabase: ReturnType<typeof createClient>, wellId: string) {
  const { data: well, error: wellError } = await supabase
    .from('wells')
    .select('id, well_id, name, formatted_id, field, formation, operator_id')
    .eq('id', wellId)
    .single<WellRecord>();

  if (wellError || !well) {
    throw wellError ?? new Error(`Well ${wellId} not found`);
  }

  let operatorName: string | null = null;
  if (well.operator_id) {
    const { data: operator } = await supabase
      .from('operators')
      .select('id, display_name')
      .eq('id', well.operator_id)
      .single<OperatorRecord>();

    operatorName = operator?.display_name ?? null;
  }

  return { well, operatorName };
}

async function loadToolContext(
  supabase: ReturnType<typeof createClient>,
  toolId: string | null,
): Promise<ToolRecord | null> {
  if (!toolId) {
    return null;
  }

  const { data: tool } = await supabase
    .from('tool_inventory')
    .select('id, serial_number, tool_type')
    .eq('id', toolId)
    .single<ToolRecord>();

  return tool ?? null;
}

async function loadWellEventContext(
  supabase: ReturnType<typeof createClient>,
  eventId: string,
): Promise<WellEventRecord> {
  const { data: event, error } = await supabase
    .from('well_events')
    .select('*')
    .eq('id', eventId)
    .single<WellEventRecord>();

  if (error || !event) {
    throw error ?? new Error(`Well event ${eventId} not found`);
  }

  return event;
}

async function buildLegacyOperationalStatusContext(
  supabase: ReturnType<typeof createClient>,
  payload: TableWebhookPayload<OperationalStatus>,
): Promise<NotificationContext | null> {
  const record = payload.record;

  if (!record?.id || !record.well_id || !record.status || !record.is_active) {
    return null;
  }

  const { well, operatorName } = await loadWellContext(supabase, record.well_id);
  const pumpWindow =
    record.pump_change_start || record.pump_change_end
      ? `${formatDate(record.pump_change_start)} to ${formatDate(record.pump_change_end)}`
      : 'Not set';

  return {
    title: `Legacy Status Update: ${labelEventState(record.status)}`,
    color: EVENT_STATE_COLORS[record.status] ?? '#94A3B8',
    actorName: record.set_by ?? 'Unknown',
    notes: record.notes,
    well,
    operatorName,
    details: [
      { label: 'Operator', value: operatorName ?? 'Unknown' },
      { label: 'Stage', value: labelEventState(record.status) },
      { label: 'Field', value: well.field ?? 'N/A' },
      { label: 'Formation', value: well.formation ?? 'N/A' },
      { label: 'Pump Window', value: pumpWindow },
    ],
  };
}

async function buildWellEventNotificationContext(
  supabase: ReturnType<typeof createClient>,
  payload: TableWebhookPayload<WellEventRecord>,
): Promise<NotificationContext | null> {
  const record = payload.record;
  const oldRecord = payload.old_record;

  if (!record?.id || !record.well_id) {
    return null;
  }

  let title: string | null = null;
  if (payload.type === 'INSERT' && record.is_active) {
    title = `Well Event Created: ${labelEventState(record.state)}`;
  } else if (
    payload.type === 'UPDATE'
    && oldRecord?.is_active
    && !record.is_active
  ) {
    title = 'Well Event Cleared';
  } else if (
    payload.type === 'UPDATE'
    && record.is_active
    && oldRecord?.is_active
    && record.state !== oldRecord.state
  ) {
    title = eventRank(record.state) > eventRank(oldRecord.state)
      ? `Well Event Escalated: ${labelEventState(record.state)}`
      : `Well Event De-escalated: ${labelEventState(record.state)}`;
  } else {
    return null;
  }

  const { well, operatorName } = await loadWellContext(supabase, record.well_id);
  const scheduleLabel = buildWindowLabel(record) ?? (record.is_abrupt ? 'Abrupt / not scheduled' : 'Not set');
  const actorName =
    record.cleared_by_name
    ?? record.updated_by_name
    ?? record.created_by_name
    ?? 'Unknown';

  return {
    title,
    color: EVENT_STATE_COLORS[record.state] ?? '#94A3B8',
    actorName,
    notes: record.notes,
    well,
    operatorName,
    details: [
      { label: 'Operator', value: operatorName ?? 'Unknown' },
      { label: 'Stage', value: labelEventState(record.state) },
      { label: 'Field', value: well.field ?? 'N/A' },
      { label: 'Formation', value: well.formation ?? 'N/A' },
      { label: 'Schedule', value: scheduleLabel },
      { label: 'Support', value: record.support_requested ? 'Requested' : 'Not requested' },
      { label: 'Requested Tool', value: record.requested_tool_type ?? 'Not set' },
      { label: 'Source', value: record.source_channel ?? 'app' },
      { label: 'Updated', value: formatDateTime(record.updated_at) },
    ],
  };
}

async function buildFulfillmentNotificationContext(
  supabase: ReturnType<typeof createClient>,
  payload: TableWebhookPayload<WellEventFulfillmentRecord>,
): Promise<NotificationContext | null> {
  const record = payload.record;
  const oldRecord = payload.old_record;

  if (payload.type !== 'UPDATE' || !record?.well_event_id || !oldRecord) {
    return null;
  }

  const event = await loadWellEventContext(supabase, record.well_event_id);
  const { well, operatorName } = await loadWellContext(supabase, event.well_id);
  const tool = await loadToolContext(supabase, record.assigned_tool_id);

  let title: string | null = null;
  if (record.assigned_tool_id !== oldRecord.assigned_tool_id && record.assigned_tool_id) {
    title = 'Tool Assigned';
  } else if (record.planned_service_date !== oldRecord.planned_service_date && record.planned_service_date) {
    title = 'Service Date Scheduled';
  } else if (
    record.status !== oldRecord.status
    && ['dispatched', 'on_site', 'completed'].includes(record.status)
  ) {
    title = `Fulfillment Updated: ${FULFILLMENT_LABELS[record.status]}`;
  } else {
    return null;
  }

  return {
    title,
    color: FULFILLMENT_COLORS[record.status] ?? EVENT_STATE_COLORS[event.state] ?? '#94A3B8',
    actorName: record.last_updated_by_name ?? 'Unknown',
    notes: record.internal_notes,
    well,
    operatorName,
    details: [
      { label: 'Operator', value: operatorName ?? 'Unknown' },
      { label: 'Event', value: labelEventState(event.state) },
      { label: 'Fulfillment', value: FULFILLMENT_LABELS[record.status] },
      { label: 'Assigned Tool', value: tool ? `${tool.serial_number} (${tool.tool_type})` : 'Not assigned' },
      { label: 'Planned Service', value: formatDate(record.planned_service_date) },
      { label: 'Assigned Tech', value: record.assigned_tech_name ?? 'Not assigned' },
      { label: 'Expected Downtime', value: record.expected_downtime_hours != null ? `${record.expected_downtime_hours} hr` : 'Not set' },
      { label: 'Production Impact', value: record.estimated_production_loss_bbl != null ? `${record.estimated_production_loss_bbl} bbl` : 'Not set' },
    ],
  };
}

function buildSlackMessage(context: NotificationContext, wellLink: string): Record<string, unknown> {
  const fieldBlocks = context.details.slice(0, 8).map((detail) => ({
    type: 'mrkdwn',
    text: `*${detail.label}:*\n${detail.value}`,
  }));

  const attachmentBlocks: Record<string, unknown>[] = [];
  if (context.notes) {
    attachmentBlocks.push({
      type: 'section',
      text: {
        type: 'mrkdwn',
        text: `*Notes:*\n${context.notes}`,
      },
    });
  }

  return {
    blocks: [
      {
        type: 'header',
        text: {
          type: 'plain_text',
          text: context.title,
          emoji: true,
        },
      },
      {
        type: 'section',
        text: {
          type: 'mrkdwn',
          text: `*${context.well.name ?? context.well.formatted_id ?? context.well.well_id}*${context.well.formatted_id ? `\n${context.well.formatted_id}` : ''}`,
        },
      },
      {
        type: 'section',
        fields: fieldBlocks,
      },
      {
        type: 'context',
        elements: [
          {
            type: 'mrkdwn',
            text: `Updated by *${context.actorName}*`,
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
              text: 'Open Well in WellFi',
              emoji: true,
            },
            url: wellLink,
            action_id: 'open_wellfi_well',
          },
        ],
      },
    ],
    attachments: attachmentBlocks.length > 0
      ? [{ color: context.color, blocks: attachmentBlocks }]
      : [{ color: context.color }],
  };
}

function buildEmail(context: NotificationContext, wellLink: string) {
  const emailSubject = `WellFi ${context.title}: ${context.well.name ?? context.well.well_id}`;
  const rows = context.details
    .map((detail) => `<tr><td style="padding: 4px 12px 4px 0;"><strong>${escapeHtml(detail.label)}</strong></td><td>${escapeHtml(detail.value)}</td></tr>`)
    .join('');

  const safeNotes = escapeHtml(context.notes ?? 'None provided');
  const safeLink = escapeHtml(wellLink);

  const emailHtml = `
    <div style="font-family: Arial, sans-serif; color: #111827;">
      <h2 style="margin-bottom: 12px;">${escapeHtml(context.title)}</h2>
      <table style="border-collapse: collapse;">
        <tr><td style="padding: 4px 12px 4px 0;"><strong>Well</strong></td><td>${escapeHtml(context.well.name ?? context.well.well_id)}</td></tr>
        <tr><td style="padding: 4px 12px 4px 0;"><strong>Identifier</strong></td><td>${escapeHtml(context.well.formatted_id ?? context.well.well_id)}</td></tr>
        <tr><td style="padding: 4px 12px 4px 0;"><strong>Updated By</strong></td><td>${escapeHtml(context.actorName)}</td></tr>
        ${rows}
        <tr><td style="padding: 4px 12px 4px 0;"><strong>Notes</strong></td><td>${safeNotes}</td></tr>
      </table>
      <p style="margin-top: 16px;">
        <a href="${safeLink}">Open this well in WellFi</a>
      </p>
    </div>
  `;

  const emailText = [
    context.title,
    `Well: ${context.well.name ?? context.well.well_id}`,
    `Identifier: ${context.well.formatted_id ?? context.well.well_id}`,
    `Updated By: ${context.actorName}`,
    ...context.details.map((detail) => `${detail.label}: ${detail.value}`),
    `Notes: ${context.notes ?? 'None provided'}`,
    `Open in WellFi: ${wellLink}`,
  ].join('\n');

  return {
    subject: emailSubject,
    html: emailHtml,
    text: emailText,
  };
}

serve(async (req: Request) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const payload = await req.json() as TableWebhookPayload<unknown>;
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!,
    );

    let context: NotificationContext | null = null;
    if (payload.table === 'well_events') {
      context = await buildWellEventNotificationContext(
        supabase,
        payload as TableWebhookPayload<WellEventRecord>,
      );
    } else if (payload.table === 'well_event_fulfillment') {
      context = await buildFulfillmentNotificationContext(
        supabase,
        payload as TableWebhookPayload<WellEventFulfillmentRecord>,
      );
    } else if (payload.table === 'operational_statuses') {
      context = await buildLegacyOperationalStatusContext(
        supabase,
        payload as TableWebhookPayload<OperationalStatus>,
      );
    }

    if (!context) {
      return new Response(JSON.stringify({ message: 'No notification generated for payload' }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const appUrl = normalizeAppUrl(Deno.env.get('APP_URL') ?? 'https://wellfi.vercel.app');
    const slackWebhookUrl = Deno.env.get('SLACK_WEBHOOK_URL');
    const resendApiKey = Deno.env.get('RESEND_API_KEY');
    const notifyEmail = Deno.env.get('NOTIFY_EMAIL');
    const emailFrom = Deno.env.get('EMAIL_FROM') ?? 'WellFi <onboarding@resend.dev>';
    const wellLink = `${appUrl}/map?well_id=${encodeURIComponent(context.well.well_id)}`;

    const slackMessage = buildSlackMessage(context, wellLink);
    const email = buildEmail(context, wellLink);
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
          subject: email.subject,
          html: email.html,
          text: email.text,
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
          notification: {
            title: context.title,
            wellLink,
          },
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
        notification: {
          title: context.title,
          wellLink,
        },
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
