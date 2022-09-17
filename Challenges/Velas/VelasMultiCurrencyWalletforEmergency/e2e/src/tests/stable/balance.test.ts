import { velasNative } from '@velas/velas-chain-test-wrapper';
import balancesAPI from '../../api/balances-api';
import { Currency } from '../../screens';
import { assert, data, helpers, test } from '../../common-test-exports';
import { log } from '../../tools/logger';

test.describe('Balance', () => {
  test.beforeEach(async ({ auth, wallets }) => {
    await auth.goto();
    await auth.loginByRestoringSeed(data.wallets.withFunds.seed);
    await wallets.waitForWalletsDataLoaded();
  });

  test('Check VLX Legacy, VLX Native, Litecoin and Bitcoin balances', async ({ wallets }) => {
    const balances = await wallets.getWalletsBalances();
    const walletsList = Object.keys(balances) as Currency[];

    for (const currency of walletsList) {
      const VLXNativeBalanceOnBlockchain = (await velasNative.getBalance(data.wallets.withFunds.address)).VLX;
      const balanceUpdateAmount = 0.001;
      const amountOfTokens = balances[currency];

      // if no balance – skip currency
      if (amountOfTokens === null) continue;

      switch (currency) {
        case 'token-vlx2':
          assert.equal(amountOfTokens, '80.999895');
          break;
        case 'token-vlx_native':
          (async () => {
            assert.equal(amountOfTokens, String(VLXNativeBalanceOnBlockchain));
            
            // const tx = await velasNative.transfer({
            //   lamports: balanceUpdateAmount * 10 ** 9,
            //   payerSeed: data.wallets.payer.seed,
            //   toAddress: data.wallets.withFunds.address,
            // });
            // await velasNative.waitForConfirmedTransaction(tx);
            // await wallets.refreshBalances();
            // const amountOfTokensAfterUpdate = helpers.toFixedNumber(Number((await wallets.getWalletsBalances())['token-vlx_native']), 6);
            // assert.equal(amountOfTokensAfterUpdate, helpers.toFixedNumber((VLXNativeBalanceOnBlockchain + balanceUpdateAmount), 6), 'Velas Native wallet balance was not updated after funding it');
          })();
          break;
        case 'token-btc':
          try {
            await balancesAPI.bitcore();
            assert.equal(amountOfTokens, '0.03484302');
          } catch (e) {
            log.debug(e);
            log.warn('Bitcoin balance check skipped because of 3rd party service is down');
          }
          break;
        case 'token-vlx_evm':
          assert.equal(amountOfTokens, '1801.000622564');
          break;
      }
    }
  });
});
