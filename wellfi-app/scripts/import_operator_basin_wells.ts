import path from 'node:path';

import {
  DEFAULT_MANIFEST_PATH,
  DEFAULT_SOURCE_PATH,
  applyOperatorImport,
  assertFileExists,
  loadManifestRows,
  loadSourceRows,
  prepareOperatorImport,
} from './lib/operator_basin_sync.js';

interface CliOptions {
  operatorSlug: string;
  sourcePath: string;
  manifestPath: string;
  dryRun: boolean;
}

function printHelp(): void {
  process.stdout.write(
    [
      'Usage: tsx scripts/import_operator_basin_wells.ts --operator <slug> [options]',
      '',
      'Sync one operator from the Clearwater / Bluesky basin snapshot into Supabase.',
      '',
      'Write behavior:',
      '  - inserts missing wells',
      '  - safely updates a limited field set on existing wells',
      '  - does not delete wells missing from the current snapshot',
      '',
      'Options:',
      '  --operator <slug>    Operator slug from the rollout manifest',
      `  --source <path>      Basin CSV/XLSX snapshot (default: ${DEFAULT_SOURCE_PATH})`,
      `  --manifest <path>    Rollout manifest CSV (default: ${DEFAULT_MANIFEST_PATH})`,
      '  --dry-run            Build the sync packet without writing to Supabase',
      '  --help               Show this message',
      '',
    ].join('\n'),
  );
}

function normalize(value: unknown): string {
  return String(value ?? '').trim();
}

function parseArgs(argv: string[]): CliOptions {
  let operatorSlug = normalize(process.env.npm_config_operator);
  if (operatorSlug === 'true') {
    operatorSlug = '';
  }
  let sourcePath = normalize(process.env.npm_config_source) || DEFAULT_SOURCE_PATH;
  let manifestPath = normalize(process.env.npm_config_manifest) || DEFAULT_MANIFEST_PATH;
  let dryRun = normalize(process.env.npm_config_dry_run).toLowerCase() === 'true';

  for (let index = 0; index < argv.length; index += 1) {
    const arg = argv[index];

    if (arg === '--help') {
      printHelp();
      process.exit(0);
    }

    if (arg === '--operator') {
      operatorSlug = normalize(argv[index + 1]);
      index += 1;
      continue;
    }

    if (arg === '--source') {
      sourcePath = path.resolve(argv[index + 1] ?? '');
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
    operatorSlug,
    sourcePath,
    manifestPath,
    dryRun,
  };
}

function diag(message: string): void {
  process.stderr.write(`${message}\n`);
}

async function main(): Promise<void> {
  const options = parseArgs(process.argv.slice(2));

  assertFileExists(options.sourcePath, 'Source file');
  assertFileExists(options.manifestPath, 'Manifest file');

  const sourceRows = loadSourceRows(options.sourcePath);
  const manifestRows = loadManifestRows(options.manifestPath);
  const prepared = prepareOperatorImport({
    operatorSlug: options.operatorSlug,
    sourceRows,
    manifestRows,
    sourcePath: options.sourcePath,
    manifestPath: options.manifestPath,
  });

  const result = await applyOperatorImport(prepared, {
    dryRun: options.dryRun,
    logger: diag,
    insertNewSnapshotWells: true,
  });

  process.stdout.write(`${JSON.stringify(result, null, 2)}\n`);
}

main().catch((error: unknown) => {
  process.stderr.write(`${error instanceof Error ? error.message : String(error)}\n`);
  process.exit(1);
});
