require! {
    \react
    \./wallet.ls
    \prelude-ls : { map, take, drop, filter, group-by, keys, obj-to-pairs, find, reverse }
    \./menu.ls
    \../web3.ls
    \../wallets-funcs.ls
    \../wallet-funcs.ls
    \../round-human.ls
    \../round-number.ls
    \../components/button.ls
    \../components/address-holder.ls
    \./manage-account.ls
    \./token-migration.ls
    \./add-coin.ls : add-coin-page
    \../get-lang.ls
    \../get-primary-info.ls
    \./history.ls
    \../icons.ls
    \./icon.ls
    \../math.ls : { div, times, minus }
    \react-chartjs-2 : { Line }
}
.wallet-mobile
    $mobile: 425px
    $tablet: 800px
    button.btn
        min-width: auto
        margin: 0
    .wallet-group
        .group-name
            text-align: left
            padding: 5px 12px
            text-transform: uppercase
            font-size: 13px
            background: var(--bgspare)
            position: -webkit-sticky
            position: sticky
            top: 0
            z-index: 1
    .wallet
        @import scheme
        $cards-height: 324px
        $pad: 20px
        $radius: 15px
        position: relative
        cursor: pointer
        $card-height: 60px
        height: $card-height
        &.disabled-wallet-item
            opacity: 0.24
            cursor: no-drop
        &.last
            height: 60px
        $mt: 20px
        box-sizing: border-box
        overflow: hidden
        transition: height .5s
        border: 0px
        &:first-child
            margin-top: 0
            box-shadow: none
        &:last-child
            margin-bottom: 0px
        .pending
            color: orange
        &.over
            background: #CCC
        &.big
            height: 125px
        &.active
        .wallet-middle
            >.uninstall
                text-align: left
                font-size: 10px
                padding-top: 5px
            box-sizing: border-box
            width: 70%
            height: 85px
            float: left
            padding: 20px
            border-top: 1px solid rgb(107, 38, 142)
            border-right: 1px solid rgb(107, 38, 142)
            &:last-child
                display: block
            &:last-child
                border-right: 0 !important
            .name
                color: #fff
                font-size: 16px
                font-weight: 700
                &.per
                    font-size: 10px
                    color: orange
                    font-weight: 100
                &:last-child
                    font-size: 10px
                    text-transform: uppercase
                    letter-spacing: 2px
                    margin-top: 5px
                    opacity: .8
            .title-balance
                color: #fff
                font-size: 14px
                text-align: left
            span
                padding-left: 10px
            a
                text-align: left
        >.wallet-top
            padding: 0 12px
            box-sizing: border-box
            $card-top-height: 50px
            width: 100%
            color: #677897
            font-size: 14px
            text-align: center
            overflow: hidden
            >*
                display: inline-block
                box-sizing: border-box
                vertical-align: top
                padding-top: 12px
                height: $card-top-height
                line-height: 16px
            >.top-left
                width: 30%
                text-align: left
                overflow: hidden
                text-overflow: ellipsis
                @media screen and (min-width: 801px)
                    padding-top: 5px
                @media screen and (max-width: 800px)
                    width: 15%
                >*
                    display: inline-block
                >.img
                    line-height: $card-top-height
                    vertical-align: top
                    margin-right: 10px
                    width: 40px
                    >img
                        vertical-align: top
                        max-width: 50px
                        $s: 35px
                        border-radius: 0
                        height: $s
                        @media screen and (min-width: 801px)
                            padding-top: 4px
                >.info
                    text-align: left
                    margin-left: 0px
                    text-overflow: ellipsis
                    overflow: hidden
                    width: auto
                    @media screen and (max-width: 390px)
                        display: none
                    >.name
                        padding-left: 3px
                    >.price
                        font-size: 11px
                        font-weight: bold
                        overflow: hidden
                        text-overflow: ellipsis
                        opacity: .5
                        padding: 0
                        letter-spacing: .4px
                        &.token
                            opacity: 1
                            font-size: 12px
            >.top-middle
                width: 30%
                text-align: center
                .label-coin
                    height: 16px
                    top: 3px
                    padding-left: 4px
                    position: relative
                @media screen and (max-width: 800px)
                    width: 50%
                    text-align: left
                >.balance
                    &:last-child
                        font-weight: bold
                        font-size: 13px
                    &.title
                        @media screen and (max-width: 220px)
                            display: none
                    .title-balance
                        display: none
            >.top-right
                width: 40%
                text-align: right
                .wallet-swap img
                    filter: invert(1)
                .icon
                    vertical-align: sub
                    .icon-svg-create
                        height: 9px
                        transform: rotate(-90deg)
                        vertical-align: inherit
                        opacity: .3
                @media screen and (max-width: 800px)
                    width: 35%
                    display: flex
                    float: right
                    flex-direction: row-reverse
                >button
                    outline: none
                    margin-bottom: 5px
                    margin-left: 5px
                    cursor: pointer
                    border: 0
                    $round: 36px
                    padding: 0
                    box-sizing: border-box
                    border-radius: $border
                    font-size: 10px
                    width: auto
                    padding: 0 6px
                    height: $round
                    color: #6CA7ED
                    text-transform: uppercase
                    font-weight: bold
                    background: transparent
                    transition: all .5s
                    text-overflow: ellipsis
                    overflow: hidden
                    width: 80px
                    .icon-svg
                        @media screen and (max-width: 800px)
                            padding: 0
                    .icon
                        position: relative
                        height: 16px
                        top: 2px
                    @media screen and (max-width: 800px)
                        width: 40px
                        padding: 0px;
                a
                    button
                        width: 34px
                        @media screen and (max-width: 480px)
                            width: auto
    .your-account
        position: relative
        display: block
        max-width: 450px
        border: 0 !important
        .tor
            right: 0px
            bottom: -27px
            .tor-content
                right: -55px
                &:after, &:before
                    right: 33%
                    top: -10%
        .switch-menu
            right: -1px
            top: 165px
            @media(max-width: 480px)
                right: -2px
    @media(max-width: 800px)
        margin-top: 0px
    .wallets
        @import scheme
        $border: var(--border-btn)
        $real-height: 300px
        $cards-height: 296px
        $pad: 20px
        $radius: 15px
        height: 395px
        box-sizing: border-box
        position: relative
        left: 0
        $cards-pad: 15px
        right: 0
        margin: 0 $cards-pad
        z-index: 2
        @media(max-width: $mobile)
            margin: 0
            height: calc(100vh - 100px)
        >*
            width: 100%
        >.arrow
            position: absolute
            text-align: center
            cursor: pointer
            &.arrow-t
                top: 0
                margin-top: 10px
            &.arrow-d
                bottom: 0
                margin-bottom: 10px
                transform: rotate(180deg)
            &:not(.true)
                >.arrow-d
                    visibility: hidden
            >.arrow-container
                display: inline-block
                width: 100%
                max-width: 450px
                position: relative
        padding-top: 20px
        >.wallet-container
            overflow: hidden
            overflow-y: auto
            border-radius: 0 0 $border $border
            max-height: 268px
            height: 100%
            max-width: 450px
            border-top: 1px solid #213040
            display: inline-block
            @media(max-width: $mobile)
                max-height: 100vh
                height: auto
                margin-bottom: 0px
            .wallet
                margin-bottom: 15px
                box-shadow: 0px 11px 20px #0808087d
                background: var(--bg-secondary)
                &:last-child
                    margin-bottom: -1px
                &.big
                    background: var(--bg-secondary)
            @media(max-width: $mobile)
                border-width: 1px 0 0 0 !important
        .switch-account
            float: right
            line-height: 2
            right: 20px
            position: relative
            display: inline-flex
            .ckeck
                color: #3cd5af
            .cancel
                color: #c25b5f
            .name
                text-overflow: ellipsis
                white-space: nowrap
                overflow: hidden
                width: 90px
                text-align: right
                cursor: default
            input
                outline: none
                width: 100px
                margin-top: -6px
                height: 36px
                line-height: 36px
                border-radius: 0px
                padding: 0px 10px
                font-size: 12px
                opacity: 1
            span
                cursor: pointer
            .icon
                vertical-align: middle
                margin-left: 20px
                transition: transform .5s
                &.rotate
                    transform: rotate(180deg)
                    transition: transform .5s
        .h1
            font-size: 12px
            text-transform: uppercase
            letter-spacing: 2px
            opacity: .8
        .icon-svg1
            position: relative
            height: 16px
            top: 2px
        .icon-svg2
            position: relative
            height: 10px
        .header
            max-width: 450px
            margin: 0 auto
            border-left: 1px solid var(--border)
            border-right: 1px solid var(--border)
            @media(max-width: $mobile)
                border: 0
    .wallet
        .title
            color: white
            text-transform: uppercase
            font-size: 11px
            font-weight: 500
            white-space: nowrap
            text-overflow: ellipsis
            overflow: hidden
        .wallet-middle
            width: 100%
            padding: 10px 0px
            box-sizing: border-box
            color: #A8BACB
            font-size: 14px
            margin-top: 5px
            text-align: center
            position: relative
            display: inline-block
            height: auto
            border: 0 !important
            .address-holder
                .browse
                    display: none
                .copy
                    padding: 10px
                    margin: 0
                div
                    a
                        padding: 0 10px 0 30px
            .buttons
                margin-top: 10px
                display: flex
                button
                    margin-right: 7px
                    padding: 0 15px
                    border-radius: 0 !important
                    &.button-swap
                        background: #621bbf
                        color: #71f4b4
                        img
                            filter: invert(99%) sepia(33%) saturate(5822%) hue-rotate(64deg) brightness(87%) contrast(153%)
