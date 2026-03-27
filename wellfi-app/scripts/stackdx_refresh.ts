import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';
import { chromium, type AriaRole, type Browser, type BrowserContext, type Locator, type Page } from 'playwright';

type SelectorType = 'css' | 'text' | 'label' | 'placeholder' | 'role' | 'testid';

interface SelectorSpec {
  type: SelectorType;
  value?: string;
  role?: AriaRole;
  name?: string;
  exact?: boolean;
}

interface StackDxJob {
  name: string;
  url?: string;
  prompt?: string;
  promptTargets?: SelectorSpec[];
  submitTargets?: SelectorSpec[];
  downloadTargets?: SelectorSpec[];
  waitForText?: string;
  waitForMs?: number;
  saveAs?: string;
}

interface StackDxConfig {
  loginUrl?: string;
  downloadsDir?: string;
  artifactsDir?: string;
  promptTargets?: SelectorSpec[];
  submitTargets?: SelectorSpec[];
  downloadTargets?: SelectorSpec[];
  jobs: StackDxJob[];
}

interface CliOptions {
  configPath: string;
  jobName?: string;
  headed: boolean;
}

const DEFAULT_LOGIN_URL = 'https://app.stackdx.com/Launch';
const DEFAULT_CONFIG_PATH = '.codex/stackdx-jobs.local.json';
const DEFAULT_DOWNLOADS_DIR = 'output/stackdx/downloads';
const DEFAULT_ARTIFACTS_DIR = 'output/stackdx/artifacts';
const DEFAULT_STORAGE_STATE_PATH = 'output/stackdx/storage-state.json';
const DEFAULT_TIMEOUT_MS = 15_000;

function parseArgs(argv: string[]): CliOptions {
  const options: CliOptions = {
    configPath: process.env.STACKDX_JOB_CONFIG || DEFAULT_CONFIG_PATH,
    headed: process.env.STACKDX_HEADLESS !== 'true',
  };

  for (let i = 0; i < argv.length; i += 1) {
    const arg = argv[i];
    if (arg === '--config' && argv[i + 1]) {
      options.configPath = argv[i + 1];
      i += 1;
      continue;
    }

    if (arg === '--job' && argv[i + 1]) {
      options.jobName = argv[i + 1];
      i += 1;
      continue;
    }

    if (arg === '--headless') {
      options.headed = false;
      continue;
    }

    if (arg === '--headed') {
      options.headed = true;
      continue;
    }

    if (arg === '--help') {
      printUsage();
      process.exit(0);
    }

    if (!arg.startsWith('-')) {
      options.configPath = arg;
    }
  }

  return options;
}

function printUsage(): void {
  console.log(`Usage: npm run stackdx:refresh -- [config-path] [--job name] [--headless|--headed]
       npm run stackdx:refresh -- .codex/stackdx-jobs.local.json --job obsidian-wells
       npx tsx scripts/stackdx_refresh.ts --config .codex/stackdx-jobs.local.json

Environment:
  STACKDX_EMAIL           StackDX username/email
  STACKDX_PASSWORD        StackDX password
  STACKDX_JOB_CONFIG      Optional path to the job config JSON
  STACKDX_STORAGE_STATE   Optional path for Playwright storage state
  STACKDX_HEADLESS=true   Run Chromium headlessly by default`);
}

function resolveFromRepo(repoRoot: string, candidate: string | undefined, fallback: string): string {
  const target = candidate || fallback;
  return path.isAbsolute(target) ? target : path.resolve(repoRoot, target);
}

function ensureDir(targetDir: string): void {
  fs.mkdirSync(targetDir, { recursive: true });
}

function loadConfig(configPath: string): StackDxConfig {
  const raw = fs.readFileSync(configPath, 'utf8');
  const parsed = JSON.parse(raw) as StackDxConfig;
  if (!Array.isArray(parsed.jobs) || parsed.jobs.length === 0) {
    throw new Error(`No jobs found in ${configPath}`);
  }
  return parsed;
}

