require! {
    \./api.ls : { get-market-history-prices }
    \./math.ls : { times, plus }
    \prelude-ls : { find, map, pairs-to-obj, foldl, filter }
    \./workflow.ls : { run, task }
    \./round5.ls
    \./round-human.ls
    #\./pending-tx.ls : { get-pending-amount }
}
get-market-coins-history = (store, cb)->
    return cb "Store is required" if not store?
    { wallets } = store.current.account
    build-loader = (wallet)-> task (cb)->
        { token } = wallet.coin
        token = wallet.coin.token.to-lower-case!
        err, history-prices <- get-market-history-prices { wallet.network, wallet.coin }
        console.error "#{token} get-market-history-prices error:" err if err?
        wallet.market-history-prices = history-prices if history-prices?data?points?
        cb!
    loaders =
        wallets |> map build-loader
    tasks =
        loaders
            |> map -> [loaders.index-of(it).to-string!, it]
            |> pairs-to-obj
    <- run [tasks] .then
    cb null
module.exports = get-market-coins-history