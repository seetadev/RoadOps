require! {
    \react
    \../get-primary-info.ls
    \../get-lang.ls
    \../pages/icon.ls
    \../icons.ls
    \../send-funcs.ls
    \../numbers.js : {parseNum}
    \react-currency-input-field : { default: CurrencyInput }
}
.trx-fee
    @import scheme
    $border-radius: var(--border-btn)
    &.disabled
        opacity:.2
    table
        margin-bottom: -1px
        border-radius: $border-radius $border-radius 0 0
    .tx-fee-mode
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
        &.disabled
            opacity: 0.2;
            cursor: not-allowed;
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
    active-cheap = send.fee-type is \cheap
    active-custom = send.fee-type is \custom
    active-auto = send.fee-type is \auto
    active-class= (fee-type) ->
        return null if fee-type isnt send.fee-type
        return \active
    decimalsLimit = wallet?network?decimals ? 4
    { choose-cheap, choose-custom, choose-auto, has-send-error} = send-funcs store, web3t
    disabled-class = if has-send-error! then "disabled" else ""
    custom-is-disabled = wallet.coin.token in <[ vlx_native ]>
    select-custom = ->
        return if has-send-error! or custom-is-disabled
        choose-custom send.amount-send-fee
    get-number = (val)->
        number = (val ? "").toString!
        return \0 if number is ""
        val
    value-without-decimal-with-dot = (value)->
        value = (value ? "").toString()
        res = value.split(DECIMAL_SEPARATOR)
        value.index-of(DECIMAL_SEPARATOR) > -1 and (res.length > 1 and res[1] is "")
    on-change-internal = (it)->
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
        balance = +wallet.balance
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
        choose-custom value
    fee-currency = wallet.network.tx-fee-in ? (wallet.coin.nickname ? "").to-upper-case!
    is-custom = wallet?coin?custom is yes 
    token-display = fee-token.to-upper-case!
    border-style = border: "1px solid #{style.app.border}"
    text = color: "#{style.app.icon}"
    input-style=
        background: style.app.input
        border: "1px solid #{style.app.border}"
        color: style.app.text
    custom-fee-value = ->
        if active-custom
        then send.fee-custom-amount
        else send.amount-send-fee
    cheap-option = ->
        return null if !send.amount-send-fee-options.cheap
        return null if send.amount-send-fee-options.cheap > send.amount-send-fee-options.auto
        td.pug(on-click=choose-cheap class="#{active-class \cheap}")
            .pug.field.type #{lang.cheap}
            .pug.field.coin #{if send.amount-send-fee-options.cheap then send.amount-send-fee-options.cheap + " " + token-display else ""}
    custom-option = ->
        disabled = 
            | custom-is-disabled => yes
            | _ => no
        disabled-class = 
            | custom-is-disabled => "disabled"
            | _ => ""
        td.pug(on-click=select-custom class="tx-fee-mode #{active-class \custom} #{disabled-class}" disabled=disabled)
            .pug.field.type #{lang.custom}
            .pug.field.coin #{custom-fee-value! + " " + token-display}
    auto-option = ->
        td.pug(on-click=choose-auto class="tx-fee-mode #{active-class \auto}")
            .pug.field.type #{lang.auto}
            .pug.field.coin #{if send.amount-send-fee-options.auto then send.amount-send-fee-options.auto + " " + token-display else ""}
    .pug.trx-fee(class="#{disabled-class}")
        label.pug(style=text) Transaction Fee
        table.pug.fee(style=border-style)
            tbody.pug
                tr.pug
                    cheap-option!
                    custom-option!
                    auto-option!
        if store.current.send.fee-type is \custom       
            CurrencyInput.pug(class="textfield tx-fee" key="tx-fee-input" style=input-style defaultValue="0" allowDecimals=yes value="#{send.fee-custom-amount}" decimalsLimit=decimalsLimit label="Send" decimalSeparator=DECIMAL_SEPARATOR groupSeparator="," onValueChange=on-change-internal)
module.exports = trx-fee
#???store.current.send.send.fee-custom-amountcheaon-change-xcon-change-custom-fee.send""store.current.send.send.fstore.current.send.fee-custom-amount