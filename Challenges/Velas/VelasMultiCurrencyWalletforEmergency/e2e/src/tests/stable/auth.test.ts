import { Language } from '../../screens';
import { assert, data, expect, test } from '../../common-test-exports';
import { log } from '../../tools/logger';

test.describe.parallel('Auth', () => {
  const accountAddress24Words = 'G3N4212jLtDNCkfuWuUHsyG2aiwMWQLkeKDETZbo4KG';

  test.beforeEach(async ({ auth }) => {
    await auth.goto();
  });

  test.describe('Sign up', () => {
    test('Create wallet', async ({ auth }) => {
      await auth.language.select('en');
      await auth.welcome.create();
      await auth.pinForNewAcc.fillAndConfirm('111222');

      const seedWords = await auth.newSeed.getSeedWords({ log: true });

      await auth.newSeed.next();
      await auth.wordByWordSeedInputForm.fill(seedWords, { fast: true });
      await auth.terms.accept();

      await expect(auth.menuItems).toBeVisible();
      await expect(auth.balanceBlockInMenu).toBeVisible();
    });
  });

  test.describe('Restore with', () => {
    test('custom seed phrase', async ({ auth, wallets }) => {
      await auth.loginByRestoringSeed(data.wallets.login.seed);

      await wallets.selectWallet('token-vlx_native');
      assert.equal(await wallets.getWalletAddress(), accountAddress24Words, 'Account address on UI does not equal expected');
    });

    test('24-words seed phrase', async ({ auth, wallets }) => {
      await auth.language.select('en');
      await auth.welcome.restore();
      await auth.restoreFrom.seed('24');
      await auth.pinForNewAcc.fillAndConfirm('111222');
      await auth.wordByWordSeedInputForm.fill(data.wallets.login.seedArr, { fast: true });

      await wallets.selectWallet('token-vlx_native');
      assert.equal(await wallets.getWalletAddress(), accountAddress24Words, 'Account address on UI does not equal expected');
    });

    test('12-words seed phrase', async ({ auth, wallets }) => {
      const accountAddress12Words = '4NmVCBCCh1cnMTCGTKCgUeYV5Eyk3CmeHUSgMJz7Dwdr';

      await auth.language.select('en');
      await auth.welcome.restore();
      await auth.restoreFrom.seed('12');
      await auth.pinForNewAcc.fillAndConfirm('111222');
      const seed12Words: string[] = [...data.wallets.login.seedArr];
      seed12Words.length = 12;
      await auth.wordByWordSeedInputForm.fill(seed12Words);

      await wallets.selectWallet('token-vlx_native');
      assert.equal(await wallets.getWalletAddress(), accountAddress12Words, 'Account address on UI does not equal expected');
    });

    test('Can\'t restore with incorrect 24-word seed phrase', async ({ auth }) => {
      await auth.language.select('en');
      await auth.welcome.restore();
      await auth.restoreFrom.seed('24');
      await auth.pinForNewAcc.fillAndConfirm('111222');
      await auth.wordByWordSeedInputForm.fill(Array(24).fill('sad'), { fast: true });

      assert.isTrue(await auth.seedPhraseChecksumMatchError.isVisible(), 'No alert for incorrect seed phrase on UI');
      assert.isFalse(await auth.isLoggedIn(), 'Restored with incorrect seed phrase');
    });
  });

  test.describe('Log in', () => {
    test.beforeEach(async ({ page, auth }) => {
      await auth.loginByRestoringSeed(data.wallets.login.seed);
      await page.reload();
    });

    test('Can\'t log in with incorrect password', async ({ auth }) => {
      await auth.pinForLoggedOutAcc.typeAndConfirm('111111');
      await expect(auth.pinForLoggedOutAcc.wrongPinError).toBeVisible();
    });

    test('Log in with pin', async ({ auth, wallets }) => {
      await auth.pinForLoggedOutAcc.typeAndConfirm('111222');

      await wallets.selectWallet('token-vlx_native');
      assert.equal(await wallets.getWalletAddress(), accountAddress24Words, 'Account address on UI does not equal expected');
    });
  });

  test.describe('Choose language on sign up', () => {
    test('Change language', async ({ page, auth }) => {
      const welcomeTexts = {
        fr: 'Bienvenu(e)!',
        en: 'Welcome!',
        kr: '어서 오십시오!',
        cn: '欢迎！',
        // in: 'स्वागत हे!',
        es: '¡Bienvenido!',
        ua: 'Ласкаво просимо!',
        ru: 'Добро пожаловать!',
        ar: 'مرحبا!',
        // id: 'Selamat datang!',
        // ph: 'pagsalubong sa Pitaka',
        // yr: 'Kaabo!',
        // vn: 'Chào mừng!'
      };

      const languages = Object.keys(welcomeTexts) as Language[];

      for (const language of languages) {
        log.info(language);
        await auth.language.select(language);
        const actualWelcomeText = (await auth.language.welcomeText.textContent())?.trim();
        assert.equal(actualWelcomeText, welcomeTexts[language], `${language} language on UI does not equal chosen language`);
        await page.reload();
      }
    });
  });
});
