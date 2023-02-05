require! {
    \./calc-wallet.ls
    \./transactions.ls : { load-all-transactions }
    \./load-rates.ls
    \./workflow.ls : { run, task }
}
refresh-txs = (web3, store, cb)->
    return cb null if store.forceReload isnt yes and store.forceReloadTxs isnt yes
    store.current.transactions-are-loading = yes
    err <- load-all-transactions store, web3
    store.current.transactions-are-loading = no
    store.forceReloadTxs = no
    return cb null
module.exports = refresh-txs