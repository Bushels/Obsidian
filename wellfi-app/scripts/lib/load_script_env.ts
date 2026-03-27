import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const REPO_ROOT = path.resolve(__dirname, '..', '..');
const ENV_FILES = ['.env', '.env.local'] as const;

let loaded = false;

function parseEnvLine(line: string): { key: string; value: string } | null {
  const trimmed = line.trim();
  if (!trimmed || trimmed.startsWith('#')) {
    return null;
  }

  const delimiterIndex = trimmed.indexOf('=');
  if (delimiterIndex <= 0) {
    return null;
  }

  const key = trimmed.slice(0, delimiterIndex).trim();
  if (!key) {
    return null;
  }

  let value = trimmed.slice(delimiterIndex + 1).trim();

  if (
    (value.startsWith('"') && value.endsWith('"')) ||
    (value.startsWith("'") && value.endsWith("'"))
  ) {
    value = value.slice(1, -1);
  }

  return { key, value };
}

export function loadScriptEnv(): void {
  if (loaded) {
    return;
  }

  const fileLoadedKeys = new Set<string>();

  for (const envFile of ENV_FILES) {
    const envPath = path.join(REPO_ROOT, envFile);
    if (!fs.existsSync(envPath)) {
      continue;
    }

    const lines = fs.readFileSync(envPath, 'utf8').split(/\r?\n/);
    for (const line of lines) {
      const parsed = parseEnvLine(line);
      if (!parsed) {
        continue;
      }

      const shouldAssign =
        process.env[parsed.key] == null || fileLoadedKeys.has(parsed.key);

      if (shouldAssign) {
        process.env[parsed.key] = parsed.value;
        fileLoadedKeys.add(parsed.key);
      }
    }
  }

  loaded = true;
}
