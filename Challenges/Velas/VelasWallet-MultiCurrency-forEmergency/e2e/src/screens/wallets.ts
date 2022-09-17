import { ElementHandle, Network, Page } from '../common-test-exports';
import { log } from '../tools/logger';
import { BaseScreen } from './base';

export type Currency =
  | 'token-vlx_native'
  | 'token-vlx_evm'
  | 'token-vlx2'
  | 'token-vlx_usdc'
  | 'token-vlx_usdt'
  | 'token-vlx_eth'
  | 'token-vlx_evm_legacy'
  | 'token-vlx_busd'
  | 'token-btc'
  | 'token-eth'
  | 'token-vlx_erc20'
  | 'token-usdc'
  | 'token-usdt_erc20'
  | 'token-eth_legacy'
  | 'token-usdt_erc20_legacy'
  | 'token-ltc'
  | 'token-vlx_huobi'
  | 'token-huobi'
  | 'token-bnb'
  | 'token-busd'
  | 'token-bsc_vlx';

export type Balances = Record<Currency, string | null>;

type CustomTokenNetwork = 'Velas' | 'Ethereum' | 'Heco' | 'BSC';
type NetworkType = Exclude<Network, 'devnet'>;

export class WalletsScreen extends BaseScreen {
  constructor(public page: Page) {
    super(page);
  }

  backButton = this.page.locator('.close');

  balanceAmount = this.page.locator('.amount:not(.placeholder)');

  lockButton = this.page.locator('.menu-item.bottom');

  manageWalletsModal = this.page.locator('.manage-account');

  swapButton = this.page.locator('.with-swap #wallet-swap:not([disabled])');

  sendButton = this.page.locator('#send-confirm:not([disabled])');

  testnetMenuItem = this.page.locator('#menu-testnet');

  totalBalance = this.page.locator('.balance div:not(.placeholder.amount) #balance-total');

  walletItemInWalletsList = this.page.locator('.big.wallet');

  walletAddress = this.page.locator('div.wallet-detailed a[data-original]');

  addTokenForm = {
    pageLoader: this.page.locator('.account-body .loading-pulse'),
  }

  txHistory = {
    txDetails: this.page.locator('.history-area div[datatesting="transaction"]'),
  };

  qrCode = this.page.locator('.receive-body canvas');

  copyToClipboardButton = this.page.locator('.address-holder .copy');

  refreshBalanceButton = this.page.locator('.balance .button.lock');

  async getWalletAddress(): Promise<string> {
    await this.page.waitForSelector('div.wallet-detailed a[data-original]');
    const address = (await this.walletAddress.getAttribute('data-original'))?.trim();
    if (!address) throw new Error('Cannot get wallet address');
    return address;
  }

  async selectWallet(tokenName: Currency): Promise<void> {
    await this.waitForWalletsDataLoaded();
    const tokenSelector = `div.big.wallet-item#${tokenName}`;
    // some time is required to load wallets and switch between them; so custom waiter is implemented
    let requiredCurrencyIsALreadySelected = await this.page.isVisible(
      tokenSelector,
    );
    while (!requiredCurrencyIsALreadySelected) {
      await this.page.click(`#${tokenName}`, { timeout: 15000 });
      await this.page.waitForTimeout(1000);
      requiredCurrencyIsALreadySelected = await this.page.isVisible(
        tokenSelector,
      );
    }
    log.debug(`${tokenName} was selected`);
    await this.waitForWalletsDataLoaded();
  }

