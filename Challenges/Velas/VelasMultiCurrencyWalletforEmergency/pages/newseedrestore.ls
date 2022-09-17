require! {
    \react
    \../newseed-funcs.ls
    \../get-lang.ls
    \../get-primary-info.ls
    \./icon.ls
    \../icons.ls
    \prelude-ls : { map, each, sort-by }
    \../pin.ls : { set, check, exists, del, setbkp }
    \../seed.ls : seedmem
}
.newseed-restore
    @import scheme
    padding-top: 30px
    width: 100%
    height: $height
    box-sizing: border-box
    height: 100%
    >.logo
        margin: 3rem 0
        >img
            height: 80px
            margin-bottom: 1rem
        >.title
            font-size: 12px
            font-weight: 600
            letter-spacing: 4px
            text-align: center
    .welcome
        color: #ebf6f8
        font-size: 26px
        margin-bottom: 15px
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
    .align-v
        display: inline-grid
        position: relative
        .select
            outline: none
            width: auto
            min-width: 100px
            margin: 15px 5px 0
            text-transform: uppercase
            font-weight: bold
            padding: 0px 6px
            height: 36px
            line-height: 36px
            border: 0
            cursor: pointer
            border-radius: $border
            font-size: 10px
            img
                width: 15px
                height: 15px
                position: absolute
                right: 15px
                top: 27px
            span
                line-height: 20px
                text-align: center
            .arrow
                right: 20px
                top: 25px
                opacity: .8
                position: absolute
        .langs-menu
            width: auto
            background: #45217e
            position: relative
            top: 0px
            right: 0
            margin: -1px 5px 0
            display: inline-grid
            z-index: 1
            padding: 10px 10px
            justify-content: center
            border-radius: 0 0 $border $border
            z-index: 11
            .langs-item
                display: inline-flex
                cursor: pointer
                line-height: 20px
                margin-bottom: 10px
                &:last-child
                    margin-bottom: 0
                img
                    width: 17px
                    height: 17px
                    border-radius: 20px
                span
                    margin-left: 10px
                    font-size: 13px
                    text-transform: capitalize
                    line-height: 17px
        button
            outline: none
            width: auto
            margin: 15px 5px 0
            text-transform: uppercase
            font-weight: bold
            padding: 0px 6px
            border: 0
            height: 36px
            width: 120px
            cursor: pointer
            background: #248295
            border-radius: $border
            font-size: 10px
            color: white
            text-overflow: ellipsis
            overflow: hidden
            white-space: nowrap
            &:hover
                background: #248295 - 20
    .warning
        padding: 15px
        border: 1px solid orange
        margin: 10px
        border-radius: $border
        background: rgba(orange, 0.2)
    .hint
        color: #f2eeee
        padding: 20px 0
        max-width: 270px
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
newseed = ({ store, web3t })->
    lang = get-lang store
    style = get-primary-info store
    { generate-seed, next } = newseed-funcs store, web3t
    text-style =
        color: style.app.text
    btn-icon =
        filter: style.app.primary-button-filter
    address-input=
        color: style.app.text
        background: style.app.wallet
    button-primary1-style=
        border: "0"
        color: style.app.text-invert
        background: style.app.primary1
        background-color: style.app.primary1-spare
    button-primary2-style=
        border: "1px solid #{style.app.primary2}"
        color: style.app.text
        background: style.app.primary2
        background-color: style.app.primary2-spare
    button-primary3-style=
        border: "0"
        color: style.app.text2
        background: style.app.primary3
        background-color: style.app.primary3-spare
    logo-style =
        filter: style.app.filterLogo
    expand-collapse = ->
        store.current.langs-open-start = not store.current.langs-open-start
    langs-menu-body =
        border: "1px solid #{style.app.border}"
        background: style.app.header
    text-style=
        color: style.app.text
    comming-soon =
        opacity: ".3"
        cursor: "no-drop"
        border: "1px solid #{style.app.primary3}"
        color: style.app.text2
        background: style.app.primary3
        background-color: style.app.primary3-spare
    new-wallet = ->
        generate-seed!
        next!
    reset-wallet = (store)->
        setbkp!
        del!
        seedmem.setbkp!
        seedmem.del!
        store.current.pin = ""
        store.current.pin-trial = 0
    random = -> Math.random!
    restore-wallet = (count)-> ->
        reset-wallet store
        store.current.seed-words =
            [1 to count] |> map -> { part: "", index: 0 }
        store.current.seed-generated = no
        sorted =
            store.current.seed-words |> sort-by random
        map-index = ->
            it.index = sorted.index-of(it)
        store.current.seed-words |> each map-index
        next!
    restore12 = restore-wallet 12
    restore24 = restore-wallet 24
    restorecustom = restore-wallet 1
    back = ->
        store.current.page = 'chooseinit'
    .newseed-restore.pug
        .pug.logo
            img.pug(src="#{style.branding.logo}")
            .title.pug(style=text-style) #{style.branding.title}
            span.pug.version.low #{store.version}
        .welcome.pug(style=text-style) #{lang.restore-from}
        .pug.align-v
            button.pug.left(style=button-primary1-style on-click=restore12 id="restore-12")
                span.pug
                    img.icon-svg.pug(src="#{icons.restore}" style=btn-icon)
                    | 12 #{lang.restore-words12}
            button.pug.right(style=button-primary1-style on-click=restore24 id="restore-24")
                span.pug
                    img.icon-svg.pug(src="#{icons.restore}" style=btn-icon)
                    | 24 #{lang.restore-words24}
            button.pug.right(style=button-primary1-style on-click=restorecustom id="restore-custom")
                span.pug
                    img.icon-svg.pug(src="#{icons.restore}" style=btn-icon)
                    | Custom
            button.pug.right(on-click=back style=button-primary3-style id="restore-back")
                img.icon-svg.pug(src="#{icons.arrow-left}" style=btn-icon)
                | #{lang.back}
focus = ({ store }, cb)->
    <- set-timeout _, 1000
    # textarea null here
    # textarea = store.root.query-selector '.newseed textarea'
    # textarea.focus!
    cb null
newseed.focus = focus
module.exports = newseed