import {
  bscchain, evmchain, hecochain, ropsten,
} from '../../api/explorers-api';
import { data, test } from '../../common-test-exports';

test.describe('Custom swap from Velas network', () => {
  const transactionsInProgress: Promise<any>[] = [];
  const minSwapAmount = '0.00000001';
  const minSwapAmountUsdtUsdc = '0.000001';

  test.beforeEach(async ({ auth, wallets }) => {
    await auth.goto();
    await auth.loginByRestoringSeed(data.wallets.customSwapFromVelas.seed);
    await wallets.waitForWalletsDataLoaded();
  });

  test.afterAll(async () => {
    await Promise.all(transactionsInProgress);
  });

  test('VLX EVM (Velas) > VLX ERC-20 (Ethereum)', async ({ wallets }) => {
    await wallets.swapTokens('token-vlx_evm', 'token-vlx_erc20', minSwapAmount, {customAddress: data.wallets.customSwapToVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  test('VLX EVM (Velas) > VLX BEP-20 (BSC)', async ({ wallets }) => {
    await wallets.swapTokens('token-vlx_evm', 'token-bsc_vlx', minSwapAmount, {customAddress: data.wallets.customSwapToVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  test('VLX EVM (Velas) > VLX HRC-20 (Heco)', async ({ wallets }) => {
    await wallets.swapTokens('token-vlx_evm', 'token-vlx_huobi', minSwapAmount, {customAddress: data.wallets.customSwapToVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  test('USDC (Velas) > USDC (Ethereum)', async ({ wallets }) => {
    await wallets.swapTokens('token-vlx_usdc', 'token-usdc', minSwapAmountUsdtUsdc, {customAddress: data.wallets.customSwapToVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  test('ETH VRC-20 (Velas) > ETH (Ethereum)', async ({ wallets }) => {
    await wallets.swapTokens('token-vlx_eth', 'token-eth', minSwapAmount, {customAddress: data.wallets.customSwapToVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  test('USDT (Velas) > USDT (Ethereum)', async ({ wallets }) => {
    await wallets.swapTokens('token-vlx_usdt', 'token-usdt_erc20', minSwapAmountUsdtUsdc, {customAddress: data.wallets.customSwapToVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  test('BUSD (Velas) > BUSD (BSC)', async ({ wallets }) => {
    await wallets.swapTokens('token-vlx_busd', 'token-busd', minSwapAmount, {customAddress: data.wallets.customSwapToVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));    
  });
});

test.describe('Custom swap to Velas network', () => {
  const transactionsInProgress: Promise<any>[] = [];
  const minSwapAmount = '0.00000001';
  const minSwapAmountUsdtUsdc = '0.000001';

  test.beforeEach(async ({ auth, wallets }) => {
    await auth.goto();
    await auth.loginByRestoringSeed(data.wallets.customSwapToVelas.seed);
    await wallets.waitForWalletsDataLoaded();
  });

  test.afterAll(async () => {
    await Promise.all(transactionsInProgress);
  });

  test('ETH (Ethereum) > ETH VRC-20 (Velas)', async ({ wallets }) => {
    await wallets.swapTokens('token-eth', 'token-vlx_eth', minSwapAmount, {customAddress: data.wallets.customSwapFromVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(ropsten.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  test('USDC (Ethereum) > USDC VRC-20 (Velas)', async ({ wallets }) => {
    await wallets.swapTokens('token-usdc', 'token-vlx_usdc', minSwapAmountUsdtUsdc, {customAddress: data.wallets.customSwapFromVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(ropsten.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  test('VLX ERC-20 (Ethereum) > VLX EVM (Velas)', async ({ wallets }) => {
    await wallets.swapTokens('token-vlx_erc20', 'token-vlx_evm', minSwapAmount, {customAddress: data.wallets.customSwapFromVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(ropsten.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  test('USDT (Ethereum) > USDT VRC-20 (Velas)', async ({ wallets }) => {
    await wallets.swapTokens('token-usdt_erc20', 'token-vlx_usdt', minSwapAmountUsdtUsdc, {customAddress: data.wallets.customSwapFromVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(ropsten.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  test('VLX BEP-20 (BSC) > VLX EVM (Velas)', async ({ wallets }) => {
    await wallets.swapTokens('token-bsc_vlx', 'token-vlx_evm', minSwapAmount, {customAddress: data.wallets.customSwapFromVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(bscchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }))
  });

  test('BUSD (BSC) > BUSD VRC-20 (Velas)', async ({ wallets }) => {
    await wallets.swapTokens('token-busd', 'token-vlx_busd', minSwapAmount, {customAddress: data.wallets.customSwapFromVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(bscchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  test('VLX HRC-20 (Heco) > VLX EVM (Velas)', async ({ wallets }) => {
    await wallets.swapTokens('token-vlx_huobi', 'token-vlx_evm', minSwapAmount, {customAddress: data.wallets.customSwapFromVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(hecochain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));  
  });
});
