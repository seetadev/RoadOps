state = {
    timeout = null
}
module.exports = (store)-> (event)->
    store.current.copied = event
    clear-timeout(state.timeout)
    remove-notification = ->
        store.current.copied = ""
    state.timeout = set-timeout remove-notification, 1700