import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import XLSX from 'xlsx';
import { createClient } from '@supabase/supabase-js';

interface RolloutRow {
  operator_slug?: string;
  source_operator_name?: string;
  username?: string;
  pilot_flag?: string;
  onboarding_status?: string;
  import_status?: string;
  smoke_test_status?: string;
  clearwater_wells?: string;
  bluesky_wells?: string;
}

interface CliOptions {
  operatorSlug: string;
  manifestPath: string;
  dryRun: boolean;
}

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const DEFAULT_MANIFEST_PATH = path.resolve(__dirname, '..', '..', 'Data', 'operator_rollout_manifest_clearwater_bluesky.csv');
const VALID_ONBOARDING_STATUSES = new Set(['inventory', 'planned', 'pilot', 'ready', 'paused']);

function printHelp() {
  process.stdout.write(
    [
      'Usage: tsx scripts/provision_operator_users.ts --operator <slug> [options]',
      '',
      'Provision one operator row plus one viewer login from the rollout manifest.',
      '',
      'Options:',
      '  --operator <slug>    Operator slug from the rollout manifest',
      '  --manifest <path>    Rollout manifest CSV',
      '  --dry-run            Build the onboarding packet without writing to Supabase',
      '  --help               Show this message',
      '',
      'Required env for live runs:',
      '  SUPABASE_URL or VITE_SUPABASE_URL',
      '  SUPABASE_SERVICE_ROLE_KEY',
      '  WELLFI_DEFAULT_COMPANY_PASSWORD',
      '',
    ].join('\n'),
  );
}

function parseArgs(argv: string[]): CliOptions {
  let operatorSlug = normalize(process.env.npm_config_operator);
  if (operatorSlug === 'true') {
    operatorSlug = '';
  }
  let manifestPath = normalize(process.env.npm_config_manifest) || DEFAULT_MANIFEST_PATH;
  let dryRun = normalize(process.env.npm_config_dry_run).toLowerCase() === 'true';

  for (let index = 0; index < argv.length; index += 1) {
    const arg = argv[index];
    if (arg === '--help') {
      printHelp();
      process.exit(0);
    }

    if (arg === '--operator') {
      operatorSlug = String(argv[index + 1] ?? '');
      index += 1;
      continue;
    }

    if (arg === '--manifest') {
      manifestPath = path.resolve(argv[index + 1] ?? '');
      index += 1;
      continue;
    }

    if (arg === '--dry-run') {
      dryRun = true;
      continue;
    }

    if (!arg.startsWith('-')) {
      operatorSlug = operatorSlug || normalize(arg);
      continue;
    }

    throw new Error(`Unknown argument: ${arg}`);
  }

  if (!operatorSlug) {
    throw new Error('Missing required argument: --operator <slug>');
  }

  return {
    operatorSlug: normalize(operatorSlug),
    manifestPath,
    dryRun,
  };
}

function normalize(value: unknown): string {
  return String(value ?? '').trim();
}

function diag(message: string): void {
  process.stderr.write(`${message}\n`);
}

function parseRows<T>(filePath: string): T[] {
  const workbook = XLSX.readFile(filePath, { raw: false });
  const firstSheetName = workbook.SheetNames[0];
  const sheet = workbook.Sheets[firstSheetName];
  return XLSX.utils.sheet_to_json<T>(sheet, {
    defval: '',
    raw: false,
  });
}

function deriveBasinScope(row: RolloutRow): string {
  const clearwaterCount = Number(normalize(row.clearwater_wells) || '0');
  const blueskyCount = Number(normalize(row.bluesky_wells) || '0');

  if (clearwaterCount > 0 && blueskyCount > 0) {
    return 'Clearwater|Bluesky';
  }

  if (clearwaterCount > 0) {
    return 'Clearwater';
  }

  if (blueskyCount > 0) {
    return 'Bluesky';
  }

  return 'Clearwater|Bluesky';
}

function parsePilotFlag(value: string): boolean {
  return ['yes', 'true', 'pilot', 'recommended'].includes(normalize(value).toLowerCase());
}

function sanitizeOnboardingStatus(value: string): string {
  const normalized = normalize(value).toLowerCase();
  return VALID_ONBOARDING_STATUSES.has(normalized) ? normalized : 'planned';
}

