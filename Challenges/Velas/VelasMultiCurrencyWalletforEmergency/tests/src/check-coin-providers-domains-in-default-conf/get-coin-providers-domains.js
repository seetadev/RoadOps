const loadPlugins = require('../../../.compiled-ssr/web3t/load-coins');

const providers = [];

// @ts-ignore
loadPlugins({}, function (err, coins) {
  Object.keys(coins).forEach((coin) => {
    var plugin = coins[coin];
    if (plugin.testnet.api) {
      var testnetProvider = plugin.testnet.api.web3Provider;
      if (testnetProvider) providers.push(testnetProvider);
    }
    if (plugin.mainnet.api) {
      var mainnetProvider = plugin.mainnet.api.web3Provider;
      if (mainnetProvider) providers.push(mainnetProvider);
    }
  });
});

module.exports = providerDomainsList = [];
providers.forEach((prodiderURL) => {
  providerDomainsList.push(new URL(prodiderURL).host);
});
