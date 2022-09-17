require! {
    \./new-account.ls
    \./refresh-wallet.ls
    \mobx : { toJS, transaction }
    \prelude-ls : { map, pairs-to-obj, find, findIndex, take, drop, filter, group-by, sort-by, obj-to-pairs, keys }
    \./mirror.ls
    \./apply-transactions.ls
    \./scam-warning.ls
    \./seed.ls : seedmem
    \./refresh-txs.ls : \refreshWaletTxs
}
export set-account = (web3, store, cb)->
    err, account <- new-account store, seedmem.mnemonic
    return cb err if err?
    store.current.account = account
    mirror.account-addresses =
        account.wallets 
            |> map -> [it.coin.token, it.address] 
            |> pairs-to-obj
    cb null

set-current-wallet = ->
   group-index = store.current.group-index
   wallet-index = store.current.wallet-index
   if store.current.account?
       wallets-groups =
           store.current.account.wallets
               |> filter (?)
               |> filter ({coin, network}) -> ((coin.name + coin.token).to-lower-case!.index-of store.current.search.to-lower-case!) != -1 and (network.disabled isnt yes)
               |> group-by (.network.group)
       groups-wallets =
           wallets-groups
               |> obj-to-pairs
               |> map (.1)
       group-wallets = groups-wallets[group-index] ? []
       current-wallet = group-wallets |> find (-> group-wallets.index-of(it) is wallet-index)
       store.current.wallet = current-wallet if current-wallet?

export refresh-account = (web3, store, cb)-->
    scam-warning!
    return cb null if store.forceReload isnt yes
    err <- set-account web3, store
    return cb err if err?
    set-current-wallet!
    store.current.account.account-name = "Anonymous"
    account-name = store.current.account.account-name
    store.current.nickname = "" if account-name isnt "Anonymous"
    store.current.nicknamefull = account-name if account-name isnt "Anonymous"
    err <- refresh-wallet web3, store
    #store.forceReload = no
    cb null
refresh-txs = (web3, store, cb)-->
    <- refresh-walet-txs web3, store
export background-refresh-account = (web3, store, cb)->
    store.current.refreshing = yes
    bg-store = toJS store
    err <- refresh-account web3, store
    store.current.refreshing = no
    return cb err if err?
    store.forceReload = no
    store.forceReload = no
    transaction ->
        wallet-index = 
            | store.current?filter?token? => 
                store.current.account.wallets |> findIndex (-> it.coin.token is store.current?filter?token)
            | _ => store.current.wallet-index 
        wallet-index = 0 if not wallet-index?
        wallet = store.current.account.wallets[wallet-index]
        return cb null if not wallet?
        store.current.filter.filter-txs-types = <[IN OUT]>
        store.current.filter = {token: wallet.coin.token}
        <- refresh-txs(web3, store)
        apply-transactions store
        cb null
    cb null