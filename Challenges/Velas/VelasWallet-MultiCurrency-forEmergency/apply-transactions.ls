require! {
    \prelude-ls : { sort-by, reverse, filter, find, keys, map }
}
make-array = (obj)->
    obj |> keys |> map (-> obj[it])      
filter-txs = (store, tx)-->
    { type, token, from, to } = tx
    filter-props = store.current.filter |> keys
    found = filter-props |> filter (prop)->
        store.current.filter[prop] is tx[prop] 
    found.length is filter-props.length
module.exports = (store)->
    #return store.transactions.applied.length = 0 if store.transactions.all.length is 0
    store.transactions.applied = 
        store.transactions.all
            |> filter (it) -> (it.type in store.current.filter-txs-types) 
            |> filter filter-txs store
            |> sort-by (.time) 
            |> reverse