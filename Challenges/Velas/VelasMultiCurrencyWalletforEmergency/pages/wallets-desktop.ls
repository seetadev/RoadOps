require! {
    \react
    \./wallet-expanded.ls
    \./wallet.ls
    \./wallet-group.ls
    \prelude-ls : { map, take, drop, filter, find, group-by, sort-by, obj-to-pairs, keys }
    \./menu.ls
    \../web3.ls
    \../wallets-funcs.ls
    \./manage-account.ls
    \./token-migration.ls
    \./add-coin.ls : add-coin-page
    \../get-lang.ls
    \../get-primary-info.ls
    \./history.ls
    \./your-account.ls
    \./icon.ls
    \localStorage
    \../icons.ls
    \../components/header.ls
}
.wallets-container
    @import scheme
    >.tooltipContent
        z-index: 100;
        width: 19vw;
        position: absolute;
        padding: 15px;
        font-size: 12px
        font-weight: 100
        color: #fff
        margin-left: 25px
        margin-top: -16px
        background: #1f1f1f
        box-shadow: 1px 1px 12px rgba(0, 0, 0, 0.34)
        text-align: left
        pointer-events: none
        opacity: 0;
        display: none;
        @media screen and (max-width: 1400px)
            width: 16vw;
        @media screen and (max-width: 1000px)
            width: 19vw;
        .inner-tooltip
            position: relative
            .triangle
                width: 0
                height: 0
                border-top: 5px solid transparent
                border-right: 8px solid #1f1f1f
                border-bottom: 5px solid transparent
                position: absolute
                left: -22.5px
                top: 0%

            @media (max-width: 735px)
                display: none
    >.left-side
        margin-left: $menu
        @media(max-width: $ipad)
            margin-left: 0
    .show-detail
        background: var(--waves)
        background-size: cover
        background-repeat: no-repeat
        background-position: top right
        padding: 20px
        box-sizing: border-box
    .wallets
        @import scheme
        $real-height: 300px
        $cards-height: 296px
        $pad: 20px
        $radius: 15px
        height: auto
        box-sizing: border-box
        position: relative
        left: 0
        bottom: 0
        $cards-pad: 15px
        right: 0
        z-index: 2
        .icon-svg1
            position: relative
            height: 16px
            top: 2px
        .icon-svg2
            position: relative
            height: 10px
        &.hide-detail
            .wallet-middle
                display: none !important
            .big
                height: 60px
            .big.active
                .icon
                    transition: all .5s
                    filter: none !important
                button
                    transition: all .5s
                    background: #9c41eb !important
                    border-color: #9c41eb !important
            .top-right
                width: 20% !important
                button
                    &.btn-open
                        display: block
                        float: right !important
                    display: none
            .top-left
                width: 100% !important
            .top-middle
                width: 32% !important
                text-align: center !important
                .price
                    display: none
            .title-balance
                display: none
        .header
            &:after
                position: absolute
                font-weight: bold
                font-size: 40px
                opacity: .05
                top: 20px
                left: -5px
        .switch-account
            float: right
            line-height: 2
            right: 20px
            position: relative
            display: inline-flex
            .ckeck
                color: #3cd5af
            .cancel
                color: #c25b5f
            .name
                text-overflow: ellipsis
                white-space: nowrap
                overflow: hidden
                width: 90px
                text-align: right
                cursor: default
            input
                outline: none
                width: 100px
                margin-top: -6px
                height: 36px
                line-height: 36px
                border-radius: 0px
                padding: 0px 10px
                font-size: 12px
                opacity: 1
            span
                cursor: pointer
            .icon
                vertical-align: middle
                margin-left: 20px
                transition: transform .5s
                &.rotate
                    transform: rotate(180deg)
                    transition: transform .5s
        .h1
            font-size: 12px
            text-transform: uppercase
            letter-spacing: 2px
            opacity: .8
        .your-account
            position: absolute
            width: auto
            display: inline-block
            right: 0
            top: 0
            padding: 12px 20px
            border-left: 0
            .buttons
                >.button
                    width: 20px
                    padding: 0
                    outline: none
        >*
            width: 100%
        >.arrow
            position: absolute
            text-align: center
            cursor: pointer
            &.arrow-t
                top: 0
                margin-top: 10px
            &.arrow-d
                bottom: 0
                margin-bottom: 10px
                transform: rotate(180deg)
            &:not(.true)
                >.arrow-d
                    visibility: hidden
            >.arrow-container
                display: inline-block
                width: 100%
                max-width: 450px
                position: relative
        >.wallet-container
            overflow: hidden
            overflow-y: auto
            height: calc(100vh - 60px)
            width: 100%
            display: inline-block
            .wallet
                background: var(--bg-secondary)
                &.big
                    background: var(--bg-primary-light)
                    .icon-svg-create
                        opacity: 1
        .history-area
            max-height: 54vh
            overflow: auto
        .info
            text-align: left
            margin-left: 0px
            text-overflow: ellipsis
            overflow: hidden
            width: 65px
            @media screen and (max-width: 390px)
                display: none
            .name
                padding-left: 3px
                font-size: 16px
            .price
                padding-left: 3px
                font-size: 12px
                font-weight: bold
                overflow: hidden
                text-overflow: ellipsis
        .table
            width: 100%
            height: calc(100vh - 260px)
            margin-top: -1px
