require! {
    \./calc-wallet.ls
    \./get-market-coins-history.ls
    \./load-rates.ls
    \./workflow.ls : { run, task }
    \./math.ls : { div, times }
    \prelude-ls : { find }
    "./../web3t/providers/solana/index.cjs" : \velasWeb3
    \./api.ls : { get-balance }
}

nativeSubscriptions = {}
subscribe-to-velas-account = (store, web3t)->
    wallet-native = store.current.account.wallets |> find (-> it.coin.token is \vlx_native)
    wallet-evm = store.current.account.wallets |> find (-> it.coin.token is \vlx_evm)
    save-key = "#{store.current.network}_#{wallet-native.publicKey}"
    currentNetwork = store.current.network
    return if nativeSubscriptions["#{save-key}"]?
    { rates } = store

    try
        publicKey = new velasWeb3.PublicKey(wallet-native.publicKey)
        callback = (updatedAccount)->
            lamports = updatedAccount.lamportsStr || updatedAccount.lamports
            return if not lamports?
            currentNetwork2 = store.current.network
            wallet-native2 = store.current.account.wallets |> find (-> it.coin.token is \vlx_native)
            #
            #check if it is right wallet
            return if wallet-native.address isnt wallet-native2.address or currentNetwork isnt currentNetwork2
            #
            wallet-native2.balance = lamports `div` (10^9)
            usd-rate = rates[wallet-native2.coin.token]
            if usd-rate then
                wallet-native2.balance-usd = wallet-native2.balance `times` usd-rate
            #
            err, balance <- get-balance { wallet-evm.address, wallet-evm.network, token: 'vlx_evm', account: { wallet-evm.address, wallet-evm.private-key } }
            if balance? and !isNaN(balance)
                wallet-evm2 = store.current.account.wallets |> find (-> it.coin.token is \vlx_evm)
                wallet-evm2.balance = balance
                usd-rate = rates[wallet-evm2.coin.token]
                if usd-rate then
                    wallet-evm2.balance-usd = wallet-evm2.balance `times` usd-rate
        commitment = 'finalized'
        id = web3t.velas.NativeStaking.connection.onAccountChange(publicKey, callback, commitment)
        nativeSubscriptions["#{save-key}"] = id if id?
    catch err
        console.log "ws onAccountChange err: " err

refresh-wallet = (web3, store, cb)->
    return cb null if store.forceReload isnt yes
    store.current.refreshing = yes 
    task1 = task (cb)->
        load-rates store, cb
    task3 = task (cb)->
        calc-wallet store, cb 
    task4 = task (cb)->
        get-market-coins-history store, cb 
    <- run [ task1, task3 ] .then
    subscribe-to-velas-account(store, web3)
    store.current.refreshing = no
    store.forceReload = no
    cb null
module.exports = refresh-wallet