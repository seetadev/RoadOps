import balancesAPI from '../api/balances-api';

(async () => {
  await balancesAPI.bitcore();
  await balancesAPI.apiVelasCom();
  await balancesAPI.explorer();
  await balancesAPI.ethBalance();
  await balancesAPI.evmExplorer();
})();