cb = console~log
wallet-group = (store, web3t, wallets, wallets-groups, wallets-group)-->
    lang = get-lang store
    style = get-primary-info store
    label-uninstall =
        | store.current.refreshing => \...
        | _ => "#{lang.hide}"
    wallet-style=
        color: style.app.text
    border-style =
        border-bottom: "1px solid #{style.app.border}"
    border =
        border-top: "1px solid #{style.app.border}"
        border-right: "1px solid #{style.app.border}"
    button-primary3-style=
        border: "0"
        color: style.app.text2
        background: style.app.primary3
        background-color: style.app.primary3-spare
    flex-style =
        display: "flex"
    address-input=
        color: style.app.color3
        background: style.app.bg-primary-light
    btn-icon =
        filter: style.app.btn-icon
    icon-color=
        filter: style.app.icon-filter
    placeholder =
        | store.current.refreshing => "placeholder"
        | _ => ""
    placeholder-coin =
        | store.current.refreshing => "placeholder-coin"
        | _ => ""
    is-loading = store.current.refreshing is yes
    group-name =
        | wallets-group?0? => wallets-group.0
        | _ => ''
    wallets = wallets-group.1
    .wallet-group.pug
        .pug.group-name #{group-name} Network
        wallets |> map (wallet)->
            { button-style, uninstall, wallet, active, big, balance, balance-usd, pending, send, receive, swap, expand, usd-rate, last } = wallet-funcs store, web3t, wallets, wallet, wallets-groups, group-name
            name = wallet.coin.name ? wallet.coin.token
            receive-click = receive(wallet)
            send-click = send(wallet)
            swap-click = swap(store, wallet)
            token = wallet.coin.token
            token-display = (wallet.coin.nickname ? "").to-upper-case!
            makeDisabled = store.current.refreshing
            wallet-is-disabled  = isNaN(wallet.balance)
            disabled-class = if not is-loading and wallet-is-disabled then "disabled-wallet-item" else ""
            wallet-is-disabled = isNaN(wallet.balance)
            send-swap-disabled = wallet-is-disabled or is-loading
            marketHistoryPrices =
                | wallet.marketHistoryPrices? => wallet.marketHistoryPrices?data?points ? {}
                | _ => {}
            historyPrices =
                marketHistoryPrices
                    |> obj-to-pairs
                    |> map (it)-> {ts: it.0, ...it.1}
                    |> reverse
                    |> take 10
            last = historyPrices[0]
            prev = historyPrices[1]
            last-price = last?v?0
            prev-price = prev?v?0
            /* Line color */
            borderColor =
                | last-price < prev-price => 'rgba(255, 0, 80, 0.9)'
                | _ => 'rgb(108, 253, 73)'
            percent =
                | not prev-price? or not last-price? => ""
                | _ => ((last-price `minus` prev-price ) `times` 100) `div` prev-price
            percent-rounded = round-number(percent, { decimals: 4})
            percent-display =
                | percent > 0 => "+" + percent-rounded
                | _ => percent-rounded
            percent-display += "%" if percent isnt ""
            percent-class =
                | percent < 0 => "negative"
                | _ => "positive"
            /* get gradient */
            getGradient = (ctx, chartArea)->
                chartWidth = chartArea.right - chartArea.left
                chartHeight = chartArea.bottom - chartArea.top
                if (gradient === null || width !== chartWidth || height !== chartHeight)
                    #Create the gradient because this is either the first render
                    #or the size of the chart has changed
                    width = chartWidth
                    height = chartHeight
                    gradient = ctx.createLinearGradient(chartArea.left, 0, chartArea.right, 0 )
                    if last-price < prev-price then
                        gradient.addColorStop(0, "rgba(255, 0, 80, 0.01)")
                        gradient.addColorStop(0.7, "rgba(255, 0, 80, 0.1)")
                        gradient.addColorStop(1, "rgba(255, 0, 80, 0.3)")
                    else
                        gradient.addColorStop(0, "rgba(119, 255, 0, 0.01)")
                        gradient.addColorStop(0.7, "rgba(30, 255, 6, 0.11)")
                        gradient.addColorStop(1, "rgba(4, 255, 14, 0.14)")
                gradient
            /* History Prices Linear Graph */
            build-data = (items)->
                data = items
                    |> reverse
                    |> map (it)->
                        it?v?0
                datasets: [{
                    data
                    backgroundColor: (context)->
                        chart = context.chart
                        {ctx, chartArea} = chart
                        if (!chartArea)
                            #This case happens on initial chart load
                            return null;
                        return getGradient(ctx, chartArea)
                    borderColor
                    borderWidth: 1
                    lineTension: 0.3
                    grid:
                        borderColor
                    label:
                        display: no
                    pointRadius: 0
                }]
                labels: data
            data = build-data historyPrices
            fn-cb = (tooltipItem)->
                tooltipItem.yLabel
            options = {
                legend: {
                    display: no
                }
                tooltips: {
                    callbacks: {
                        label: fn-cb
                    }
                }
                scales: {
                    xAxes: [
                        display: no
                        gridLines: {
                            color: "red"
                            display: no
                        }
                    ]
                    yAxes: [
                        display: no
                        gridLines: {
                            color: 'red'
                            display: no
                        }
                    ]
                }
            }
            legend =
                display: false
            installed-networks = store.coins |> map (.token)
            available-networks =
                (wallet.network.networks ? [])
                    |> obj-to-pairs
                    |> map (-> it.1 )
                    |> filter (-> it.disabled isnt yes and it.referTo in installed-networks)
            locationWallet = if window.location.host is "wallet.testnet.velas.com" then 'wallet_testnet' else 'wallet_mainnet'
            uri-prod = "https://buy.velas.com/?address=#{wallet.address}&crypto_currency=#{tokenDisplay}&env=#{locationWallet}"
            uri-test = "https://fiat-payments.testnet.velas.com/?address=#{wallet.address}&crypto_currency=#{tokenDisplay}&env=#{locationWallet}"
            uri_buy =
                | store.current.network is \testnet => uri-test
                | _ => uri-prod
            buy = ->
                window.open(uri_buy)
            /* Render */
            .wallet.wallet-mobile.pug.wallet-item(class="#{big} #{disabled-class}" key="#{token}" style=border-style)
                .wallet-top.pug(on-click=expand)
                    .top-left.pug(style=wallet-style)
                        .img.pug(class="#{placeholder-coin}")
                            img.pug(src="#{wallet.coin.image}")
                        .info.pug
                            .balance.pug.title(class="#{placeholder}") #{name}
                            if store.current.device is \desktop
                                .price.token.pug(class="#{placeholder}" title="#{wallet.balance}")
                                    span.pug #{ round-human wallet.balance }
                                    span.pug #{ token-display }
                            .price.pug(class="#{placeholder}" title="#{balance-usd}")
                                span.pug #{ round-human balance-usd}
                                span.pug USD
                    if store.current.device is \mobile
                        .top-middle.pug(style=wallet-style)
                            if +wallet.pending-sent is 0
                                .balance.pug.title(class="#{placeholder}") #{name}
                            .balance.pug(class="#{placeholder}")
                                span.pug(title="#{wallet.balance}") #{ round-human wallet.balance }
                                    img.label-coin.pug(class="#{placeholder-coin}" src="#{wallet.coin.image}")
                                    span.pug #{ token-display }
                                if +wallet.pending-sent >0
                                    .pug.pending
                                        span.pug -#{ pending }
                    .top-right.pug
                        if no and store.current.device is \desktop
                            span.pug.icon(on-click=expand)
                                img.icon-svg-create.pug(src="#{icons.arrow-down}" style=icon-color)
                                    .pug expand
                        button { store, on-click=send-click, text: \send , icon: \send , type: \secondary, makeDisabled=send-swap-disabled }
                        button { store, on-click=receive-click, text: \receive , icon: \get, type : \primary }
                        if wallet?coin?token is "vlx_usdv"
                            button { store, on-click=buy, icon: \buy  , id: "wallet-buy", classes="wallet-swap" }
                        if (available-networks.length > 0) then
                            button { store, on-click=swap-click, text: \swap , icon: \swap, id: "wallet-swap", makeDisabled=send-swap-disabled, classes="wallet-swap" }
                        if wallet?coin?token is "vlx_native"
                            button { store, on-click=buy, text: \buy , icon: \buy  , id: "wallet-buy", classes="wallet-swap" }
                        if wallet?coin?token is "vlx_evm"
                            button { store, on-click=buy, text: \buy , icon: \buy  , id: "wallet-buy", classes="wallet-swap" }
                    .wallet-middle.pug(style=border)
                        address-holder { store, wallet, type: \bg }
                        if token not in <[ btc vlx vlx_native vlx2 eth vlx_evm ]>
                            .pug.uninstall(on-click=uninstall style=wallet-style) #{label-uninstall}
