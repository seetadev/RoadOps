import { test as base } from '@playwright/test';
import { AuthScreen, DAppsScreen, SearchScreen, SettingsScreen, StakingScreen, Staking2Screen, WalletsScreen } from './screens';

type Fixtures = {
  auth: AuthScreen,
  dApps: DAppsScreen,
  search: SearchScreen,
  settings: SettingsScreen,
  staking: StakingScreen,
  staking2: Staking2Screen,
  wallets: WalletsScreen,
};

const test = base.extend<Fixtures>({
  auth: async ({ page }, use) => {
    await use(new AuthScreen(page));
  },
  dApps: async ({ page }, use) => {
    await use(new DAppsScreen(page));
  },
  search: async ({ page }, use) => {
    await use(new SearchScreen(page));
  },
  settings: async ({ page }, use) => {
    await use(new SettingsScreen(page));
  },
  staking: async ({ page }, use) => {
    await use(new StakingScreen(page));
  },
  staking2: async ({ page }, use) => {
    await use(new Staking2Screen(page));
  },
  wallets: async ({ page }, use) => {
    await use(new WalletsScreen(page));
  },
});

// test.beforeEach(async ({ auth, page }) => {
  // if (!page.url() || page.url() === 'about:blank') await auth.goto();
// });

export const expect = test.expect;
export { test };
