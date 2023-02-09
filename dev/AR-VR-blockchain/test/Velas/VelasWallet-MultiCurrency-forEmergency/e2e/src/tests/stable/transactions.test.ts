import { velasNative } from '@velas/velas-chain-test-wrapper';
import {
  assert, data, helpers, test,
} from '../../common-test-exports';
import { ropsten } from '../../api/explorers-api';

test.describe.parallel('Transactions', () => {
  test.beforeEach(async ({ auth, wallets }) => {
    await auth.goto();
    await auth.loginByRestoringSeed(data.wallets.txSender.seed);
    await wallets.waitForWalletsDataLoaded();
  });

  test('Send VLX native', async ({ wallets }) => {
    await wallets.addToken('token-vlx_native');

    const receiverInitialBalance = await velasNative.getBalance(data.wallets.fundsReceiver.address);
    const senderInitialBalance = await velasNative.getBalance(data.wallets.txSender.address);
    const transactionAmount = 0.0001;

    await wallets.sendTx('token-vlx_native', 'FJWtmzRwURdnrgn5ZFWvYNfHvXMtHK1WS7VHpbnfG73s', transactionAmount);

    const txSignature = await wallets.getTxHashFromTxlink();

    const tx = await velasNative.waitForConfirmedTransaction(txSignature);
    assert.exists(tx);

    const receiverFinalBalance = await velasNative.getBalance(data.wallets.fundsReceiver.address);
    assert.equal(helpers.toFixedNumber(receiverFinalBalance.VLX, 6), helpers.toFixedNumber((receiverInitialBalance.VLX + transactionAmount), 6));

    const senderFinalBalance = await velasNative.getBalance(data.wallets.txSender.address);
    assert.isBelow(senderFinalBalance.VLX, senderInitialBalance.VLX - transactionAmount, 'Final sender balance is not below the initial sender balance');
  });

  // TODO: network request error
  test.skip('Send BTC', async ({ wallets }) => {
    await wallets.addToken('token-btc');

    await wallets.sendTx('token-btc', 'mvvFj8fbFpL61S2HyhvcqEHjT2ThB1f78j', 0.00001);

    // TODO: btc chain api
    const txSignatureLink = await wallets.txListAfterSendOrSwap.linkToTxExecuted.getAttribute('href');
    if (!txSignatureLink) throw new Error('No txSignatureLink');
    assert.isTrue(txSignatureLink.includes('https://bitpay.com/insight/#/BTC/testnet/'));
  });

  // TODO: network request error
  test.skip('Send LTC', async ({ wallets }) => {
    await wallets.addToken('token-ltc');

    await wallets.sendTx('token-ltc', 'mvvFj8fbFpL61S2HyhvcqEHjT2ThB1f78j', 0.00001);

    // TODO: ltc chain api
    const txSignatureLink = await wallets.txListAfterSendOrSwap.linkToTxExecuted.getAttribute('href');
    if (!txSignatureLink) throw new Error('No txSignatureLink');
    assert.isTrue(txSignatureLink.includes('https://testnet.litecore.io/'));
  });

  test('Send ETH Legacy', async ({ wallets }) => {
    await wallets.addToken('token-eth_legacy');

    await wallets.sendTx('token-eth_legacy', '0xb322f01cb6a191974e7291600a4dc1b46f00f752', 0.00001);
    const txSignature = await wallets.getTxHashFromTxlink();
    await ropsten.waitForTx({ txHash: txSignature });
  });
});
