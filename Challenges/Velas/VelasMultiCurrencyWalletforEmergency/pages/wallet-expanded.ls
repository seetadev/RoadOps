require! {
    \react
    \../tools.ls : { money }
    \prelude-ls : { each, filter, foldl, map, obj-to-pairs, group-by, keys }
    \../wallet-funcs.ls
    \../get-lang.ls
    \../math.ls : { plus }
    \./icon.ls
    \../get-primary-info.ls
    \../../web3t/providers/superagent.js : { get }
    \../icons.ls
    \../round-human.ls
    \./confirmation.ls : { alert }
    \../components/button.ls
    \../components/address-holder.ls
    \./wallet-stats.ls
    \./loading.ls
    \./confirmation.ls : { confirm }
    \../plugin-loader.ls : { base-array }
}
.wallet-detailed
    @import scheme
    height: 240px
    box-sizing: border-box
    $tablet: 1200px
    >.wallet-part
        display: inline-block
        position: relative
        box-sizing: border-box
        vertical-align: top
        width: 50%
        @media screen and (max-width: $tablet)
            padding: 0
        .with-swap
            display: flex
            button
                flex: 1
                margin: 0 5px 0 !important
                &:first-child
                    margin-left: 0 !important
            .wallet-swap img
                filter: invert(1)
            .wallet-buy img
                filter: invert(1)
        &.left
            text-align: center
        &.left
            text-align: left
            @media screen and (max-width: $tablet)
                width: 60%
            >.buttons
                margin-top: 15px
                width: calc((130px * 2) + 10px)
                .btn
                    margin: 0
                    width: 130px
                    &:last-child
                        margin-left: 10px
                        margin: 0 0 5px !important
            >.details
                display: none
            .uninstall
                position: relative
                text-transform: uppercase
                font-size: 10px
                padding: 1px 5px 1px 2px
                margin-left: 5px
                letter-spacing: 2px
                cursor: pointer
                border-radius: var(--border-btn)
            >.address-holder
                margin-top: 10px
                width: calc((130px * 2) + 10px)
                a
                    padding-left: 10px
                @media screen and (max-width: $tablet)
                    margin-top: 20px
        &.right
            @media screen and (max-width: $tablet)
                width: 40%
        >.wallet-header
            &.chart
                text-align: right
                padding-top: 0px
                border-left: 1px solid rgba(white, 0.2)
                border-color: var(--border-color)
                @media screen and (max-width: $tablet)
                    >.wallet-header-part
                        width: 100%
                        text-align: center
                        &.left
                            display: none
                        >.stats
                            margin: 0 auto
            >.wallet-header-part
                display: inline-block
                box-sizing: border-box
                vertical-align: top
                .stats-style
                    height: 90%
                    width: 90%
                    top: 4%
                    right: 4%
                    content: ''
                    display: block
                    position: absolute
                    border-radius: 100px
                    .coin
                        margin: 20% auto
                        text-align: center
                        .course
                            font-size: 12px
                            opacity: .5
                &.left
                    img
                        width: 40px
                &.right
                    text-align: left
                    padding: 0
                    .title
                        font-size: 10px
                        text-transform: uppercase
                        letter-spacing: 2px
                    .token-balance
                        font-size: 24px
                        font-weight: bold
                    .usd-balance
                        font-size: 14px
                        opacity: .5
                    .pending
                        font-size: 14px
                        color: orange
                .counts
                    margin-bottom: 5px
                    .label
                        font-size: 12px
                    .label-icon
                        width: 25px
                        height: 25px
                        background: #f7618a
                        border-radius: var(--border-btn)
                        text-align: center
                        margin-bottom: 6px
                        .icon-svg
                            filter: invert(105%)
        .stats
            $size: 150px
            $size-tablet: 100px
            margin-right: 20px
            display: inline-block
            height: $size
            max-height: $size
            width: $size
            max-width: $size
            position: relative
            @media screen and (max-width: $tablet)
                height: $size-tablet - 10
                max-height: $size-tablet - 10
                width: $size-tablet - 10
                max-width: $size-tablet - 10
            >*
                height: inherit
                width: inherit
