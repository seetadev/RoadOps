# Velas Multi-Currency Wallet

### Install and run wallet locally
**Requirements:**
node version 14.16+
npm version 7+

Run `npm run setup`

OR follow next steps

1. Install lsxc: `npm i lsxc -g`
2. `git clone https://github.com/velas/web-wallet`
3. `git clone http://github.com/velas/web3t`
4. `cd web3t && npm i`
5. Delete git cache and copy web3t to web-wallet:
   `cd .. && rm -rf web-wallet/.compiled-ssr/web3t/.git/objects/ && mkdir -p web-wallet/.compiled-ssr/ && cp -pr web3t/ web-wallet/.compiled-ssr/web3t/ && cd web-wallet`
6. `npm i`
7. Build and run wallet: `npm run wallet-start`
8. Open `127.0.0.1:8080/main-index.html`

You can also specify network by adding it as parameter: `?network=testnet`.
Do not open `localhost`, use `127.0.0.1`. Otherwise some wallet functions may work incorrectly.

## Run e2e tests
Please refer to e2e/README.md

### Install Web Wallet on your server (steps could be DEPRECATED

1. mkdir wallet-area
2. cd wallet-area
1. git clone https://github.com/velas/web-wallet wallet
2. git clone http://github.com/velas/web3t
3. cd web3t
4. npm i 
5. cd ../wallet
6. npm i 
7. npm i lsxc -g
7. npm run wallet-start
8. open http://127.0.0.1:8080

Tested with `node --version` v11.10.1


### Features

* All coins managed by single mnemonic pharse
* Ability to install/uninstall other coins from github repository
* Web3 api support for multi-currency

### Supported Browsers:

* Chrome
* Mozilla 
* Opera
* Safari

### Supported Sreens: 

* Mobile - Compact Design
* Desktop - Extended Design with Transaction History 

### Supported Coins

* VLX
* BTC (+ All OMNI)
* LTC
* DASH
* ETH (+ All ERC20)
* ETC
* USDT (+ USDT_ERC20)
* and other less known
