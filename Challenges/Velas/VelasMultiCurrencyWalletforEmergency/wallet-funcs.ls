require! {
    \./web3.ls
    \./round5.ls
    \./get-primary-info.ls
    \./navigate.ls
    \./apply-transactions.ls
    \prelude-ls : { find }
    \./math.ls : { times }
    \mobx : { transaction }
    \./icons.ls
}
module.exports = (store, web3t, wallets, wallet, wallets-groups, group-name)->
    return null if not store? or not web3t? or not wallets? or not wallet?coin?token?
    index = wallets.index-of wallet
    group-index =
        | wallets-groups? => wallets-groups.index-of group-name
        | _ => 0
    #type = 
    #    | index is 0 => \top
    #    | index + 1 is wallets.length => \bottom
    #    | _ => \middle
    return null if not store? or not wallet?
    get-plugin = (token, cb)->
        load-coins = require("../web3t/load-coins.js")
        err, $web3t-tokens <- load-coins {plugins:[]}
        console.error err if err?
        return cb null if not $web3t-tokens?
        found = $web3t-tokens[token]
        return cb null, found
    add-fee-payer-coin = (cb)->
        { coin, network } = wallet
        { txFeeIn } = network
        return cb null if not txFeeIn?
        found = store.current.account.wallets |> find (-> it.coin.token is txFeeIn)
        return cb null if found?
        err, fee-payer-plugin <- get-plugin(txFeeIn)
        console.error "[add-fee-payer-coin] error: ", "Plugin #{txFeeIn} is not found" if not fee-payer-plugin?
        return cb null if not fee-payer-plugin?
        err <- web3t.install-quick fee-payer-plugin
        return cb err if err?
        console.log "Fee payer plugin was installed succesfully"
        cb null
    send = (wallet, event)-->
        #event.stop-propagation!
        return alert "Not yet loaded" if not wallet?
        return alert "Not yet loaded" if not web3t[wallet.coin.token]?
        wallet-is-disabled = isNaN(wallet.balance)
        is-loading = store.current.refreshing is yes
        return if wallet-is-disabled or is-loading
        err <- add-fee-payer-coin! 
        { send-transaction } = web3t[wallet.coin.token]
        to = ""
        value = 0
        err <- send-transaction { to, value }
        #console.log err if err?
    receive = (wallet, event)-->
        #console.log { event }
        event.stop-propagation!
        store.current.send-menu-open = no
        #{ coin, network, wallet } = store.current.send
        network = wallet.coin[store.current.network]
        store.current.invoice <<<< { wallet.coin, wallet, network }
        navigate store, web3t, \invoice
    swap = (store, wallet, event)-->
        wallet-is-disabled = isNaN(wallet.balance)
        is-loading = store.current.refreshing is yes
        return if wallet-is-disabled or is-loading
        cb = console.log
        store.current.send.contract-address = null
        store.current.send.is-swap = yes
        return alert "Not yet loaded" if not wallet?
        return alert "Not yet loaded" if not web3t[wallet.coin.token]?
        err <- add-fee-payer-coin! 
        { send-transaction } = web3t[wallet.coin.token]
        config = { to: "", value: 0, swap: yes }
        err <- send-transaction config  
        store.current.send.error = err if err?
        return cb err if err?
    usd-rate = wallet?usd-rate ? ".."
    uninstall = (e)->
        store.loading-wallet = yes
        e.stop-propagation!
        wallet-index =
            store.current.account.wallets.index-of(wallet) 
        group-index = store.current.group-index
        if wallet-index is -1 or group-index is -1
            store.loading-wallet = no
            return 
        store.current.account.wallets.splice wallet-index, 1
        err <- web3t.uninstall wallet.coin.token
        #<- web3t.refresh
        store.loading-wallet = no
        store.current.wallet-index = 0
        store.current.group-index = 0
    expand = (e)->
        e.stop-propagation!
        # return send(wallet, {}) if store.current.wallet-index is index and group-index is store.current.group-index
        store.current.wallet-index = index
        store.current.group-index = group-index
        store.current.filter = { token: wallet.coin.token}
        apply-transactions store
    active = if index is store.current.wallet-index and group-index is store.current.group-index then \active else ''
    big = 
        | index is store.current.wallet-index and group-index is store.current.group-index=> \big
        | _ => ""
    status = wallet.status

    balance = round5(wallet.balance) + ' ' + wallet.coin.token.to-upper-case!
    balance-usd = wallet.balance `times` usd-rate
    pending = round5(wallet.pending-sent) + ' ' + wallet.coin.token.to-upper-case!
    wallet-icon = 
        | wallet.coin?custom is yes and icons.customWalletIcon? => icons.customWalletIcon
        | _ => wallet.coin.image 
    style = get-primary-info store
    button-style=
        color: style.app.text
        background: "#{style.app.background}36"
        border: "1px solid #{style.app.border}"
    last = 
        | wallets.length < 4 and index + 1 is wallets.length => \last
        | _ => ""
    { wallet-icon, button-style, wallet, active, status, big, balance, balance-usd, pending, send, swap, expand, usd-rate, last, receive, uninstall }