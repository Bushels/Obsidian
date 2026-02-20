
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

serve(async (req: Request) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const payload = await req.json();
    const statusRecord = payload.record as OperationalStatus;

    // We only care about active statuses being set
    if (!statusRecord.is_active) {
      return new Response(JSON.stringify({ message: 'Status not active, ignoring' }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // 1. Fetch well details
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
    );

    const { data: well, error: wellError } = await supabase
      .from('wells')
      .select('name, formatted_id, field, formation')
      .eq('id', statusRecord.well_id)
      .single();

    if (wellError) {
      console.error('Error fetching well:', wellError);
      throw wellError;
    }

    // 2. Format Slack Message
    const appUrl = Deno.env.get('APP_URL') ?? 'https://wellfi.vercel.app';
    const wellName = well.name ?? well.formatted_id ?? 'Unknown Well';
    const wellIdStr = well.formatted_id ? `(${well.formatted_id})` : '';
    
    // Status color mapping
    const statusColors = {
      watch: '#3B82F6',   // Blue
      warning: '#EAB308', // Yellow/Orange
      well_down: '#EF4444' // Red
    };
    const color = statusColors[statusRecord.status] || '#888888';

    // Format Status Label
    const statusLabels = {
      watch: 'Watch',
      warning: 'Warning',
      well_down: 'Well Down'
    };
    const statusLabel = statusLabels[statusRecord.status] || statusRecord.status;

    const slackMessage = {
      blocks: [
        {
          type: 'header',
          text: {
            type: 'plain_text',
            text: `🚨 Operational Status Update: ${statusLabel}`,
            emoji: true
          }
        },
        {
          type: 'section',
          fields: [
            {
              type: 'mrkdwn',
              text: `*Well:*\n${wellName} ${wellIdStr}`
            },
            {
              type: 'mrkdwn',
              text: `*Status:*\n${statusLabel}`
            },
            {
              type: 'mrkdwn',
              text: `*Set By:*\n${statusRecord.set_by}`
            },
            {
              type: 'mrkdwn',
              text: `*Field:*\n${well.field ?? 'N/A'}`
            }
          ]
        }
      ],
      attachments: [
        {
          color: color,
          blocks: [] as any[]
        }
      ]
    };

    // Add Notes if present
    if (statusRecord.notes) {
      slackMessage.attachments[0].blocks.push({
        type: 'section',
        text: {
          type: 'mrkdwn',
          text: `*Notes:*\n${statusRecord.notes}`
        }
      });
    }

    // Add Pump Change details if present
    if (statusRecord.pump_change_start || statusRecord.pump_change_end) {
       const start = statusRecord.pump_change_start ?? 'Not set';
       const end = statusRecord.pump_change_end ?? 'Not set';
       
       slackMessage.attachments[0].blocks.push({
        type: 'section',
        text: {
          type: 'mrkdwn',
          text: `*Pump Change Window:*\n${start} to ${end}`
        }
      });
    }
    
    // Add Link Button
    slackMessage.blocks.push({
      type: 'actions',
      elements: [
        {
          type: 'button',
          text: {
            type: 'plain_text',
            text: 'View Well Details',
            emoji: true
          },
          url: `${appUrl}/map?well_id=${statusRecord.well_id}`,
          action_id: 'view_well'
        }
      ]
    } as any);

    // 3. Send to Slack
    const SLACK_WEBHOOK_URL = Deno.env.get('SLACK_WEBHOOK_URL');
    if (SLACK_WEBHOOK_URL) {
      const slackResponse = await fetch(SLACK_WEBHOOK_URL, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(slackMessage),
      });

      if (!slackResponse.ok) {
        console.error('Failed to send to Slack:', await slackResponse.text());
      }
    } else {
      console.warn('SLACK_WEBHOOK_URL not set');
    }

    return new Response(JSON.stringify({ success: true }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });

  } catch (error) {
    console.error(error);
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});
