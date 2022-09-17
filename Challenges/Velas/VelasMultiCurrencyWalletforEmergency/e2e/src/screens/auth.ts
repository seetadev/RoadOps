import { log } from '../tools/logger';
import { Page } from '../common-test-exports';
import { BaseScreen } from './base';

export type Language = 'fr' | 'en' | 'kr' | 'cn' | 'es' | 'ua' | 'ru' | 'ar';

export class AuthScreen extends BaseScreen {
  constructor(public page: Page) {
    super(page);
  }

  balanceBlockInMenu = this.page.locator('.menu-body .balance');

  menuItems = this.page.locator('.menu-items');

  seedPhraseChecksumMatchError = this.page.locator('" Seed phrase checksum not match. Please try again."');

  downloadButtons = {
    iOS: this.page.locator('#download-ios'),
    android: this.page.locator('#download-android'),
    desktop: this.page.locator('#download-desktop'),
    apk: this.page.locator('#download-apk'),
  };

  passwordInput = this.page.locator('input[type="password"]');

  customSeedInput = {
    fillAndConfirm: async (seedPhrase: string | string[]): Promise<void> => {
      if (typeof seedPhrase !== 'string') seedPhrase = seedPhrase.join(' ');
      log.info(`Fill seed phrase: ${seedPhrase}`);
      await this.page.fill('#seedphrase-custom', seedPhrase);
      await this.page.click('#seed-phrase-next');
    },
  };

  async fastLogin(testWallet: Wallet) {
    if (!testWallet.encryptedSeed) throw new Error(`Wallet with seed ${testWallet.seed} does not contain encrypted seed value`);
    if (!this.page.url() || this.page.url() === 'about:blank') await this.goto();

    await this.setSeedToLocalStorage(testWallet.encryptedSeed);
    await this.page.reload({ waitUntil: 'commit' });
    await this.pinForNewAcc.fillAndConfirm('111222');
  }

  async loginByRestoringSeed(seedPhrase: string | string[]) {
    const auth = new AuthScreen(this.page);

    if (await this.isLoggedIn()) {
      log.info('User is logged in');
      return;
    }

    const passwordInput = await this.page.isVisible('[placeholder="Password or PIN"]', { timeout: 1000 });
    if (passwordInput) {
      log.info('You try to log in. And login was already performed in this context. Adding new account...');
      await auth.pinForLoggedOutAcc.newAccount();
    }

    await auth.language.select('en');
    await auth.welcome.restore();
    await auth.restoreFrom.seed('custom');
    await auth.pinForNewAcc.fillAndConfirm('111222');
    await auth.customSeedInput.fillAndConfirm(seedPhrase);

    if (await this.isLoggedIn()) {
      log.info(`Successfully logged in with seed "${seedPhrase}"`);
    } else {
      throw new Error('Can\'t perform login');
    }
  }

  newSeed = {
    getSeedWords: async (params: { log?: boolean }): Promise<string[]> => {
      const wordsElements = await this.page.$$('div.words .word span:nth-child(2)');
      const seedWords: string[] = [];

      for (const wordElement of wordsElements) {
        const word = await wordElement.textContent() as string;
        seedWords.push(word.trim());
      }

      if (params.log) {
        log.info(`Seed phrase:\n${seedWords.join(' ')}`);
      }

      return seedWords;
    },

    next: async (): Promise<void> => {
      await this.page.click('#seed-next');
    },
  };

  pinForLoggedOutAcc = {
    typeAndConfirm: async (password: string): Promise<void> => {
      await this.passwordInput.fill(password);
      await this.page.click('" Enter"');
    },

    newAccount: async (): Promise<void> => {
      await this.page.click('button.setup');
      await this.modals.confirmPrompt();
    },

    wrongPinError: this.page.locator('.wrong'),
  };

  pinForNewAcc = {
    fillAndConfirm: async (password: string): Promise<void> => {
      await this.passwordInput.fill(password);
      await this.page.click('button.setup');
    },
  };

  restoreFrom = {
    seed: async (type: '24' | '12' | 'custom'): Promise<void> => {
      await this.page.click(`#restore-${type}`);
    },
  };

  language = {
    select: async (language: Language): Promise<void> => {
      await this.page.click(`#lang-${language}`);
    },
    welcomeText: this.page.locator('.welcome'),
  };

  terms = {
    accept: async (): Promise<void> => {
      await this.page.click('" Accept"');
    },
  };

  welcome = {
    create: async (): Promise<void> => {
      await this.page.click('#btn-create');
    },

    restore: async (): Promise<void> => {
      await this.page.click('#btn-restore');
    },
  };

  installWallets = {
    platformsList: this.page.locator('.platforms'),
  };

  wordByWordSeedInputForm = {
    fill: async (seedWords: string[], params: { fast: boolean } = { fast: false }): Promise<void> => {
      log.error(seedWords);
      const elementWithWordNumberSelector = this.page.locator('.words [placeholder*="word #"]');
      for (const work of seedWords) {
        // example of "placeholder" attribute value: "word #1"
        const placeholderValue = await elementWithWordNumberSelector.getAttribute('placeholder');
        // cut text "word #" and leave only number at the end of string
        const requestedWordNumber = Number(placeholderValue?.slice(6));
        const inputToFill = this.page.locator(`.words [placeholder*="word #${requestedWordNumber}"]`);
        if (params.fast) {
          await inputToFill.fill(seedWords[requestedWordNumber - 1]);
        } else {
          await inputToFill.type(seedWords[requestedWordNumber - 1]);
        }
        await this.page.click('" Next"');
      }
    },
  };
}
