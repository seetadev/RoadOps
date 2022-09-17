require! {
    \react
    \../get-primary-info.ls
    \react-copy-to-clipboard : { CopyToClipboard }
    \../copied-inform.ls
    \../copy.ls
}
module.exports = ({ store, text, elId })->
    style = get-primary-info store
    filter-icon=
        filter: style.app.filterIcon
    icon2=
        filter: style.app.icon2
    enter = ->
        store.current.try-copy = text
    leave = ->
        store.current.try-copy = null
    onCopy =  
        | elId? => (event) ->
                        # fixes the issue with no copied value after one click https://github.com/nkbt/react-copy-to-clipboard/issues/100#issuecomment-524057405
                        el = document.getElementById elId
                        el.click!
                        copied-inform(store)(event)
        | _ => copied-inform(store)
    CopyToClipboard.pug(text="#{text}" id="#{elId}" on-copy=onCopy style=icon2 on-mouse-enter=enter on-mouse-leave=leave)
        copy store