mobile = ({ store, web3t })->
    return null if not store.current.account?
    { wallets, go-up, can-up, go-down, can-down } = wallets-funcs store, web3t
    style = get-primary-info store
    lang = get-lang store
    row =
        display: "flex"
        height: "calc( 100vh - 61px )"
        overflow: "hidden"
    left-side =
        min-width: "200px"
        width: "30%"
        background: "#{style.app.left-side}"
    right-side =
        width: "70%"
        border-left: "1px solid #{style.app.border}"
    header-style =
        border-top: "1px solid #{style.app.border}"
        padding: "17px 0px 20px"
        color: style.app.text
        text-align: "left"
    icon-style=
        filter: style.app.icon-filter
    input=
        background: style.app.wallet
        border: "1px solid #{style.app.border}"
        color: style.app.text
    header-left =
        margin-left: "10px"
    border-right=
        border-right: "1px solid #{style.app.border}"
    tooltipVisibility = if (store.showTooltip) then
        top: "#{store.tooltipCoordinates.y}px"
        left: "#{store.tooltipCoordinates.x}px"
        opacity: 1
        display: "block"
    else
        opacity: 0
        display: "none"
    open-account = ->
        store.current.switch-account = not store.current.switch-account
    edit-account-name = ->
        store.current.edit-account-name = current-account-name!
    default-account-name = -> "Account #{store.current.account-index}"
    edit-account = (e)->
        #console.log e
        store.current.edit-account-name = e.target.value
    done-edit = ->
        local-storage.set-item default-account-name!, store.current.edit-account-name
        cancel-edit-account-name!
    cancel-edit-account-name = ->
        store.current.edit-account-name = ""
    current-account-name = ->
        local-storage.get-item(default-account-name!) ? default-account-name!
    account-name = current-account-name!
    rotate-class =
        if store.current.switch-account then \rotate else \ ""
    view-account-template = ->
        .pug.switch-account.h1
            span.name.pug(on-click=open-account) #{account-name}
            span.pug.icon(on-click=edit-account-name)
                img.icon-svg1.pug(src="#{icons.create}" style=icon-style)
            span.pug.icon(on-click=open-account class="#{rotate-class}")
                img.icon-svg2.pug(src="#{icons.arrow-down}" style=icon-style)
    edit-account-template = ->
        .pug.switch-account.h1
            input.h1.pug(value="#{store.current.edit-account-name}" on-change=edit-account style=input)
            span.ckeck.pug.icon(on-click=done-edit)
                icon "Check", 20
            span.cancel.pug.icon(on-click=cancel-edit-account-name)
                icon "X", 20
    chosen-account-template =
        if store.current.edit-account-name is "" then view-account-template! else edit-account-template!
    wallets-groups =
        ^^wallets
            |> filter (?)
            |> filter ({coin, network}) -> ((coin.name + coin.token).to-lower-case!.index-of store.current.search.to-lower-case!) != -1 and (network.disabled isnt yes)
            |> group-by (.network.group)
    groups = wallets-groups |> keys
    group-index = store.current.group-index
    groups-wallets =
        wallets-groups
            |> obj-to-pairs
            |> map (.1)
    group-wallets = groups-wallets[group-index]
    #return null if not group-wallets?
    group-wallets = [] if not group-wallets?
    wallet-detail = group-wallets |> find (-> group-wallets.index-of(it) is store.current.wallet-index)
    #return null if not wallet-detail?
    .wallets-container.pug(key="wallets")
        .pug.tooltipContent(style=tooltipVisibility)
            .inner-tooltip.pug
                .pug #{store.tooltipMessage}
                .triangle.pug
        header store, web3t
        .pug.left-side(style=row)
            .pug(style=left-side)
                if no
                    menu { store, web3t }
                if no
                    manage-account { store, web3t }
                    token-migration { store, web3t }
                add-coin-page { store, web3t }
                .wallets.hide-detail.pug(key="wallets-body")
                    if no
                        .header.pug(style=header-style)
                            span.pug.head.left.h1.hidden(style=header-left) #{lang.your-wallets}
                            chosen-account-template
                            your-account store, web3t
                    .wallet-container.pug(key="wallets-viewport")
                        wallets
                            |> filter (?)
                            |> filter ({coin, network}) -> ((coin.name + coin.token).to-lower-case!.index-of store.current.search.to-lower-case!) != -1 and (network.disabled isnt yes)
                            |> group-by (.network.group)
                            |> obj-to-pairs
                            |> map wallet-group store, web3t, wallets, groups
            .pug.show-detail(style=right-side)
                wallet-expanded store, web3t, wallets, wallet-detail
                .history-area.pug(key="#{store.current.wallet-index}")
                    history { store, web3t }
module.exports = mobile