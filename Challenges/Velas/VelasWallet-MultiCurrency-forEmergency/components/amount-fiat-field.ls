require! {
    \react
    \../get-primary-info.ls
    \prelude-ls : { find }
    \../math.ls : { times }
    \./keyboard.ls
    \../numbers.js : {parseNum}
    \../send-funcs.ls
    \../round-number.ls
    \./react-currency-input-field : { default: CurrencyInput }
}
DECIMAL_SEPARATOR = '.'
module.exports = ({ store, value, on-change, placeholder, id, show-details, title, token="vlx2", disabled=no })->
    # Styles ##################
    style = get-primary-info store
    amount-style=
        background: style.app.input
        border: "1px solid #{style.app.border}"
        color: style.app.text
    just-crypto-background =
        background: style.app.wallet  
    ###########################
    # Input validation ########
    decimalsLimit = 4
    # Input validation #
    decimals = value.toString!.split(DECIMAL_SEPARATOR).1
    if decimals? and (decimals.length > decimalsLimit) then
        value = round-number(value, {decimals: decimalsLimit})
    ###########################
    # Listeners
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
            return
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
                parsed-left + DECIMAL_SEPARATOR + (res?1 ? "")    
            | has-dot and (str_val.length isnt (+str_val).toString().length) and (+value is +str_val) =>
                parseNum(res.0) + DECIMAL_SEPARATOR + (res?1 ? "")          
            | _ => parseNum(value)
        value = $value 
        on-change { target: { value } }
    .input-wrapper.small.pug(style=amount-style)
        .label.lusd.pug $
        CurrencyInput.pug(class="textfield amount-usd" key="amount-usd" style=just-crypto-background allowDecimals=yes value="#{value}" decimalsLimit=decimalsLimit label="Send" decimalSeparator=DECIMAL_SEPARATOR groupSeparator="," onValueChange=on-change-internal disabled=disabled)