import { expect, data, test } from '../common-test-exports';

test.describe.parallel('Wallets screen >', () => {
  test.beforeEach(async ({ auth }) => {
    await auth.goto();
  });

  test.describe('Transactions', () => {
    test('Transactions list is displayed', async ({ auth, page, wallets }) => {
      await auth.loginByRestoringSeed(data.wallets.login.seed);

      // assert
      await wallets.waitForWalletsDataLoaded();
      await expect(page.locator('div.disabled-wallet-item')).not.toBeVisible();
    });
  });
});
