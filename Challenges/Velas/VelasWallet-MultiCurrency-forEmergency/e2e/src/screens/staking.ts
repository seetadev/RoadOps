import { Locator } from '@playwright/test';
import { velasNative } from '@velas/velas-chain-test-wrapper/lib/velas-native';
import { Page } from '../common-test-exports';
import { helpers } from '../tools/helpers';
import { log } from '../tools/logger';
import { BaseScreen } from './base';

type Stake = 'Delegate' | 'Undelegate' | 'Withdraw';

export class StakingScreen extends BaseScreen {
  constructor(public page: Page) {
    super(page);
  }

  vlxNativeBalance = this.page.locator('#vlx-native-balance');
  loader = this.page.locator('.item.blink').first();

  async refresh() {
    const refreshStakesButton = this.page.locator('.balance .button.lock');
    await refreshStakesButton.click();
    await this.loader.waitFor();
    await this.waitForLoaded();
  }

  accounts = {
    delegateButton: this.page.locator('#staking-accounts tr button:not([disabled]).action-delegate'),
    delegateButtonSecond: this.page.locator(':nth-match(#staking-accounts tr button:not([disabled]).action-delegate, 2)'),
    undelegateButton: this.page.locator('#staking-accounts button:not([disabled]).action-undelegate'),
    withdrawButton: this.page.locator('#staking-accounts tr.loading button:not([disabled]).action-withdraw'),
    loader: this.page.locator('#staking-accounts .entities-loader'),
    stakerAddress: this.page.locator('#staking-accounts [datacolumn="Staker Address"]'),

    emptyListSelector: '#staking-accounts .amount:text(" (0) ")',

    clickWithdraw: async (): Promise<void> => {
      try {
        await this.accounts.withdrawButton.click();
      } catch (e) {
        throw new Error(`No stakes available to withdraw. Please undelegate first\n${e}`);
      }
    },
    clickDelegate: async (): Promise<void> => {
      try {
        await this.accounts.delegateButton.first().click();
      } catch (e) {
        throw new Error(`No stakes available to delegate. Please create a stake first\n${e}`);
      }
    },
    clickUndelegate: async (): Promise<void> => {
      try {
        await this.accounts.undelegateButton.first().click();
        log.debug('Undelegating stake');
      } catch (e) {
        throw new Error(`No stakes available to undelegate. Please delegate first\n${e}`);
      }
    },
  };

  stakeAccount = {
    withdrawButton: this.page.locator('button span:text(" Withdraw")'),
    splitButton: this.page.locator('button.action-split'),
    splittingInProcess: this.page.locator('"Splitting in process"'),
  };

  validatorsList = {
    validator: {
      icon: this.page.locator('.validator-item .identicon'),
      browse: this.page.locator('.validator-item .browse'),
      copy: this.page.locator('.validator-item .copy'),
      myStakes: this.page.locator('.validator-item .with-stake'),
    },
  };

  createStakingAccountButton = this.page.locator('#create-staking-account button span:text(" Create Account")');

  creatingStakingAccountLoader = this.page.locator('"Creating staking account..."');

  createStakingAccountForm = {
    amount: this.page.locator('.input-area input'),
    maxAmount: '',
    getMaxAmount: async () => {
      const maxAmountValue = await this.createStakingAccountForm.amount.getAttribute('value');
      const maxAmount = Number(maxAmountValue?.replace(',', ''));
      return maxAmount;
    },
  };

  async waitForStakingAccountCreation() {
    const startTime = new Date().getTime();
    await this.creatingStakingAccountLoader.waitFor();
    let accountCreationIsInProgress = await this.creatingStakingAccountLoader.isVisible();
    while (accountCreationIsInProgress && (new Date().getTime() - startTime < 25000)) {
      await this.page.waitForTimeout(500);
      accountCreationIsInProgress = await this.creatingStakingAccountLoader.isVisible();
    }
    log.debug(`Staking account was created. It took ${((new Date().getTime() - startTime) / 1000).toFixed()} seconds`);
    await this.createStakingAccountButton.waitFor();
  }

  delegateTo = {
    selectValidator: this.page.locator('.select-validators-list button.btn'),
  };

  async waitForLoaded(): Promise<void> {
    while (await this.loader.isVisible()) {
      await this.page.waitForTimeout(500);
    }
    while (await this.accounts.loader.isVisible()) {
      await this.page.waitForTimeout(500);
    }
    // wait staking account item or make sure there are no accounts
    await this.page.waitForSelector(`#staking-accounts [datacolumn="Staker Address"], ${this.accounts.emptyListSelector}`);
    await this.page.waitForTimeout(500);
  }

  async waitForSplitedStakeToAppear(timeout = 30000): Promise<void> {
    const startTime = new Date().getTime();
    while (!await this.accounts.delegateButtonSecond.isVisible() && new Date().getTime() - startTime < timeout) {
      await this.page.waitForTimeout(1000);
      await this.refresh();
    }
    if (!await this.accounts.delegateButtonSecond.isVisible()) throw new Error(`Splited account does not appear within ${timeout} seconds`);
  }

