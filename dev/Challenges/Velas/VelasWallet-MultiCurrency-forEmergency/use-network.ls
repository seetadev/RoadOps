module.exports = (web3, store, network, cb)->
    return cb "Accept only mainnet and testnet" if network not in <[ mainnet testnet ]>
    return cb "Already on that network" if network is store.current.network
    store.current.network = network
    store.forceReload = yes
    store.forceReloadTxs = yes
    err <- web3.refresh
    store.forceReload = no
    store.forceReloadTxs = no
    return cb err if err?
    cb null