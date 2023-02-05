require! {
    \./velas/addresses.ls
    \prelude-ls : { map, filter, obj-to-pairs, find }
    \./round-human.ls
    \./round-number.ls
    \./math.ls : { times, minus, div, plus }
}
module.exports = (store, web3t)->
    { send } = store.current
    decimalsConfig = send.network.decimals
    is-data = (send.data ? "").length > 0
    network = store.current.network
    contract =
        addresses[network]
            |> obj-to-pairs
            |> filter -> it.1 is send.to
            |> map -> it.0
            |> -> it ? send.to
    wallet = store.current.send.wallet
    walletGroup = wallet.network?group
    swap = store.current.send.swap
    token-display = (wallet.coin.nickname ? send.coin.token).to-upper-case!
    amount-send = round-human send.amount-send, {decimals: decimalsConfig}
    funtype =
        | swap? =>
            receiver-token = store.current.send.chosenNetwork.referTo
            wallet-receiver = store.current.account.wallets |> find (-> it.coin.token is receiver-token)
            receiverGroup =
                | receiver-token is \vlx_native => "Velas Native"
                | (wallet-receiver?network?group ? "").to-lower-case! is \velas => "Velas EVM" 
                | _ => wallet-receiver?network?group
            homeFeePercent = store.current.send.homeFeePercent
            homeFee =
                | store.current.send.feeMode is "fixed" => store.current.send.homeFeePercent
                | _ => store.current.send.amount-send `times` store.current.send.homeFeePercent
            amount-receive = round-human (send.amount-send `minus` homeFee), {decimals: decimalsConfig}
            "Please confirm that you would like to send #{amount-send} #{token-display} from #{walletGroup} to receive #{amount-receive} #{token-display} on #{receiverGroup}."
        |  +send.amount-send > 0 => 
            "Send #{amount-send} #{token-display} to #{contract} contract." 
        | _ =>  
            "Execute the #{contract} contract."
    text-parts-contract =
        * funtype
        * "You are allowed to spend your resources on execution #{round-number send.amount-send-fee, {decimals: decimalsConfig}} #{token-display}."
    text-parts-regular =
        * "Send #{amount-send} #{token-display} to #{send.to}"
        * "You are allowed to spend your resources on execution #{round-number send.amount-send-fee, {decimals: decimalsConfig}} #{token-display}."
    text-parts-swap =
        * "Swap #{amount-send} #{token-display} to #{send.to}"
        * "You are allowed to spend your resources on execution #{round-number send.amount-send-fee, {decimals: decimalsConfig}} #{token-display}."
    text =
        | is-data => text-parts-contract
        | swap is yes => text-parts-swap 
        | _ => text-parts-regular
    text