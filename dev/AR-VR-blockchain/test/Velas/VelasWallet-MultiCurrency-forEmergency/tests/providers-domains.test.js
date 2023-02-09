let providersListFromWeb3t = require('./src/check-coin-providers-domains-in-default-conf/get-coin-providers-domains');
const getProvidersListFromDeaultConf = require('./src/check-coin-providers-domains-in-default-conf/get-providers-list-from-default-conf');

let errorMessage;

async function checkProviders() {
  const providersListFromDefaultConf = await getProvidersListFromDeaultConf();
  providersListFromWeb3t.forEach((providerURL) => {
    if (!providersListFromDefaultConf.includes(providerURL)) {
      errorMessage = `ERROR:
      web3t providers:${JSON.stringify(providersListFromWeb3t, null, 2)}

      default conf providers:${JSON.stringify(providersListFromDefaultConf, null, 2)}
      - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      "${providerURL}" is present in web3t but absent in nginx_config/default.conf
      - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      `;

      throw new Error(errorMessage);
    }
  });
}


(async () => {
  try {
    await checkProviders();
  } catch(e) {
    console.error(errorMessage);
    process.exit(1);
  }
})();
