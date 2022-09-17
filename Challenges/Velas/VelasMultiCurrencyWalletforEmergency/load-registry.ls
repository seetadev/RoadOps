require! {
    \../web3t/providers/superagent.js : { get, post }
    \atob
    \./providers.ls
    \../web3t/plugins/btc-coin.js : btc
    \../web3t/plugins/eth-coin.js : eth
    \../web3t/plugins/eth-legacy-coin.js : eth_legacy
    \../web3t/plugins/symblox.js : syx
    \../web3t/plugins/symblox-v2.js : syx2
    \../web3t/plugins/ltc-coin.js : ltc
    \../web3t/plugins/usdt-coin.js : usdt
    \../web3t/plugins/usdt_erc20.json : usdt_erc20
    \../web3t/plugins/vlx_erc20-coin.js : vlx_erc20
    \../web3t/plugins/vlx-coin.js : vlx_evm
    \../web3t/plugins/bnb-coin.js : bnb 
    \../web3t/plugins/vlx_busd-coin.js : vlx_busd
    \../web3t/plugins/busd-coin.js : busd
    \../web3t/plugins/huobi-coin.js : huobi 
    \../web3t/plugins/vlx-huobi-coin.js : vlx_huobi
    \../web3t/plugins/vlx-usdt-coin.js : vlx_usdt
    \../web3t/plugins/vlx-eth-coin.js : vlx_eth
    \../web3t/plugins/usdc-coin.js : usdc
    \../web3t/plugins/vlx_usdc-coin.js : vlx_usdc
    \../web3t/plugins/usdt_erc20_legacy-coin.json : usdt_erc20_legacy
    \../web3t/plugins/bsc-vlx-coin.js : bsc_vlx
    \../web3t/plugins/vlx-evm-legacy-coin.js : vlx_evm_legacy
    \../web3t/plugins/vlx_usdv-coin.js : vlx_usdv
}
module.exports = (cb) ->
    def = [ eth, eth_legacy, vlx_usdv, usdt, syx, syx2, usdt_erc20, ltc, vlx_erc20, vlx_evm, bnb, vlx_busd, busd, huobi, vlx_huobi, vlx_usdt, vlx_eth, usdt_erc20_legacy, usdc, vlx_usdc, bsc_vlx, vlx_evm_legacy  ]
    cb null, def