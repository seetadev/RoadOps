import { velasNative } from '@velas/velas-chain-test-wrapper';
import { data } from '../test-data';

(async () => {
  const receiverInitialBalance = (await velasNative.getBalance(data.wallets.fundsReceiver.address)).lamports;

  const tx = await velasNative.transfer({ payerSeed: data.wallets.payer.seed, toAddress: data.wallets.fundsReceiver.address, lamports: 1 });
  await velasNative.waitForConfirmedTransaction(tx);

  const receiverFinalBalance = (await velasNative.getBalance(data.wallets.fundsReceiver.address)).lamports;
  if (receiverInitialBalance === receiverFinalBalance) {
    throw new Error('Balance hasn\'t changed');
  }
})();
