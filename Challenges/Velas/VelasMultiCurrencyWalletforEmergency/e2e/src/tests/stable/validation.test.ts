import { data, test } from '../../common-test-exports';

test.describe.parallel('Validation', () => {
  test.beforeEach(async ({ auth, wallets }) => {
    await auth.goto();
    await auth.loginByRestoringSeed(data.wallets.txSender.seed);
    await wallets.selectWallet('token-vlx_native');
  });

  test('VLX Native: Show Invalid Address error', async ({ wallets }) => {
    await wallets.clickSendButton();
    await wallets.sendForm.recepientInput.type('invalid');
    const error = wallets.getElementWhichTextContentContainsWords(['not', 'valid', 'address']);
    await error.waitFor();
    await wallets.sendForm.recepientInput.fill('BfGhk12f68mBGz5hZqm4bDSDaTBFfNZmegppzVcVdGDW');
    await error.isHidden();
  });

  test('VLX Native: Show Not Enough Funds error', async ({ page, wallets }) => {
    await wallets.selectWallet('token-vlx_native');
    await wallets.clickSendButton();
    await wallets.sendForm.recepientInput.fill('BfGhk12f68mBGz5hZqm4bDSDaTBFfNZmegppzVcVdGDW');
    await wallets.sendForm.amount.fill('99999999');

    try {
      await page.waitForSelector('text=/not enough/i');
    } catch {
      await wallets.sendButton.click();
      await page.waitForSelector('text=/not enough/i');
    }

    // need to clear the field because actions are too fast and test fails
    await wallets.sendForm.amount.fill('');

    await wallets.useMax();
    await wallets.waitForSelectorDisappears('text=/not enough/i');
  });
});
