require! {
    \react
    \../menu-funcs.ls
    \./naming.ls
    \../get-primary-info.ls
    \../get-lang.ls
    \./icon.ls
    \../navigate.ls
    \../../web3t/providers/superagent.js : { get }
    \prelude-ls : { each, map, find }
    \../menu-funcs.ls
    \../icons.ls
    \../navigate.ls
}
.choose-language
    @import scheme
    @keyframes bounceIn
        from
            opacity: 0
            transform: scale3d(0.8, 0.8, 0.8)
        to
            opacity: 1
            transform: scale3d(1, 1, 1)
    position: fixed
    padding-top: 30px
    padding-bottom: 30px
    width: 100%
    top: 0
    left: 0
    z-index: 999
    height: 100%
    min-height: 100vh
    box-sizing: border-box
    background-color: var(--bgspare)
    overflow: auto
    @media(max-width: 430px)
        padding-top: 0px
    .title
        color: #ebf6f8
        font-size: 22px
    .version
        letter-spacing: 1px
        font-size: 8px
        padding: 6px
        color: #89829d
        border-radius: 8px
        line-height: 5px
        margin: 5px auto
    .downloadwalletlist
        padding: 30px 0 30px
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
    >.account-body
        max-width: 600px
        display: inline-block
        overflow: hidden
        width: 100%
        margin-top: 0vh
        border-radius: $border
        position: relative
        box-sizing: border-box
        >.title
            position: absolute
            z-index: 999
            box-sizing: border-box
            top: 0
            width: 100%
            color: gray
            font-size: 22px
            padding: 10px
            height: 60px
            background: black
            >.header
                margin: 5px
        >.settings
            padding-top: 0px
            overflow-y: auto
            .title
                color: $primary
                text-transform: uppercase
                font-size: 14px
                a
                    color: #ee8791
            .box
                input
                    width: 104px
            button
                background-color: $primary
                border: 1px solid $primary
                border-radius: $border
                color: white
                height: 36px
                width: 104px
                padding: 0 6px
                text-decoration: none
                text-transform: uppercase
                font-size: 10px
                font-weight: bold
                cursor: pointer
                outline: none
                display: inline-block
                text-overflow: ellipsis
                overflow: hidden
                white-space: nowrap
                &:hover
                    background: transparent
                    color: $primary
                &.link
                    min-width: 190px
        .bold
            color: #f0c16b
        .section
            .logo
                margin: 3rem 0
                >.title
                    font-size: 12px
                    font-weight: 600
                    letter-spacing: 4px
                    text-align: center
                    color: #ebf6f8
                >img
                    height: 80px
                    margin-bottom: 1rem
                    @media(max-width: 430px)
                        height: 50px
                @media(max-width: 800px)
                    margin: 1rem 0
            .welcome
                color: #ebf6f8
                font-size: 26px
                margin-bottom: 15px
                @media(max-width: 430px)
                    font-size: 20px
                    margin-bottom: 10px
            .langs
                width: 100%
                margin: 50px auto
                max-height: 50vh
                overflow: auto
                @media(max-width: 430px)
                    width: 100%
                    margin: 0
                ul
                    list-style: none
                    display: inline-flex
                    width: 100%
                    margin: 0
                    padding: 0
                    margin-top: 20px
                    @media(max-width: 430px)
                        display: block
                        margin-top: 0
                    &:first-child
                        margin-top: 0px
            .lang-item
                padding: 0px
                font-size: 13px
                color: #b0aeae
                width: calc(100%/4)
                text-align: center
                line-height: 20px
                cursor: pointer
                img
                    width: 20px
                    position: relative
                    &.active
                        opacity: 1
                    @media (max-width: 430px)
                        display: none
                @media (max-width: 430px)
                    width: 100%
                    padding: 7px 0
                    text-align: center
            padding: 0px 10%
            .title
                padding: 2px
            .description
                padding: 7px
                font-size: 16px
                color: #b0aeae
            @media(max-width: 430px)
                padding: 0px 10%
    .iron
        -webkit-mask-image: linear-gradient(75deg, rgba(0, 0, 0, 0.6) 30%, #000 50%, rgba(0, 0, 0, 0.6) 70%)
        -webkit-mask-size: 50% 100%
        animation: shine 2s infinite
    @keyframes shine
        0%
            -webkit-mask-position: right
        100%
            -webkit-mask-position: left
language = (store, web3t)->
    style = get-primary-info store
    lang = get-lang store
    { close-language } = menu-funcs store, web3t
    input-style =
        background: style.app.wallet
        color: style.app.text
    color =
        color: style.app.text
    style-textarea=
        background: style.app.wallet
        color: style.app.text
    logo-style =
        filter: style.app.filterLogo
    button-primary2-style=
        border: "1px solid #{style.app.primary2}"
        color: style.app.text
        background: style.app.primary2
        background-color: style.app.primary2-spare
    button-primary3-style=
        border: "1px solid #{style.app.border}"
        color: style.app.text2
        background: style.app.primary3
        background-color: style.app.primary3-spare
    filter-icon=
        filter: style.app.filterIcon
    text-style =
        color: style.app.text
    country-codes = 
        en: \English
        ru: \Русский
        ua: \Українська
        cn: \中文語言
        kr: \한국어
        fr: \Français
        es: \Español
        ar: \عربى
        in: "हिंदी"
        id: \Indonesian
        ph: \Pilipino
        yr: \Yoruba
        vn: "Tiếng Việt"
    order =
        * <[ fr en cn kr ]>
        * <[ ru ua es ar ]>
        * <[ in id ph yr ]>
        * <[ vn ]>
    set-lang = (lang)->
        store.lang = lang
        store.current.choose-language = no
    change-lang = (code)->
        ->
            store.current.language-menu = no
            return set-lang code    
    download = ->
        navigate store, web3t, \downloadwallet
    .pug
        .pug.section
            .pug.logo
                img.pug(src="#{style.branding.logo}")
                .title.pug(style=text-style) #{style.branding.title}
                span.pug.version.low #{store.version}
            .welcome.pug(style=text-style) #{lang.language}
            .pug.langs
                order
                    |> map (arr)->
                        ul.pug
                            arr
                                |> map (code) ->
                                    lang-style = color
                                    name = country-codes[code]
                                    tag = "langs_#{code}"
                                    li.pug.lang-item(key="lang_#{code}" on-click=change-lang(code) style=color id="lang-#{code}")
                                        img.pug(src="#{icons[tag]}")
                                        .pug #{name}
            if not process?versions?electron?    
                .pug.downloadwalletlist
                    a.pug(href="https://apps.apple.com/us/app/velas-mobile-wallet/id1541032748" target="_blank" rel="noopener noreferrer nofollow" id="download-ios")
                        img.icon-download.pug(src="#{icons[\ios]}")
                    a.pug(href="https://play.google.com/store/apps/details?id=com.velas.mobile_wallet" target="_blank" rel="noopener noreferrer nofollow" id="download-android")
                        img.icon-download.pug(src="#{icons[\android]}")
                    a.pug(href="https://github.com/velas/mobile-wallet/releases/latest/download/app-release.apk" target="_blank" rel="noopener noreferrer nofollow" id="download-apk")
                        img.icon-download.pug(src="#{icons[\apk]}")
                    span.pug(id="download-desktop")
                        img.icon-download.pug(on-click=download src="#{icons[\desktop]}")
module.exports = ({ store, web3t } )->
    return null if store.current.choose-language isnt yes
    { close-language } = menu-funcs store, web3t
    style = get-primary-info store
    account-body-style =
        background: style.app.background
        color: style.app.text
        background-color: style.app.bgspare
    body-style =
        background: "transparent"
        color: style.app.text
    border-style =
        background: style.app.header
        color: style.app.text
    lang = get-lang store
    .pug.choose-language(style=account-body-style)
        .account-body.pug
            if no
                .pug.title(style=border-style)
                    .pug.header #{lang.choose-language}
                    if no
                        .pug.close(on-click=close-language)
                            icon \X, 20
            .pug.settings
                language store, web3t