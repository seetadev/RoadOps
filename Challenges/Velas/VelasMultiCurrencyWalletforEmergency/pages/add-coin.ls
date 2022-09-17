require! {
    \react
    \prelude-ls : { map, filter, group-by, keys, obj-to-pairs, sortWith }
    \./loading2.ls
    \../web3.ls
    \../get-primary-info.ls
    \../get-lang.ls
    \./icon.ls
    \../icons.ls
    \../../web3t/providers/superagent.js : { get }
    \../components/button.ls
    \./custom-token.ls : \CustomToken
    \../components/popups/loader.ls    
}
.manage-account
    @import scheme
    @keyframes bounceIn
        from
            opacity: 0
            transform: scale3d(0.8, 0.8, 0.8)
        to
            opacity: 1
            transform: scale3d(1, 1, 1)
    position: fixed 
    width: 100%
    top: 0
    bottom: 0  
    left: 0
    right: 0  
    z-index: 999
    padding-top: 5%
    box-sizing: border-box
    padding: 10px
    background: rgba(black, 0.08)
    backdrop-filter: blur(5px)
    display: flex
    align-items: center
    >.account-body
        max-width: 600px
        display: inline-block
        animation-duration: 0.5s
        animation-name: bounceIn
        background: white
        width: 100%
        margin: auto
        border-radius: var(--border-btn)
        position: relative
        max-height: 600px    
        overflow: hidden
        box-shadow: 17px 10px 13px #0000001f, -6px 10px 13px #00000024
        padding-bottom: 20px
        @media (max-width: 580px)
            margin-top: 0
            margin-bottom: 0
            height: auto    
        .content-manage
            display: flex
            flex-direction: row  
        .add-custom-token
            float: right  
        >.title
            box-sizing: border-box
            font-size: 22px
            padding: 10px
            margin-top: 20px
            margin: 15px
            > div
                margin-bottom: 20px  
            .closed
                position: absolute
                padding: 10px 20px
                font-size: 20px
                right: 0
                top: 0
                cursor: pointer
                &:hover
                    color: #CCC
        .add-custom-token
            @media (max-width: 580px)
                width: 100% 
            button    
                margin-right: 0      
        .search-content
            position: relative
            width: calc(50% - 5px)
            float: left
            text-align: left
            @media (max-width: 580px)
                width: 100%    
                padding: 0
            .search
                margin-top: 7px
                border: 1px solid #CCC
                padding: 9px
                border-radius: var(--border-btn)
                width: 100%
                padding-left: 35px
                box-sizing: border-box
                font-size: 13px
                outline: none
            .icon
                top: 4px
                left: 11px
                position: absolute
                @media (max-width: 580px)
                    left: 10px
        >.settings
            display: inline-block    
            height: 480px   
            overflow-y: scroll
            margin-top: 0
            width: 100%
            border-top: 1px solid rgba(255, 255, 255,  0.05)
            .section
                position: relative
                min-height: 200px
                background: rgba(84, 102, 96,  0.03)
                .legacy-tokens.title
                    margin-top: 20px
                    opacity: 0.2
                .list
                    display: flex;
                    flex-wrap: wrap;
                    height: 80%
                    padding: 10px
                    margin: auto 10px
                    @media (max-width: 580px)
                        padding: 10px 0
                    .wallet-group
                        width: 100%   
                        text-align: left
                        margin-bottom: 10px
                        .network-wallets
                            display: flex
                            flex-wrap: wrap 
                        .group-name
                            text-align: left
                            padding: 5px 12px 5px 10px
                            color: #7f818a
                            text-transform: uppercase
                            font-size: 12px
                            top: -1px !important   
                        .outer-item 
                            width: 50%  
                            text-align: center 
                            @media (max-width: 580px)
                                width: 100%    
                        .item
                            width: calc(100% - 10px)
                            margin-bottom: 10px    
                            display: inline-block
                            background: #642dbd
                            border-radius: var(--border-btn)
                            padding: 10px
                            text-align: left
                            box-sizing: border-box
                            @media (max-width: 580px)
                                width: 100%
                                float: none
                            &:nth-child(odd)
                                @media (max-width: 580px)
                                    margin-right: 0
                            >*
                                display: inline-block
                                vertical-align: middle
                                height: 40px
                                box-sizing: border-box
                            input
                                margin: 0 5px
                                border-radius: var(--border-btn)
                                width: calc(100% - 90px)
                                border: 0
                                padding: 5px 10px
                                outline: none
                                font-size: 15px
                            img
                                width: 40px
                                border-radius: 0px
                            .title
                                margin-left: 10px
                                color: gray
                                width: calc(100% - 90px)
                                height: auto
                            button
                                width: 40px
                                height: 40px
                                line-height: 45px
                                border-radius: var(--border-btn)
                                border: 0 !important
                                box-sizing: border-box
                                padding: 0
                                margin: 0
                                cursor: pointer
                                color: black
                                background: transparent
                                outline: none
                                &:hover
                                    color: white
                                    opacity: .6
                                    transition: .5s
                                >*
                                    vertical-align: middle
                &.legacy-tokens
                    margin-top: 10px
create-item = ({ store, web3t }, item)-->
    add = ->
        store.current.add-coin = no
        err <- web3t.install-quick item
        console.error "[add] err" err if err?   
    title = "#{item.name}"
    style = get-primary-info store
    button-style =
        border: "1px solid #{style.app.text}"
        color: style.app.text
    background =
        background: style.app.input
    menu-style=
        color: style.app.text
    .pug.outer-item
        .item.pug(style=background, id="add-token-#{item.token}")
            img.pug(src="#{item.image}")
            span.pug.title(style=menu-style) #{title}
            button.pug(on-click=add style=button-style)
                icon \Plus, 20
