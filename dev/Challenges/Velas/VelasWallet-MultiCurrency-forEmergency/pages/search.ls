require! {
    \react
    \react-dom
    \../navigate.ls
    \../get-primary-info.ls
    \../web3.ls
    \../get-lang.ls
    \../history-funcs.ls
    \./icon.ls
    \./switch-account.ls
    \./epoch.ls
    \../icons.ls
    \../components/burger.ls
}
.search
    @import scheme
    $border-radius: var(--border-btn)
    $smooth: opacity .15s ease-in-out
    position: relative
    display: block
    width: auto
    overflow: hidden
    margin-left: $left-margin
    top: 0
    height: 100%
    min-height: 100vh
    padding-top: 5%
    box-sizing: border-box
    padding: 0px
    background: transparent
    .search-input
        position: fixed
        background: var(--background)
        z-index: 1
        width: 100%
    @media(max-width:$ipad)
        width: 100%
        margin: 0
    .search-field
        .left
            position: relative
        .icon
            position: absolute
            top: 8px
            right: 12px
    >.title
        position: sticky
        position: -webkit-sticky
        background: var(--background)
        box-sizing: border-box
        top: 0
        width: 100%
        color: gray
        font-size: 22px
        padding: 10px
        height: 60px
        z-index: 2
        >.header
            margin: 5px
            text-align: center
            @media(max-width:800px)
                text-align: center
    >.wrapper
        height: calc(115vh - 250px);
        display: block
        overflow-y: scroll
        scrollbar-width: none
        margin-top: 40px
        >.panel-content
            display: flex
            justify-content: center
            @media(max-width: 800px)
                width: 100%
                margin-left: 0
                display: block
            .results
                text-align: left
                font-size: 13px
            .section
                padding: 10px 0
                display: block
                border: 0
                &:last-child
                    margin-bottom: 20vh
                .source
                    &:hover
                        .header
                            text-decoration: underline
                &.developing
                    opacity: .5
                    .source
                        &:hover
                            .header, .address
                                text-decoration: none
                                cursor: not-allowed
                .address, .header, .description
                    width: 100%
                    text-align: left
                    margin: 5px 0
                .address
                    color: #969696
                    font-size: 13px
                    cursor: pointer
                .header
                    font-weight: 500
                    color: #6f6fe2
                    font-size: 22px
                    cursor: pointer
                    white-space: nowrap
                    overflow: hidden
                    text-overflow: ellipsis
                .description
                    opacity: .8
                    line-height: 1.6
                    font-size: 13px
                ul.links
                    list-style: none
                    padding: 0
                    margin-bottom: 0
                    color: #6f6fe2
                    font-size: 13px
                    text-align: left
                    margin-top: 0
                    li
                        display: inline-block
                        margin-left: 4px
                        cursor: pointer
                        span
                            &:hover
                                text-decoration: underline
                        + li
                            &:before
                                content: ' · '
                        &:first-child
                            margin-left: 0
            >.platform
                display: inline-block
                width: 300px
                padding: 20px
                vertical-align: top
                text-overflow: ellipsis
                border: 1px solid white
                overflow: hidden
                margin: 10px 1%
                border-radius: $border
                >.tag_name
                    margin-bottom: 10px
                .title-icons
                    height: 40px
                    margin: 10px 0
                    filter: brightness(4)
                .title-icons-small
                    height: 35px
                    margin: 10px 0
                    filter: brightness(4)
                a
                    padding: 10px
                >.title
                    font-size: 16px
                    font-weight: bold
                    margin-top: 10px
                >.subtitle
                    margin-block: 20px
                    font-size: 14px
                    color: #8286a0
                >.source
                    &.link
                        a
                            text-decoration: underline
                            padding: 0
                >.source, >.download
                    padding: 10px 0 0
                    box-sizing: content-box
                    a
                        text-decoration: none
                        text-transform: uppercase
                        font-size: 10px
                        font-weight: bold
                        cursor: pointer
                        outline: none
                        display: inline-block
                        overflow: hidden
                        white-space: nowrap
                        width: 80px
                        border-radius: $border
                &:hover
                    opacity: .8
                    cursor: pointer
    .iron
        -webkit-mask-image: linear-gradient(75deg, rgba(0, 0, 0, 0.6) 30%, #000 50%, rgba(0, 0, 0, 0.6) 70%)
        -webkit-mask-size: 50% 100%
        animation: shine 2s infinite
    @keyframes shine
        0%
            -webkit-mask-position: right
        100%
            -webkit-mask-position: left
dapps = (store, web3t)->
    lang = get-lang store
    { go-back } = history-funcs store, web3t
    info = get-primary-info store
    resource =
        color: info.app.text
        border: "1px solid #{info.app.border}"
        background: info.app.header
    goto-staking = ->
        navigate store, web3t, \validators
    goto-wallets = ->
        navigate store, web3t, \offlinewallets
    goto-util = ->
        navigate store, web3t, \util
    .pug.panel-content
        .pug.platform(style=resource on-click=goto-staking)
            img.pug.title-icons-small(src="#{icons.staking}")
            .pug.title Velas Staking 1.0
            .pug.subtitle Previous version of staking for experienced users
        .pug.platform(style=resource on-click=goto-wallets)
            img.pug.title-icons-small(src="#{icons.wallet}")
            .pug.title Download Desktop Wallets
            .pug.subtitle  Desktop versions for Mac, Windows, Linux
        .pug.platform(style=resource on-click=goto-util)
            img.pug.title-icons(src="#{icons.convert}")
            .pug.title Legacy address conversion
            .pug.subtitle Convert VLX Legacy address format to EVM format
search = ({ store, web3t })->
    lang = get-lang store
    { go-back } = history-funcs store, web3t
    info = get-primary-info store
    border-style =
        color: info.app.text
        border-bottom: "1px solid #{info.app.border}"
        background: info.app.background
        background-color: info.app.bgspare
    show-class =
        if store.current.open-menu then \hide else \ ""
    .pug.search
        .pug.title(style=border-style)
            .pug.header(class="#{show-class}") #{lang.dapps}
            .pug.close(on-click=go-back)
                img.icon-svg.pug(src="#{icons.arrow-left}")
            burger store, web3t
        .pug.wrapper
            dapps store, web3t
module.exports = search