  async getWalletsBalances(): Promise<Balances> {
    await this.waitForWalletsDataLoaded();
    const walletElements = await this.page.$$('.wallet-item');
    const balances: Balances = {
      'token-vlx_native': null,
      'token-vlx_evm': null,
      'token-vlx2': null,
      'token-vlx_usdc': null,
      'token-vlx_usdt': null,
      'token-vlx_eth': null,
      'token-vlx_evm_legacy': null,
      'token-vlx_busd': null,
      'token-btc': null,
      'token-eth': null,
      'token-vlx_erc20': null,
      'token-usdc': null,
      'token-usdt_erc20': null,
      'token-eth_legacy': null,
      'token-usdt_erc20_legacy': null,
      'token-ltc': null,
      'token-vlx_huobi': null,
      'token-huobi': null,
      'token-bnb': null,
      'token-busd': null,
      'token-bsc_vlx': null,
    };

    for (const walletElement of walletElements) {
      const tokenId: Currency = (await this.getTokenIdOfWalletItemElement(
        walletElement,
      )) as Currency;

      // skip if wallet is not in the wallets list
      if (!(await this.isWalletInWalletsList(tokenId))) continue;

      const amountOfTokens = await this.getAmountOfTokensFromOfWalletItemElement(walletElement);
      if (amountOfTokens === '..') continue;
      balances[tokenId] = amountOfTokens;
    }
    log.info(balances);
    return balances;
  }

  async isWalletInWalletsList(tokenName: Currency): Promise<boolean> {
    return this.page.isVisible(`#${tokenName}`);
  }

  async getAmountOfTokensFromOfWalletItemElement(
    walletElement: ElementHandle<SVGElement | HTMLElement>,
  ): Promise<string> {
    const amountOfTokens = await (
      await walletElement.$('.info .token.price')
    )?.getAttribute('title');
    if (!amountOfTokens) throw new Error('Cannot get amount of tokens');
    return amountOfTokens;
  }

  async getCustomTokenBalance(selector: string): Promise<string> {
    const customTokenElement = await this.page.waitForSelector(selector);
    if (!customTokenElement) throw new Error(`There is no custom token element with selector: ${selector}`);
    const customTokenBalance = await this.getAmountOfTokensFromOfWalletItemElement(customTokenElement);
    return customTokenBalance;
  }

  private async getTokenIdOfWalletItemElement(
    walletElement: ElementHandle<SVGElement | HTMLElement>,
  ): Promise<string> {
    const tokenId = await walletElement.getAttribute('id');
    if (!tokenId) throw new Error('Cannot get token id');
    return tokenId;
  }

  async refreshBalances(): Promise<void> {
    await this.refreshBalanceButton.click();
    await this.waitForWalletsDataLoaded();
  }

  async hideWallet(): Promise<void> {
    await this.waitForWalletsDataLoaded();
    await this.page.click('.wallet-header .uninstall');
    await this.waitForWalletsDataLoaded();
  }

  async waitForWalletsDataLoaded(): Promise<void> {
    await this.page.waitForSelector('.wallet-item .top-left [class=" img"]', {
      state: 'visible',
      timeout: 40000,
    });
    await this.page.waitForTimeout(100);
  }

  addWalletsPopup = {
    open: async () => {
      const editWalletsButton = this.page.locator('.header .button.lock.mt-5');
      await editWalletsButton.waitFor({ timeout: 15000 });
      await this.page.waitForTimeout(500);
      await editWalletsButton.click();
      await this.manageWalletsModal.waitFor();
      await this.page.waitForTimeout(500);
    },
    add: async (tokenName: Currency) => {
      const addTokenButton = this.page.locator(`#add-${tokenName} button`);
      await addTokenButton.waitFor({ timeout: 20000 });
      await addTokenButton.scrollIntoViewIfNeeded();
      await this.page.waitForTimeout(500);

      await addTokenButton.click({ timeout: 15000, force: true });
      await this.page.waitForTimeout(500);
    },
  };

