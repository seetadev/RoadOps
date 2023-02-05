import { PlaywrightTestConfig } from '@playwright/test';
import { config as globalConfig } from './src/config';

const windowSize = { width: 1900, height: 1080 };

const config: PlaywrightTestConfig = {
  expect: {
    timeout: 6 * 1000,
  },
  globalSetup: 'src/pw-helpers/before-hook.ts',
  // globalTeardown: '',
  maxFailures: globalConfig.CI ? 5 : 1,
  projects: [
    {
      name: 'Chrome Stable',
      use: {
        actionTimeout: 10000,
        navigationTimeout: 30 * 1000,
        browserName: 'chromium',
        userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36',
        channel: 'chrome',
        headless: globalConfig.headless,
        launchOptions: {
          args: ['--disable-dev-shm-usage', '--disable-gpu', '--no-sandbox', `--window-size=${windowSize.width},${windowSize.height}`, '--disable-features=TranslateUI'],
          devtools: false,
          slowMo: 250,
        },
        screenshot: 'only-on-failure',
        viewport: { width: 1890, height: 1080 },
        video: {
          mode: 'retain-on-failure',
          size: {
            width: 1024,
            height: 768,
          },
        },
        trace: 'retain-on-failure'
      },
      // testDir: '',
    },
  ],
  reporter: [
    ['list'],
    ['html', { outputFolder: 'test-report', open: 'never' }]
  ],
  reportSlowTests: { threshold: 120000, max: 0 },
  // repeatEach: 5,
  // reporter: 'list',
  retries: globalConfig.CI ? 1 : 0,
  timeout: 130000,
  workers: 2,
};

export default config;
