require! {
    \react
    \../send-funcs.ls
    \prelude-ls : { map, find, keys, filter, pairs-to-obj, obj-to-pairs, uniqueBy }
    \../get-primary-info.ls
    \./icon.ls
    \../get-lang.ls
    \./switch-account.ls
    \../icons.ls
    \../round-human.ls
    \../round-number.ls
    \../wallets-funcs.ls
    \./epoch.ls
    \../components/button.ls
    \../components/address-holder.ls
    \../components/identicon.ls
    \../history-funcs.ls
    \../components/burger.ls
    \../components/amount-field.ls
    \../components/amount-fiat-field.ls
    \../math.ls : { times, div }
    \bignumber.js
    \../install-plugin.ls : { get-install-list }
    \../plugin-loader.ls : { common }
    \lodash/cloneDeep
}
.custom-token-content
    position: relative
    @import scheme
    $border-radius: var(--border-btn)
    $label-padding: 3px
    $label-font: 13px
    width: calc(100% - 0px) !important
    margin-left: 0px !important
    max-width: none !important
    display: flex !important
    flex-direction: column  
    align-items: center
    @media(min-height:900px)
        justify-content: center    
    @media(max-width:800px)
        margin-left: 0 !important
    .icon-svg
        position: relative
        height: 12px
        top: 2px
    .icon-svg-history
        width: auto !important
        height: 20px
    .content-body
        max-width: 450px !important
    .navigation-button
        img
            &.rotate
                transform: rotate(-180deg)
                transition: transform .3s
                display: inline-block
    >.title
        position: fixed
        position: -webkit-fixed
        background: var(--background)
        box-sizing: border-box
        top: 0
        width: 100%
        color: gray
        font-size: 22px
        padding: 10px
        height: 60px
        z-index: 3
        @media(max-width:800px)
            left: 0
        >.header
            margin: 5px
            text-align: center
            @media(max-width:800px)
                text-align: center
    .h1
        font-size: 17px
        text-transform: uppercase
        letter-spacing: 2px
        opacity: .8
    .pending
        color: orange
    >*
        display: inline-block
        text-align: center
        width: 100%
        box-sizing: border-box
        border-radius: $border-radius
    .swap-notification
        p
            font-size: 12px
            opacity: 0.3
    .more-buttons
        top: 30px
        right: 0
        width: 150px
        box-shadow: 0px 0px 2px black
        border-radius: var(--border-btn)
        text-align: left
        padding-bottom: 3px
        >.more
            display: block
            cursor: pointer
            padding: 5px 0
            &:last-child
                border-bottom: 0px
            .more-icon
                width: 50px
                text-align: center
                display: inline-block
                vertical-align: middle
            .more-text
                width: 80px
                display: inline-block
                vertical-align: middle
    >.content-body
        border: 0
        background: "transparent"
        @import scheme
        color: gray
        @media(max-width:800px)
            margin-top: -5px  
        a
            color: #6f6fe2
        .table-row-menu
            border-bottom: 1px solid rgba(238, 238, 238, 0.07)
            &:hover
                background: var(--input)
                .network-item-button
                    background: #080e35    
            .network-item-title
                display: inline-block
                margin-right: 10px
                min-width: 90px
            .networks
                .network-item-button
                    opacity: 0.8
                    padding: 5px 10px
                    display: inline-block
                    margin: 0 5px
                    background: #303372
                    text-transform: uppercase
                    font-size: 12px
                    box-shadow: 0px 1px 2px black
                    &:hover
                        opacity: 1
                    &.testnet-network
                        background: #343434
        >form
            >table
                background: transparent
                border-radius: 0 0 var(--border-btn) var(--border-btn)
                width: 100%
                border-spacing: 0
                tr
                    &.gray
                        color: #CCC
                    &.orange
                        color: #cf952c
                    &.green
                        color: #23b723
                    td
                        padding: 3px 10px
                        font-size: 14px
                        .label-coin
                            left: 3px
                            top: 3px
                            padding: 0 2px 0 2px
                            height: 16px
                            position: relative
                        &:last-child
                            text-align: right
            text-align: left
            margin: auto 10px
            .switch-menu
                .network-item
                    padding: 2px 5px
                    background: #ffffff
                    text-align: center
                    width: auto
                    min-width: auto
                    max-width: initial
                    margin: 0 5px
                    font-weight: 400
                    border: 0.1px solid rgba(255, 255, 255, 0.1)
                    color: #292b55
                    display: inline-block
                    &.testnet
                        background: rgb(31, 31, 31)
            >.form-group
                margin-bottom: 10px
                min-height: 80px
                padding: 0px
                text-overflow: ellipsis
                background: transparent
                border-radius: $border-radius
                input 
                    padding: 0 10px 0 45px 
                    text-align: left
                &.sender
                    .address-holder .inner-address-holder
                        text-align: left
                        padding-left: 45px
                &.receiver input
                    text-align: left !important
                .identicon
                    ~ span
                        background: var(--input)
                .control-label
                    padding-top: 5px
                    font-size: $label-font
                    padding-bottom: 5px
                    display: block
                &.network
                    div
                        position: relative
                    .button
                        width: 12px
                        height: 16px
                        display: inline-block
                        padding: 9px
                        border-radius: var(--border-btn)
                        cursor: pointer
                        vertical-align: top
                        position: absolute
                        &.left
                            left: 0
                        &.right
                            right: 0
                            top: 3px
                        svg
                            vertical-align: inherit !important
                input
                    outline: none
                    width: 100%
                    box-sizing: border-box
                    height: 36px
                    line-height: 36px
                    border-radius: $border-radius
                    padding: 0px 10px
                    font-size: 14px
                    border: 0px
                    box-shadow: none
                .amount-field
                    position: relative
                    >.input-wrapper
                        position: relative
                        width: 65%
                        border-radius: var(--border-btn) 0 0 var(--border-btn)
                        &.choose-currency
                            display: inline-flex
                            width: 45% !important
                        .input-area
                            margin: 0
                        select
                            -webkit-appearance: none
                            -moz-appearance: none
                            padding-right: 30px
                            padding-left: 10px
                            background-position: right 5px top 50%
                            background-repeat: no-repeat
                            display: block
                            width: 30%
                            height: 36px
                            font-size: 14px
                            line-height: 1.5
                            color: #fff
                            background-color: #421f7c
                            background-clip: padding-box
                            border-radius: 0
                            border-color: #6b258e
                            border-left: 0 solid
                            margin-left: -1px
                        &.small
                            width: 35%
                            border-radius: 0 var(--border-btn) var(--border-btn) 0
                        display: inline-block
                        box-sizing: border-box
                        margin: 0
                        >.label
                            position: absolute
                            top: 8px
                            display: inline
                            &.lusd
                                left: 5px
                            &.crypto
                                right: 5px
                                top: 7px
                                height: 22px
                        .label-coin
                            height: 18px
                            top: 3px
                            position: relative
                            padding: 0 0px 0 8px;
                        input
                            width: 100%
                            color: white
                            box-shadow: none
                            outline: none
                            ::placeholder
                                color: #eee
                            &:disabled
                                opacity:.2
                            &.amount
                                border-radius: $border-radius 0 0 $border-radius
                                border-right: 0
                            &.amount-eur
                                background: #f1eeee
                                padding-left: 20px
                                border-radius: 0 $border-radius $border-radius 0
                                border-left: 0
                            &.amount-usd
                                background: #f1eeee
                                border-radius: 0 $border-radius $border-radius 0
                                padding-left: 20px
        .smart-contract
            overflow: hidden
            padding: 2px
            box-sizing: border-box
        >.header
            padding: 10px
            min-height: 40px
            text-align: left
            padding: 0
            margin: 0 10px
            >.head
                box-sizing: border-box
                width: 70%
                line-height: 70px
                font-size: 27px
                font-weight: 600
                vertical-align: middle
                line-height: 29px
                display: inline-block
                color: #677897
                width: 80%
                &.center
                    padding-left: 10px
                    text-align: center
                &.left
                    width: 10%
                    text-align: center
                &.right
                    width: 10%
                    text-align: right
                    cursor: pointer
                    >*
                        vertical-align: middle
            img
                width: 34px
                border-radius: 0px
        .field
            font-size: 12px
            padding-left: 3px
            color: gray
            margin-top: 5px
            &.type
                font-size: 14px
                color: #fff
                text-transform: capitalize
            &.coin
                font-size: 14px
                color: #fff
        .usd
            font-size: 11px
            padding-left: 3px
            color: gray
            margin-top: 5px
            .switch-currency
                float: right
                &.active
                    background: var(--primary3)
                &:last-child
                    margin-right: 2px
            .label-coin
                left: 3px
                top: 3px
                padding: 0 2px 0 2px
                height: 13px
                position: relative
        .balance
            color: #5E72E4
        .send-all
            background: transparent
            outline: none
            border: 0
            border-radius: $border
            font-size: 12px
            line-height: 16px
            text-align: center
            padding: 2px 5px
            cursor: pointer
        .error
            color: #ff5336
            padding-top: 5px
            font-size: 12px
            max-height: 20px
            font-weight: 400f
            overflow: hidden
        .bold
            font-weight: bold
        .button-container
            text-align: center
            .buttons
                text-align: center
                border-radius: $border
                width: 100%
                display: inline-block
                overflow: hidden
                .btn
                    width: auto
                    min-width: 110px
                    padding: 0 6px
                    line-height: 36px
                    height: 36px
                    text-transform: uppercase
                    text-align: center
                    font-weight: bold
                    border: 0
                    margin: 5px 10px
                    font-size: 10px
                    border-radius: $border
                    display: inline-block
                    cursor: pointer
                    box-sizing: border-box
                    &.btn-primary
                        background: #6CA7ED
                        color: white
                    &:hover
                        background: rgba(#6CA7ED, 0.2)
                        opacity: .9
form-group = (classes, title, style, content)->
    .pug.form-group(class="#{classes}")
        label.pug.control-label(style=style) #{title}
        content!
custom-token = ({ store, web3t })->
    return null if store.custom-token.add is no
    load-coins = require("../../web3t/load-coins.js")
    load-coins-keys = load-coins |> keys
    err, $web3t-tokens <- load-coins {plugins:[]}
    console.error err if err?
    err, custom-tokens <- get-install-list
    custom-tokens = custom-tokens |> filter (-> it.token not in load-coins-keys)
    web3t-tokens = 
        $web3t-tokens
            |> obj-to-pairs 
            |> filter (-> it[1]?)
            |> map (-> it[1])
    base-plugins = common
    all-tokens = ((web3t-tokens ? []) ++ (custom-tokens ? [])) ++ base-plugins
    { symbol, symbol-display, icon, contract-address, decimals, edit-symbol, network, switch-network, errors, selected-network } = store.custom-token
    WALLETS_FOR_NETWORKS = <[ vlx_eth vlx_erc20 bsc_vlx vlx_huobi ]>
    wallets = all-tokens
        |> filter (?token in WALLETS_FOR_NETWORKS) 
        |> filter (-> it?[store.current.network]?disabled isnt yes) 
    get-wallet = (token)->
        all-tokens |> find(-> it.token is token)
    if not network? then
        evm-wallet = get-wallet(WALLETS_FOR_NETWORKS[0])
        store.custom-token.network = { evm-wallet?token, ...evm-wallet?[store.current.network] }
    close = ->
        store.current.add-coin = no
        store.custom-token.add = no
        clear-chosen-token-data!
    is-exiting = store.custom-token.add is no || store.current.add-coin is no   
    theme = get-primary-info(store)
    round-money = (val)->
        +val |> (-> it * 100) |> Math.round |> (-> it / 100)
    style = get-primary-info store
    styles = $styles(style)
    menu-style=
        background: style.app.background
        background-color: style.app.bgspare
        border: "1px solid #{style.app.border}"
    input-style=
        background: style.app.input
        border: "1px solid #{style.app.border}"
        color: style.app.text
    border-style=
        border: "1px solid #{style.app.border}"
    amount-style=
        background: style.app.input
        border: "1px solid #{style.app.border}"
        color: style.app.text
    icon-style =
        color: style.app.icon
    use-max-style =
        color: style.app.text2
    button-primary3-style=
        border: "0"
        color: style.app.text2
        background: style.app.primary3
        background-color: style.app.primary3-spare
    button-primary2-style=
        border: "1px solid #{style.app.wallet}"
        color: style.app.text
        background: style.app.primary2
        background-color: style.app.primary2-spare
    crypto-background =
        background: style.app.wallet
        width: "50%"
    just-crypto-background =
        background: style.app.wallet
    content-body-style=
        color: style.app.text
    more-text=
        color: style.app.text
    border-header =
        color: style.app.text
        border-bottom: "1px solid #{style.app.border}"
        background: style.app.background
        background-color: style.app.bgspare
    lang = get-lang store
    open-invoice = ->
    show-class =
        if store.current.open-menu then \hide else \ ""
    token-display = (symbol ? "").to-upper-case!
    token-icon = icon
    get-number = (val)->
        number = (val ? "").toString!
        return \0 if number is ""
        val
    go-back-from-send = ->
        store.custom-token.add = no
    up = (str)->
        (str ? "").to-upper-case!
    network-type = (store.current.network ? "").to-upper-case!
    token = store.customToken.network.token
    group = store.customToken.network.group  
    subtitle = up(store.custom-token.selected-network ? "")
    display-network = group + " " + up(subtitle)
    /* Contract address */    
    contract-address-exists = (address)->
        address = address.trim!
        console.log "check1", custom-tokens
        found = 
            all-tokens
                |> filter (-> it?[store.current.network]?group is group)
                |> find (it)-> 
                    up(it?[store.current.network]?address) is up(address)
        console.log "found" found
        found?
    check-token-unique = (token)->
        token-network = store.customToken.network?group
        selected-network = store.customToken.selected-network
        plugins = all-tokens
        found = plugins |> find(-> (it.token is token) and (up(it[selected-network]?group) is up(token-network))) 
        not found?
    getParentWallet = (token)-> 
        wallet = all-tokens |> find (-> it.token is token)
        wallet 
    save-custom-token = ->
        return set-error "contractAddress", "Please fill all required fields" if not (contract-address isnt "" or symbol isnt "" or symbol-display isnt "" or decimals isnt "")
        store.custom-token.isLoading = yes
        plugins = all-tokens
        prototype-token = store.customToken.network.token
        found-plugin = plugins |> find (-> it.token is prototype-token)
        proto-plugin = cloneDeep(found-plugin) 
        { symbol, decimals, selectedNetwork } = store.customToken
        err <- get-contract-symbol(contract-address)
        return set-error "symbol", "Contract not found for chosen network" if err?
        $token = symbol.trim!.replace(/\s/g, "_").toLowerCase() + "_" + selectedNetwork + "_#{store.customToken.network?group}_" + "_custom"
        /* Check if it is unique token */
        is-unique = check-token-unique($token)
        if not is-unique then
            console.log("token is not unique!")
            $token = $token + ":" + Date.now()       
            #store.custom-token.isLoading = no
            #return set-error "symbol", "This symbol is already taken. Please choose another one."
        mainnet = proto-plugin?mainnet
        delete mainnet?networks
        delete mainnet?FOREIGN_BRIDGE
        delete mainnet?FOREIGN_BRIDGE_TOKEN
        delete mainnet?HOME_BRIDGE
        delete mainnet?HOME_BRIDGE_TOKEN
        mainnet <<<< { decimals, address: contract-address }
        testnet = proto-plugin?testnet
        delete testnet?networks
        delete testnet?FOREIGN_BRIDGE
        delete testnet?FOREIGN_BRIDGE_TOKEN
        delete testnet?HOME_BRIDGE
        delete testnet?HOME_BRIDGE_TOKEN        
        testnet <<<< { decimals, address: contract-address }        
        result-network = 
            | up(store.customToken.selected-network) is "MAINNET" => { mainnet, testnet: null }
            | _ => { mainnet: null, testnet }
        parentWallet = getParentWallet(proto-plugin?[store.current.network]?txFeeIn)
        nickname = if parentWallet then parentWallet.nickname else proto-plugin.nickname
        image = icons.customWalletIcon ? parentWallet?image ? proto-plugin.image
        res = { 
            token: $token, 
            custom: yes, 
            enabled: yes, 
            color: "white", 
            name: symbol-display, 
            image: image, 
            type: "coin", 
            usdInfo: 0,
            nickname: symbol 
        }    
        res <<<< result-network
        err <- web3t.install-quick res
        console.error err if err?
        store.custom-token.isLoading = no
        store.just-added-token = $token
        timer = {}
        clear-task = ->
            store.just-added-token = null
            clear-timeout timer.id
        timer.id = set-timeout clear-task, 1500
        close! if not err?
    decimals-change = (event)->
        value = event.target.value
        value = (+get-number(value)).toString()
        # Restrictions check #
        valid = //^[0-9]+?$//.test(value)
        return if not valid
        if (value > 36)
            store.custom-token.errors.decimals = "Decimals must be at least 0, and not over 36" 
        else
            store.custom-token.errors.decimals = ""      
        #return if not valid
        #return if +value > 36
        store.custom-token.decimals = value
    token-symbol-change = (event)->
        $symbol = (event?target?value ? "").trimLeft!
        if $symbol.match(/[^a-zA-Z0-9\-_\s]+/g)
            return store.custom-token.errors.symbol = "Symbol may contain latin characters, numbers, '_', '-' signs"     
        if ($symbol.length > 30)
            store.custom-token.errors.symbol = "Symbol must be 30 characters or fewer" 
        else
            store.custom-token.errors.symbol = ""        
        store.custom-token.symbol-display = $symbol
        store.custom-token.symbol = $symbol if (store.custom-token.symbol ? "").trim!.length is 0
    contract-address-change = (event)->
        store.custom-token.errors.contract-address = ""
        address = (event?target?value ? "").trim!
        if (address.length > 0 and !/^(0x)?[0-9a-f]{40}$/i.test(address))
            store.custom-token.errors.contract-address = "Invalid address"
            return store.custom-token.contract-address = address 
        #else
            #store.custom-token.errors.contract-address = ""   
        store.custom-token.contract-address = address
        if address.length > 0
            exists = contract-address-exists(address)
            if (exists)
                return store.custom-token.errors.contract-address = "Token has already been added"
        retrieve-info-by-token-address(address)
        err-msg = 
            | typeof! err in <[ Object Error ]> => err?message ? "Error occured while fetching contract data"
            | _ => (err ? "").toString!
        return store.custom-token.errors.contract-address = err-msg if err? 
    get-contract-symbol = (address, cb)->
        { web3Provider } = store.custom-token.network?api
        web3 = new Web3(new Web3.providers.HttpProvider(web3Provider))
        web3.eth.provider-url = web3Provider
        abi = 
            * {"constant":true,"inputs":[],"name":"decimals","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"}
            * {"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"}
        contract = web3.eth.contract(abi).at(address)   
        error, symbol <- contract.symbol!
        cb null, symbol 
    retrieve-info-by-token-address = (address)->
        return null if (address ? "").length is 0
        clear-errors! 
        store.custom-token.isLoading = yes   
        { web3Provider } = store.custom-token.network?api
        return cb "web3Provider is not found!" if not web3Provider?
        web3 = new Web3(new Web3.providers.HttpProvider(web3Provider))
        web3.eth.provider-url = web3Provider
        abi = 
            * {"constant":true,"inputs":[],"name":"decimals","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"}
            * {"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"}
        contract = web3.eth.contract(abi).at(address)
        error, symbol <- contract.symbol!
        if error?
            set-default-chosen-token-data! 
            store.custom-token.isLoading = no       
            return set-error "symbol", error
        store.custom-token.symbol = symbol
        store.custom-token.symbol-display = symbol
        err, decimals-hex <- contract.decimals!
        if err?
            store.custom-token.isLoading = no
            return set-error "symbol", err
        decimals-hex = "0" if err?
        decimals = new bignumber(decimals-hex + '').to-fixed!
        store.custom-token.decimals = decimals         
        store.custom-token.isLoading = no
    set-error = (initiator, error)->
        return if not store.custom-token.errors[initiator]?
        return if not error?
        err-msg = 
            | (error?message ? error.toString!).indexOf("not a base 16 number") > -1 => "Failed to get symbol for current contract"
            | typeof! error in <[ Object Error ]> => error?message ? "Contract not found for chosen network"
            | _ => (error ? "").toString!
        store.custom-token.errors[initiator] = err-msg                        
    run-async-task = (name, task)->
        console.log "run #{name} task"
        tt = set-timeout task, 1
        if is-exiting then
            stop-async-task(name, tt)        
    stop-async-task = (name, task-id)->
        clear-timeout(task-id)    
    cancel = ->
        store.custom-token.add = no
        clear-chosen-token-data!
    has-contract-error = (store.custom-token.errors.contract-address ? "").trim!.length > 0
    has-symbol-error   = (store.custom-token.errors.symbol ? "").trim!.length > 0
    has-decimals-error = (store.custom-token.errors.decimals ? "").trim!.length > 0
    has-network-error   = (store.custom-token.errors.network ? "").trim!.length > 0
    disabled = 
        | store.custom-token.decimals is 0 or store.custom-token.symbol.trim!.length is 0 or store.custom-token.contract-address.trim!.length is 0 => yes
        | has-contract-error || has-symbol-error || has-decimals-error => yes
        | _ => no  
    /* Network dropdown */
    network-dropdown-click = ->
        store.custom-token.switch-network = !store.custom-token.switch-network
    rotate-class =
        | store.custom-token.switch-network is yes => \rotate 
        | _ => ""    
    /*
    * available-networks  <Array>[] Network> - Array of networks.
    * Network: { api, group }
    */    
    available-networks = 
        wallets
            |> filter (-> it?[store.current.network]?disabled isnt yes) 
            |> uniqueBy (-> it?[store.current.network]?api?web3Provider)
            |> map (-> { token: it?token, api: it?[store.current.network]?api, group: it?[store.current.network]?group })
    change-network = (token, network) ->
        return ->
            return if not token? or not network?
            store.custom-token.selected-network = network
            found-wallet = get-wallet(token)
            if not found-wallet?[network]?
                return store.custom-token.errors.network = "No configuration found for chosen #{network} network"
            store.custom-token.network = { token, ...found-wallet?[network] }
            clear-chosen-token-data!
            clear-default-errors!
    set-default-chosen-token-data = ->
        store.custom-token.decimals = 0
        store.custom-token.symbol = ""
        store.custom-token.symbol-display = ""
    clear-chosen-token-data = ->
        store.custom-token.decimals = 0
        store.custom-token.symbol = ""
        store.custom-token.symbol-display = ""
        store.custom-token.contract-address = ""
    clear-errors = ->
        store.custom-token.errors.contract-address = ""
        store.custom-token.errors.symbol = ""
        store.custom-token.errors.decimals = ""
        store.custom-token.errors.network = ""
    clear-default-errors = ->
        store.custom-token.errors.contract-address = ""
        store.custom-token.errors.decimals = ""
        store.custom-token.errors.network = ""
    create-network-position = (data)-->
        { api, group, token } = data
        { apiUrl, url, web3Provider, provider } = api
        name = group
        position-style =
            color: if up(store.custom-token.network?api?provider) is up(provider) then '#3cd5af' else ''
            padding: "10px"
        get-button-style = (network-type)->
            #return {} if network-type not in <[ testnet mainnet ]>
            | up(store.custom-token.network?api?provider) is up(provider) and up(selected-network) is up(network-type) => { color: '#3cd5af' }
            | _ => { color: "white" }  
        button-style-mainnet = get-button-style("mainnet")
        button-style-testnet = get-button-style("testnet")
        change-mainnet-network = change-network(token, "mainnet")
        change-testnet-network = change-network(token, "testnet")
        /* Render */
        .pug.table-row-menu(key="network-#{provider}" style=position-style)
            .col.folder-menu.pug(style=styles.folder-menu)
                .pug.network-item-title(style=styles.folder-menu-div) #{name}
                span.pug.networks
                    span.pug.network-item-button.mainnet-network(on-click=change-mainnet-network style=button-style-mainnet) Mainnet
                    span.pug.network-item-button.testnet-network(on-click=change-testnet-network style=button-style-testnet) Testnet
    /* Render */
    .pug.custom-token-content
        .pug.content-body(style=content-body-style)
            form.pug
                form-group \sender, "Network", icon-style, ->
                    .pug
                        .pug.bold.default-network-input(style=styles.input-network on-click=network-dropdown-click)
                            .pug.change-network-screen #{display-network}
                            .pug.button.navigation-button.right(style=styles.navigation-button)
                                img.icon-svg.pug(src="#{icons.arrow-down}" style=styles.img-icon-style class="#{rotate-class}")
                            if store.custom-token.switch-network
                                .pug.switch-menu(style=styles.filter-body)
                                    .pug.middle
                                        available-networks  
                                            |> map create-network-position
                        if has-network-error
                            .pug.control-label.error.text-left #{store.custom-token.errors.network}
                form-group \sender, "Token Contract Address", icon-style, ->
                    .address.pug
                        input.pug(type='text' style=input-style on-change=contract-address-change value="#{contract-address}" id="contract-address" )
                        if has-contract-error
                            .pug.control-label.error.text-left #{store.custom-token.errors.contract-address}
                form-group \receiver, "Token symbol", icon-style, ->
                    .pug
                        input.pug(type='text' disabled=has-symbol-error style=input-style on-change=token-symbol-change value="#{symbol-display}"  id="symbol" )
                        if has-symbol-error
                            .pug.control-label.error.text-left #{store.custom-token.errors.symbol}
                form-group \send-amount, "Token Decimals", icon-style, ->
                    .pug
                        .input-wrapper.pug
                            input.pug(type='number' disabled=has-symbol-error style=input-style placeholder="0" on-change=decimals-change value="#{decimals}"  id="decimals" )
                            if has-decimals-error
                                .pug.control-label.error.text-left #{store.custom-token.errors.decimals}
            .pug.button-container
                .pug.buttons
                    button { store, text: "Add token" , on-click: save-custom-token , type: \primary, no-icon:yes, makeDisabled: disabled, id: "send-confirm" }
                    button { store, text: \cancel , on-click: cancel, icon: \close2, id: "send-cancel" }
module.exports = custom-token
$styles = (style)->
    {
        input-network:
            cursor: "pointer" 
            min-height: "36px"
            position: "relative"
            display: "flex"
            align-items: "center"
            border-bottom: "0.1px solid rgb(238, 238, 238, 0.12)"
        img-icon-style = 
            width: "13px"
            height: "8px"
            margin-left: "0"
            margin-top: "4px"
            filter: "grayscale(100%) brightness(40%) sepia(100%) hue-rotate(14deg) saturate(790%) contrast(1.5)"
        filter-body:
            border: "1px solid #{style.app.border}"
            background: style.app.account-bg
            right: "-1px"
            top: "38px"
            width: "100%"
            display: "inline-grid"
            z-index: 3
            box-shadow: "0px 13px 20px 0px rgba(0, 0, 0, 0.35)"
            border-radius: "0 0 var(--border-btn) var(--border-btn)"
            position: "absolute"
        folder-menu:
            width: "100%"
        folder-menu-div:
            text-overflow: "ellipsis"
            white-space: "nowrap"
            overflow: "hidden"
            font-size: "12px"
            text-transform: "uppercase"
            letter-spacing: "2px"
            opacity: ".7"
            display: "inline-block"
            margin-right: "10px"
            margin-bottom: "-5px"
        navigation-button:
            position: "absolute"
            right: 0
            top: "5px"
    }