cb = console~log
module.exports = (store, web3t, wallets, wallet)-->
    style = get-primary-info store
    wallet-style=
        color: style.app.text3
    if (not wallets? or not wallet?)
        no-result-text =
            font-size: "25px"
            text-transform: "initial"
            color: "white"
        msg-txt-style =
            font-size: "20px"
            color: "white"
            opacity: 0.3
        return
            .wallet-detailed.pug(key="no-details" style=wallet-style)
                .wallet-part.center.pug(style=text)
                    .wallet-header.pug
                        .pug
                            if store.loading-wallet is yes
                                loading(store.loading-wallet)
                            else
                                h3.text-message.pug(style=msg-txt-style) No wallet found
    { wallet-icon, uninstall, wallet, balance, balance-usd, pending, send, receive, swap, usd-rate } = wallet-funcs store, web3t, wallets, wallet
    lang = get-lang store
    label-uninstall =
        | store.current.refreshing => \...
        | _ => "#{lang.hide}"
    placeholder =
        | store.current.refreshing => "placeholder"
        | _ => ""
    placeholder-coin =
        | store.current.refreshing => "placeholder-coin"
        | _ => ""
    is-custom = wallet?coin?custom is yes
    wallet-is-disabled = isNaN(wallet?balance)
    is-loading = store.current.refreshing is yes
    send-swap-disabled = wallet-is-disabled or is-loading
    name = wallet?coin?name ? wallet?coin?token
    receive-click = receive(wallet)
    send-click = send(wallet)
    swap-click = swap(store, wallet)
    token = (wallet?coin?token ? "").to-upper-case!
    tokenDisplay = (wallet?coin?nickname ? "").to-upper-case!
    locationWallet = if window.location.host is "wallet.testnet.velas.com" then 'wallet_testnet' else 'wallet_mainnet'
    uri-prod = "https://buy.velas.com/?address=#{wallet.address}&crypto_currency=#{token}&env=#{locationWallet}"
    uri-test = "https://fiat-payments.testnet.velas.com/?address=#{wallet.address}&crypto_currency=#{token}&env=#{locationWallet}"
    uri_buy =
        | store.current.network is \testnet => uri-test
        | _ => uri-prod
    buy = ->
        window.open(uri_buy)
    style = get-primary-info store
    color1 =
        color: style.app.text
        opacity: ".5"
    color2 =
        color: style.app.text
        opacity: ".5"
    get-total = (type, address)->
        transactions = ^^store.transactions.applied
        transactions
            |> filter (it)-> it.type is type and (not it.pending? or it.pending isnt yes)
            |> map (it)-> it.amount
            |> foldl plus, \0
            |> round-human
    total-sent = get-total \OUT, wallet.address
    total-received = get-total \IN, wallet.address
    installed-networks = store.coins |> map (.token)
    available-networks =
        (wallet?network?networks ? [])
            |> obj-to-pairs
            |> map (-> it.1 )
            |> filter (-> it.disabled isnt yes and it.referTo in installed-networks)
    uninstall-action = (e)->
        if is-custom isnt yes
            return uninstall(e)
        agree <- confirm store, "You can add this token back in the future by going to “Add custom token”."
        return if not agree
        uninstall(e)
    wallet-style=
        color: style.app.text3
        background: style.app.wallet
        border-bottom: "0"
        border-color: "#{style.app.border-color}"
    uninstall-style=
        background: style.app.menu
    text=
        color: style.app.text
    color-label=
        background: style.app.primary2
        background-color: style.app.primary2-spare
    color-label2=
        background: style.app.primary1
        background-color: style.app.primary1-spare
    .wallet-detailed.pug(key="#{token}" style=wallet-style)
        .wallet-part.left.pug(style=text)
            .wallet-header.pug
                .wallet-header-part.right.pug
                    .pug
                        span.title.pug(class="#{placeholder}") #{name}
                        if wallet?coin?token not in base-array
                            span.pug.uninstall(on-click=uninstall-action style=uninstall-style) #{label-uninstall}
                    .balance.pug(class="#{placeholder}")
                        .pug.token-balance(title="#{wallet?balance}")
                            span.pug #{ round-human wallet?balance }
                            span.pug #{ tokenDisplay }
                        if not is-custom
                            .pug.usd-balance(class="#{placeholder}" title="#{balance-usd}")
                                span.pug #{ round-human balance-usd }
                                span.pug USD
                        if +wallet.pending-sent >0 and no
                            .pug.pending
                                span.pug -#{ pending }
            address-holder { store, wallet, type: \bg }
            if (available-networks.length > 0) then
                .buttons.pug
                    .with-swap.pug
                        button { store, on-click=send-click, text: \send , icon: \send , type: \secondary, id: "wallets-send", makeDisabled=send-swap-disabled }
                        button { store, on-click=receive-click, text: \receive , icon: \get  , type : \primary, id: "wallets-receive", makeDisabled=no }
                    .with-swap.pug
                        if wallet?coin?token is "vlx_native"
                            button { store, on-click=buy, text: \buy , icon: \buy  , id: "wallet-buy", classes="wallet-swap" }
                        if wallet?coin?token is "vlx_evm"
                            button { store, on-click=buy, text: \buy , icon: \buy  , id: "wallet-buy", classes="wallet-swap" }
                        button { store, on-click=swap-click, text: \swap , icon: \swap  , id: "wallet-swap", classes="wallet-swap", makeDisabled=send-swap-disabled  }
            else
                .buttons.pug
                    .with-swap.pug
                        button { store, on-click=send-click, text: \send , icon: \send , type: \secondary, id: "wallets-send", makeDisabled=send-swap-disabled }
                        button { store, on-click=receive-click, text: \receive , icon: \get  , type : \primary, id: "wallets-receive", makeDisabled=no }
                    .with-swap.pug
                        if wallet?coin?token is "vlx_usdv"
                            button { store, on-click=buy, text: \buy , icon: \buy  , id: "wallet-buy", classes="wallet-swap" }
            .details.pug
                .price.pug(class="#{placeholder}" title="#{balance-usd}") $#{ round-human balance-usd }
                .name.pug(class="#{placeholder}" title="#{usd-rate}") $#{ round-human usd-rate}
        .wallet-part.right.pug
            .wallet-header.pug.chart
                .wallet-header-part.left.pug
                    .stats.pug
                        span.stats-style.pug
                            .pug.coin(style=text)
                                img.label-coin.pug(class="#{placeholder-coin}" src="#{wallet-icon}")
                                .pug(class="#{placeholder}") #{ token-display }
                                if not is-custom
                                    .pug.course(class="#{placeholder}" title="#{usd-rate}") $#{ round-human usd-rate}
                        wallet-stats store, web3t
                .wallet-header-part.right.pug(style=text)
                    .pug.counts
                        .pug.label-icon(style=color-label)
                            img.icon-svg.pug(src="#{icons.send}")
                        .pug(class="#{placeholder}") #{ total-sent + ' ' token-display }
                        .pug.label(style=color1) #{lang.totalSent}
                    .pug.counts
                        .pug.label-icon(style=color-label2)
                            img.icon-svg.pug(src="#{icons.get}")
                        .pug(class="#{placeholder}") #{ total-received + ' ' token-display }
                        .pug.label(style=color2) #{lang.totalReceived}