function getLocator(page: Page, selector: SelectorSpec): Locator {
  switch (selector.type) {
    case 'css':
      if (!selector.value) throw new Error('css selector requires value');
      return page.locator(selector.value);
    case 'text':
      if (!selector.value) throw new Error('text selector requires value');
      return page.getByText(selector.value, { exact: selector.exact });
    case 'label':
      if (!selector.value) throw new Error('label selector requires value');
      return page.getByLabel(selector.value, { exact: selector.exact });
    case 'placeholder':
      if (!selector.value) throw new Error('placeholder selector requires value');
      return page.getByPlaceholder(selector.value, { exact: selector.exact });
    case 'role':
      if (!selector.role) throw new Error('role selector requires role');
      return page.getByRole(selector.role, {
        name: selector.name || selector.value,
        exact: selector.exact,
      });
    case 'testid':
      if (!selector.value) throw new Error('testid selector requires value');
      return page.getByTestId(selector.value);
    default:
      throw new Error(`Unsupported selector type: ${(selector as SelectorSpec).type}`);
  }
}

async function firstVisibleLocator(page: Page, selectors: SelectorSpec[] | undefined): Promise<Locator | null> {
  if (!selectors || selectors.length === 0) {
    return null;
  }

  for (const selector of selectors) {
    const locator = getLocator(page, selector).first();
    try {
      if (await locator.isVisible({ timeout: 1_000 })) {
        return locator;
      }
    } catch {
      continue;
    }
  }

  return null;
}

async function isVisible(locator: Locator, timeout = DEFAULT_TIMEOUT_MS): Promise<boolean> {
  try {
    await locator.waitFor({ state: 'visible', timeout });
    return true;
  } catch {
    return false;
  }
}

async function clickFirst(page: Page, selectors: SelectorSpec[] | undefined, label: string): Promise<void> {
  const locator = await firstVisibleLocator(page, selectors);
  if (!locator) {
    throw new Error(`Could not find ${label} on ${page.url()}`);
  }
  await locator.click({ timeout: DEFAULT_TIMEOUT_MS });
}

async function fillPrompt(locator: Locator, page: Page, prompt: string): Promise<void> {
  const controlType = await locator.evaluate((element) => {
    const htmlElement = element as HTMLElement;
    return {
      tagName: element.tagName.toLowerCase(),
      isContentEditable: htmlElement.isContentEditable,
    };
  });

  if (controlType.tagName === 'input' || controlType.tagName === 'textarea') {
    await locator.fill(prompt, { timeout: DEFAULT_TIMEOUT_MS });
    return;
  }

  await locator.click({ timeout: DEFAULT_TIMEOUT_MS });
  await page.keyboard.press(process.platform === 'darwin' ? 'Meta+A' : 'Control+A');
  await page.keyboard.insertText(prompt);
}

async function captureScreenshot(page: Page, artifactsDir: string, name: string): Promise<void> {
  const sanitized = name.replace(/[^a-z0-9-_]+/gi, '_').toLowerCase();
  await page.screenshot({
    path: path.join(artifactsDir, `${sanitized}.png`),
    fullPage: true,
  });
}

async function waitForInvitationError(page: Page): Promise<void> {
  const invitationText = page.getByText('An invitation from your company', { exact: false });
  if (await invitationText.isVisible({ timeout: 2_000 }).catch(() => false)) {
    const artifactsDir = path.resolve(process.cwd(), 'output/stackdx/artifacts');
    fs.mkdirSync(artifactsDir, { recursive: true });
    await page.screenshot({ path: path.join(artifactsDir, 'invitation-error.png'), fullPage: true });
    console.log(`[stackdx] Screenshot saved to output/stackdx/artifacts/invitation-error.png`);
    console.log(`[stackdx] Current URL: ${page.url()}`);
    console.log(`[stackdx] Page title: ${await page.title()}`);
    throw new Error(
      'StackDX authentication succeeded, but this account is not invited to a StackDX workspace. Ask StackDX or your org admin to grant access before trying to automate the in-app agent.',
    );
  }
}

async function login(page: Page, loginUrl: string, email: string, password: string): Promise<void> {
  await page.goto(loginUrl, { waitUntil: 'domcontentloaded' });

  const emailField = page.getByRole('textbox', { name: 'Email Address' });
  if (await isVisible(emailField)) {
    await emailField.fill(email);
    await page.getByRole('button', { name: 'Continue' }).click();
  }

  const passwordField = page.getByRole('textbox', { name: 'Password' });
  if (await isVisible(passwordField)) {
    await passwordField.fill(password);
    await page.getByRole('button', { name: 'Continue', exact: true }).click();
  }

  await page.waitForLoadState('networkidle');
  await waitForInvitationError(page);

  if (page.url().includes('/Identity/LoginDirector') || page.url().includes('/u/login/')) {
    throw new Error(
      `StackDX login did not reach a workspace and remained on ${page.url()}. Check credentials, SSO requirements, or whether this account has app access.`,
    );
  }
}

