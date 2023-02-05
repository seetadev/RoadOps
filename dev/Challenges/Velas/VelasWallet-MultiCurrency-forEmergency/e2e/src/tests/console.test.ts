import {
  assert, data, test, walletURL,
} from '../common-test-exports';
import { AuthScreen, WalletsScreen } from '../screens';

let wallets: WalletsScreen;
let auth: AuthScreen;

test.describe('Console', () => {
  test.beforeEach(async ({ page }) => {
    wallets = new WalletsScreen(page);
    auth = new AuthScreen(page);
  });

  test('Check console for errors', async ({ page }) => {
    const errorLog: (string | Error)[] = [];

    page.on('console', (msg) => {
      if (msg.type() === 'error') {
        errorLog.push(msg.text());
      }
    });

    page.on('pageerror', (exception) => {
      errorLog.push(exception);
    });

    await page.goto(walletURL);
    await auth.loginByRestoringSeed(data.wallets.login.seed);

    await wallets.waitForWalletsDataLoaded();
    await wallets.addWalletsPopup.open();

    let hiddenTokenElements = await page.$$('.manage-account .settings .list .item');

    while (hiddenTokenElements.length !== 0) {
      await page.click('.list .item button');
      await wallets.waitForWalletsDataLoaded();
      await wallets.addWalletsPopup.open();
      hiddenTokenElements = await page.$$('.manage-account .settings .list .item');
    }
    await page.click('.manage-account .closed');
    await wallets.waitForWalletsDataLoaded();

    assert.lengthOf(errorLog, 0, `Following console errors have been found:\n${errorLog.join('\n= = = = = = = = = = = = = = = =\n')}\n`);
  });
});
