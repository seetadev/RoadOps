import { assert, data, test } from '../../common-test-exports';

test.describe.parallel('Wallets screen', () => {
  test.beforeEach(async ({ auth }) => {
    await auth.goto();
  });

  test.describe('Transactions', () => {
    test('Transactions list is displayed', async ({ auth, wallets }) => {
      // arrange
      await auth.loginByRestoringSeed(data.wallets.fundsReceiver.seed);

      await wallets.selectWallet('token-vlx_native');
      await wallets.txHistory.txDetails.first().waitFor({ timeout: 35000 });
      const transactions = await wallets.txHistory.txDetails.elementHandles();
      assert.isAbove(transactions.length, 10, 'Amount of transactions in the list is less than 10');

      const txDetails = await wallets.txHistory.txDetails.first().elementHandle();
      await txDetails?.waitForSelector(`.address-holder a[href*="https://native.velas.com/tx/"]`);
    });
  });

  test.describe('Main', () => {
    test.beforeEach(async ({ auth, wallets }) => {
      await auth.loginByRestoringSeed(data.wallets.login.seed);
      await wallets.waitForWalletsDataLoaded();
    });

    test('Lock and unlock', async ({ auth, wallets }) => {
      await wallets.lockButton.click();
      await auth.passwordInput.isVisible();
      assert.isFalse(await wallets.lockButton.isVisible());

      await auth.pinForLoggedOutAcc.typeAndConfirm('111222');
      assert.isTrue(await auth.isLoggedIn());
    });

    // BUG: https://velasnetwork.atlassian.net/browse/VLWA-868
    test.skip('Add and hide litecoin wallet', async ({ wallets }) => {
      // TODO: need to scroll to launch test for mainnet
      // add litecoin
      await wallets.addWalletsPopup.open();
      await wallets.addWalletsPopup.add('token-ltc');
      await wallets.selectWallet('token-ltc');
      assert.isTrue(await wallets.isWalletInWalletsList('token-ltc'));

      // remove litecoin
      await wallets.hideWallet();
      assert.isFalse(await wallets.isWalletInWalletsList('token-ltc'));
    });

    test('Add and hide EVM Legacy wallet', async ({ wallets }) => {
      await wallets.addWalletsPopup.open();
      await wallets.addWalletsPopup.add('token-vlx_evm_legacy');
      await wallets.selectWallet('token-vlx_evm_legacy');
      assert.isTrue(await wallets.isWalletInWalletsList('token-vlx_evm_legacy'));

      await wallets.hideWallet();
      assert.isFalse(await wallets.isWalletInWalletsList('token-vlx_evm_legacy'));
    });

    test('Switch account', async ({ page, wallets }) => {
      await wallets.selectWallet('token-vlx_native');
      await page.click('.switch-account');
      await page.click('" Account 2"');
      assert.equal(await wallets.getWalletAddress(), 'BfGhk12f68mBGz5hZqm4bDSDaTBFfNZmegppzVcVdGDW', 'Account 2 address on UI does not equal expected');
    });

    test('Show QR', async ({ page }) => {
      await page.hover('.wallet-detailed .address-holder .copy');
      await page.waitForSelector('.qrcode');
    });

    test('Copy wallet address from "Receive" page', async ({ context, page, wallets }) => {
      await context.grantPermissions(['clipboard-read', 'clipboard-write']);
      // clear clipboard
      await page.evaluate(async () => await navigator.clipboard.writeText(''));

      await wallets.selectWallet('token-vlx_native');
      await page.click('#wallets-receive');
      await page.waitForSelector('.ill-qr img');
      await wallets.qrCode.waitFor();

      // copy to clipboard
      await wallets.copyToClipboardButton.click();
      const copiedText = await page.evaluate(async () => await navigator.clipboard.readText());
      assert.equal(copiedText, 'G3N4212jLtDNCkfuWuUHsyG2aiwMWQLkeKDETZbo4KG');

      // back to wallets list
      await page.click('" Cancel"');
      await wallets.waitForWalletsDataLoaded();
    });
  });

  test.describe('Add custom tokens: ', () => {
    test.beforeEach(async ({ auth, wallets }) => {
      await auth.loginByRestoringSeed(data.wallets.withFunds.seed);
      await wallets.waitForWalletsDataLoaded();
    });

    test('WAG on Velas', async ({ wallets }) => {
      await wallets.addCustomToken(data.customTokens.velas.wag, 'Velas', 'testnet');
      const customTokenBalance = await wallets.getCustomTokenBalance('#token-wag_testnet_Velas__custom');
      assert.equal(customTokenBalance, '1');
    });

    test('WEENUS on Ethereum', async ({ wallets }) => {
      await wallets.addCustomToken(data.customTokens.eth.weenus, 'Ethereum', 'testnet');
      const customTokenBalance = await wallets.getCustomTokenBalance('#token-weenus_testnet_Ethereum__custom');
      assert.equal(customTokenBalance, '2');
    });

    // TODO: CORS error
    test.skip('DAI on BSC', async ({ wallets }) => {
      await wallets.addCustomToken(data.customTokens.bsc.dai, 'BSC', 'testnet');

      const customTokenBalance = await wallets.getCustomTokenBalance('#token-dai_testnet_BSC__custom');
      assert.equal(customTokenBalance, '3');
    });

    test('DAI on Heco', async ({ wallets }) => {
      await wallets.addCustomToken(data.customTokens.heco.dai, 'Heco', 'testnet');

      const customTokenBalance = await wallets.getCustomTokenBalance('#token-dai_testnet_Heco__custom');
      assert.equal(customTokenBalance, '4');
    });
  });
});