  async swapTokens(
    fromToken: Currency,
    toToken: Currency,
    transactionAmount: number | string | 'use max',
    params?: { customAddress?: string, confirm?: boolean }
  ): Promise<void> {
    if (fromToken === toToken) {
      throw TypeError('You can\'t swap to the same token you are swapping from');
    }

    await this.addToken(fromToken);
    await this.addToken(toToken);
    await this.selectWallet(fromToken);
    await this.swapButton.click({ timeout: 25000 });
    await this.swapForm.networkSelector.waitFor({ timeout: 20000 });
    await this.swapActions.chooseDestinationNetwork(toToken);

    if (params?.customAddress) {
      await this.sendForm.recepientInput.fill(params.customAddress);
    }

    if (transactionAmount === 'use max') {
      await this.useMax();
    } else {
      await this.swapActions.fillAmount(String(transactionAmount));
    }

    // wait for amount error disappears
    await this.page.waitForTimeout(300);

    if (params?.confirm ?? true) {
      try {
        await this.swapActions.confirm();
      } catch {
        log.error(`Attention! This could be an expected error from try/catch.
        Test could pass even if this error is thrown.
        | swap ${fromToken} >> ${toToken} failed on attempt to confirm |`);
      }
    }
  }

  swapForm = {
    networkSelector: this.page.locator('.network-slider'),
    amountInput: this.page.locator('div.amount-field .input-area input[label="Send"]'),
    changeNetwork: this.page.locator('.change-network'),
  };

  txListAfterSendOrSwap = {
    linkToTxExecuted: this.page.locator('.sent .text a'),
  };

  sendForm = {
    recepientInput: this.page.locator('#send-recipient'),
    // TODO: change to "#value-input" (already updated in wallet)
    amount: this.page.locator('div.amount-field .textfield[label="Send"]:left-of(.crypto)'),
  };

  private swapActions = {
    fillAmount: async (transactionAmount: string) => {
      await this.swapForm.amountInput.waitFor();
      await this.page.waitForTimeout(200);
      await this.swapForm.amountInput.fill(transactionAmount);
    },
    getDestinationNetworkForTokenName: async (swapToToken: Currency): Promise<string> => {
      switch (swapToToken) {
        case 'token-vlx2':
          return 'Velas Legacy';
        case 'token-vlx_native':
          return 'Velas Native';
        case 'token-vlx_evm':
          return 'Velas EVM';
        case 'token-bsc_vlx':
          return 'Binance';
        case 'token-vlx_huobi':
          return 'Huobi ECO Chain';
        case 'token-vlx_erc20':
          return 'Ethereum (VLX ERC20)';
        case 'token-usdt_erc20':
          return 'Ethereum (Tether USD ERC-20)';
        default:
          return 'default';
      }
    },
    chooseDestinationNetwork: async (swapToToken: Currency) => {
      const destinationNetworkName = await this.swapActions.getDestinationNetworkForTokenName(swapToToken);
      const chosenNetwork = await this.swapForm.changeNetwork.getAttribute('value');
      const isProperNetworkChosen = chosenNetwork?.includes(destinationNetworkName);

      if (destinationNetworkName === 'default' || isProperNetworkChosen) {
        log.debug(`Swap: no need to select destination newtork ${destinationNetworkName}. It's already chosen`);
        return;
      }

      log.debug(`Select destination network - ${destinationNetworkName}`);
      await this.page.click('.network-slider .right');
      const destinationNetowk = this.page.locator(`.switch-menu div:text("${destinationNetworkName}")`);
      await destinationNetowk.click({ timeout: 25000 });
      await this.waitForSelectorDisappears('.switch-menu', 25000);
    },
    confirm: async () => {
      await this.sendButton.waitFor();
      await this.page.waitForTimeout(500);
      await this.sendButton.click();
      await this.modals.confirmPrompt();
      await this.page.waitForSelector('.sent .text a:not([href=""])', { timeout: 30000 });
    },
  };

