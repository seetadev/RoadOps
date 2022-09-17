require! {
    \react
    \../../get-primary-info.ls
    \../../round5.ls
    \../../round.ls
    \prelude-ls : { find, filter, obj-to-pairs, pairs-to-obj, map }
    \../../math.ls : { times }
    \../../icon.ls
    \../../icons.ls
    \../../swaping/networks.ls : "token-networks" 
    \../../send-funcs.ls
    \../../pages/confirmation.ls : { network-details-modal }  
}
.network-slider
    .switch-menu
        position: absolute !important
        right: -1px
        top: 45px
        width: 100%
        display: inline-grid
        z-index: 3
        box-shadow: 0px 13px 20px 0px rgba(0, 0, 0, 0.15)
        border-radius: 0 0 var(--border-btn) var(--border-btn)
        .folder-menu
            width: 100%
            div
                text-overflow: ellipsis
                white-space: nowrap
                overflow: hidden
                font-size: 12px
                text-transform: uppercase
                letter-spacing: 2px
        .col
            font-size: 12px
            padding: 10px
            margin: 0
            display: inline-block
            vertical-align: top
            box-sizing: border-box
            overflow-y: hidden
            &.folder-menu
                text-align: left
                display: inline-flex
                span
                    margin-right: 10px
        .table-row-menu
            text-align: left
            &.disabled
                opacity: 0.4
                cursor: not-allowed
            &:hover
                cursor: pointer
                background: var(--bg-primary-light)
            &.active
                background: var(--bg-primary-light)
        .middle
            padding: 11px 10px
            height: 37px
            &.account
                padding: 10px
                min-height: 155px
                overflow: scroll
                background: linear-gradient(var(--color1) 30%, rgba(50,18,96, 0)), linear-gradient(rgba(50,18,96, 0), var(--color1) 70%) 0 100%, radial-gradient(farthest-side at 50% 0, var(--color2), rgba(0,0,0,0)), radial-gradient(farthest-side at 50% 100%, var(--color2), rgba(0,0,0,0)) 0 100%
                background-repeat: no-repeat
                background-attachment: local, local, scroll, scroll
                background-size: 100% 30px, 100% 30px, 100% 15px, 100% 15px
                animation: breathe 3s ease-in infinite
                -moz-transition: breathe 3s ease-in infinite
                -web-kit-transition: breathe 3s ease-in infinite
            @keyframes breathe
                0%
                    background-size: 100% 30px, 100% 30px, 100% 15px, 100% 15px
                15%
                    background-size: 100% 30px, 100% 30px, 100% 17px, 100% 17px
                30%
                    background-size: 100% 30px, 100% 30px, 100% 20px, 100% 20px
                45%
                    background-size: 100% 30px, 100% 30px, 100% 23px, 100% 23px
                60%
                    background-size: 100% 30px, 100% 30px, 100% 23px, 100% 23px
                75%
                    background-size: 100% 30px, 100% 30px, 100% 20px, 100% 20px
                90%
                    background-size: 100% 30px, 100% 30px, 100% 17px, 100% 17px
                100%
                    background-size: 100% 30px, 100% 30px, 100% 15px, 100% 15px
            @-webkit-keyframes breathe
                0%
                    background-size: 100% 30px, 100% 30px, 100% 15px, 100% 15px
                15%
                    background-size: 100% 30px, 100% 30px, 100% 17px, 100% 17px
                30%
                    background-size: 100% 30px, 100% 30px, 100% 20px, 100% 20px
                45%
                    background-size: 100% 30px, 100% 30px, 100% 23px, 100% 23px
                60%
                    background-size: 100% 30px, 100% 30px, 100% 23px, 100% 23px
                75%
                    background-size: 100% 30px, 100% 30px, 100% 20px, 100% 20px
                90%
                    background-size: 100% 30px, 100% 30px, 100% 17px, 100% 17px
                100%
                    background-size: 100% 30px, 100% 30px, 100% 15px, 100% 15px
    @keyframes animate-arrow-1  
        0%
            transform: translateX(-40px)
            opacity: 0
        70%
            transform: translateX(0px)
            opacity: 1
    @keyframes animate-arrow-2  
        0%
            transform: translateX(-20px)
            opacity: 0
        70%,100%
            transform: translateX(0px)
            opacity: 0.5
    @keyframes animate-arrow-3  
        0%
            transform: translateX(-10px)
            opacity: 0
        70%,100%
            transform: translateX(0px)
            opacity: 0.3
    @-webkit-keyframes blink
        0%     
            opacity: 0
        25% 
            opacity: 1    
        50%   
            opacity: 0
        100%
            transform: translate(15px, 0px) 
            opacity: 1
    @keyframes blink
        0%     
            opacity: 0
        25% 
            opacity: 1    
        50%   
            opacity: 0
        100%
            transform: translate(15px, 0px) 
            opacity: 1
    .chosen-network
        font-size: 13px
        font-weight: 500
        letter-spacing: -0.4px
        position: absolute
        text-transform: uppercase
        top: 30px
        z-index: 2
        @media(max-width: 600px)
            font-size: 10px    
        &.network-from
            left: 10px
        &.network-to
            right: 0  
            color: #ce942c 
            left: 0
            text-align: center
    .default-network-input
        position: relative
    .arrow-right
        font-size: 15px
        font-weight: bold
        position: absolute
        top: 28px
        z-index: 2
        width: 30px
        left: -40px
        right: 0
        margin: auto 
        color: #61d6b0
        animation: blink 2000ms linear infinite 
        text-shadow: -2px 2px #5a6dda 
        @media(max-width: 600px)
            display: none
        &:nth-child(1)
            animation-delay: 1s 
        &:nth-child(2)
            animation-delay: 1.1s   
        &:nth-child(3)
            animation-delay: 1.2s
        &:nth-child(4)
            animation-delay: 1.3s
        &:nth-child(5)
            animation-delay: 1.4s
    .navigation-button
        transition: opacity 0.2
        z-index: 2
        &:hover
            opacity: 0.9
        &.inactive
            opacity: 0.6
            cursor: not-allowed !important
        .button-inner
            position: relative
            img
                top: 0 !important
                &.rotate
                    transform: rotate(180deg)
                    transition: transform .5s
                    display: inline-block