async function main() {
  const options = parseArgs(process.argv.slice(2));

  if (!fs.existsSync(options.manifestPath)) {
    throw new Error(`Manifest file not found: ${options.manifestPath}`);
  }

  const manifestRows = parseRows<RolloutRow>(options.manifestPath);
  const rolloutRow = manifestRows.find(
    (row) => normalize(row.operator_slug) === options.operatorSlug,
  );

  if (!rolloutRow) {
    throw new Error(`Operator ${options.operatorSlug} was not found in ${options.manifestPath}`);
  }

  const displayName = normalize(rolloutRow.source_operator_name);
  const username = normalize(rolloutRow.username) || options.operatorSlug;
  const loginEmail = `${username}@wellfi.local`;
  const basinScope = deriveBasinScope(rolloutRow);
  const onboardingStatus = sanitizeOnboardingStatus(normalize(rolloutRow.onboarding_status));
  const isPilot = parsePilotFlag(normalize(rolloutRow.pilot_flag));

  const operatorSpec = {
    slug: options.operatorSlug,
    display_name: displayName,
    status: 'active',
    onboarding_status: onboardingStatus,
    is_pilot: isPilot,
    basin_scope: basinScope,
  };

  const appUserSpec = {
    username,
    display_name: displayName,
    role: 'viewer',
    operator_slug: options.operatorSlug,
    email: loginEmail,
  };

  let operatorId: string | null = null;
  let authUserId: string | null = null;
  let authAction = 'dry-run';
  let appUserAction = 'dry-run';
  let operatorAction = 'dry-run';

  if (!options.dryRun) {
    const supabaseUrl = process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL;
    const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
    const defaultPassword = process.env.WELLFI_DEFAULT_COMPANY_PASSWORD;

    if (!supabaseUrl || !serviceRoleKey || !defaultPassword) {
      throw new Error('Set SUPABASE_URL (or VITE_SUPABASE_URL), SUPABASE_SERVICE_ROLE_KEY, and WELLFI_DEFAULT_COMPANY_PASSWORD');
    }

    const supabase = createClient(supabaseUrl, serviceRoleKey, {
      auth: { persistSession: false },
    });

    const { data: operatorData, error: operatorError } = await supabase
      .from('operators')
      .upsert(operatorSpec, { onConflict: 'slug' })
      .select('id')
      .single();

    if (operatorError || !operatorData) {
      throw operatorError ?? new Error(`Failed to provision operator ${options.operatorSlug}`);
    }

    operatorId = operatorData.id;
    operatorAction = 'upserted';

    const { data: authUsersData, error: listUsersError } = await supabase.auth.admin.listUsers({
      page: 1,
      perPage: 1000,
    });

    if (listUsersError) {
      throw listUsersError;
    }

    const existingAuthUser = authUsersData.users.find((user) => normalize(user.email).toLowerCase() === loginEmail.toLowerCase());

    if (existingAuthUser) {
      authUserId = existingAuthUser.id;
      authAction = 'reused';

      const { error: updateAuthError } = await supabase.auth.admin.updateUserById(existingAuthUser.id, {
        email_confirm: true,
        user_metadata: {
          username,
          operator_slug: options.operatorSlug,
        },
      });

      if (updateAuthError) {
        throw updateAuthError;
      }
    } else {
      const { data: createdUserData, error: createAuthError } = await supabase.auth.admin.createUser({
        email: loginEmail,
        password: defaultPassword,
        email_confirm: true,
        user_metadata: {
          username,
          operator_slug: options.operatorSlug,
        },
      });

      if (createAuthError || !createdUserData.user) {
        throw createAuthError ?? new Error(`Failed to create auth user for ${loginEmail}`);
      }

      authUserId = createdUserData.user.id;
      authAction = 'created';
    }

    const { data: existingAppUser } = await supabase
      .from('app_users')
      .select('id')
      .eq('username', username)
      .maybeSingle();

    if (existingAppUser && existingAppUser.id !== authUserId) {
      throw new Error(`Username collision: ${username} already belongs to another app_users row`);
    }

    const { error: appUserError } = await supabase
      .from('app_users')
      .upsert(
        {
          id: authUserId,
          username,
          display_name: displayName,
          role: 'viewer',
          operator_id: operatorId,
        },
        { onConflict: 'id' },
      );

    if (appUserError) {
      throw appUserError;
    }

    appUserAction = existingAppUser ? 'updated' : 'created';
  }

  diag(`Prepared operator packet for ${displayName}`);

  process.stdout.write(
    `${JSON.stringify(
      {
        operatorSlug: options.operatorSlug,
        manifestPath: options.manifestPath,
        dryRun: options.dryRun,
        operatorSpec,
        appUserSpec,
        result: {
          operatorId,
          authUserId,
          operatorAction,
          authAction,
          appUserAction,
        },
        checklist: {
          manifestRowFound: true,
          operatorProvisioned: options.dryRun ? 'dry-run' : 'done',
          authUserProvisioned: options.dryRun ? 'dry-run' : 'done',
          appUserProvisioned: options.dryRun ? 'dry-run' : 'done',
          nextStep: `tsx scripts/import_operator_basin_wells.ts --operator ${options.operatorSlug}`,
        },
      },
      null,
      2,
    )}\n`,
  );
}

main().catch((error: unknown) => {
  process.stderr.write(`${error instanceof Error ? error.message : String(error)}\n`);
  process.exit(1);
});
