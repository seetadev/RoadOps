import { velasNative } from '@velas/velas-chain-test-wrapper';
import { data, expect, helpers, test } from '../../common-test-exports';
import { log } from '../../tools/logger';

test.describe('Staking 2', () => {
  test.beforeAll(async () => {
    const epochInfo = await velasNative.getEpochInfo();
    const amountOfSlotsRemaining = epochInfo.slotsInEpoch - epochInfo.slotIndex;
    if (amountOfSlotsRemaining < 150) {
      const timeToNewEpochStart = amountOfSlotsRemaining * 400;
      log.warn(`The new epoch will start in less than a minute. The test suite will wait to avoid unstability.
      Its better if tests start and finish within the same epoch.
      Estimated time to wait: ${timeToNewEpochStart / 1000} seconds`);
      await helpers.sleep(timeToNewEpochStart);

      const newEpochInfo = await velasNative.getEpochInfo();
      expect(newEpochInfo.epoch).toEqual(epochInfo.epoch + 1);
    }
  });

  test.beforeEach(async ({ auth }) => {
    await auth.goto();
  });

  test.describe('validators list', () => {
    test('validator item info: active/inactive, name', async ({ auth, staking2, wallets }) => {
      await auth.loginByRestoringSeed(data.wallets.staking.withoutStakeAccounts.seed);
      await wallets.waitForWalletsDataLoaded();
      await wallets.openMenu('staking');
      await staking2.waitForLoaded();

      await staking2.validatorsList.validator.first().waitFor();

      // status: active/inactive
      await expect(staking2.validatorsList.activeStatus.first()).toBeVisible();
      await expect(staking2.validatorsList.inactiveStatus.first()).toBeVisible();

      // name
      await expect(staking2.validatorsList.validatorName.first()).toBeVisible();
    });

    // TODO: test fails; need investigation
    test.skip('sorting', async ({ auth, staking2, wallets }) => {
      await auth.loginByRestoringSeed(data.wallets.staking.withoutStakeAccounts.seed);
      await wallets.waitForWalletsDataLoaded();
      await wallets.openMenu('staking');
      await staking2.waitForLoaded();

      await staking2.validatorsList.sortBy('apr');
      await staking2.validatorsList.apr.first().waitFor();
      const aprs = await staking2.validatorsList.apr.allInnerTexts();
      expect(aprs).toEqual([...aprs].sort().reverse());

      /*
      // !BUG: https://velasnetwork.atlassian.net/browse/VLWA-1515
      await staking2.validatorsList.sortBy('total staked');
      await staking2.validatorsList.totalStaked.first().waitFor();
      let totalStakes = await staking2.validatorsList.totalStaked.allInnerTexts();
      totalStakes = totalStakes.map((totalStakeAmount: string) => totalStakeAmount.split(' VLX')[0]);
      expect(totalStakes).toEqual([...totalStakes].sort((a, b) => Number(a) - Number(b)));
      */
    });

    test('search', async ({ auth, staking2, wallets }) => {
      await staking2.goto({ network: 'mainnet' });
      await auth.loginByRestoringSeed(data.wallets.staking.withoutStakeAccounts.seed);
      await wallets.waitForWalletsDataLoaded();
      await wallets.openMenu('staking');
      await staking2.waitForLoaded();

      // nothing found
      await staking2.search.open.click();
      await staking2.search.input.type('none');
      await expect(staking2.search.noResults).toBeVisible();
      await staking2.search.cancel.click();

      // address
      await staking2.search.open.click();
      await expect(staking2.search.getSearchResultItemWithText('Velas Validator Node')).not.toBeVisible();
      await staking2.search.input.fill('DgmRwYK5tNLKeCSk6a4zpnwXSw3RdgMDTfAU1x6iqL3g');
      await expect(staking2.search.getSearchResultItemWithText('Velas Validator Node')).toBeVisible();
      await staking2.search.cancel.click();

      // name (case insensitive)
      await staking2.search.open.click();
      await expect(staking2.search.getSearchResultItemWithText('BlueZilla.vc')).not.toBeVisible();
      await staking2.search.input.fill('BlueZilla.vc');
      await expect(staking2.search.getSearchResultItemWithText('BlueZilla.vc')).toBeVisible();
      await staking2.search.cancel.click();

      // identity (type only part of string)
      await staking2.search.open.click();
      await expect(staking2.search.getSearchResultItemWithText('VelasPad.io')).not.toBeVisible();
      await staking2.search.input.fill('HdCn5cV2Cugcb2XgpCR3Uu6FcdTAyJw');
      await expect(staking2.search.getSearchResultItemWithText('VelasPad.io')).toBeVisible();
      await staking2.search.cancel.click();
    });
  });

  test.describe.serial('stake - stake more - withdraw', () => {
    let allTestsPassed = false;

    test('cleanup on start', async ({ auth, staking2, wallets }) => {
      await auth.loginByRestoringSeed(data.wallets.staking.staker2_1.seed);
      await wallets.waitForWalletsDataLoaded();
      await wallets.openMenu('staking');
      await staking2.waitForLoaded();

      await staking2.cleanup();
    });

    test('stake', async ({ auth, page, staking2, wallets }) => {
      await auth.loginByRestoringSeed(data.wallets.staking.staker2_1.seed);
      await wallets.waitForWalletsDataLoaded();
      await wallets.openMenu('staking');
      await staking2.waitForLoaded();
      await staking2.validatorsList.refreshStakesUntilStakedValidatorDisappears();

      await staking2.validatorsList.selectFirstValidator();
      await staking2.validator.notStaked.stakeButton.click();
      await staking2.stakeForm.typeAmount(1.1);
      await staking2.stakeForm.nextButton.click();
      await staking2.modals.confirmPrompt();

      await page.locator('"Stake account has been created successfully"').waitFor({ timeout: 15000 });
      await staking2.stakeForm.okButton.click();
      await staking2.validator.goBack();
      await staking2.validatorsList.stakedValidatorsAmountIsVisible(1); // WS
      await staking2.validatorsList.reload(); //no WS
      await staking2.validatorsList.refreshStakesUntilStakedValidatorAppears();
    });

    test('stake more', async ({ auth, page, staking2, wallets }) => {
      await auth.loginByRestoringSeed(data.wallets.staking.staker2_1.seed);
      await wallets.waitForWalletsDataLoaded();
      await wallets.openMenu('staking');
      await staking2.waitForLoaded();

      await staking2.validatorsList.stakedValidatorsAmountIsVisible(1);
      await staking2.validatorsList.selectFirstValidator();
      await staking2.validator.staked.clickStakeMore();
      await staking2.stakeForm.typeAmount(0.2);
      await staking2.stakeForm.nextButton.click();
      await staking2.modals.confirmPrompt();

      await page.locator('"Stake account has been created successfully"').waitFor();
      await staking2.stakeForm.okButton.click();
      expect (await staking2.validator.getStakeValue()).toEqual('1.30'); // WS
      await staking2.validator.reload(); // no WS
      await staking2.validator.waitForStakeValueUpdate({ fromValue: '1.10', toValue: '1.30' });
    });

    test('request withdraw (2 stakes from one validator)', async ({ auth, staking2, wallets }) => {
      await auth.loginByRestoringSeed(data.wallets.staking.staker2_1.seed);
      await wallets.waitForWalletsDataLoaded();
      await wallets.openMenu('staking');
      await staking2.waitForLoaded();

      await staking2.validatorsList.stakedValidatorsAmountIsVisible(1);
      await staking2.validatorsList.selectFirstValidator();
      await staking2.validator.staked.clickrequestWithdraw();
      await staking2.stakeForm.useMaxButton.click();
      await staking2.stakeForm.withdrawButton.click();
      await staking2.stakeForm.successfulWithdraRequestMessage.waitFor({ timeout: 20000 });
      await staking2.stakeForm.okButton.click();
    });

    test('withdraw', async ({ auth, staking2, wallets }) => {
      await auth.loginByRestoringSeed(data.wallets.staking.staker2_1.seed);
      await wallets.waitForWalletsDataLoaded();
      await wallets.openMenu('staking');
      await staking2.waitForLoaded();

      await staking2.validatorsList.stakedValidatorsAmountIsVisible(1);
      await staking2.validatorsList.selectFirstValidator();
      await staking2.validator.tab.withdrawals.click();
      await staking2.validator.withdrawals.withdrawButton.click();
      await staking2.stakeForm.successfulWithdrawMessage.waitFor({ timeout: 20000 });
      await staking2.stakeForm.okButton.click();
      await staking2.validator.goBack();

      await staking2.validatorsList.stakedValidatorsAmountIsVisible(0); // WS
      await staking2.validatorsList.reload(); // no WS
      await staking2.validatorsList.refreshStakesUntilStakedValidatorDisappears();

      allTestsPassed = true;
    });

    test('cleanup on teardown', async ({ auth, staking2, wallets }) => {
      test.skip(allTestsPassed);

      await auth.loginByRestoringSeed(data.wallets.staking.staker2_1.seed);
      await wallets.waitForWalletsDataLoaded();
      await wallets.openMenu('staking');
      await staking2.waitForLoaded();

      await staking2.cleanup();
    });
  });

  test.describe('validator', () => {
    test('rewards', async ({ auth, staking2, wallets }) => {
      await auth.loginByRestoringSeed(data.wallets.staking.rewards.seed);
      await wallets.waitForWalletsDataLoaded();
      await wallets.openMenu('staking');
      await staking2.waitForLoaded();

      await staking2.validatorsList.stakedValidatorsAmountIsVisible(1);
      await staking2.validatorsList.selectFirstValidator();
      await staking2.validator.rewards.open();

      await expect(staking2.validator.rewards.rewardItem.first()).toBeVisible();
      const lastRewardEpoch = Number(await staking2.validator.rewards.epochNumber.textContent());
      const epochNumberFromBlockchain = (await velasNative.getEpochInfo()).epoch;
      expect(lastRewardEpoch).toEqual(epochNumberFromBlockchain - 1);
    });

    test('use max', async ({ auth, staking2, wallets }) => {
      await auth.loginByRestoringSeed(data.wallets.staking.useMax.seed);
      await wallets.waitForWalletsDataLoaded();
      await wallets.openMenu('staking');
      await staking2.waitForLoaded();

      await staking2.validatorsList.selectFirstValidator();
      await staking2.validator.notStaked.stakeButton.click();
      const availableForStakingAmount = await staking2.stakeForm.getAvailableForStakingAmount();
      await staking2.stakeForm.useMaxButton.click();
      const inputValue = await staking2.stakeForm.amountInput.inputValue();

      expect(Number(inputValue)).toEqual(availableForStakingAmount - 1);
    });

    test('copy validator address', async ({ auth, page, staking2, wallets }) => {
      await auth.loginByRestoringSeed(data.wallets.staking.withoutStakeAccounts.seed);
      await wallets.waitForWalletsDataLoaded();
      await wallets.openMenu('staking');
      await staking2.waitForLoaded();

      await staking2.validatorsList.selectFirstValidator();

      const copiedAddress = await staking2.validator.copyAddress();

      expect(copiedAddress).toHaveLength(44);
      await expect(page.locator('#message', { hasText: 'Copied' })).toBeVisible();
    });
  });

  test('stake with conversion (ENM > Native)', async ({ auth, page, staking2, wallets }) => {
    await auth.loginByRestoringSeed(data.wallets.staking.stakerEVM.seed);
    await wallets.waitForWalletsDataLoaded();
    await wallets.openMenu('staking');
    await staking2.waitForLoaded();

    await staking2.validatorsList.selectFirstValidator();
    await staking2.validator.notStaked.stakeButton.click();
    await staking2.stakeForm.typeAmount(13.13);
    await staking2.stakeForm.nextButton.click();

    await expect(page.locator('"Convert 11.13 VLX EVM to VLX Native"')).toBeVisible();
  });
});
