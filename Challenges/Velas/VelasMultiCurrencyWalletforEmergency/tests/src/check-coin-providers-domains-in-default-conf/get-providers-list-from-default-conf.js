const { promisify } = require('util');
const { readFile } = require('fs');

const promisifiedReadFile = promisify(readFile);

module.exports = async function getArrayWithProvidersDomains() {
  const fileData = await promisifiedReadFile('nginx_config/default.conf', 'utf8');

  const rows = fileData.replace(/\r\n/g, '\n').split('\n');
  let providersDomainsStr;
  rows.forEach((row) => {
    if (row.includes('add_header Content-Security-Policy')) providersDomainsStr = row;
  });

  let providersDomainsArr = providersDomainsStr.split(' ').filter((string) => string.includes('http'));
  // get only domain/host
  providersDomainsArr = providersDomainsArr.map((prodiderURL) => new URL(prodiderURL).host);
  return providersDomainsArr;
}

// (async() => {
//   await getArrayWithProvidersDomains();
// })();