module.exports = ({ web3t, wallet, store, id, on-change })->
    return null if not wallet.network.networks?
    #return null if not store.current.send.chosenNetwork?
    return null if not (store.current.send.isSwap? and store.current.send.isSwap is yes)
    return null if not wallet.network.networks? or Object.keys(wallet.network.networks).length is 0
    { getHomeFee } = send-funcs store, web3t
    is-not-bridge = ->
        { token } = store.current.send.wallet.coin  
        { chosen-network } = store.current.send
        chosen-network.refer-to in <[ vlx_evm vlx2 vlx_native ]> and token in <[ vlx_evm vlx2 vlx_native ]> 
    wallets = store.current.account.wallets |> map (-> [it.coin.token, it]) |> pairs-to-obj 
    available-networks = 
        wallet.network.networks 
            |> obj-to-pairs
            |> filter (-> it.disabled isnt yes)
            |> filter (it)-> 
                wallets[it[1].referTo]? and ((not it[1].disabled?) or it[1].disabled is no)
            |> pairs-to-obj
    network-labels = Object.keys(available-networks)
    return null if network-labels.length is 0
    getNetworkById = (id)->
        available-networks["#{id}"]
    style = get-primary-info store
    style2 = 
        color: "#{style.app.icon}"
    filter-body =
        border: "1px solid #{style.app.border}"
        background: style.app.account-bg
    input-style2 =
        background: style.app.input
        color: "rgb(206 148 44)"
        border: "0"
        opacity: 1
        text-transform: "uppercase"
    choose-network-style = 
        | is-not-bridge! => {}
        | _ =>
            text-decoration: "underline"
            cursor: "help"       
    img-icon-style = 
        width: "13px"
        height: "8px"
        margin-left: "-6px"
        margin-top: "4px"
        filter: "grayscale(100%) brightness(40%) sepia(100%) hue-rotate(14deg) saturate(790%) contrast(1.5)"
    info-style =
        width: "10px"
        height: "10px"
        font-size: "10px"
        margin-left: "10px"
        margin-top: "-1px"
        float: "revert"
        display: "block"
    tooltip-style =
        position: "absolute"
        right: "0"
        bottom: "-21px"        
    limits-label-style =
        font-size: "11px"
        color: "rgb(206, 148, 44)" 
        display: "block"
        position: "relative"
        left: "-24px"
        text-transform: "uppercase"
        text-decoration: "underline"
        cursor: "help"   
    pointer-style =    
        | network-labels.length > 1 =>
            cursor: "pointer" 
            min-height: "36px"
        | _ => 
            cursor: "default"
            min-height: "36px"
    input-style2 <<<< pointer-style        
    display-value = store.current.send.chosen-network.name.to-upper-case!
    go = (inc)-> ->
        current = network-labels.index-of(store.current.send.chosen-network.id)
        lenght = network-labels.length
        return if lenght <= 1
        index = current + inc 
        if (current + inc) >= lenght then 
            index = 0 
        else if (current + inc) < 0 then
            index = lenght - 1
        chosen-network-id = network-labels[index]
        store.current.send.chosenNetwork = getNetworkById(chosen-network-id)
        store.current.send.to = token-networks.get-default-recipient-address(store)
        store.current.send.error = ''
        store.current.send.data = null
        err <- on-change!
    dropdown-click = ->
        return if network-labels.length <= 1
        store.current.switch-network = !store.current.switch-network
    { name, referTo } = store.current.send.chosen-network
    wallet2 = store.current.account.wallets |> find (-> (it?coin?token ? "").to-lower-case! is (referTo ? "").to-lower-case!)
    network-from = (wallet?coin?name ? "") 
    network-to   = (name ? "")  
    network-to-details = ->
        return if is-not-bridge!
        store.current.current-network-details = store.current.foreign-network-details <<<< { wallet: wallet2 }
        network-details-modal!
    network-from-details = ->
        return if is-not-bridge!
        store.current.current-network-details = store.current.network-details <<<< { wallet }
        network-details-modal!
    create-network-position = (it)->
        details = it?1
        return if not details?
        { referTo, name } = details
        net-wallet = store.current.account.wallets |> find (-> it.coin.token is referTo)
        return if not net-wallet?
        change-network = ->
            return if store.current.refreshing is yes
            if store.current.send.chosenNetwork.refer-to is referTo
                store.current.switch-network = no
                return
            store.current.send.chosenNetwork = getNetworkById(referTo)
            store.current.send.to = token-networks.get-default-recipient-address(store)
            store.current.send.error = ''
            store.current.send.data = null
            err <- on-change!
            store.current.refreshing = no
            store.current.switch-network = no
        position-style =
            color: if store.current.send.chosenNetwork.refer-to is referTo then '#3cd5af' else ''
        .pug.table-row-menu(on-click=change-network key="account#{referTo}" style=position-style class="")
            .col.folder-menu.pug
                .pug #{name}
    dropdown-class = 
        | network-labels.length > 1 => ""
        | _ => "inactive"           
    rotate-class =
        | store.current.switch-network is yes => \rotate 
        | _ => ""
    /* Render */
    .pug.network-slider 
        label.pug.control-label(style=style2) Choose Network
        if no
            span.pug.chosen-network.network-from(on-click=network-from-details style=choose-network-style)
                | #{network-from} 
        if no
            span.pug.chosen-network.network-to(style=choose-network-style)
                | #{network-to}
        .pug
            span.pug.bold.default-network-input(style=pointer-style on-click=dropdown-click)
                input.pug.change-network(value="#{network-to}" style=input-style2 disabled=true)
            span.pug.button.navigation-button.right(on-click=dropdown-click class="#{dropdown-class}")
                .pug.button-inner
                    img.icon-svg.pug(src="#{icons.arrow-down}" style=img-icon-style class="#{rotate-class}")
            if store.current.switch-network and network-labels.length > 1
                .pug.switch-menu(style=filter-body)
                    .pug.middle.account
                        available-networks  
                            |> obj-to-pairs 
                            |> map create-network-position
        if not is-not-bridge!
            .pug.limits-tooltip(style=tooltip-style on-click=network-from-details)
                span.pug 
                    img.icon-svg.pug(src="#{icons.info}" style=info-style)
                    span.pug(style=limits-label-style) limits  