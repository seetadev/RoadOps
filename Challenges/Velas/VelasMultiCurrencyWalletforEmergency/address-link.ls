require! {
    \prelude-ls : { map, filter, obj-to-pairs }
    \./velas/addresses.ls
    \./contracts.ls    
}
get-address-label = (wallet)->
    | wallet.coin.token in <[ xem eos ]> => \account
    | _ => \address
get-address = (wallet, address-suffix)->
    wallet["address#{address-suffix}"]
export get-address-link = (wallet, address-suffix)->
    address = get-address(wallet, address-suffix)
    network = global.store?.current?.network || \mainnet
    res=
        | not wallet.network? => \about:blank
        | wallet.coin.token is \btc => "https://bitpay.com/insight/#/BTC/#{network}/address/#{address}"
        | wallet.coin.token is \vlx_native =>
            $cluster = if wallet?network?api?cluster? then "?cluster=#{wallet.network.api.cluster}" else ""   
            "#{wallet?network?api?url}/#{get-address-label(wallet)}/#{address}#{$cluster}"   
        | typeof! address is \String => "#{wallet?network?api?url}/#{get-address-label(wallet)}/#{address}"
        | typeof! address is \Null and wallet.public-key? =>  wallet.network.register-account-link.replace(':public-key', wallet.public-key)
        | _ => "#"
    res
export get-address-title = (wallet, address-suffix)->
    address = get-address(wallet, address-suffix)
    res =
        | typeof! address is \String => address
        | typeof! address is \Null => "..."
        | _ => "n/a"
    res
export get-address-display = (store, wallet, address-suffix) ->
    address = get-address(wallet, address-suffix)
    return "" if not address?    
    address    