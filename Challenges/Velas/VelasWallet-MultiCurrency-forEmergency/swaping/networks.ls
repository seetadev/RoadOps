require!{
    \prelude-ls : { find}
}
export get-default-recipient-address = (store)->
    chosenNetwork = store.current.send.chosenNetwork
    token = chosenNetwork.referTo
    wallet = store.current.account.wallets |> find (-> it.coin.token is token)
    return "" if not wallet?
    wallet.address