  async waitForStakesAmountUpdated(params: { initialStakesAmount: number, stakeType?: Stake | 'all', timeout?: number }): Promise<number> {
    const stakeType = params.stakeType || 'all';
    const initialStakesAmount = params.initialStakesAmount ?? await this.getAmountOfStakes(stakeType);
    const timeout = params.timeout || 40_000;

    let finalAmountOfStakingAccounts = await this.getAmountOfStakes(stakeType);
    const startTime = new Date().getTime();
    while (finalAmountOfStakingAccounts === initialStakesAmount) {
      if (new Date().getTime() - startTime > timeout) {
        throw new Error(`You expected "${stakeType}" stakes amount to be changed. But no changes during ${timeout / 1000} sec.
        "${stakeType}" stakes amount: initial=${initialStakesAmount}, final=${finalAmountOfStakingAccounts}.`);
      }
      log.debug(`Amount of stake accounts still the same - ${finalAmountOfStakingAccounts}. Refreshing...`);
      await this.page.waitForTimeout(1000);
      await this.refresh();
      finalAmountOfStakingAccounts = await this.getAmountOfStakes(stakeType);
    }
    log.debug(`Great! Amount of "${params.stakeType}" stakes amount has changed: ${initialStakesAmount} > ${finalAmountOfStakingAccounts}.`);
    return finalAmountOfStakingAccounts;
  }

  async getFirstStakingAccountAddressFromTheList(type: Stake): Promise<string> {
    await this.waitForLoaded();
    const accountsElementsList = await this.page.$$('#staking-accounts tr');
    const errorText = `No accounts in the list of required type – "${type}"`;

    for (const accountElement of accountsElementsList) {
      let buttonText: string;

      switch (type) {
        case 'Delegate':
          buttonText = 'Delegate';
          break;
        case 'Undelegate':
          buttonText = 'Undelegate';
          break;
        case 'Withdraw':
          buttonText = 'Withdraw';
          break;
      }

      if (await accountElement.$(`span:text("${buttonText}")`)) {
        const accountAddress = await (await accountElement.$('td[title]'))?.getAttribute('title');
        if (typeof accountAddress !== 'string') throw new Error(errorText);
        return accountAddress;
      }
    }
    throw new Error(errorText);
  }

  async getAmountOfStakes(type: Stake | 'all'): Promise<number> {
    await this.waitForLoaded();
    if (type === 'all') return await this.accounts.stakerAddress.count();
    let stakeItemSelector: Locator;
    switch (type) {
      case 'Delegate':
        stakeItemSelector = this.accounts.delegateButton;
        break;
      case 'Undelegate':
        stakeItemSelector = this.accounts.undelegateButton;
        break;
      case 'Withdraw':
        stakeItemSelector = this.accounts.withdrawButton;
        break;
    }

    const stakesAmount = await stakeItemSelector.count();
    log.debug(`"${type}" stakes amount: ${stakesAmount}`);
    return stakesAmount;
  }

  async getStakingAccountsAddresses(): Promise<string[]> {
    await this.waitForLoaded();
    // const stakesAccountsElements = await this.page.$$(this.stakingAccountAddress);
    const stakesAccountsElements = await this.accounts.stakerAddress.elementHandles();
    const stakingAccountAddresses = await Promise.all(
      stakesAccountsElements.map(async (el) => await el.getAttribute('title') as string),
    );
    return stakingAccountAddresses;
  }

  /**
   * Function requires only initial stake accounts addresses list. Final list could be passed or will be got during function invocation.
   * Returns difference between states with specifying if stake account was added or removed from stake accounts list
   *
   * @param initialAccountsList
   * @param finalAccountsList
   * @return added or removed accounts list
   */
  async getStakingAccountsUpdate(initialAccountsAddressesList: string[], currentAccountsAddressesList?: string[]): Promise<{
    added?: string,
    removed?: string,
  } | null> {
    currentAccountsAddressesList = currentAccountsAddressesList || await this.getStakingAccountsAddresses();
    const diff = helpers.getArraysDiff(initialAccountsAddressesList, currentAccountsAddressesList);
    log.debug(`<<<<<
This is log of getStakingAccountsUpdate function

initialAccountsAddressesList:
${initialAccountsAddressesList || '<empty>'};
finalAccountsAddressesList:
${currentAccountsAddressesList || '<empty>'};

diff: ${diff || '<no diff>'}
>>>>>`);
    if (diff.length === 0) return null;
    return currentAccountsAddressesList.length > initialAccountsAddressesList.length ? { added: diff[0] } : { removed: diff[0] };
  }

