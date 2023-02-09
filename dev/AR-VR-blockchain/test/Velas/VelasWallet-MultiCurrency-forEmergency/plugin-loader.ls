require! {
    \prelude-ls : { filter, sort-by, reverse, map }
    \./install-plugin.ls : { get-install-list, install-plugin }
    \./browser/window.ls
    \localStorage
}
gobyte = require \../web3t/plugins/gobyte-coin.js
export common = (store)->
    vlx2 = require \../web3t/plugins/vlx2-coin.js
    btc  = require \../web3t/plugins/btc-coin.js
    vlx_native  = require \../web3t/plugins/sol-coin.js
    eth  = require \../web3t/plugins/eth-coin.js
    vlx_evm = require \../web3t/plugins/vlx-coin.js
    vlx_usdv = require \../web3t/plugins/vlx_usdv-coin.js
    #vlx_evm_legacy = require \../web3t/plugins/vlx-evm-legacy-coin.js
    coins = [ vlx_native, vlx_evm, vlx2, vlx_usdv, btc, eth ]
    if store.url-params.gbx?
        coins.push gobyte
    coins
export base-array = <[ vlx_native vlx_evm vlx2 vlx_usdv btc eth ]>
legacy-tokens = 
    * require \../web3t/plugins/eth-legacy-coin.js
    * require \../web3t/plugins/usdt_erc20_legacy-coin.json
    * require \../web3t/plugins/vlx2-coin.js 
legacy-arr = <[ vlx2 vlx_evm_legacy usdt_erc20_legacy eth_legacy ]>
legacy-is-hidden = (name)->
    name = name ? ""
    res = (local-storage.get-item "plugin-" + name)
    res? and res is ""
check-and-install = ([plugin, ...rest], cb)->
    return cb null if not plugin?
    err <- install-plugin(plugin)
    console.error if err?
    check-and-install(rest, cb)
decide-to-show-or-ignore-legacy-tokens = (store, items, cb)->
    installed-items = items |> map (.token)
    /* Check if legacy tokens were installed or legacy tokens were not hidden by user, so do not make balance check for them */
    leg-tokens =
        legacy-tokens
            |> filter (?token not in installed-items)
            |> filter (?token not in base-array)
            |> filter (it)-> not legacy-is-hidden(it.token)
    /* Check not installed tokens and install them */
    err <- check-and-install(leg-tokens)
    return cb err if err?
    cb null
export get-coins = (store, cb)->
    network = store.current.network
    base =
        common store
            |> filter (?)
            |> filter (-> it[network]? and (it.type is \coin) and (it.enabled is yes) and (not (it[network]?disabled is yes)))
    err, items <- get-install-list
    return cb err if err?
    /* here we need to check legacy tokens if it is first load */
    err, res <- decide-to-show-or-ignore-legacy-tokens(store, items)
    return cb err if err?
    installed =
        items
            |> filter (.type is \coin)
            |> filter (.enabled isnt no)
            |> filter (.token not in base-array)
            #|> sort-by (.wallet-index)
            #|> reverse
    all =  base ++ installed
    cb null, all