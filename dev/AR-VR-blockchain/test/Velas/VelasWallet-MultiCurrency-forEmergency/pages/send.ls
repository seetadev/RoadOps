require! {
    \react
    \../send-funcs.ls
    \prelude-ls : { map, find, keys, filter, pairs-to-obj, obj-to-pairs }
    \../calc-amount.js : { calc-fee-before-send }
    \../get-primary-info.ls
    \./icon.ls
    \../get-lang.ls
    \./switch-account.ls
    \../icons.ls
    \../round-human.ls
    \../round-number.ls
    \../wallets-funcs.ls
    \./epoch.ls
    \../components/button.ls
    \../components/address-holder.ls
    \../components/identicon.ls
    \../components/trx-fee.ls
    \../components/trx-custom-gas-price.ls
    \./send-contract.ls
    \../history-funcs.ls
    \../components/burger.ls
    \../components/amount-field.ls
    \../components/amount-fiat-field.ls
    \../components/sliders/network-slider.ls
    \../math.ls : { times, div, minus }
    \ethereumjs-util : {BN}
    \../velas/addresses.ls
    \../contracts.ls
    \../swaping/networks.ls : \token-networks
    "../../web3t/contracts/HomeBridgeNativeToErc.json" : \HomeBridgeNativeToErc
    "../../web3t/contracts/ForeignBridgeNativeToErc.json" : \ForeignBridgeNativeToErc
    \../contract-data.ls
    \moment
    \../components/popups/loader.ls
}
.content
    position: relative
    @import scheme
    $border-radius: var(--border-btn)
    $label-padding: 3px
    $label-font: 13px
    width: calc(100% - 0px) !important
    margin-left: 0px !important
    max-width: none !important
    height: 100vh
    display: flex !important
    flex-direction: column
    align-items: center
    @media(min-height:900px)
        justify-content: center
    @media(max-width:800px)
        margin-left: 0 !important
    .icon-svg
        position: relative
        height: 12px
        top: 2px
    .icon-svg-history
        width: auto !important
        height: 20px
    .content-body
        max-width: 450px !important
    >.title
        position: fixed
        position: -webkit-fixed
        background: var(--background)
        box-sizing: border-box
        top: 0
        width: 100%
        color: gray
        font-size: 22px
        padding: 10px
        height: 60px
        z-index: 3
        @media(max-width:800px)
            left: 0
        >.header
            margin: 5px
            text-align: center
            @media(max-width:800px)
                text-align: center
    .h1
        font-size: 17px
        text-transform: uppercase
        letter-spacing: 2px
        opacity: .8
    .pending
        color: orange
    >*
        display: inline-block
        text-align: center
        width: 100%
        box-sizing: border-box
        border-radius: $border-radius
    .swap-notification
        p
            font-size: 12px
            opacity: 0.3
    .more-buttons
        top: 30px
        right: 0
        width: 150px
        box-shadow: 0px 0px 2px black
        border-radius: var(--border-btn)
        text-align: left
        padding-bottom: 3px
        >.more
            display: block
            cursor: pointer
            padding: 5px 0
            &:last-child
                border-bottom: 0px
            .more-icon
                width: 50px
                text-align: center
                display: inline-block
                vertical-align: middle
            .more-text
                width: 80px
                display: inline-block
                vertical-align: middle
    >.content-body
        margin-top: 75px
        @import scheme
        color: gray
        padding: 20px 10px
        @media(max-width:800px)
            margin-top: -5px
        a
            color: #6f6fe2
        >form
            >table
                background: transparent
                border-radius: 0 0 var(--border-btn) var(--border-btn)
                width: 100%
                border-spacing: 0
                tr
                    &.gray
                        color: #CCC
                    &.orange
                        color: #cf952c
                    &.green
                        color: #23b723
                    td
                        padding: 3px 10px
                        font-size: 14px
                        .label-coin
                            left: 3px
                            top: 3px
                            padding: 0 2px 0 2px
                            height: 16px
                            position: relative
                        &:last-child
                            text-align: right
            text-align: left
            margin: auto 10px
            >.form-group
                &.sender, &.receiver
                    input
                        padding: 0 10px 0 45px
                        text-align: left
                &.sender
                    .address-holder .inner-address-holder
                        text-align: left
                        padding-left: 45px
                &.receiver input
                    text-align: left !important
                .identicon
                    ~ span
                        background: var(--input)
                &:nth-child(2), &:nth-child(3)
                    div
                        position: relative
                        img
                            position: absolute
                            right: auto
                            left: 4px
                            top: 3px
                            height: 30px
                            border-radius: var(--border-btn)
                            margin: 0px
                        input
                            text-align: center
                .control-label
                    padding-top: 5px
                    padding-left: $label-padding
                    font-size: $label-font
                &.network
                    div
                        position: relative
                    .button
                        width: 12px
                        height: 16px
                        display: inline-block
                        padding: 9px
                        border-radius: var(--border-btn)
                        cursor: pointer
                        vertical-align: top
                        position: absolute
                        &.left
                            left: 0
                        &.right
                            right: 0
                            top: 3px
                        svg
                            vertical-align: inherit !important
                margin-top: 4px
                .address
                    padding: 0px
                    height: 36px
                    line-height: 36px
                    overflow: hidden
                    text-overflow: ellipsis
                    background: transparent
                    border-radius: $border-radius
                    font-size: 14px
                    overflow: hidden
                    text-overflow: ellipsis
                    color: #677897
                input
                    outline: none
                    width: 100%
                    box-sizing: border-box
                    height: 36px
                    line-height: 36px
                    border-radius: $border-radius
                    padding: 0px 10px
                    font-size: 14px
                    border: 0px
                    box-shadow: none
                .amount-field
                    position: relative
                    >.input-wrapper
                        position: relative
                        width: 65%
                        border-radius: var(--border-btn) 0 0 var(--border-btn)
                        &.choose-currency
                            display: inline-flex
                            width: 45% !important
                        .input-area
                            margin: 0
                        select
                            -webkit-appearance: none
                            -moz-appearance: none
                            padding-right: 30px
                            padding-left: 10px
                            background-position: right 5px top 50%
                            background-repeat: no-repeat
                            display: block
                            width: 30%
                            height: 36px
                            font-size: 14px
                            line-height: 1.5
                            color: #fff
                            background-color: #421f7c
                            background-clip: padding-box
                            border-radius: 0
                            border-color: #6b258e
                            border-left: 0 solid
                            margin-left: -1px
                        &.small
                            width: 35%
                            border-radius: 0 var(--border-btn) var(--border-btn) 0
                        display: inline-block
                        box-sizing: border-box
                        margin: 0
                        >.label
                            position: absolute
                            top: 8px
                            display: inline
                            &.lusd
                                left: 5px
                            &.crypto
                                right: 5px
                                top: 7px
                                height: 22px
                        .label-coin
                            height: 18px
                            top: 3px
                            position: relative
                            padding: 0 0px 0 8px;
                        input
                            width: 100%
                            color: white
                            box-shadow: none
                            outline: none
                            ::placeholder
                                color: #eee
                            &:disabled
                                opacity:.2
                            &.amount
                                border-radius: $border-radius 0 0 $border-radius
                                border-right: 0
                            &.amount-eur
                                background: #f1eeee
                                padding-left: 20px
                                border-radius: 0 $border-radius $border-radius 0
                                border-left: 0
                            &.amount-usd
                                background: #f1eeee
                                border-radius: 0 $border-radius $border-radius 0
                                padding-left: 20px
        .smart-contract
            overflow: hidden
            padding: 2px
            box-sizing: border-box
        >.header
            padding: 10px
            min-height: 40px
            text-align: left
            padding: 0
            margin: 0 10px
            >.head
                box-sizing: border-box
                width: 70%
                line-height: 70px
                font-size: 27px
                font-weight: 600
                vertical-align: middle
                line-height: 29px
                display: inline-block
                color: #677897
                width: 80%
                &.center
                    padding-left: 10px
                    text-align: center
                    overflow: hidden
                    text-overflow: ellipsis
                &.left
                    width: 10%
                    text-align: center
                &.right
                    width: 10%
                    text-align: right
                    cursor: pointer
                    >*
                        vertical-align: middle
            img
                width: 34px
                border-radius: 0px
        .field
            font-size: 12px
            padding-left: 3px
            color: gray
            margin-top: 5px
            &.type
                font-size: 14px
                color: #fff
                text-transform: capitalize
            &.coin
                font-size: 14px
                color: #fff
        .usd
            font-size: 11px
            padding-left: 3px
            color: gray
            margin-top: 5px
            .switch-currency
                float: right
                &.active
                    background: var(--primary3)
                &:last-child
                    margin-right: 2px
            .label-coin
                left: 3px
                top: 3px
                padding: 0 2px 0 2px
                height: 13px
                position: relative
        .balance
            color: #5E72E4
        .send-all
            background: transparent
            outline: none
            border: 0
            border-radius: $border
            font-size: 12px
            line-height: 16px
            text-align: center
            padding: 2px 5px
            cursor: pointer
        .not-enough
            height: 0
            border: none;
            color: red
            font-size: 12px
            font-weight: 400
            overflow: hidden
            border-radius: 4px;
            width: auto;
            min-width: auto;
            display: inline-block;
            line-height: initial;
            margin-top: 7px;
            max-height: initial;
            &.visible
                height: auto
                padding-top: 2.5px !important
                padding-left: 5px !important
                min-height: auto;
                padding: 2.5px 5px;
        .bold
            font-weight: bold
        .button-container
            text-align: center
            .buttons
                margin-top: 20px
                text-align: center
                border-radius: $border
                width: 100%
                display: inline-block
                overflow: hidden
                .btn
                    width: auto
                    min-width: 80px
                    padding: 0 6px
                    line-height: 36px
                    height: 36px
                    text-transform: uppercase
                    text-align: center
                    font-weight: bold
                    border: 0
                    margin: 5px
                    font-size: 10px
                    border-radius: $border
                    display: inline-block
                    cursor: pointer
                    box-sizing: border-box
                    transaction: all .5s
                    &.btn-primary
                        background: #6CA7ED
                        color: white
                    &:hover
                        background: rgba(#6CA7ED, 0.2)
                        opacity: .9
form-group = (classes, title, style, content)->
    .pug.form-group(class="#{classes}")
        label.pug.control-label(style=style) #{title}
        content!
send = ({ store, web3t })->
    { wallet-icon, execute-contract-data, getBridgeInfo, token, name, homeFee, homeFeeUsd, fee-token, bridge-fee-token, network, send, wallet, pending, recipient-change, amount-change, amount-usd-change, amount-eur-change, use-max-amount, show-data, show-label, history, cancel, send-anyway, before-send-anyway, choose-auto, round5edit, round5, is-data, encode-decode, change-amount, invoice } = send-funcs store, web3t
    return send-contract { store, web3t } if send.details is no
    theme = get-primary-info(store)
    send.sending = false
    { go-back } = history-funcs store, web3t
    return go-back! if not wallet?
    round-money = (val)->
        +val |> (-> it * 100) |> Math.round |> (-> it / 100)
    style = get-primary-info store
    menu-style=
        background: style.app.background
        background-color: style.app.bgspare
        border: "1px solid #{style.app.border}"
    input-style=
        background: style.app.input
        border: "1px solid #{style.app.border}"
        color: style.app.text
        user-select: "text"
    input-custom-style=
        background: style.app.input
        border: "1px solid #{style.app.border}"
        color: style.app.text
        width: "100%"
    border-style=
        border: "1px solid #{style.app.border}"
    amount-style=
        background: style.app.input
        border: "1px solid #{style.app.border}"
        color: style.app.text
    icon-style =
        color: style.app.icon
    use-max-style =
        color: style.app.text2
    button-primary3-style=
        border: "0"
        color: style.app.text2
        background: style.app.primary3
        background-color: style.app.primary3-spare
    button-primary2-style=
        border: "1px solid #{style.app.wallet}"
        color: style.app.text
        background: style.app.primary2
        background-color: style.app.primary2-spare
    crypto-background =
        background: style.app.wallet
        width: "50%"
    just-crypto-background =
        background: style.app.wallet
    content-body-style=
        color: style.app.text
        border: "1px solid #{style.app.border}"
        background: theme.app.sendForm ? theme.app.background
    more-text=
        color: style.app.text
    border-header =
        color: style.app.text
        border-bottom: "1px solid #{style.app.border}"
        background: style.app.background
        background-color: style.app.bgspare
    lang = get-lang store
    wallet-title = "#{name + network} #{lang.wallet ? 'wallet'}"
    open-invoice = ->
        invoice store, wallet
    activate = (convert)-> ->
        store.current.convert = convert
    activate-usd = activate \usd
    activate-eur = activate \eur
    active-class = (convert)->
        if store.current.convert is convert then 'active' else ''
    active-usd = active-class \usd
    active-eur = active-class \eur
    show-class =
        if store.current.open-menu then \hide else \ ""
    is-custom = wallet?coin?custom is yes
    token-display =
        | is-custom is yes => (wallet.coin.name ? "").to-upper-case!
        | _ => (wallet.coin.nickname ? "").to-upper-case!
    down = (it)->
        (it ? "").to-lower-case!
    fee-token-display = fee-token.to-upper-case!
    fee-coin-image =
        | send.fee-coin-image? => send.fee-coin-image
        |_ => send.coin.image
    go-back-from-send = ->
        send.error = ''
        go-back!
    makeDisabled = send.amount-send <= 0 or store.current.send.fee-calculating is yes
    token = store.current.send.coin.token
    is-swap = store.current.send.is-swap is yes
    send-func = before-send-anyway
    disabled = not send.to? or send.to.trim!.length is 0 or ((send.error ? "").index-of "address") > -1
    placeholder-class = if store.current.send.fee-calculating is yes then "placeholder" else ""
    receiver-is-swap-contract = contracts.is-swap-contract(store, store.current.send.contract-address)
    visible-error = if send.error? and send.error.length > 0 then "visible" else ""
    get-recipient = (address)->
        address
    recipient = get-recipient(send.to)
    title = if store.current.send.is-swap isnt yes then \send else \swap
    homeFeePercent =
        | _ => send.homeFeePercent `times` 100
    homeFeePercentLabel =
        | store.current.send.feeMode is "fixed" => ""
        | _ => "(#{homeFeePercent}%)"
    is-not-bridge = ->
        { token } = store.current.send.wallet.coin
        { chosen-network } = store.current.send
        chosen-network.refer-to in <[ vlx_evm vlx2 vlx_native ]> and token in <[ vlx_evm vlx2 vlx_native ]>
    is-swap-pair = ({from, to})->
        { chosen-network, coin, wallet } = store.current.send
        token = coin.token
        token is from and chosen-network.refer-to is to
    network-on-change = (cb)->
        err <- getBridgeInfo!
        if err?
            store.current.send.error = err
            return cb err
        err <- execute-contract-data { store }
        if err?
            store.current.send.error = err
            return cb err
        amount-change { target: { value: store.current.send.amountSend }}
        cb null
    before-amount-change = (e)->
        { TYPING_THRESHOLD_MS, typing-amount-time-ms, fee-calculating } = send
        fee-calculating = yes
        #clear-timeout before-amount-change.timer
        now = moment!.valueOf!
        timeout = +(now `minus` typing-amount-time-ms)
        #if timeout < TYPING_THRESHOLD_MS then
        #store.current.send.amount-send = e.target.value
        store.current.send.typing-amount-time-ms = moment!.valueOf!
        #before-amount-change.timer = set-timeout check-stop(e), 50
        #store.current.send.typing-amount-time-ms = moment!.valueOf!
        amount-change(e)
    check-stop = (e)->
        ->
            { TYPING_THRESHOLD_MS, typing-amount-time-ms, fee-calculating } = send
            now = moment!.valueOf!
            timeout = +(now `minus` typing-amount-time-ms)
            if timeout > TYPING_THRESHOLD_MS then
                console.log "run amount-change"
                amount-change(e)
    input-wrapper-style =
        | is-custom is yes => input-custom-style
        | _ => input-style
    inline-style =
        display: "inline"
        min-width: "30px"
    amount-send-fee-rounded = round-human(send.amount-send-fee, {decimals:8})
    /* Render */
    .pug.content
        loader {loading: store.current.send.checking-allowed, text: "Please wait, approving bridge contract..."}
        .pug.title(style=border-header)
            .pug.header(class="#{show-class}") #{title}
            .pug.close(on-click=go-back-from-send)
                img.icon-svg.pug(src="#{icons.arrow-left}")
            burger store, web3t
            epoch store, web3t
            switch-account store, web3t
        .pug.content-body(style=content-body-style)
            if store.current.device isnt \mobile
                .pug.header
                    span.head.pug.left
                        img.pug(src="#{wallet-icon}")
                    span.pug.head.center(style=more-text) #{wallet-title}
                    if store.current.device is \mobile
                        span.pug.head.right(on-click=history style=icon-style)
                            img.icon-svg-history.pug(src="#{icons.history}")
            if store.current.send-menu-open
                .pug.more-buttons(style=menu-style)
                    if store.preference.invoice-visible is yes
                        if store.current.device is \desktop
                            a.pug.more.receive(on-click=open-invoice)
                                .pug
                                    span.pug.more-icon(style=icon-style)
                                        icon \Mail, 20
                                    span.pug.more-text(style=more-text) #{lang.invoice}
                    if store.current.device is \mobile
                        a.pug.more.history(on-click=history)
                            .pug
                                span.pug.more-icon(style=icon-style)
                                    icon \Inbox, 20
                                span.pug.more-text(style=more-text) #{lang.history}
            form.pug
                form-group \sender, lang.from, icon-style, ->
                    .address.pug(style=border-style)
                        address-holder { store, wallet }
                .pug.network.form-group
                    network-slider { web3t, wallet, store, on-change: network-on-change}
                form-group \receiver, lang.to, icon-style, ->
                    .pug
                        identicon { store, address: send.to }
                        input.pug(type='text' style=input-style on-change=recipient-change value="#{recipient}" placeholder="#{store.current.send-to-mask}" id="send-recipient" )
                form-group \send-amount, lang.amount, icon-style, ->
                    .pug
                        .pug.amount-field
                            .input-wrapper.pug(style=input-wrapper-style)
                                .label.crypto.pug
                                    img.label-coin.pug(src="#{wallet-icon}")
                                    | #{token-display}
                                amount-field { store, value: send.amount-send, on-change: before-amount-change, placeholder="0", id="send-amount", token, disabled }
                            if active-usd is \active
                                if not is-custom
                                    amount-fiat-field { store, on-change:amount-usd-change, placeholder:"0", title:"#{send.amount-send-usd}" value:"#{send.amount-send-usd}", id:"send-amount-usd", disabled: no }
                            if active-eur is \active
                                .input-wrapper.small.pug(style=amount-style)
                                    .label.lusd.pug
                                    input.pug.amount-eur(type='text'  style=crypto-background on-change=amount-eur-change placeholder="0" title="#{send.amount-send-eur}" value="#{round-money send.amount-send-eur}" id="send-amount-eur")
                        .pug.usd
                            button.pug.send-all(on-click=use-max-amount style=button-primary3-style type="button" id="send-max") #{lang.use-max}
                            span.pug #{lang.balance}
                            span.pug.balance
                                span.pug(title="#{wallet.balance}") #{round-human wallet.balance}
                                    img.label-coin.pug(src="#{wallet-icon}")
                                    span.pug #{token-display}
                                if +wallet.pending-sent >0 and no
                                    span.pug.pending #{'(' + pending + ' ' + lang.pending + ')'}
                        if not store.current.send.parseError
                            .pug.control-label.not-enough.text-left(title="#{send.error}" class="#{visible-error}") #{send.error}
                if is-data
                    form-group \contract-data, 'Data', icon-style, ->
                        .pug.smart-contract(style=input-style) #{show-data!}
                if down(wallet.network?group) in <[ bitcoin ]>
                or wallet.coin.token in <[ vlx_native ltc ]>
                    trx-fee { store, web3t, wallet, fee-token }
                else
                    trx-custom-gas-price { store, web3t, wallet, fee-token }
                table.pug(style=border-style)
                    tbody.pug
                        tr.pug
                            td.pug #{lang.you-spend}
                            td.pug
                                span.pug(title="#{send.amount-charged}") #{round-human(send.amount-charged)}
                                    img.label-coin.pug(src="#{wallet-icon}")
                                    span.pug(title="#{send.amount-charged}") #{token-display}
                                if not is-custom
                                    .pug.usd $ #{round-human send.amount-charged-usd}
                        tr.pug.orange
                            td.pug #{lang.fee}
                            td.pug
                                span.pug(class="#{placeholder-class}" title="#{send.amount-send-fee}" style=inline-style) #{amount-send-fee-rounded}
                                    img.label-coin.pug(src="#{fee-coin-image}")
                                    span.pug(title="#{send.amount-send-fee}") #{fee-token-display}
                                .pug.usd $ #{round-human send.amount-send-fee-usd}
                        if send.homeFeePercent? and send.homeFeePercent > 0
                            tr.pug.orange.home-fee
                                td.pug
                                    | #{lang.home-fee}
                                    | #{homeFeePercentLabel}
                                td.pug
                                    span.pug(title="#{homeFee}") #{round-human homeFee}
                                        img.label-coin.pug(src="#{send.coin.image}")
                                        span.pug(title="#{homeFee}") #{token-display}
                                    .pug.usd $ #{round-human homeFeeUsd}
            .pug.button-container
                .pug.buttons
                    button { store, text: "#{title}" , on-click: send-func , loading: send.sending, type: \primary, error: send.error, makeDisabled: makeDisabled, id: "send-confirm" }
                    button { store, text: \cancel , on-click: cancel, icon: \close2, id: "send-cancel" }
                if store.current.send.is-swap is yes
                    if not is-not-bridge!
                        .pug.swap-notification
                            p.pug #{lang.swapNotification}
module.exports = send
module.exports.init = ({ store, web3t }, cb)->
    return cb null if not store? or not web3t?
    { execute-contract-data, wallet, getBridgeInfo } = send-funcs store, web3t
    return cb null if not wallet?
    return cb null if send.sending is yes
    store.current.send.fee-calculating = no
    store.current.send.checking-allowed = no
    store.current.send.foreign-network-fee = 0
    store.current.send.amountCharged = 0
    store.current.send.amountChargedUsd = 0
    store.current.send.homeFeePercent = 0
    store.current.send.gasEstimate = \0
    store.current.send.gasPriceAuto = null
    store.current.send.gas-price-type = \auto
    store.current.send.gas-price-custom-amount = \0
    store.current.send.amount-buffer.val = \0
    store.current.send.amount-buffer.usdVal = \0
    store.current.send.error = ''
    store.current.send.feeMode = 'percent'
    if store.current.send.is-swap isnt yes
        store.current.send.contract-address = null
    is-swap-contract = contracts.is-swap-contract(store, send.to)
#    if is-swap-contract then
#        contract-address = if wallet.coin.token is \vlx2 then web3t.velas.HomeBridgeNativeToErc.address else web3t.velas.ForeignBridgeNativeToErc.address
#        store.current.send.to = contract-address
#        network-type = store.current.network
#        networks = wallet.coin["#{network-type}s"]
#        store.current.send.networks = networks
#        network-keys = networks |> keys
#        default-network = networks[network-keys.0].name
    /* If it is Swap! */
    if wallet.network.networks? and (store.current.send.isSwap is yes) then
        $wallets = store.current.account.wallets |> map (-> [it.coin.token, it]) |> pairs-to-obj
        available-networks =
            wallet.network.networks
                |> obj-to-pairs
                |> filter (-> $wallets[it[1]?referTo]?)
                |> filter (-> (not it[1]?disabled?) or it[1]?disabled is no)
                |> pairs-to-obj
        wallet-swap-networks-ids = Object.keys(available-networks)
        if wallet-swap-networks-ids.length > 0
            default-network = wallet.network.networks[wallet-swap-networks-ids[0]]
            store.current.send.chosenNetwork = default-network
            store.current.send.to = token-networks.get-default-recipient-address(store)
        else
            console.error "networks prop in #{store.current.send.token} wallet is defined but is empty"
    err <- contract-data({store}).form-contract-data!
    console.log "form-contract-data err: " err if err?
    #return cb err if err?
    err <- getBridgeInfo!
    return cb err if err?
    { wallets } = wallets-funcs store, web3t
    current-wallet =
        wallets |> find (-> it.coin.token is wallet.coin.token)
    err, fee <- contracts.get-home-network-fee({store, web3t}, store.current.send.to)
    store.current.send.foreign-network-fee = fee
    { wallet } = send-funcs store, web3t
    store.current.send.fee-coin-image =
        | wallet.network.tx-fee-in? =>
            tx-fee-in-wallet = wallets |> find (-> it.coin.token is wallet.network.tx-fee-in)
            if not tx-fee-in-wallet then
                store.current.send.error = "Please add #{((wallet.network.tx-fee-in ? "").to-upper-case!)} wallet in order to calculate transaction fee"
            tx-fee-in-wallet?coin?image ? ""
        | _ => wallet.coin.image
    #if wallet.network.txBridgeFeeIn? and (wallet.coin.token isnt wallet.network.txBridgeFeeIn) then
        #bridge-fee-token = wallet.network.txBridgeFeeIn
        #second-wallet = wallets |> find (-> it.coin.token is bridge-fee-token)
        #store.current.send.fee-coin-image = second-wallet?coin?image if second-wallet?coin?image?
    { send } = store.current
    account = { wallet.address, wallet.private-key, wallet.balance }
    query = { store, token: wallet.coin.token, to: wallet.address, send.data, send.network, amount: 0, fee-type: \auto, account }
    err, result <- calc-fee-before-send { store, query, fast: yes }
    return cb err if err?
    #{ calced-fee, gas-price, gas-estimate } = result
    send.gas-price-auto = result?gas-price ? 0
    send.gas-price-custom-amount = +((result?gas-price ? 0) `div` (10^9))
    send.amount-send-fee = +(result?calced-fee ? 0)
    return cb null if current-wallet.address is wallet.address
    return cb null if not wallet?
    return cb null if not web3t[wallet.coin.token]?
    { send-transaction } = web3t[wallet.coin.token]
    err <- send-transaction { to: "", value: 0 }
    send.sending = false
    cb null