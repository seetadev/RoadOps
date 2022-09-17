require! {
    \react
    \../get-primary-info.ls
    \../get-lang.ls
    \../pages/icon.ls
    \../icons.ls
    \../send-funcs.ls
    \../numbers.js : {parseNum}
    \../math.ls : { times, minus, div, plus }
    \prelude-ls : { find }
    \../round-human.ls
    \./react-currency-input-field : { default: CurrencyInput }
}
.trx-custom-gas-price
    position: relative
    @import scheme
    $border-radius: var(--border-btn)
    &.disabled
        opacity:.2
    table
        margin-bottom: -1px
        border-radius: $border-radius $border-radius 0 0
    td
        cursor: pointer
        padding: 2px 5px 10px
        transition: all .5s
        position: relative
        &:first-child
            border-radius: $border-radius 0 0 0
        &:last-child
            text-align: left
            border-radius: 0 $border-radius 0 0
        &:hover
            background: var(--td-hover)
            transition: all .5s
        &.active
            background: var(--td-hover)
            .field
                &.type
                    color: orange
                    &:after
                        opacity: 1
                        filter: none
        .type
            &:after
                content: $check-xs
                position: absolute
                right: 5px
                opacity: .2
                filter: grayscale(1)
                margin-bottom: 20px
        .coin
            text-transform: uppercase
    .warn-label
        display: inline-block;
        margin: 0;
        font-size: 13px;
        .warn-label-text
            background: #191919 
            border: 1px solid #cc932c
            top: 30px
            z-index: 3;
            padding: 10px;
            left: 10px;
    .question-mark
        display: inline-block
        .label
            background: white
            padding: 0px 3.6px !important
            margin-left: 5px
            font-weight: bold
            border-radius: 50%
            margin-bottom: 1px
            position: relative
            bottom: 2px
            cursor: pointer
            display: inline-block
            font-size: 10px
        &:hover
            .question-mark-text
                display: block
        .question-mark-text
            display: none
            background: #121212 
            position: absolute;
            top: 30px
            z-index: 3;
            padding: 10px;
            left: 10px;
            min-width: 270px;
            .triangle
                width: 0;
                height: 0;
                border-style: solid;
                border-width: 0 10px 15px 10px;
                border-color: transparent transparent #121212 transparent
                position: absolute;
                left: 51px;
                top: -9px;
            span
                font-size: 12px
                font-weight: 500;
                color: white
    .low-gas-price-warn
        p
            font-size: 13px
            color: red
            padding: 10px
            position: absolute
            right: 0
    label
        padding-top: 5px
        padding-left: 3px
        font-size: 13px
    table
        width: 100%
    input
        outline: none
        width: 100%
        box-sizing: border-box
        height: 36px
        line-height: 36px
        border-radius: 0px
        padding: 0px 10px
        font-size: 14px
        border: 0px
        box-shadow: none
        margin-bottom: -1px
