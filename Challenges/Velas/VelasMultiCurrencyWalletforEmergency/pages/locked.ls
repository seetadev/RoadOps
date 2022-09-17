require! {
    \react
    \prelude-ls : { map }
    \../pin.ls : { set, check, exists, del, setbkp }
    \../navigate.ls
    \../get-primary-info.ls
    \../get-lang.ls
    \../send-form.ls : { notify-form-result }
    \../seed.ls : seedmem
    \../menu-funcs.ls
    \./choose-language.ls
    \../icons.ls
    \./confirmation.ls : { confirm }
    \../components/button.ls
    \../components/text-field.ls
    \../components/export-import-seed.ls
    \../pages/confirmation.ls : { alert }
}
.locked
    @import scheme
    padding-top: 20px
    padding-bottom: 20px
    height: 100vh
    overflow: scroll
    box-sizing: border-box
    text-align: center
    background-size: cover !important
    display: flex
    justify-content: center
    align-items: center
    z-index: 99999999
    position: relative
    background: $primary
    background-color: var(--bgspare)
    @media screen and (max-width: 800px)
        display: block
    .locked-inner
        max-width: 550px
        max-height: 700px
        margin: auto
        @media screen and (max-width: 800px)
            max-height: 100%   
        .notice
            max-width: 300px
            text-align: center
            color: red
            margin: 10px auto
            font-size: 15px
            padding: 10px
            border: 1px solid rgba(255, 0, 0, 0.5)
        .icon-svg
            position: relative
            height: 12px
            top: 2px
            margin-right: 3px
        .downloadwallet
            padding: 0 0 30px
        .icon-download
            padding: 10px
            height: 20px
            cursor: pointer
            margin: 20px 6px 0
            transition: all 1s
            position: relative
            opacity: 0.7
            &:hover
                opacity: 1
                filter: drop-shadow(0px 8px 11px #71f4c0)
        .language
            position: absolute
        .password
            -webkit-text-security: disc
            text-security: disc
            &::-webkit-outer-spin-button, &::-webkit-inner-spin-button
                -webkit-appearance: none
            -moz-appearance: textfield
        >.logo
            margin: 4rem 0
            @media screen and (max-width: 800px)
                margin: 2rem 0
            >img
                height: 80px
                margin-bottom: 1rem
            >.title
                font-size: 12px
                font-weight: 600
                letter-spacing: 4px
                text-align: center
        >.title
            font-size: 20px
            margin-bottom: 1rem
        >.inputs
            max-width: 400px
            width: 130px
            display: inline-block
            div
                .division
                    float: none
                    margin: 15px auto 0
                    overflow: hidden
                    position: relative
                    text-align: center
                    width: 100px
                    font-size: 10px
                    span
                        text-transform: uppercase
                    .line
                        border-top: 1px solid rgba(223, 223, 223, 0.2)
                        position: absolute
                        top: 6px
                        width: 34%
                        &.l
                            left: 0
                        &.r
                            right: 0
            input
                text-align: left
                font-size: 12px
                display: inline-block
                height: 36px
                background: transparent
                border: 0
                border-radius: var(--border-btn)
                outline: none
                width: 130px
                margin-bottom: 5px
                letter-spacing: 5px
                padding: 7px 25px 7px 7px
                box-sizing: border-box
                &:focus
                    border-color: #248295
                &:placeholder
                    color: $primary + 40
                @media screen and (max-width: 800px)
                    padding: 7px 0
                    text-align: center
        .wrong-pin-trial
            @media screen and (max-width: 800px)
                box-shadow: 1px 2px 12px black
                background: #010731
                z-index: 999
        >div>.wrong
            color: red
            font-size: 15px
            padding-top: 15px
            max-width: 400px
            display: inline-block
            ~div .orange
                color: orange
                text-transform: uppercase
                letter-spacing: 1px
                display: block
        button
            width: 130px
            margin: 5px 0
            &.text-primary
                color: rgb(156, 65, 235)
                &:hover
                    text-decoration: underline
            &.setup
                font-weight: bold
                cursor: pointer
                margin: 5px 0
                width: 130px
                height: 36px
                font-size: 10px
                text-transform: uppercase
                padding: 0px 6px
                border-radius: $border
                border: 0px
                background: transparent
                &.reset
                    &:hover
                        text-decoration: underline
                color: white
        .hint
            color: #f2eeee
            padding: 20px 0
            max-width: 250px
            font-size: 13px
            margin: 0 auto
        .iron
            -webkit-mask-image: linear-gradient(75deg, rgba(0, 0, 0, 0.6) 30%, #000 50%, rgba(0, 0, 0, 0.6) 70%)
            -webkit-mask-size: 50% 100%
            animation: shine 2s infinite
        @keyframes shine
            0%
                -webkit-mask-position: right
            100%
                -webkit-mask-position: left
        .version
            letter-spacing: 1px
            font-size: 8px
            padding: 6px
            color: #89829d
            border-radius: 8px
            height: 5px
            line-height: 5px
            margin: 5px auto
        ::placeholder
            color: var(--color3)
            font-size: 12px
            letter-spacing: 0
            line-height: 18px
        ::-ms-input-placeholder
            color: var(--color3)
            font-size: 12px !important
            letter-spacing: 0
            line-height: 22px
        .drag
            animation: horizontal_5859 2s ease
            transform-origin: 50% 50%
        @keyframes horizontal_5859
            0%
                transform: translate(0, 0)
            4.41177%
                transform: translate(5px, 0)
            8.82353%
                transform: translate(0, 0)
            13.23529%
                transform: translate(5px, 0)
            17.64706%
                transform: translate(0, 0)
            22.05882%
                transform: translate(5px, 0)
            26.47059%
                transform: translate(0, 0)
            100%
                transform: translate(0, 0)
wrong-pin = (store)->
    store.current.pin = ""
    store.current.pin-trial += 1
    left-trials = total-trials - store.current.pin-trial
    reset-wallet store if left-trials <= 0
check-pin = (store, web3t)->
    return if not exists!
    return wrong-pin store if not check(store.current.pin)
    store.current.pin-trial = 0
    store.current.pin = ""
    store.current.loading = yes
    if store.current.page-pin?
#        <- navigate store, web3t, \:init, no
        navigate store, web3t, store.current.page-pin
        store.current.page-pin = null
    else
        navigate store, web3t, \:init
        notify-form-result \unlock, null
version = (store, web3t)->
    .version.pug #{store.version}
MIN_PASSWORD_LENGTH = 6
validate-password = (store, cb)->
    is-secure-length = (store.current.pin ? "").length >= MIN_PASSWORD_LENGTH
    return cb "Password must contain at least #{MIN_PASSWORD_LENGTH} characters" if not is-secure-length
    is-secure-encoding = /^[0-9a-zA-Z$&+,:;=?@#|'<>.^*()%!-_]{6,}$/.test(store.current.pin)
    return cb "Password must contain only latin characters and/or special characters and digits" if not is-secure-encoding
    cb null
input = (store, web3t)->
    style = get-primary-info store
    button-primary1-style=
        border: "0"
        color: style.app.text
        background: style.app.primary1
        background-color: style.app.primary1-spare
        width: "130px"
        height: "36px"
        margin-top: "10px"
    button-primary0-style=
        border: "0"
        color: style.app.text-primary
        background: "transparent"
        width: "130px"
        height: "36px"
        margin-top: "0px"
    locked-style=
        color: style.app.text
        background: style.app.wallet
        border: "0"
    enter = ->
        if exists!
            check-pin store, web3t
        else
            err <- validate-password store
            return alert(store, err) if err?
            set store.current.pin
            check-pin store, web3t
            store.current.pin = ""
    change = (e)->
        store.current.pin = e.target.value
    lang = get-lang store
    catch-key = ->
        enter! if it.key-code is 13
    reset-account = ->
        res <- confirm store, "#{lang.backup-info}"
        return if res is no
        reset-wallet store
    drag =
        if store.current.pin-trial is 0 then \ "" else \drag
    focus-input = (ref)!->
        ref.focus! if ref?
    .pug
        text-field { ref:(c)->{ a = focus-input(c)}, store, type: 'password' value: store.current.pin, placeholder: lang.pin-placeholder, on-change: change , on-key-down: catch-key, id="locked-password" }
        if exists!
            .pug
                button { store, on-click: enter, type: \primary , text: \enter }
                .pug
                    .division.pug
                        .line.l.pug
                        span.pug #{lang.or}
                        .line.r.pug
                    .pug
                        button.setup.text-primary.pug(style=button-primary0-style on-click=reset-account) #{lang.new-account}
reset-wallet = (store)->
    setbkp!
    del!
    seedmem.setbkp!
    seedmem.del!
    store.current.pin = ""
    store.current.pin-trial = 0
    store.current.page = 'chooseinit'
total-trials = 8
wrong-trials = (store)->
    return null if store.current.pin-trial is 0
    lang = get-lang store
    style = get-primary-info store
    left-trials = total-trials - store.current.pin-trial
    notice=
        background: style.app.wallet
    button-primary0-style=
        border: "0"
        color: style.app.text-primary
        background: "transparent"
        width: "130px"
        height: "36px"
        margin-top: "0px"
    reset-account = ->
        res <- confirm store, "#{lang.backup-info}"
        return if res is no
        reset-wallet store
    wrong-pin-text = "#{left-trials}/#{total-trials} #{lang.notice-reset}."
    .pug.wrong-pin-trial
        .pug.wrong(key="wrong-trial") #{wrong-pin-text}
        .pug.notice(style=notice)
            span.orange.pug #{lang.notice}!
            span.pug #{lang.notice-text}
        .pug
            button.reset.setup.text-primary.pug(style=button-primary0-style on-click=reset-account) #{lang.reset-account}
setup-button = (store, web3t)->
    lang = get-lang store
    style = get-primary-info store
    { open-language } = menu-funcs store, web3t
    setup = ->
        err <- validate-password store
        return alert(store, err) if err?
        set store.current.pin
        check-pin store, web3t
        store.current.pin = ""
    text-color=
        color: style.app.text
    button-style =
        border: "1px solid #{style.app.primary3}"
        color: style.app.text2
        background: style.app.primary3
        background-color: style.app.primary3-spare
    btn-icon =
        filter: style.app.btn-icon
    .pug(key="setup-button")
        button.setup.pug(on-click=setup style=button-style id="locked-continue")
            span.pug
                img.icon-svg.pug(src="#{icons.key}" style=btn-icon)
                | #{lang.setup}
        .hint.p.pug(style=text-color) #{lang.pin-info}
create-wallet = (store, web3t)->
    lang = get-lang store
    style = get-primary-info store
    create = ->
        next!
    text-color=
        color: style.app.text
    button-primary2-style=
        border: "1px solid #{style.app.primary2}"
        color: style.app.text
        background: style.app.primary2
        background-color: style.app.primary2-spare
    .pug(key="create-wallet")
        button.setup.pug(on-click=create style=button-primary2-style)
            span.pug
                img.icon-svg.pug(src="#{icons.create-wallet}")
                | #{lang.create-wallet}
locked = ({ store, web3t })->
    return null if store.current.loading is yes
    lang = get-lang store
    style = get-primary-info store
    title =
        | not exists! => lang.enter-pin
        | _ => lang.enter-pin
    footer =
        | not exists! => setup-button
        | _ => wrong-trials
    info = get-primary-info store
    locked-style=
        color: info.app.text
        background: info.app.glitch

    button-primary2-style=
        border: "1px solid #{style.app.primary2}"
        color: style.app.text
        background: style.app.primary2
        background-color: style.app.primary2-spare
    txt-style=
        color: info.app.text
    logo-style =
        filter: info.app.filterLogo
    download = ->
        navigate store, web3t, \downloadwallet
    .pug.locked(key="locked" style=locked-style)
        .pug.locked-inner
            .pug.logo
                img.pug(src="#{info.branding.logo}")
                .title.pug(style=txt-style) #{info.branding.title}
                version store, web3t
            .pug.title(key="locked-title") #{title}
            .pug.inputs(key="locked-inputs")
                input store, web3t
            export-import-seed store
            footer store, web3t
            if not process?versions?electron?
                .pug.downloadwallet
                    a.pug(href="https://apps.apple.com/us/app/velas-mobile-wallet/id1541032748" target="_blank" rel="noopener noreferrer nofollow")
                        img.icon-download.pug(src="#{icons[\ios]}" )
                    a.pug(href="https://play.google.com/store/apps/details?id=com.velas.mobile_wallet" target="_blank" rel="noopener noreferrer nofollow")
                        img.icon-download.pug(src="#{icons[\android]}" )
                    a.pug(href="https://github.com/velas/mobile-wallet/releases/latest/download/app-release.apk" target="_blank" rel="noopener noreferrer nofollow" id="download-apk")
                        img.icon-download.pug(src="#{icons[\apk]}")
                    span.pug
                        img.icon-download.pug(on-click=download src="#{icons[\desktop]}" )
focus = ({ store }, cb)->
    store.forceReload = yes
    store.forceReloadTxs = yes
    cb null
locked.focus = focus
module.exports = locked