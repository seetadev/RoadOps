require! {
    \react
    \./\../get-primary-info.ls
    \./\../get-lang.ls
    \./\../icons.ls
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
    background: red
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
    span
        margin-bottom: 0px
        font-weight: 700
    a
        font-weight: 700
        color: white
    .contents
        padding-bottom: 8px
module.exports = (store) ->
    return null if store.current.send.parseError is ''
    message = store.current.send.parseError
    style = get-primary-info store
    lang = get-lang store
    copy-style=
        color: style.app.text
        z-index: 99999999999
    cancel = ->
        store.current.send.parseError = ""
    .copied.pug(class="opened" key="default-alert" style=copy-style)
        .pug.button-close(on-click=cancel id="prompt-close")
            span.cancel.pug
                img.icon-svg-cancel.pug(src="#{icons.close}")
        .copied-inner.pug
            .pug.mb-5 #{lang.errorParseTitle}
            .pug.contents
                span.pug #{lang.errorParseMessage1}
                    a.pug(target="_blank" rel="noopener noreferrer nofollow" href="https://support.velas.com") #{lang.errorSupportLinkTitle}
                        span.pug #{lang.errorParseMessage2}
                        br.pug
                        span.pug #{message}