  async selectAccount(type: Stake): Promise<void> {
    const accountsList = await this.page.$$('#staking-accounts .stake-account-item');
    let accountFound = false;
    for (const account of accountsList) {
      const buttonAccordingToType = await account.$(`"${type}"`);
      if (buttonAccordingToType) {
        const accountAddress = await account.$('.inner-address-holder div a');
        await accountAddress?.click();
        accountFound = true;
        break;
      }
    }
    if (!accountFound) throw new Error(`Cannot find account with type "${type}"`);
  }

  async selectAccountByAddress(address: string): Promise<void> {
    await this.waitForLoaded();
    const accountsElementsList = await this.page.$$('#staking-accounts tr');

    for (const accountElement of accountsElementsList) {
      const accountAddress = await (await accountElement.$('td[title]'))?.getAttribute('title');
      if (typeof accountAddress !== 'string') throw new Error(`Invalid account address: "${accountAddress}"`);
      if (accountAddress === address) {
        await this.page.click(`#staking-accounts tr [title="${address}"] .inner-address-holder`);
        return;
      }
    }

    const stakingAccountsAddresses = await this.getStakingAccountsAddresses();
    throw new Error(`No staking accounts with address ${address} in the staking accounts list.
    Available adresses:
    ${stakingAccountsAddresses}`);
  }

  async makeSureStakingAccIsCreatedAndNotDelegated(address: string): Promise<void> {
    try {
      await velasNative.getStakeAccount(address);
    } catch (error) {
      log.debug('This is expected error. Please ignore:', error);
      if (!(error instanceof Error)) {
        throw new Error(`Cannot parse error: ${error}`);
      }
      if (!error.toString().includes('stake account has not been delegated')) {
        throw new Error(`Something is wrong with staking account on blockchain:\n${error}`);
      }
    }
    log.info(`Newly added staking account: ${address}`);
  }

  async makeSureStakingAccountDoesNotExistOnBlockchain(address: string): Promise<void> {
    try {
      await velasNative.getStakeAccount(address);
    } catch (error: unknown) {
      log.debug('This is expected error. Please ignore:', error);
      if (!(error instanceof Error)) {
        throw new Error(`Cannot parse error: ${error}`);
      }
      if (!error.toString().includes('account not found')) {
        throw new Error(`Staking account still exist but should not. Error:\n${error}`);
      }
    }
    log.info(`Withdrawed staking account: ${address}`);
  }

  cleanup = {
    stakesToUndelegate: async () => {
      let toUndelegateStakesAmount = await this.getAmountOfStakes('Undelegate');
      while (toUndelegateStakesAmount > 0) {
        log.debug(`There are ${toUndelegateStakesAmount} delegated stakes to be undelegate as precondition`);
        await this.accounts.clickUndelegate();
        await this.modals.confirmPrompt();
        await this.page.waitForSelector('" Funds undelegated successfully"');
        await this.modals.clickOK();

        await this.refresh();
        await this.waitForStakesAmountUpdated({ stakeType: 'Undelegate', initialStakesAmount: toUndelegateStakesAmount });
        toUndelegateStakesAmount = await this.getAmountOfStakes('Undelegate');
      }
    },
    stakesToWithdraw: async () => {
      let toWithdrawStakesAmount = await this.getAmountOfStakes('Withdraw');
      while (toWithdrawStakesAmount > 0) {
        log.debug(`There are ${toWithdrawStakesAmount} stakes to be withdrawn as precondition`);
        await this.accounts.clickWithdraw();
        await this.modals.confirmPrompt();
        await this.page.waitForSelector('" Funds withdrawn successfully"', { timeout: 30000 });
        await this.modals.clickOK();

        await this.refresh();
        await this.waitForStakesAmountUpdated({ stakeType: 'Withdraw', initialStakesAmount: toWithdrawStakesAmount });
        toWithdrawStakesAmount = await this.getAmountOfStakes('Withdraw');
      }
    },

    stakesNotDelegated: async () => {
      let notDelegatedStakesAmount = await this.getAmountOfStakes('Delegate');
      while (notDelegatedStakesAmount > 0) {
        log.debug(`There are ${notDelegatedStakesAmount} not delegated stakes to be withdrawn as precondition`);
        await this.selectAccount('Delegate');
        await this.stakeAccount.withdrawButton.click();
        await this.modals.confirmPrompt();
        await this.page.waitForSelector('" Funds withdrawn successfully"', { timeout: 30000 });
        await this.modals.clickOK();

        await this.refresh();
        await this.waitForStakesAmountUpdated({ stakeType: 'Delegate', initialStakesAmount: notDelegatedStakesAmount });
        notDelegatedStakesAmount = await this.getAmountOfStakes('Delegate');
      }
    },

  };

  async getVLXNativeBalance(): Promise<number> {
    const textWithBalance = (await this.vlxNativeBalance.textContent())?.trim();
    const balance = Number(textWithBalance?.split(' ')[0]);
    return balance;
  }
}
