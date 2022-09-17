require! {
    \./api.ls : { get-balance }
    \./math.ls : { times, plus }
    \prelude-ls : { find, map, pairs-to-obj, foldl, filter }
    \./workflow.ls : { run, task }
    \./round5.ls
    \./round-human.ls
    #\./pending-tx.ls : { get-pending-amount }
}
calc-wallet = (store, cb)->
    return cb "Store is required" if not store?
    { wallets } = store.current.account
    { rates } = store
    return if calc-wallet.loading is yes
    calc-wallet.loading = yes

    build-loader = (wallet)->
        <- set-timeout _, 1
        wallet.status = 'loading'
        { token } = wallet.coin
        token = wallet.coin.token.to-lower-case!
        usd-rate = 
            | not rates[token]? =>  \..
            | rates[token] is "" => \..
            | _ => rates[token]
        # convert usd-rate to string because bigint does not like number type and can throw exception
        usd-rate = usd-rate + ''
        wallet.usd-rate =
            | usd-rate is \.. => \..
            | _ => usd-rate
        eur-rate = \0.893191
        btc-rate = \0
        wallet.eur-rate =
            | usd-rate is \.. => \..
            | _ => round5 (usd-rate `times` eur-rate)
        wallet.btc-rate =
            | usd-rate is \.. => \..
            | _ => round5 (usd-rate `times` btc-rate)
        try
            err, balance <- get-balance { wallet.address, wallet.network, token, account: { wallet.address, wallet.private-key } }
            console.error "#{token} get-balance error:" err if err?
            pending-sent = 0
            wallet.pending-sent = pending-sent
            wallet.balance =
                | isNaN(balance) => ".."
                | _ => balance
            wallet.balance-usd =
                | isNaN(usd-rate) or isNaN(balance) => ".."
                | _ => balance `times` usd-rate
            balance-usd-current =
                | isNaN(wallet.balance-usd) => 0
                | _ => wallet.balance-usd
            wallet.status =
                | isNaN(balance) => 'error'
                | _ => 'loaded'
            wallet.state =
                | err? => 'error'
                | _ => 'success'
        catch err
            wallet.status = "error"
            wallet.state = 'error'
            cb!
        cb!
    store.current.account.wallets |> map build-loader
    calc-wallet.loading = no
    cb null
module.exports = calc-wallet