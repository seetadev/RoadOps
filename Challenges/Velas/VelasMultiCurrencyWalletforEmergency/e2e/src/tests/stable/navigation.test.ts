import { assert, data, test } from '../../common-test-exports';

test.describe.parallel('Navigation', () => {
  test.beforeEach(async ({ auth }) => {
    await auth.goto();
    await auth.loginByRestoringSeed(data.wallets.login.seed);
  });

  test('Navigate with back button in header', async ({ auth, page, search, settings, staking2, wallets }) => {
    await wallets.waitForWalletsDataLoaded();

    const screens = ['settings', 'search', 'staking', 'swap', 'send'];

    for (const screen of screens) {
      // check that navigation doesn't get broken by locking screen
      await page.reload();
      await auth.pinForLoggedOutAcc.typeAndConfirm('111222');
      assert.isTrue(await auth.isLoggedIn());

      switch (screen) {
        case 'settings':
          await wallets.openMenu('settings');
          await settings.networkSwitcher.waitFor();
          break;

        case 'search':
          await wallets.openMenu('wallets');
          await wallets.openMenu('dApps');
          await search.dapps.waitFor();
          break;

        case 'staking':
          await wallets.openMenu('wallets');
          await wallets.openMenu('staking');
          await staking2.container.waitFor();
          break;

        case 'swap':
          await wallets.openMenu('wallets');
          await wallets.swapButton.click({ timeout: 25000 });
          await wallets.swapForm.networkSelector.waitFor();
          break;

        case 'send':
          await wallets.openMenu('wallets');
          await wallets.clickSendButton();
          await wallets.sendForm.recepientInput.waitFor();
          assert.isFalse(await wallets.swapForm.networkSelector.isVisible());
          break;
      }
    }
  });

  test('Redirects to support page from menu', async ({ context, wallets }) => {
    const [newPage] = await Promise.all([
      context.waitForEvent('page'),
      wallets.openMenu('support'),
    ]);

    await newPage.waitForLoadState();
    assert.isTrue(newPage.url().includes('https://support.velas.com'));
  });
});