  async confirmTxFromEvmExplorer(): Promise<void> {
    const [txPage] = await Promise.all([
      this.context.waitForEvent('page'),
      this.txListAfterSendOrSwap.linkToTxExecuted.click(),
    ]);

    let url = txPage.url();
    if (url.includes('https://explorer.testnet.velas.com/')) {
      url = url.replace('https://explorer', 'https://evmexplorer');
      await txPage.goto(url);
    }

    await txPage.waitForLoadState();

    const startTime = new Date().getTime();
    let timePassedInSeconds = 0;
    const secondsToWait = 180;
    while (await txPage.isVisible('.error-title')) {
      timePassedInSeconds = (new Date().getTime() - startTime) / 100;
      if (timePassedInSeconds > secondsToWait) {
        throw new Error(`Tx hash not been found on explorer during ${secondsToWait} seconds
      ${txPage.url()}`);
      }

      await txPage.waitForLoadState();
      log.debug(
        `Tx hash not been found on explorer, refreshing...\n${txPage.url()}`,
      );
      await txPage.waitForTimeout(1000);
      await txPage.reload();
    }

    await txPage.waitForSelector('[data-transaction-status="Success"]');
  }

  async getLastTxSignatureInHistory(): Promise<string> {
    await this.page.click('[datatesting="transaction"] div.more', {
      timeout: 15000,
    });

    const lastTxSignatureElementSelector = '[datatesting="transaction"] .tx-middle .txhash a[data-original]';
    const lastTxSignature = (
      await this.page.getAttribute(
        lastTxSignatureElementSelector,
        'data-original',
      )
    )?.trim();
    if (!lastTxSignature) {
      throw new Error(
        `Cannot get transaction signature from element with selector ${lastTxSignatureElementSelector}`,
      );
    }
    await this.page.click('[datatesting="transaction"] div.more');
    return lastTxSignature;
  }

  async addToken(currency: Currency): Promise<void> {
    await this.waitForWalletsDataLoaded();
    if (!(await this.isWalletInWalletsList(currency))) {
      await this.addWalletsPopup.open();
      await this.addWalletsPopup.add(currency);
    } else {
      log.info(
        `You tried to add token "${currency}" but it's already in the list.`,
      );
    }
  }

  async addCustomToken(
    contract: string,
    customTokenNetwork: CustomTokenNetwork,
    networkType: NetworkType,
  ): Promise<void> {
    await this.addWalletsPopup.open();
    await this.page.click('#add-custom-token');
    await this.page.click('.default-network-input .button');
    await this.page.click(
      `.network-item-title:has-text('${customTokenNetwork}') + .networks .${networkType}-network`,
    );
    await this.waitForSelectorDisappears('.switch-menu');
    await this.page.fill('#contract-address', `${contract}`);
    await this.sendButton.waitFor({ timeout: 15000 });
    await this.sendButton.click();

    while (await this.addTokenForm.pageLoader.isVisible()) {
      await this.page.waitForTimeout(500);
    }

    await this.waitForSelectorDisappears('#add-custom-token');
  }

  async getTxHashFromTxlink(): Promise<string> {
    await this.txListAfterSendOrSwap.linkToTxExecuted.waitFor({ timeout: 20000 });
    const txSignatureLink = await this.txListAfterSendOrSwap.linkToTxExecuted.getAttribute('href');
    if (!txSignatureLink) throw new Error('No txSignatureLink');
    let txSignature = txSignatureLink.replace(/^.*tx\//, '');
    txSignature = txSignature.replace(/\?cluster=testnet.*/, '');
    if (!txSignature) {
      throw new Error('Cannot get transaction signature from tx link');
    }
    log.debug(`Obtained tx signature: ${txSignature}`);
    return txSignature;
  }

  async clickSendButton(): Promise<void> {
    await this.page.click('button#wallets-send:not([disabled])', { timeout: 10000 });
  }

  async sendTx(fromToken: Currency, toAddress: string, transactionAmount: number): Promise<void> {
    await this.selectWallet(fromToken);
    await this.clickSendButton();
    await this.sendForm.recepientInput.fill(toAddress);
    await this.sendForm.amount.fill(String(transactionAmount));
    await this.sendButton.click();
    await this.modals.confirmPrompt({ timeout: 30000 });
  }
}
