require! {
    \localStorage
    \prelude-ls : { keys, any, map, filter, obj-to-pairs }
    #react controls
    \./modal.ls : { install, replace }
    \../web3t/providers/superagent.js : { get }
    \./json-parse.ls
    \./providers.ls
    \../web3t/plugins/eth-coin.js : eth
    \../web3t/plugins/eth-legacy-coin.js : eth_legacy
    \../web3t/plugins/symblox.js : syx
    \../web3t/plugins/symblox-v2.js : syx2
    \../web3t/plugins/ltc-coin.js : ltc
    \../web3t/plugins/usdt-coin.js : usdt
    \../web3t/plugins/usdt_erc20.json : usdt_erc20
    #\../web3t/plugins/vlx-coin.js : vlx_evm
    \../web3t/plugins/vlx_erc20-coin.js : vlx_erc20
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
}
current-configs = { vlx_eth,eth_legacy, syx, syx2, usdt, usdt_erc20, ltc, vlx_erc20, bnb, vlx_busd, busd, huobi, vlx_huobi, vlx_usdt,  usdt_erc20_legacy, usdc, vlx_usdc, bsc_vlx, vlx_evm_legacy }
plugin-pairs = {
    vlx_huobi: \huobi
    busd: \bnb
    vlx_erc20: \eth 
    #vlx_usdc: \usdc   
    bsc_vlx: \bnb 
    #usdc: <[ vlx_usdc ]>  
}    
required-fields = <[ type token enabled ]>
not-in = (arr, arr2)->
    arr |> any -> arr2.index-of(it) is -1
verify-plugin = (plugin, cb)->
    return cb "Expected Object" if typeof! plugin isnt \Object
    return cb "Required fields: #{required-fields.join(', ')}" if required-fields `not-in` Object.keys(plugin)
    cb null
get-registry = (cb)->
    registry-string = local-storage.get-item(\plugin-registry) ? "[]"
    json-parse registry-string, cb
get-plugin = (name, cb)->
    coin-name = name.substr("plugin-".length)
    if current-configs[coin-name]?   
        item = JSON.stringify current-configs[coin-name]
    else
        /* try to search in local storage for custom token */    
        item = local-storage.get-item(name)    
        if not item? or (item ? "").trim!.length is 0   
            console.error "[get-plugin] plugin #{name} not found"  
            return cb null
    return cb null if typeof! item isnt \String
    json-parse item, cb
get-plugin-one-by-one = ([item, ...rest], cb)->
    return cb null, [] if not item?
    err, plugin <- get-plugin item
    console.error "[get-plugin-one-by-one] error:" err if err?   
    return cb err if err?
    err, other <- get-plugin-one-by-one rest
    return cb err if err?
    all = if plugin? then (other ++ [plugin] ) else other
    cb null, all
export get-install-list = (cb)->
    err, data <- get-registry
    return cb err if err?
    err, res <- get-plugin-one-by-one data
    return cb err if err?
    cb null, res
save-registry = (registry)->
    resulted-string = JSON.stringify registry
    local-storage.set-item \plugin-registry, resulted-string
add-to-registry = (name, cb)->
    err, registry <- get-registry
    return cb err if err?
    return cb "#{name} already installed" if registry.index-of(name) > -1
    registry.push name
    save-registry registry
    cb null
remove-from-registry = (name, cb)->
    err, registry <- get-registry
    return cb err if err?
    index = registry.index-of(name)
    return cb null if index is -1
    registry.splice index, 1
    save-registry registry
    cb null
build-name = (token)-> "plugin-#{token}"
install-plugins = (plugin, cb)->
    result-plugins = 
        | plugin-pairs[plugin.token]? and typeof! plugin-pairs[plugin.token] is \Array =>
            rest = 
                current-configs
                    |> obj-to-pairs 
                    |> filter (it)->
                        it?1?token in plugin-pairs[plugin.token] 
                    |> map (-> it?1)                            
            [plugin] ++ rest      
        | plugin-pairs[plugin.token]? => [plugin, current-configs[plugin-pairs[plugin.token]]]
        | _ => [plugin]
    err <- install-all-plugins result-plugins
    return cb err if err?
    cb null 
install-all-plugins = ([plugin, ...rest], cb)->
    return cb null if not plugin?
    err <- install-plugin(plugin)
    return cb err if err?
    err <- install-all-plugins(rest)
    return cb err if err?
    cb null   
export install-plugin = (plugin, cb)->
    err <- verify-plugin plugin
    return cb err if err?
    plugin.can-uninstall = yes
    name = build-name plugin.token
    body = JSON.stringify plugin
    local-storage.set-item name, body
    err <- add-to-registry name
    console.error err if err?
    cb null
uninstall-plugin = (cweb3, token, cb)->
    return cb "expected string argument" if typeof! token isnt \String
    name = build-name token
    err <- remove-from-registry name
    return cb err if err?
    local-storage.set-item name, ""
    store.forceReload = yes
    <- cweb3.refresh
    store.forceReload = no
    cb null
ask-user = (cweb3, store, plugin, cb)->
    err, registry <- get-registry
    return cb err if err?
    return cb "pluing is required" if typeof! plugin isnt \Object
    return cb "callback is required" if typeof! cb isnt \Function
    return install store, plugin, cb if registry.index-of(plugin.token) is -1
    replace store, plugin, cb
export build-install = (cweb3, store)-> (plugin, cb)->
    return cb "Please unlock the wallet" if store.current.page is \locked
    err <- verify-plugin plugin
    return cb err if err?
    err <- ask-user cweb3, store, plugin
    return cb err if err?
    err <- install-plugins plugin
    return cb err if err?
    cweb3.refresh cb
export build-quick-install = (cweb3, store)-> (plugin, cb)->
    store.forceReload = yes
    store.forceReloadTxs = yes
    return cb "Please unlock the wallet" if store.current.page is \locked
    err <- verify-plugin plugin
    return cb err if err?
    err <- install-plugins plugin
    return cb err if err?
    cweb3.refresh cb
export build-uninstall = (cweb3, store)-> (name, cb)->
    uninstall-plugin cweb3, name, cb
export build-install-by-name = (cweb3, store)-> (name, cb)->
    err, resp <- get "https://raw.githubusercontent.com/web3space/plugin-registry/master/plugins/#{name}.json" .end
    return cb err if err?
    err, plugin <- json-parse resp.text
    return cb err if err?
    return cb "type is required" if not plugin.type?
    return cb "enabled is true" if plugin.enabled isnt yes
    err <- install-plugin plugin
    return cb err if err?
    cweb3.refresh cb