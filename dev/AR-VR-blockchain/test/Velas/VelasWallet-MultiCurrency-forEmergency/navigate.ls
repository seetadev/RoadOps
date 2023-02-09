require! {
    \./browser/window.ls
    \./pages.ls
    \./seed.ls : seedmem
    \mobx : { transaction }
    \./scroll-top.ls
}
#https://web3.space/wallet?internal=yes
init-flow = (prev)->
    return \newseedrestore if prev is \chooseinit and store.current.seed-generated is no
    return \locked if prev is \chooseinit and store.current.seed-generated is yes
    return \locked if prev is \newseedrestore
    return \reviewwords if prev in <[ locked newseedrestore ]> and not seedmem.saved! and store.current.seed-generated is yes
    return \verifyseed if prev is \reviewwords
    return \restorewords if prev in <[ locked newseedrestore ]> and not seedmem.saved! and store.current.seed-generated is no
    return \terms if prev is \verifyseed
    return \choosestaker if prev is \choosestaker-pool
    #return \chooseinit if not saved!
    \wallets
get-page = (store, page, prev) ->
    return page if page isnt \:init
    init-flow prev
init-control = (scope, name, cb) !->
    #<- set-timeout _, 1
    control = pages[name]
    return cb null if typeof! control?init isnt \Function
    control.init scope, cb
focus-control = (scope, name, cb) !->
    scroll-top!
    control = pages[name]
    return cb null if typeof! control?focus isnt \Function
    control.focus scope, cb
perform-ask-pin = (store, page)->
    scroll-top!
    store.current.page = \locked
    store.current.page-pin = page
module.exports = (store, web3t, page, ask-pin, cb) !->
    return perform-ask-pin store, page if ask-pin is yes
    return alert "store is required" if not store?
    return alert "web3t is required" if not web3t?
    scroll-top!
    #<- set-timeout _, 1
    if page? and page isnt \loading and page isnt \:init
        if store.pages.length > 0 
            if (store.pages.index-of(page) > -1)
                index = store.pages.index-of(page)
                store.pages.splice(-(store.pages.length - index), 1)
            store.pages.push(page)
    store.pages = [\locked] if page is \locked 
    store.pages = [\wallets] if page is \wallets or page is \:init
    prev = store.current.page
    store.current.page = \loading
    store.current.loading = yes
    name = get-page store, page, prev
    <- init-control { store, web3t }, name
    store.current.page = name
    store.current.loading = no
    <- focus-control { store, web3t }, name
    cb! if cb?