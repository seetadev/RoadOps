module.exports = (value, config = null) ->
    MIN_VALUE_LEAVE_TWO_DECIMAL = 1000
    MIN_VALUE_REMOVE_DECIMAL = 1000000
    decimals = void
    digits = void
    maxValue = void
    ref$ = void
    head = void
    dec = void
    try
        return '0' if value is null
        decimals = config.decimals
        digits = config.digits
        maxValue = config.maxValue
        if maxValue isnt null and +value > +maxValue then return maxValue
        if +value >= MIN_VALUE_LEAVE_TWO_DECIMAL and +value < MIN_VALUE_REMOVE_DECIMAL
            ref$ = value.toString!.split '.'
            head = ref$.0
            dec = ref$.1
            return head if not dec
            dec_ = dec.substr 0, 2
            return head + '.' + dec_
        if +value >= MIN_VALUE_REMOVE_DECIMAL
            ref$ = value.toString!.split '.'
            head = ref$.0
            return head
        if decimals is null then decimals = 10
        if +value is 0 and (value + '').length <= decimals then return value
        ref$ = value.toString!.split '.'
        head = ref$.0
        dec = ref$?1 ? ""
        if digits isnt null and head.length > digits then head = head.substr 0, digits
        if dec is null then return head
        dec = dec.substr 0, decimals
        return head + '.' + dec
    catch e
        console.error e
        return value
    return value