filter-item = (store)-> (item)->
    return yes if (store.current.filter-plugins ? "").length is 0
    (item.token ? "").index-of(store.current.filter-plugins) > -1
add-by-address = (store, web3t)->
    coin-contract = (e)->
        store.contract-address = e.target.value
    not-found = ->
        store.contract-address = "Not Found"
        <- set-timeout _, 1000
        store.contract-address = ""
    add = ->
        err, data <- get "https://registry.web3.space/token/#{store.contract-address}" .end
        return not-found! if err? or not data.body?token?
        <- web3t.install-quick data.body
        store.current.add-coin = no
    style = get-primary-info store
    button-style =
        border: "1px solid #{style.app.text}"
        color: style.app.text
    input-style=
        color: style.app.text
        background: style.app.bg-primary-light
        border: "0"
    erc-bg=
        background: style.app.bg-primary-light
    background =
        background: style.app.input
    .item.pug(style=background)
        img.pug(src="#{icons.erc20-token}" style=erc-bg)
        input.search.pug(placeholder="0x...." value="#{store.contract-address}" on-change=coin-contract style=input-style)
        button.pug(on-click=add style=button-style)
            icon \Plus, 20
add-by-vlxaddress = (store, web3t)->
    coin-contract = (e)->
        store.contract-vlxaddress = e.target.value
    not-found = ->
        store.contract-vlxaddress = "Not Found"
        <- set-timeout _, 1000
        store.contract-vlxaddress = ""
    add = ->
        err, data <- get "https://registry.web3.space/token/#{store.contract-vlxaddress}" .end
        return not-found! if err? or not data.body?token?
        <- web3t.install-quick data.body
        store.current.add-vlxcoin = no
    style = get-primary-info store
    button-style =
        border: "1px solid #{style.app.text}"
        color: style.app.text
    input-style=
        color: style.app.text
        background: style.app.bg-primary-light
        border: "0"
    erc-bg=
        background: style.app.bg-primary-light
    background =
        background: style.app.input
    .item.pug(style=background)
        img.pug(src="#{icons.vlx-icon}" style=erc-bg)
        input.search.pug(placeholder="V...." value="#{store.contract-vlxaddress}" on-change=coin-contract style=input-style)
        button.pug(on-click=add style=button-style)
            icon \Plus, 20
module.exports = ({ store, web3t } )->
    return null if store.current.add-coin isnt yes
    current-network = store.current.network   
    close = ->
        store.current.add-coin = no
        store.custom-token.add = no 
    filter-registery = (event)->
        store.current.filter-plugins = event.target.value
    style = get-primary-info store
    account-body-style =
        background: style.app.background
        background-color: style.app.bgspare
        color: style.app.text
        transition: "height .5s"
    account-body-style-custom =
        background: style.app.background
        background-color: style.app.bgspare
        color: style.app.text
        transition: "height .5s"
        height: "550px"
        max-height: "550px"    
    color =
        color: style.app.text
    lang = get-lang store
    input-style=
        color: style.app.text
        background: style.app.input
        border: "0"
        width: "calc(100%) - 100"    
    plugins = store.registry
    groups =    
        plugins
            |> filter (it)->
                it[current-network]?
            |> filter (it)->
                (it[current-network]?disabled is no) or (not it[current-network]?disabled?)
            |> filter filter-item store
            |> group-by (-> it[current-network].group)
    velas-group = 
        | groups.Velas? => { groups.Velas } 
        | _ => null   
    delete groups.Velas    
    create-group = ({ store, web3t }, item)--> 
        group-name =
            | item?0? => item.0
            | _ => ''
        wallets = item.1
        .wallet-group.pug(id="wallet-group-add-#{group-name}")
            .pug.group-name #{group-name} Network
            .pug.network-wallets
                .pug         
                    wallets |> map create-item { store, web3t }  
    add-custom-token = ->
        store.custom-token.add = yes
        store.custom-token.network = null  
        store.custom-token.contract-address = ""
        store.custom-token.symbol = ""
        store.custom-token.decimals = 0 
        store.custom-token.errors.contract-address = ""
        store.custom-token.errors.symbol = ""
        store.custom-token.errors.decimals = ""
        store.custom-token.errors.network = ""  
    button-style =
        border: "1px solid #{style.app.text}"
        color: style.app.text 
    title-style = 
        font-weight: "bold"
        opacity: ".9"    
    go-back-from-custom-token = ->
        store.custom-token.add = no   
    .pug.manage-account
        if not store.custom-token.add    
            .account-body.pug(style=account-body-style)
                .pug.title(style=color)
                    .pug
                        .pug(style=title-style) #{lang.your-wallets}
                        .pug.closed(on-click=close)
                            icon \X, 20
                    .pug.search-content
                        .pug.jhjj    
                            input.search.pug(placeholder="#{lang.search}" on-change=filter-registery style=input-style)
                            .pug.icon
                                icon \Search, 15
                    .pug.add-custom-token
                        button { store, on-click=add-custom-token, text: "Add custom token" , icon: \plus , type: \secondary, id: "add-custom-token", makeDisabled=no }                 
                .pug.settings
                    if store.registry.length > 0
                        .pug.section
                            .list.pug
                                if velas-group? 
                                    velas-group
                                        |> obj-to-pairs
                                        |> map create-group { store, web3t }
                                groups
                                    |> obj-to-pairs
                                    |> map create-group { store, web3t }
        else
            .account-body.pug(style=account-body-style-custom)
                loader { loading: store.custom-token.isLoading }
                .pug.title(style=color)
                    .pug
                        .pug(style=title-style) Add custom token   
                        .pug.closed(on-click=close)
                            icon \X, 20
                CustomToken { store, web3t }  