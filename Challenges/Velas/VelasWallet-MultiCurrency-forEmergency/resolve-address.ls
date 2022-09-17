require! {
    \./web3.ls
    \prelude-ls : { map, split, find, head, filter }
    \./api.ls : { is-valid-address }
}
module.exports = (config, cb)->
    { store, network, coin, address} = config
    return cb "Address not found" if address.trim! is ""
    $token = coin.token
    $network = network
    chosen-network = store.current.send.chosen-network
    if store.current.send.isSwap is yes and chosen-network.referTo?
        $token = chosen-network.referTo
        wallet = store.current.account.wallets |> find (-> it.coin.token is $token)
        return cb "Wallet for token #{chosen-network.name} not found!" if not wallet?
        $network = wallet.network 
    err, isValid <- is-valid-address { network: $network, address, token: $token }
    return cb null, address if isValid
    return cb err if err? if err.index-of("method is not supported") is -1
    is-name = address.index-of(\.) isnt -1 or address.index-of(\@) isnt -1
    return cb null, address if not is-name
    cb "Address is not valid"