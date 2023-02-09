# #!/usr/bin/env bash

npm i lsxc -g

cd .. && git clone http://github.com/velas/web3t

cd web3t && npm i

# Delete git cache and copy web3t to web-wallet:
cd .. && rm -rf web-wallet/.compiled-ssr/web3t/.git/objects/ && mkdir -p web-wallet/.compiled-ssr/ && cp -pr web3t/ web-wallet/.compiled-ssr/web3t/
cd web-wallet && npm i --legacy-peer-deps

# Build and run wallet
npm run wallet-build 

echo '
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
| Wallet will be opened in your browser (works only for mac). Please refresh the page after a few seconds.|
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
'

open http://127.0.0.1:8080/main-index.html?network=testnet || echo '>>>>> Please open link http://127.0.0.1:8080/main-index.html?network=testnet'

npm run wallet-start || echo '>>>>> Wallet cannot be started. Please check the logs.'
