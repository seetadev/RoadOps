import { velasNative } from '@velas/velas-chain-test-wrapper';
import {
  bscchain, evmchain, hecochain, ropsten,
} from '../../api/explorers-api';
import { data, test } from '../../common-test-exports';
import { log } from '../../tools/logger';

test.describe('Swap', () => {
  const transactionsInProgress: Promise<any>[] = [];
  const isSmokeRun = process.env.SMOKE === 'true';
  log.warn(`${isSmokeRun ? 'Only tests marked @smoke will be run' : 'All smoke tests will be run'}`);

  test.beforeEach(async ({ auth, wallets }) => {
    await auth.goto();
    await auth.loginByRestoringSeed(data.wallets.swap.seed);
    await wallets.waitForWalletsDataLoaded();
  });

  test.afterAll(async () => {
    await Promise.all(transactionsInProgress);
  });

  test.describe('Inside Velas network: ', () => {
    test('VLX Native (Velas) > VLX EVM (Velas) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-vlx_native', 'token-vlx_evm', '0.0001');
      await wallets.txListAfterSendOrSwap.linkToTxExecuted.waitFor({ timeout: 30000 });
      const txSignature = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(velasNative.waitForConfirmedTransaction(txSignature));
    });

    test('Error: Not enough funds @smoke', async ({ page, wallets }) => {
      await wallets.swapTokens('token-vlx_native', 'token-vlx_evm', '9999999999', { confirm: false });
      await page.locator('" Not Enough Funds"').waitFor();
    });

    test('VLX Native (Velas) > VLX Legacy (Velas)', async ({ wallets }) => {
      await wallets.swapTokens('token-vlx_native', 'token-vlx2', '0.0001');
      await wallets.txListAfterSendOrSwap.linkToTxExecuted.waitFor({ timeout: 30000 });
      const txSignatureLink = await wallets.txListAfterSendOrSwap.linkToTxExecuted.getAttribute('href');
      if (!txSignatureLink) throw new Error('No txSignatureLink');
      const txSignature = txSignatureLink.replace('https://native.velas.com/tx/', '');
      transactionsInProgress.push(velasNative.waitForConfirmedTransaction(txSignature));
    });

    test('VLX EVM (Velas) > VLX Native (Velas) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-vlx_evm', 'token-vlx_native', '0.0001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    test('VLX EVM (Velas) > VLX Legacy (Velas)', async ({ wallets }) => {
      await wallets.swapTokens('token-vlx_evm', 'token-vlx2', '0.0001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    test('VLX Legacy (Velas) > VLX Native (Velas)', async ({ wallets }) => {
      await wallets.swapTokens('token-vlx2', 'token-vlx_native', '0.0001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    test('VLX Legacy (Velas) > VLX EVM (Velas)', async ({ wallets }) => {
      await wallets.swapTokens('token-vlx2', 'token-vlx_evm', '0.0001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });
  });

  test.describe('From Velas network', async () => {
    test('VLX EVM (Velas) > VLX ERC-20 (Ethereum) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-vlx_evm', 'token-vlx_erc20', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    // bsc is down too often; test may be unstable
    test('VLX EVM (Velas) > VLX BEP-20 (BSC) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-vlx_evm', 'token-bsc_vlx', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    test('VLX EVM (Velas) > VLX HRC-20 (Heco) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-vlx_evm', 'token-vlx_huobi', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    // TODO: no tokens! need replenishment
    test('USDC (Velas) > USDC (Ethereum) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-vlx_usdc', 'token-usdc', '0.000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    test('ETH VRC-20 (Velas) > ETH (Ethereum) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-vlx_eth', 'token-eth', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    test('USDT (Velas) > USDT (Ethereum)', async ({ wallets }) => {
      await wallets.swapTokens('token-vlx_usdt', 'token-usdt_erc20', '0.000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    // to run this test, min amount per tx should be larger that bridge fee, but now its smaller
    // TODO: run on mainnet
    test.skip('USDT (Velas) > USDT (Ethereum): min amount per tx error', async ({ auth, page, wallets }) => {
      await auth.goto({ network: 'mainnet' });
      await auth.pinForLoggedOutAcc.typeAndConfirm('111222');
      await wallets.waitForWalletsDataLoaded();

      await wallets.swapTokens('token-bsc_vlx', 'token-vlx_evm', '0.0000001', { confirm: false });
      await (page.locator('button :text("swap")')).click();
      await page.locator('" Min amount per transaction is 1 VLX"').waitFor();
    });

    // to run this test bridge fee should be larger than min amount
    // TODO: maybe could be run on mainnnet
    test.skip('USDT (Velas) > USDT (Ethereum): amount is less than bridge fee @smoke', async ({ page, wallets }) => {
      await wallets.swapTokens('token-vlx_usdt', 'token-usdt_erc20', '0.000001', { confirm: false });
      await page.locator('" Amount 0.000001 is less than bridge fee (0.001)"').waitFor();
    });

    test('BUSD (Velas) > BUSD (BSC) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-vlx_busd', 'token-busd', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });
  });

  test.describe('From Ethereum network', async () => {
    // ETH ropsten testnet has a huge gas price (111,363 Gwei)
    test('ETH (Ethereum) > ETH VRC-20 (Velas)', async ({ wallets }) => {
      await wallets.swapTokens('token-eth', 'token-vlx_eth', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(ropsten.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    test('USDC (Ethereum) > USDC VRC-20 (Velas)', async ({ wallets }) => {
      await wallets.swapTokens('token-usdc', 'token-vlx_usdc', '0.000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(ropsten.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    // BUG: 0 fee error
    test('VLX ERC-20 (Ethereum) > VLX EVM (Velas)', async ({ wallets }) => {
      await wallets.swapTokens('token-vlx_erc20', 'token-vlx_evm', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(ropsten.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    test('USDT (Ethereum) > USDT VRC-20 (Velas)', async ({ wallets }) => {
      await wallets.swapTokens('token-usdt_erc20', 'token-vlx_usdt', '0.000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(ropsten.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });
  });

  test.describe('From BSC network', async () => {
    test('VLX BEP-20 (BSC) > VLX EVM (Velas) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-bsc_vlx', 'token-vlx_evm', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(bscchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }))
    });

    test('BUSD (BSC) > BUSD VRC-20 (Velas)', async ({ wallets }) => {
      await wallets.swapTokens('token-busd', 'token-vlx_busd', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(bscchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });
  });

  test.describe('From HECO network', async () => {
    test('VLX HRC-20 (Heco) > VLX EVM (Velas) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-vlx_huobi', 'token-vlx_evm', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(hecochain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });
  });
});
