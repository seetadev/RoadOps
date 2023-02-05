require! {
    \react
    \./get-primary-info.ls
    \./get-lang.ls
    \./icons.ls
}
.copied
    @import scheme
    position: fixed
    background: #74cee1
    z-index: 9999999
    font-size: 14px
    box-sizing: border-box
    color: white
    width: 100%
    height: 80px
    padding: 10px
    right: 0
    text-align: center
    border-radius: 0px 0px var(--border-btn) var(--border-btn)
    box-shadow: 0px 0px 0px 0px #aee7f3
    margin: 10px
    border-radius: calc(var(--border-btn) * 2)
    width: calc(100% - 20px)
    box-shadow: 7px 10px 13px #0000001f, -16px 20px 13px #00000024
    opacity: 0.85
    min-width: 30%
    max-width: 400px
    background: green
    @keyframes top
        0%
            top: -80px
        100%
            top: 0
    &.opened
        animation: top 0.5s forwards
    .button-close
        cursor: pointer
        float: right
        img
            width: 13px
    .mb-5
        margin-bottom: 5px
    .contents
        height: 35px
module.exports = (store)->
    { copied } = store.current
    return null if copied is ''
    copied-class = if copied is '' then '' else 'opened'
    style = get-primary-info store
    lang = get-lang store
    cut = (tx)->
        return \none if not tx?
        t = tx.to-string!
        if t.to-lower-case!.indexOf("private key") > -1
            t
        else
            t.substr(0, 10) + \.. + t.substr(tx.length - 25, 0) + \.. + t.substr(t.length - 10, 10)
        #r.to-upper-case!
    copy-style=
        color: style.app.text
        z-index: 99999999999
    cancel = ->
        store.current.copied = ""
    .copied.pug(class="#{copied-class}" key="copy-message" style=copy-style)
        .pug.button-close(on-click=cancel id="prompt-close")
            span.cancel.pug
                img.icon-svg-cancel.pug(src="#{icons.close}")
        .copied-inner.pug
            .pug.mb-5 #{lang.copied}
            h4.pug.contents #{cut copied}