require! {
    \react
    \../get-primary-info.ls
    \../round5.ls
    \../round.ls
    \../round-number.ls
    \prelude-ls : { find }
    \../math.ls : { times }
    \./keyboard.ls
    \../numbers.js : {parseNum}
    \./react-currency-input-field : { default: CurrencyInput }
    \../icons.ls
    \bignumber.js
}
.input-area
    @import scheme
    position: relative
    margin: 10px 0
    width: 100%
    box-sizing: border-box
    height: 36px
    line-height: 36px
    >*
        display: inline-block
        box-sizing: border-box
        margin: 0 !important
        height: inherit
        line-height: inherit
        vertical-align: top
        z-index: 1
    >input
        background: transparent
        overflow-x: auto
        color: white
        display: inline-block
        width: calc(100% - 70px) !important
        padding: 0 10px
        border-radius: $border 0 0 $border !important
        border: none
        text-align: left
        &:disabled
            opacity: .2
    >.suffix
        $color: rgba(#ccc, 0.3)
        width: 70px
        border-left: 1px solid $color
        text-align: center
        border-radius: 0 $border $border 0
        >*
            display: inline-block
        >.icon
            width: 15px
            margin-bottom: -1px
            margin-right: 5px
    >.show-details
        display: none
    &:hover
        >.show-details
            display: block
            position: absolute
            top: 36px
            right: 0
            width: auto
            padding: 0
            color: white
            height: 90px
            text-align: right
            background: transparent
            >.panel
                padding: 10px
                background: rgba(black, 0.8)
                display: inline-block
                max-width: 250px
                min-width: 250px
                text-align: left
DECIMAL_SEPARATOR = '.' 
module.exports = ({ store, value, on-change, placeholder, id, show-details, token="vlx2", disabled=no })->
    style = get-primary-info store
    usd = null
    eur = null
    ref=null
    input-style =
        background: style.app.input
        color: style.app.text
        overflow-x: \auto
    current=
        ref: null
    { wallets } = store.current.account
    wallet =
        wallets |> find (-> it.coin.token is token)
    if wallet?
        usd =
            | wallet.usd-rate? => (value || "0") `times` wallet.usd-rate
            | _ => ".."
        eur =
            | wallet.eur-rate? => (value || "0") `times` wallet.eur-rate
            | _ => ".."
    value = 0 if value is "" or not value?
    # Input validation #
    decimalsLimit = Math.min(wallet?network?decimals, 8)
    decimals = value.toString!.split(DECIMAL_SEPARATOR).1
    if decimals? and (decimals.length > decimalsLimit) then
        value = round-number(value, {decimals: decimalsLimit})
    ####################
    actual-placeholder = placeholder ? ""        
    get-number = (val)->
        number = (val ? "").toString!
        return \0 if number is ""
        val
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
        on-change { target: { value } }
    token = \vlx if token is \vlx2
    is-custom = wallet?coin?custom is yes 
    token-label = 
        | is-custom is yes => wallet.coin.name 
        | _ => (wallet.coin.nickname ? token).to-upper-case!
    value-without-decimal-with-dot = (value)->
        value = (value ? "0").toString()
        res = value.split(DECIMAL_SEPARATOR)
        value.index-of(DECIMAL_SEPARATOR) > -1 and (res.length > 1 and res[1] is "")
    wallet-icon = 
        | wallet.coin?custom is yes and icons.customWalletIcon? => icons.customWalletIcon
        | _ => wallet.coin.image
    .pug.input-area
        CurrencyInput.pug(id="value-input" class="textfield" style=input-style key="amount" allowDecimals=yes allowNegativeValue=no value="#{value}" decimalsLimit=decimalsLimit label="Send" decimalSeparator=DECIMAL_SEPARATOR groupSeparator="," onValueChange=on-change-internal)
        span.suffix.pug(style=input-style)
            img.icon.pug(src="#{wallet-icon}")
            span.pug #{token-label}
        if show-details? and show-details then   
            .show-details.pug
                .panel.pug
                    .pug USD: #{round usd}