async function createContext(headed: boolean, storageStatePath: string): Promise<{ browser: Browser; context: BrowserContext }> {
  const browser = await chromium.launch({ headless: !headed });
  const context = await browser.newContext({
    acceptDownloads: true,
    storageState: fs.existsSync(storageStatePath) ? storageStatePath : undefined,
  });

  return { browser, context };
}

async function runJob(page: Page, job: StackDxJob, config: StackDxConfig, downloadsDir: string, artifactsDir: string): Promise<void> {
  console.log(`\n[stackdx] Running job: ${job.name}`);

  if (job.url) {
    await page.goto(job.url, { waitUntil: 'domcontentloaded' });
    await page.waitForLoadState('networkidle');
  }

  if (job.waitForText) {
    await page.getByText(job.waitForText, { exact: false }).waitFor({ timeout: DEFAULT_TIMEOUT_MS });
  }

  if (job.prompt) {
    const promptLocator = await firstVisibleLocator(page, job.promptTargets || config.promptTargets);
    if (!promptLocator) {
      throw new Error(`Prompt input not found for job "${job.name}" on ${page.url()}`);
    }
    await fillPrompt(promptLocator, page, job.prompt);

    if (job.submitTargets || config.submitTargets) {
      await clickFirst(page, job.submitTargets || config.submitTargets, `submit button for ${job.name}`);
    }
  }

  if (job.waitForMs) {
    await page.waitForTimeout(job.waitForMs);
  }

  if (job.waitForText) {
    await page.getByText(job.waitForText, { exact: false }).waitFor({ timeout: DEFAULT_TIMEOUT_MS });
  }

  if (job.downloadTargets || config.downloadTargets) {
    const downloadPromise = page.waitForEvent('download', { timeout: DEFAULT_TIMEOUT_MS });
    await clickFirst(page, job.downloadTargets || config.downloadTargets, `download button for ${job.name}`);
    const download = await downloadPromise;

    const targetName = job.saveAs || (await download.suggestedFilename());
    const targetPath = path.join(downloadsDir, targetName);
    await download.saveAs(targetPath);
    console.log(`[stackdx] Download saved to ${targetPath}`);
  }

  await captureScreenshot(page, artifactsDir, job.name);
}

async function main(): Promise<void> {
  const repoRoot = process.cwd();
  const options = parseArgs(process.argv.slice(2));
  const configPath = resolveFromRepo(repoRoot, options.configPath, DEFAULT_CONFIG_PATH);
  const storageStatePath = resolveFromRepo(repoRoot, process.env.STACKDX_STORAGE_STATE, DEFAULT_STORAGE_STATE_PATH);

  if (!fs.existsSync(configPath)) {
    throw new Error(`Missing config file: ${configPath}`);
  }

  const email = process.env.STACKDX_EMAIL;
  const password = process.env.STACKDX_PASSWORD;
  if (!email || !password) {
    throw new Error('STACKDX_EMAIL and STACKDX_PASSWORD must be set in the environment');
  }

  const config = loadConfig(configPath);
  const loginUrl = config.loginUrl || DEFAULT_LOGIN_URL;
  const downloadsDir = resolveFromRepo(repoRoot, config.downloadsDir, DEFAULT_DOWNLOADS_DIR);
  const artifactsDir = resolveFromRepo(repoRoot, config.artifactsDir, DEFAULT_ARTIFACTS_DIR);

  ensureDir(path.dirname(storageStatePath));
  ensureDir(downloadsDir);
  ensureDir(artifactsDir);

  const { browser, context } = await createContext(options.headed, storageStatePath);

  try {
    const page = await context.newPage();
    await login(page, loginUrl, email, password);
    await context.storageState({ path: storageStatePath });

    const jobs = options.jobName
      ? config.jobs.filter((job) => job.name === options.jobName)
      : config.jobs;

    if (jobs.length === 0) {
      throw new Error(`No jobs matched "${options.jobName}" in ${configPath}`);
    }

    for (const job of jobs) {
      await runJob(page, job, config, downloadsDir, artifactsDir);
    }
  } finally {
    await context.close();
    await browser.close();
  }
}

main().catch((error: unknown) => {
  const message = error instanceof Error ? error.message : String(error);
  console.error(`[stackdx] ${message}`);
  process.exit(1);
});