DECIMAL_SEPARATOR = '.'
trx-fee = ({ store, web3t, wallet, fee-token })->
    style = get-primary-info store
    lang = get-lang store
    {send} = store.current
    active-cheap = send.gas-price-type is \cheap
    active-custom = send.gas-price-type is \custom
    active-auto = send.gas-price-type is \auto
    active-class= (gas-price-type) ->
        return null if gas-price-type isnt send.gas-price-type
        return \active
    decimalsLimit = 9
    { choose-custom-gas-price, choose-auto-gas-price, has-send-error} = send-funcs store, web3t
    disabled-class = if has-send-error! then "disabled" else ""
    select-custom-gas-price = ->
        return if has-send-error!
        choose-custom-gas-price send.gas-price-custom-amount
    get-number = (val)->
        number = (val ? "").toString!
        return \0 if number is ""
        val
    value-without-decimal-with-dot = (value)->
        value = (value ? "").toString()
        res = value.split(DECIMAL_SEPARATOR)
        value.index-of(DECIMAL_SEPARATOR) > -1 and (res.length > 1 and res[1] is "")
    on-change-internal = (it)->
        console.log "[on-change-internal]"
        value = it
        value = get-number(value)
        # Restrictions check #
        result = value.toString!.split(DECIMAL_SEPARATOR)
        groups = result.0
        decimals = result.1
        if +groups > 10^15 then 
            return
        if decimals? and (decimals.length > decimalsLimit) then
            value = round-number(value, {decimals: decimalsLimit})
        else
            decimalsLimit = 0
        # # # # # # # # # # #
        res = (value ? "0").toString().split(DECIMAL_SEPARATOR)
        parsed-left = parseNum(res?0)
        has-dot = res.length > 1
        value = "0" if not value? or value is ""
        str_val = (value ? "0").toString()
        $value = 
            | it is "" => 0
            | value-without-decimal-with-dot(value) =>
                left = res.0
                parseNum(left) + DECIMAL_SEPARATOR
            | has-dot and parsed-left is parseNum(it) =>
                parsed-left + DECIMAL_SEPARATOR + (res?1 ? "" )    
            | has-dot and (str_val.length isnt (+str_val).toString().length) and (+value is +str_val) =>
                parseNum(res.0) + DECIMAL_SEPARATOR + (res?1 ? "" )          
            | _ => parseNum(value)
        value = $value 
        if send.gas-price-type is \custom then
            send.gas-price-custom-amount = value 
            choose-custom-gas-price value 
        else
            send.gas-price-auto = value    
        #choose-custom-gas-price value
        send.amount-buffer.gas-price = send.gasPriceCustomAmount 
    border-style = border: "1px solid #{style.app.border}"
    text = color: "#{style.app.icon}"
    icon-style = color: "rgb(38 98 145)"
    input-style=
        background: style.app.input
        border: "1px solid #{style.app.border}"
        color: style.app.text
    gas-price-custom-amount_GWEI = send.gas-price-custom-amount
    gas-price-custom-amount = round-human(gas-price-custom-amount_GWEI)
    auto-gas-price =  round-human((send.gas-price-auto ? 0) `div` (10^9))
    custom-option = ->
        td.pug(on-click=select-custom-gas-price class="#{active-class \custom}")
            .pug.field.type #{lang.custom}
            .pug.field.coin #{gas-price-custom-amount + " GWEI"}
    auto-fee-display-field-class =
        | store.current.send.fee-calculating is yes and send.gas-price-type is \auto => "placeholder" 
        | _ => ""
    auto-option = ->
        td.pug(on-click=choose-auto-gas-price class="#{active-class \auto}")
            .pug.field.type #{lang.auto}
            .pug.field.coin(class="#{auto-fee-display-field-class}") #{auto-gas-price  + " GWEI"}
    fee-payer = 
        | wallet.network.tx-fee-in? =>
            tx-fee-in-wallet = store.current.account.wallets |> find (-> it.coin.token is wallet.network.tx-fee-in)           
            tx-fee-in-wallet?coin?name  
        | _ => wallet.coin.name        
    gas-price-tooltip = "Gas price specifies the amount of #{fee-payer} you are willing to pay for each unit of gas."
    gas-price-islower = send.gas-price-custom-amount < ((send.gas-price-auto ? 0) `div` (10^9))
    low-gas-warn = 
        | send.gas-price-type is \custom and gas-price-islower =>
            "Gas price is lower than offered. Transaction will be confirmed longer or canceled."
        | _ => ""
    warn-label = ->
        .warn-label.pug
            if send.gas-price-type is \custom and gas-price-islower 
                .warn-label-text.pug #{low-gas-warn}
    .pug.trx-custom-gas-price(class="#{disabled-class}")
        .pug
            label.pug(style=text) Gas Price
            .question-mark.pug 
                .pug.label(style=icon-style) ?
                .pug.question-mark-text
                    .triangle.pug
                    span.pug #{gas-price-tooltip}
            warn-label!
        table.pug.fee(style=border-style)
            tbody.pug
                tr.pug
                    custom-option!
                    auto-option! 
        if store.current.send.gas-price-type is \custom             
            CurrencyInput.pug(class="textfield tx-fee" key="tx-fee-input" allowNegativeValue=no style=input-style defaultValue="0" allowDecimals=yes value="#{gas-price-custom-amount_GWEI}" decimalsLimit=decimalsLimit label="Send" decimalSeparator=DECIMAL_SEPARATOR groupSeparator="," onValueChange=on-change-internal)
module.exports = trx-fee
#???store.current.send.send.gas-price-custom-amountcheaon-change-xcon-change-custom-fee.send""store.current.send.send.fstore.current.send.gas-price-custom-amount