mobile = ({ store, web3t })->
    return null if not store.current.account?
    { wallets, go-up, can-up, go-down, can-down } = wallets-funcs store, web3t
    style = get-primary-info store
    lang = get-lang store
    border-style-w =
        border: "1px solid #{style.app.border}"
        background: "#{style.app.input}99"
    border-style =
        border-top: "1px solid #{style.app.border}"
    row =
        display: "flex"
        height: "100vh"
        margin-left: "60px"
    left-side =
        width: "45%"
    right-side =
        width: "55%"
        border-left: "1px solid #{style.app.border}"
    header-style =
        border-top: "1px solid #{style.app.border}"
        padding: "17px 0px 20px"
        color: style.app.text
        text-align: "left"
    input=
        background: style.app.wallet
        border: "1px solid #{style.app.border}"
        color: style.app.text
    header-left =
        margin-left: "10px"
    border-right=
        border-right: "1px solid #{style.app.border}"
    open-account = ->
        store.current.switch-account = not store.current.switch-account
    edit-account-name = ->
        store.current.edit-account-name = current-account-name!
    default-account-name = -> "Account #{store.current.account-index}"
    edit-account = (e)->
        #console.log e
        store.current.edit-account-name = e.target.value
    done-edit = ->
        local-storage.set-item default-account-name!, store.current.edit-account-name
        cancel-edit-account-name!
    cancel-edit-account-name = ->
        store.current.edit-account-name = ""
    current-account-name = ->
        local-storage.get-item(default-account-name!) ? default-account-name!
    account-name = current-account-name!
    rotate-class =
        if store.current.switch-account then \rotate else \ ""
    wallets-groups =
        wallets
            |> filter ({coin, network}) -> ((coin.name + coin.token).to-lower-case!.index-of store.current.search.to-lower-case!) != -1 and (network.disabled isnt yes)
            |> group-by (.network.group)
    groups = wallets-groups |> keys
    group-index = store.current.group-index
    groups-wallets =
        wallets-groups
            |> obj-to-pairs
            |> map (.1)
    group-wallets = groups-wallets[group-index]
    #return null if not group-wallets?
    wallet-detail = (group-wallets ? []) |> find (-> group-wallets.index-of(it) is store.current.wallet-index)
    #return null if not wallet-detail?
    view-account-template = ->
        .pug.switch-account.h1
            span.name.pug(on-click=open-account) #{account-name}
            span.pug.icon(on-click=edit-account-name)
                img.icon-svg1.pug(src="#{icons.create}")
            span.pug.icon(on-click=open-account class="#{rotate-class}")
                img.icon-svg2.pug(src="#{icons.arrow-down}")
    edit-account-template = ->
        .pug.switch-account.h1
            input.h1.pug(value="#{store.current.edit-account-name}" on-change=edit-account style=input)
            span.ckeck.pug.icon(on-click=done-edit)
                icon "Check", 20
            span.cancel.pug.icon(on-click=cancel-edit-account-name)
                icon "X", 20
    chosen-account-template =
        if store.current.edit-account-name is "" then view-account-template! else edit-account-template!
    .pug.wallet-mobile(key="wallets")
        menu { store, web3t }
        manage-account { store, web3t }
        token-migration { store, web3t }
        add-coin-page { store, web3t }
        .wallets.pug(key="wallets-body")
            .header.pug(style=header-style)
                span.pug.head.left.h1.hidden(style=header-left) #{lang.your-wallets}
                chosen-account-template
            .wallet-container.pug(key="wallets-viewport" style=border-style-w)
                wallets
                    |> group-by (.network.group)
                    |> obj-to-pairs
                    |> map wallet-group store, web3t, wallets, groups
module.exports = mobile