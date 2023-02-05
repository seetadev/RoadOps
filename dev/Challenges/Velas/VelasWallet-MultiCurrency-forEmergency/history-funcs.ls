require! {
    \prelude-ls : { sort-by, reverse, filter, map, find }
    \moment
    \./navigate.ls
    \react
    \./pending-tx.ls : { remove-tx }
    \./api.ls : { get-transaction-info }
    \./web3.ls
    \mobx : { toJS }
    \./pages/confirmation.ls : { confirm, prompt }
    \./apply-transactions.ls
    \./get-lang.ls
    \./icons.ls
    \./round-human.ls
}
module.exports = (store, web3t)->
    return null if not store? or not web3t?
    ago = (time)->
        moment(time * 1000).from-now!
    date = (time)->
        moment(time * 1000).format!
    filt = store.current.filter
    lang = get-lang store
    arrow = (type)->
        | type is \IN => \ "#{lang.in}"
        | _ => \ "#{lang.out}"
    arrow-lg = (type)->
        | type is \IN => \ "#{icons.get}"
        | _ => \ "#{icons.send}"
    sign = (type)->
        | type is \IN => \+
        | _ => \-
    go-back = ->
        return null if store.pages.length <= 1
        store.pages.splice(-1, 1)
        prev = store.pages[store.pages.length - 1]
        page = prev ? \wallets
        navigate store, web3t, page
    extended = (str)->
        | str.index-of('.') > -1 => "#{str}0"
        | _ => "#{str}.0"
    cut-amount = (amount, max)->
        str = (amount ? "")to-string!
        res =
            | str.length is max => str
            | str.length >= max => str.substr(0, max - 1) + ".."
            | _ => cut-amount extended(str), max
        res
    amount-beautify = (amount, max)->
        str = (amount ? "")to-string!
        #data = str.match(/(.+[^0])(0+)$/)
        $amount = round-human(str, {decimals: 4})
        [int, dec] = $amount.split(".")
        gray-style = 
            opacity: 0.8
            font-size: "90%"
            font-weight: 600
        return
            .pug.balance
                span.color.pug #{int}
            if dec? then
                span.gray-color.pug(style=gray-style)\.#{dec}     
    is-active = (value)->
        types = store.current.filter-txs-types
        if value in types then \active else ''
    set-filter  = (value)->
        key = Object.keys(value).0
        val = value[key]  
        if (val.toString().trim()).length > 0
            filt["#{key}"] = val
        else
            delete filt["#{key}"]
        apply-transactions store
    switch-type = (type, event)-->
        types = filt.types
        if type not in store.current.filter-txs-types
            store.current.filter-txs-types.push type
        else
            store.current.filter-txs-types.splice(store.current.filter-txs-types.index-of(type), 1) 
    # Deprecated: was used in order to switch filter to another tokens to filter tansactions in chosen wallet.
    switch-filter  = (value, event)-->
        key = Object.keys(value).0
        val = value[key]  
        if not filt["#{key}"]?
            filt["#{key}"] = val
        else
            delete filt["#{key}"]
        apply-transactions store
    switch-type = (type, event)-->
        #types = filt.types
        if type not in store.current.filter-txs-types
            store.current.filter-txs-types.push type
        else
            store.current.filter-txs-types.splice(store.current.filter-txs-types.index-of(type), 1)  
        apply-transactions store  
    switch-type-in = switch-type \IN
    switch-type-out = switch-type \OUT
    switch-sender = (from)->
        if \IN not in store.current.filter-txs-types 
            store.current.filter-txs-types.push(\IN)
        set-filter {from}
    switch-receiver = (to)->
        if \OUT not in store.current.filter-txs-types 
            store.current.filter-txs-types.push(\OUT)
        set-filter {to}
    get-key = (obj)->
        Object.keys(obj).0
    get-value = (obj)->
        key = Object.keys(obj).0
        obj[key] 
    remove-type-from-filter = (type, event)-->
        store.current.filter-txs-types.splice(store.current.filter-txs-types.index-of(type), 1) 
        apply-transactions store      
    remove-filter-raram = (prop, event)-->
        return null if not prop?
        key = get-key(prop)
        return no if not store.current.filter["#{key}"]?
        delete store.current.filter["#{key}"]
        apply-transactions store  
    delete-pending-tx = (tx)-> (event)->
        agree <- confirm store, "Would you like to remove pending transaction?  Your balance will be updated once the transaction is confirmed"
        return if not agree
        err <- remove-tx { store, ...tx }
        <- web3t.refresh
    transaction-info = (config)-> (event)->
        err, info <- get-transaction-info config
    { go-back, switch-type-in, transaction-info, remove-type-from-filter, remove-filter-raram, switch-sender, switch-receiver, switch-type-out, store.coins, is-active, switch-filter, arrow, arrow-lg, sign, delete-pending-tx, amount-beautify, ago }