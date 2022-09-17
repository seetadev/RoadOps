import { Page } from '../common-test-exports';
import { BaseScreen } from './base';

type TokenInCopyModal = 'Velas Native' | 'Velas EVM' | 'Velas Legacy' | 'Bitcoin';

export class SettingsScreen extends BaseScreen {
  constructor(public page: Page) {
    super(page);
  }

  accountIndexSwitcherRight = this.page.locator('.button.right');

  copyPrivateKeyButton = this.page.locator('" Copy"');

  networkSwitcher = this.page.locator('.active-network');

  switchLanguageButon = this.page.locator('#switch-language .btn');

  header = this.page.locator('.header');

  async selectTokenInCopyModal(tokenName: TokenInCopyModal): Promise<void> {
    await this.page.click(`.tokens-drop span:text(" ${tokenName}")`);
  }

  async selectLanguageFromDropdown(fullLanguageName: string): Promise<void> {
    await this.page.locator(`.lang-item:has-text("${fullLanguageName}")`).click();
  }
}
