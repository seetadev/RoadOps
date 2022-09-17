import { Language } from '../../screens';
import {
  assert, data
} from '../../common-test-exports';
import { log } from '../../tools/logger';
import { test } from '../../fixtures'

test.describe.parallel('Settings', () => {
  test.beforeEach(async ({ auth }) => {
    await auth.goto();
    await auth.loginByRestoringSeed(data.wallets.login.seed);
  });

  test('Copy private key', async ({ context, page, auth, settings, wallets }) => {
    // arrange
    await context.grantPermissions(['clipboard-read', 'clipboard-write']);
    // clear clipboard
    await page.evaluate(async () => await navigator.clipboard.writeText(''));

    await wallets.openMenu('settings');
    await settings.copyPrivateKeyButton.click();
    await auth.passwordInput.fill('111222');
    await wallets.modals.confirmPrompt();
    await settings.selectTokenInCopyModal('Velas Native');
    await page.waitForSelector('" Copied to Clipboard!"');

    const copiedKey = await page.evaluate(async () => await navigator.clipboard.readText());
    log.info(copiedKey);
    if (!copiedKey) throw new Error(`Clipboard is empty :/`)
    assert.equal(copiedKey, 'WnexSzUPFb258nLxGC1jiCShUZC1DbTpaRC2kizKxnpKNuvsqAhegBUCVgoULDxog19CjxfYaijS5Cpe78EFKqQ');
  });

  test('Switch account index', async ({ wallets, settings }) => {
    await wallets.waitForWalletsDataLoaded();
    await wallets.openMenu('settings');
    await settings.accountIndexSwitcherRight.click();
    await wallets.balanceAmount.waitFor();

    await wallets.openMenu('wallets');
    await wallets.selectWallet('token-vlx_native');

    assert.equal(await wallets.getWalletAddress(), 'BfGhk12f68mBGz5hZqm4bDSDaTBFfNZmegppzVcVdGDW', 'Account 2 address on UI does not equal expected');
  });

  test('Enable/Disable testnet', async ({ page, settings, wallets }) => {
    await wallets.waitForWalletsDataLoaded();

    await wallets.openMenu('settings');
    await settings.networkSwitcher.click();
    await wallets.totalBalance.waitFor();
    assert.isFalse(await wallets.testnetMenuItem.isVisible());

    await wallets.openMenu('wallets');
    await wallets.selectWallet('token-btc');
    await page.waitForTimeout(1000);
    assert.equal(await wallets.getWalletAddress(), '1PV8RPEL8kNBnQytq2881TE3bSZJbJazDw', 'Mainnet BTC address on UI does not equal expected');

    await wallets.openMenu('settings');
    await settings.networkSwitcher.click();
    await wallets.totalBalance.waitFor();
    assert.isTrue(await wallets.testnetMenuItem.isVisible());

    await wallets.openMenu('wallets');
    await wallets.selectWallet('token-btc');
    await page.waitForTimeout(500);

    assert.equal(await wallets.getWalletAddress(), 'n415iSKJwmoSZXTWYb6VqNSNTSA1YMwL8U', 'Testnet BTC address on UI does not equal expected');
  });

  test('Change language setting', async ({ settings, wallets }) => {
    await wallets.openMenu('settings');

    const headerTexts = {
      fr: ['Gérer le Compte', 'Français'],
      en: ['Manage Account', 'English'],
      kr: ['계정 관리', '한국어'],
      cn: ['管理帐户', '中文語言'],
      es: ['Administrar Cuenta', 'Español'],
      ua: ['Управління аккаунтом', 'Українська'],
      ru: ['Управлять аккаунтом', 'Русский'],
      ar: ['إدارة الحساب', 'عربى'],
    };

    const languages = Object.keys(headerTexts) as Language[];

    for (const language of languages) {
      log.info(language);
      await settings.switchLanguageButon.click();

      const fullLanguageName = headerTexts[language][1];
      await settings.selectLanguageFromDropdown(fullLanguageName);
      const actualHeaderText = (await settings.header.textContent())?.trim();
      assert.equal(actualHeaderText, headerTexts[language][0], `${language} language on UI does not equal chosen language`);
    }
  });
});
