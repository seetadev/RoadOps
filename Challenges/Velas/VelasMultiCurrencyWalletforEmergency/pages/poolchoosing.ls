require! {
    \react
    \react-dom
    \../navigate.ls
    \../get-primary-info.ls
    \../web3.ls
    \bignumber.js
    \../get-lang.ls
    \../history-funcs.ls
    \../staking/funcs.ls : { query-pools }
    \./icon.ls
    \prelude-ls : { map, split, filter, find, foldl, sort-by, unique, head, each }
    \../math.ls : { div, times, plus, minus }
    \../velas/velas-node-template.ls
    \../../web3t/providers/deps.js : { hdkey, bip39 }
    \md5
    \../menu-funcs.ls
    \btoa
    \safe-buffer : { Buffer }
    \../copied-inform.ls
    \../copy.ls
    \../round5.ls
    \../../web3t/addresses.js : { ethToVlx, vlxToEth }
    \./switch-account.ls
    \../round-human.ls
    \./exit-stake.ls
    \../icons.ls
    \./placeholder.ls
    \./claim-stake.ls
    \../staking/can-make-staking.ls
    \./epoch.ls
    \./confirmation.ls : { alert, notify, confirm }
    \../components/button.ls
    \../components/address-holder-popup.ls
    \../components/pagination.ls
    \./alert-txn.ls
    \../components/amount-field.ls
    \./move-stake.ls
    \../seed.ls : seedmem
    \../components/burger.ls
    \./stake/accounts.ls : \stake-accounts
    \./stake/error-funcs.ls : { get-error-message }
}
.staking
    @import scheme
    position: relative
    display: block
    width: auto
    margin-left: $left-margin
    top: 0
    height: auto
    min-height: 100vh
    padding-top: 5%
    box-sizing: border-box
    padding: 0px
    background: transparent
    .stake-item
        background: #628881
        color: white
        font-weight: bold
        text-align: center
        margin-bottom: 5px
        cursor: pointer
        &:last-child
            margin-bottom: 0
    .loader
        svg
            width: 12px
            cursor: pointer
        &.spin > svg
            @keyframes spin
                from
                    transform: rotate(0deg)
                to
                    transform: rotate(360deg)
            animation-name: spin
            animation-duration: 4000ms
            animation-iteration-count: infinite
            animation-timing-function: linear
        &.disabled
            opacity: 0.3
    .icon-right
        height: 12px
        top: 2px
        position: relative
    .pad
        padding: 0 5px
    .pad-bottom
        padding-bottom: 5px
    @media(max-width:$ipad)
        width: 100%
        margin: 0
    .float-left
        float: left
    .float-right
        float: right
    span.color
        color: #cc8b1a
        font-weight: bold
    .staking-content
        background: transparent
        width: 100%
        border-radius: 0px
        position: relative
        box-sizing: border-box
        .claim-table
            max-height: 100px
            width: 300px
            overflow-y: auto
            background: rgb(90, 26, 154)
            @media(max-width:800px)
                margin: 15px auto
            tbody
                background: rgb(45, 15, 85)
            table
                width: 100%
                tr
                    padding: 0
                    margin: 0
                    td
                        width: 33%
                        &:first-child
                            text-align: center
        .left-proxy, .right-proxy
            width: 15px
            height: 16px
            line-height: 10px
            display: inline-block
            color: white
            padding: 9px
            border-radius: 0px
            cursor: pointer
            vertical-align: top
            text-align: center
        .form-group
            text-align: center
            padding-top: 0px
            input, textarea
                margin: 5px 0
                outline: none
            .section
                border-bottom: 1px solid rgba(240, 237, 237, 0.16)
                padding: 30px 20px
                display: flex
                .chosen-pool
                    .buttons
                        text-align: left
                        @media(max-width:800px)
                            text-align: center
                    span
                        @media (max-width: 800px)
                            font-size: 14px
                    .check
                        width: 15px
                        height: 15px
                        margin-left: 10px
                        vertical-align: middle
                        animation: pulse_check 1s linear
                        transform-origin: 50% 50%
                    @keyframes pulse_check
                        0%
                            transform: scale(0)
                        25%
                            transform: scale(0.5)
                        50%
                            transform: scale(1.6)
                        100%
                            transform: scale(1)
                @media (max-width: 800px)
                    display: flow-root
                    padding: 20px
                &:last-child
                    border: 0
                    @media (max-width: 800px)
                        padding-bottom: $ios-m-b
                &.reward
                    background-image: $reward
                    background-repeat: no-repeat
                    background-position: 80%
                    background-size: auto
                    background-color: rgba(111, 50, 162, 0.15)
                    @media(max-width: 800px)
                        background-position: 5%
                    @media(max-width: 540px)
                        background-image: none
                .title
                    padding: 0px
                    width: 17%
                    min-width: 150px
                    text-align: left
                    text-transform: uppercase
                    font-size: 14px
                    @media (max-width: 800px)
                        width: 100%
                        margin-bottom: 20px
                        text-align: center
                    .less
                        font-size: 10px
                        opacity: 0.9
                .description
                    padding: 0px
                    font-size: 14px
                    width: 80%
                    text-align: left
                    hr
                        margin: 15px auto
                        border: 1px solid rgba(240, 237, 237, 0.16)
                        border-top: 0
                    .chosen-pool
                        margin-bottom: 10px
                        .color
                            color: orange
                            font-weight: 600
                    &.min-height
                        max-height: 300px
                        overflow: scroll
                        table
                            td,td
                                padding: 0 3px
                        .choose-pool
                            max-width: 50px
                    .table-scroll
                        overflow-x: scroll
                        background: linear-gradient(var(--color1) 30%, rgba(50,18,96, 0)), linear-gradient(rgba(50,18,96, 0), var(--color1) 70%) 0 100%, radial-gradient(farthest-side at 50% 0, var(--color2), rgba(0,0,0,0)), radial-gradient(farthest-side at 50% 100%, var(--color2), rgba(0,0,0,0)) 0 100%
                        background-repeat: no-repeat
                        background-attachment: local, local, scroll, scroll
                        background-size: 100% 30px, 100% 30px, 100% 15px, 100% 15px
                        animation: breathe 3s ease-in infinite
                        -moz-transition: breathe 3s ease-in infinite
                        -web-kit-transition: breathe 3s ease-in infinite
                        height: auto
                        max-height: 70vh
                        background: rgba(255, 255, 255, 0.04)
                        .stake-pointer
                            background: rgb(37, 87, 127)
                        &.lockup
                            height: auto
                        .address-holder
                            a
                                padding-left: 30px !important
                            .browse
                                right: 30px !important
                        thead
                            th
                                @media(min-width:800px) and (max-width: 900px)
                                    font-size: 11px !important
                        td
                            &:nth-child(2)
                                cursor: pointer
                            &.with-stake
                                filter: saturate(6.5)
                        tr
                            &.chosen
                                background: #305673
                            &.active
                                color: var(--color-td)
                            &.inactive
                                color: orange
                            &.banned
                                color: red
                            .circle
                                border-radius: 0px
                                width: 20px
                                height: 20px
                                display: inline-block
                                color: white
                                line-height: 1.6
                                border-radius: 4px
                                background: gray
                                &.active
                                    background: rgb(38, 219, 85)
                                &.inactive
                                    background: orange
                                &.banned
                                    background: red
                        button
                            width: 100%
                            height: 36px
                            margin: 0
                    table
                        width: 100%
                        border-collapse: collapse
                        margin: 0px auto
                    th
                        font-weight: 400
                        &:first-child
                            text-align: center
                            width: 5%
                    td
                        &:nth-child(1), &:nth-child(6)
                            text-align: center
                        img.copy
                            height: 16px
                            margin-right: 5px
                    td, th
                        padding: 8px
                        max-width: 200px
                        border: 1px solid rgba(240, 237, 237, 0.16)
                        white-space: nowrap
                        font-size: 13px
                        @media(max-width:800px)
                            text-align: left
                    .left
                        position: relative
                        .small-btns
                            line-height: 36px
                            button.small
                                outline: none
                                border-radius: $border
                                line-height: 10px
                                text-align: center
                                height: 16px
                                font-size: 10px
                                font-weight: 600
                                margin-top: 0
                                width: auto
                                margin-right: 10px
                                padding: 2px 5px
                                cursor: pointer
                    @media (max-width: 800px)
                        width: 100%
                        text-align: center
                    .important
                        color: orange
                    .left-node
                        width: 40%
                        float: left
                        @media (max-width: 800px)
                            width: 100%
                            text-align: center
                            margin-bottom: 20px
                        @media (min-width: 801px) and (max-width: 992px)
                            width: 50%
                        img
                            width: 240px
                    .right-node
                        width: 60%
                        float: right
                        @media (max-width: 800px)
                            width: 100%
                            text-align: center
                        @media (min-width: 801px) and (max-width: 992px)
                            width: 50%
                            text-align: left
                    &.node
                        width: 80%
                    .tabs
                        display: inline-block
                        margin: 20px 0 20px
                        width: 100%
                        .tab
                            width: 25%
                            display: inline-block
                            opacity: 0.5;
                            text-align: center
                            border-bottom: 1px solid
                            line-height: 37px
                            text-transform: uppercase
                            font-size: 10px
                            font-weight: bold
                            cursor: pointer
                            height: 36px
                            background: #2c0d5f
                            border-color: #6b258e
                            @media (max-width: 800px)
                                width: 50%
                            &.active
                                opacity: 1
                                border-bottom: 1px solid #6e1d96
                                background: #37156d
                    .btn
                        margin: 10px 0
                        @media (max-width: 800px)
                            margin: 10px auto 0
                    .step-content
                        .btn
                            margin: 10px auto 0
                    .code
                        overflow: scroll
                        background: #1b1b1b
                        text-align: left
                        .copy
                            float: right
                            margin-top: 11px
                            margin-right: 10px
                            width: 15px
                        .cursor
                            -webkit-animation: blink 0.9s infinite
                            animation: blink 0.9s infinite
                            font: initial
                            display: inline-block
                            opacity: 1
                            margin-left: 5px
                        @-webkit-keyframes blink
                            0%
                                opacity: 1
                            50%
                                opacity: 0
                            100%
                                opacity: 1
                        @keyframes blink
                            0%
                                opacity: 1
                            50%
                                opacity: 0
                            100%
                                opacity: 1
                        &.comming
                            background: transparent
                            text-align: center
                    .window
                        position: sticky
                        top: 0
                        left: 0
                        height: 39px
                        background: #040404
                        .icons
                            padding: 0.75em
                            position: absolute
                            span
                                background: #040404
                            &:before
                                content: ""
                                background: #040404
                            &:after
                                content: ""
                                background: #040404
                            span, &:before, &:after
                                display: inline-block
                                float: left
                                width: 1em
                                height: 1em
                                border-radius: 50%
                                margin-right: 0.5em
                    .balance
                        font-size: 14px
                        .color
                            color: orange
                            font-weight: 600
                        .label-coin
                            left: 3px
                            top: 2px
                            padding-right: 2px
                            height: 15px
                            position: relative
                            color: orange
                            font-weight: 600
                    textarea
                        border: 0
                        padding: 10px
                        font-size: 13px
                        width: 100%
                        box-sizing: border-box
                        min-height: 120px
                        font-family: monospace
                .content
                    width: 30%
                    position: relative
                    button, .switch-index
                        margin: 0
                        position: absolute
                        top: 50%
                        left: 40%
                        -ms-transform: translateY(-50%)
                        transform: translateY(-50%)
            .center
                text-align: center
            .left
                text-align: left
            label
                font-size: 13px
            h3
                font-size: 12px
                text-transform: uppercase
                letter-spacing: 2px
                opacity: .8
                font-weight: 400
                margin: 0
            input[type="radio"]
                height: auto
                width: auto
                margin: 0 40%
                cursor: pointer
            input[type="checkbox"]
                height: auto
                width: auto
                margin: 0 40%
                cursor: pointer
            input
                outline: none
                width: 100%
                box-sizing: border-box
                height: 36px
                line-height: 36px
                border-radius: 0
                padding: 0px 10px
                font-size: 14px
                margin: 5px 0
                border: 0px
                box-shadow: none
                &.change-index
                    margin: 0 !important
                    border-radius: 0px
                    height: 36px
                    width: 55px
                    line-height: 36px
                    text-align: center
                    font-size: 13px
    ul
        padding: 0
        margin: 0
        min-width: 100%
        max-width: 300px
        li
            list-style: none
            margin-left: 0
            font-size: 13px
            color: #6f6fe2
            font-size: 16px
            list-style-position: inside
            white-space: nowrap
            overflow: hidden
            text-overflow: ellipsis
            @media (max-width: 800px)
                text-align: center
    .yesno
        &.Yes
            background: rgba(60, 213, 175, 0.2)
            color: #3cd5af
        &.No
            background: rgba(236, 146, 146, 0.2)
            color: #d85757
    .noyes
        &.Yes
            background: rgba(236, 146, 146, 0.2)
            color: #d85757
        &.No
            background: rgba(60, 213, 175, 0.2)
            color: #3cd5af
    button
        background-color: $primary
        border: 1px solid $primary
        border-radius: $border
        color: white
        height: 36px
        width: 125px
        padding: 0 6px
        margin-top: 10px
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
        &.mt-0
            margin-top: 0
        &:hover
            background: transparent
            color: $primary
        &.link
            min-width: 190px
    >.title
        position: sticky
        position: -webkit-sticky
        z-index: 1
        background: var(--background)
        box-sizing: border-box
        top: 0
        width: 100%
        color: gray
        font-size: 22px
        padding: 10px
        height: 60px
        >.header
            margin: 5px
            text-align: center
            @media(max-width:800px)
                text-align: center
        &:checked + label:before
            background-color: #3cd5af
            border-color: #3cd5af
            color: #fff
cb = console.log
as-callback = (p, cb)->
    p.catch (err) -> cb err
    p.then (data)->
        cb null, data
export paginate = (array, per-page, page)->
    page = page - 1
    array.slice page * per-page, (page + 1) * per-page
to-keystore = (store, with-keystore)->
    mnemonic = seedmem.mnemonic
    seed = bip39.mnemonic-to-seed(mnemonic)
    wallet = hdkey.from-master-seed(seed)
    index = store.current.account-index
    password = md5 wallet.derive-path("m1").derive-child(index).get-wallet!.get-address!.to-string(\hex)
    staking =
        | store.url-params.anotheracc? => { address: window.toEthAddress(store.url-params.anotheracc) }
        | _ => get-pair wallet, \m0 , index, password, no
    mining  = get-pair wallet, \m0/2 , index, password, with-keystore
    { staking, mining, password }
show-validator = (store, web3t)-> (validator)->
    li.pug(key="show-validator-#{validator}") #{validator}
staking-content = (store, web3t)->
    { go-back } = history-funcs store, web3t
    style = get-primary-info store
    lang = get-lang store
    button-primary3-style=
        border: "1px solid #{style.app.primary3}"
        color: style.app.text2
        background: style.app.primary3
        background-color: style.app.primary3-spare
    filter-icon=
        filter: style.app.filterIcon
    comming-soon =
        opacity: ".3"
    pairs = store.staking.keystore
    i-stake-choosen-pool = ->
        pool = store.staking.chosenPool
        myStake = +pool.myStake
        myStake >= 10000
    delegate = ->
        wallet =
            store.current.account.wallets
                |> find -> it.coin.token is \vlx_native
        return null if not wallet?
        #err, options <- get-options
        #return alert store, err, cb if err?
        #err <- can-make-staking store, web3t
        #return alert store, err, cb if err?
        return alert store, "please choose the pool", cb if not store.staking.chosen-pool?
        account = store.staking.chosen-account
        pool = store.staking.chosen-pool
        #
        pay-account = store.staking.accounts |> find (-> it.address is account.address)
        return cb null if not pay-account
        err, result <- as-callback web3t.velas.NativeStaking.delegate(pay-account.address, pool.address)
        err-message = get-error-message(err, result)
        return alert store, err-message if err-message?
        store.staking.getAccountsFromCashe = no
        <- notify store, "Funds delegated to\n #{store.staking.chosenPool.address}"
        if store.staking.webSocketAvailable is no
            store.staking.getAccountsFromCashe = no
            return navigate store, web3t, \validators
        store.current.page = \validators
    change-address = ->
        store.staking.add.add-validator = it.target.value
    change-stake = !->
        try
            value = new bignumber(it.target.value).toFixed!.to-string!
            store.staking.add.add-validator-stake = value
        catch err
            console.log "[Change-stake]: #{err}"
    velas-node-applied-template =
        pairs
            |> velas-node-template
            |> split "\n"
    velas-node-applied-template-line =
        pairs
            |> velas-node-template
            |> btoa
            |> -> "echo '#{it}' | base64 --decode | sh"
    return null if not pairs.mining?
    show-script = ->
        store.staking.keystore = to-keystore store, yes
    {  account-left, account-right, change-account-index } = menu-funcs store, web3t
    update-current = (func)-> (data)->
        func data
        <- staking.init { store, web3t }
        store.staking.keystore = to-keystore store, no
    account-left-proxy   = update-current account-left
    account-right-proxy  = update-current account-right
    change-account-index-proxy = update-current change-account-index
    line-style =
        padding: "10px"
        width: \100%
    activate = (tab)-> ->
        store.staking.tab = tab
    activate-line = activate \line
    activate-string = activate \string
    activate-ssh = activate \ssh
    activate-do = activate \do
    active-class = (tab)->
        if store.staking.tab is tab then 'active' else ''
    active-line = active-class \line
    active-string = active-class \string
    active-ssh = active-class \ssh
    active-do = active-class \do
    get-balance = ->
        wallet =
            store.current.account.wallets
                |> find -> it.coin.token is \vlx2
        wallet.balance
    get-options = (cb)->
        i-am-staker = i-stake-choosen-pool!
        return cb null if i-am-staker
        err, data <- web3t.velas.Staking.candidateMinStake
        return cb err if err?
        min =
            | +store.staking.stake-amount-total >= 10000 => 1
            | _ => data `div` (10^18)
        balance = get-balance! `minus` 0.1
        stake = store.staking.add.add-validator-stake
        return cb lang.amountLessStaking if 10000 > +stake
        return cb lang.balanceLessStaking if +balance < +stake
        max = +balance
        cb null, { min, max }
    use-min = ->
        #err, options <- get-options
        #return alert store, err, cb if err?
        store.staking.add.add-validator-stake = 10000
    use-max = ->
        #err, options <- get-options
        #return alert store, err, cb if err?
        store.staking.add.add-validator-stake = Math.max (get-balance! `minus` 0.1), 0
    vote-for-change = ->
        err, can <- web3t.velas.ValidatorSet.emitInitiateChangeCallable
        return alert store, err, cb if err?
        return alert store, lang.actionProhibited, cb if can isnt yes
        data = web3t.velas.ValidatorSet.emitInitiateChange.get-data!
        #console.log { data }
        to = web3t.velas.ValidatorSet.address
        amount = 0
        err <- web3t.vlx2.send-transaction { to, data, amount }
        store.current.page = \staking
    your-balance = " #{store.staking.chosenAccount.balance} "
    your-staking-amount = store.staking.stakeAmountTotal `div` (10^18)
    your-staking = " #{round-human your-staking-amount}"
    vlx-token = "VLX"
    isSpinned = if ((store.staking.all-pools-loaded is no or !store.staking.all-pools-loaded?) and store.staking.pools-are-loading is yes) then "spin disabled" else ""
    build-staker = (store, web3t)-> (item)->
        checked = item.checked
        stake = item.stake
        my-stake =
            | +item.my-stake.length is 0 => []
            | _ => item.my-stake
        fee = item.commission
        build-my-stake = (stake)->
            show-details = ->
                account = store.staking.accounts |> find (-> it.seed is stake.seed)
                return null if not account?
                store.staking.chosen-account = account
                navigate store, web3t, \account_details
            .pug(class="stake-item" on-click=show-details)
                .pug.name
                    span.pug #{stake.seed}
        index = store.staking.pools.index-of(item) + 1
        choose-pull = ->
            page = \choosestaker
            #store.pages.push(page) if store.pages.length > 0 and page isnt store.pages[store.pages.length - 1]
            cb = (err, data)->
                alert store, err, console~log if err?
            store.staking.pools |> map (-> it.checked = no)
            item.checked = yes
            store.staking.chosen-pool = item
            store.staking.add.new-address = ""
            store.staking.error = ""
            delegate-amount = your-balance
            delegate-receiver = store.staking.chosen-pool.address
            confirmText = "Please confirm that you would like to delegate #{delegate-amount} VLX to #{delegate-receiver}"
            agree <- confirm store, confirmText
            return if agree is no
            delegate!
        cancel-pool = ->
            store.staking.chosen-pool = null
        to-eth = ->
            item.eth = not item.eth
        reward =
            | item.validator-reward-percent is ".." => ".."
            | _ => (100 - +item.validator-reward-percent) * 1.4285714286
        filled = "#{round-human reward}%"
        filled-color =
            color:
                | reward > 95 => \red
                | reward > 75 => \orange
                | reward > 40 => "rgb(165, 174, 81)"
                | _ => "rgb(38, 219, 85)"
        vlx_native =
            store.current.account.wallets |> find (.coin.token is \vlx_native)
        return if not vlx_native?
        wallet =
            address: item.address
            network: vlx_native.network
            coin: vlx_native.coin
        vote-power =
            | item.vote-power? => "#{item.vote-power}%"
            | _ => "..."
        mystake-class = if +my-stake > 0 then "with-stake" else ""
        chosen = if store.staking.chosen-pool? and store.staking.chosen-pool.address is item.address then "chosen" else ""
        config = {decimals: 2}
        tr.pug(class="#{item.status} #{chosen}")
            td.pug(datacolumn='Staker Address' title="#{item.address}")
                address-holder-popup { store, wallet }
            td.pug #{ round-human(stake, config) }
            td.pug #{fee}%
            td.pug(class="#{mystake-class}")
                my-stake |> map build-my-stake
            td.pug #{item.stakers}
            td.pug
                button { store, on-click: choose-pull , type: \secondary , icon : \arrowRight }
    activate = (step)-> ->
        store.current.step = step
    activate-first = activate \first
    activate-second = activate \second
    activate-third = activate \third
    active-class = (step)->
        if store.current.step is step then 'active' else ''
    active-first = active-class \first
    active-second = active-class \second
    active-third = active-class \third
    refresh = ->
        store.staking.all-pools-loaded = no
        if ((store.staking.all-pools-loaded is no or !store.staking.all-pools-loaded?) and store.staking.pools-are-loading is yes)
            return no
        store.staking.pools-are-loading = yes
        cb = console.log
        #store.staking.accountIndex = "non-exists"
        err <- staking.init { store, web3t }
        return cb err if err?
        cb null, \done
    icon-style =
        color: style.app.loader
        margin-top: "10px"
        width: "inherit"
    staker-pool-style =
        max-width: 200px
        background: style.app.stats
    stats=
        background: style.app.stats
    totalValidators = (store.staking.totalValidators ? 0)
    allPages = Math.ceil(totalValidators `div` store.staking.validators_per_page)
    loadingValidatorIndex = store.staking.loadingValidatorIndex
    per-page = store.staking.validators_per_page
    page = store.staking.current_validators_page
    pagination-disabled = store.staking.pools-are-loading is yes
    .pug.staking-content.delegate
        .pug.main-sections
            .form-group.pug(id="pools" class="select-validators-list")
                alert-txn { store }
                .pug.section
                    .title.pug
                        h3.pug #{lang.pleaseSelectValidator}
                        .pug
                            if no
                                .loader.pug(on-click=refresh style=icon-style title="refresh" class="#{isSpinned}")
                                    icon \Sync, 25
                    .description.pug
                        .pug.table-scroll
                            table.pug
                                thead.pug
                                    tr.pug
                                        td.pug(width="30%" style=staker-pool-style title="Validator Staking Address. Permanent") #{lang.validator} (?)
                                        td.pug(width="15%" style=stats title="Sum of all stakings") #{lang.total-stake} (?)
                                        td.pug(width="5%" style=stats title="Validator Interest. (100% - Validator Interest = Pool Staking Reward)") #{lang.comission} (?)
                                        td.pug(width="10%" style=stats title="Find you staking by Seed") #{lang.my-stake} (?)
                                        td.pug(width="5%" style=stats title="How many stakers in a pool") #{lang.stakers} (?)
                                        td.pug(width="4%" style=stats) #{lang.select}
                                tbody.pug
                                    paginate(store.staking.pools, per-page, store.staking.current_validators_page)
                                        |> map build-staker store, web3t
                        pagination {store, type: \validators, disabled: pagination-disabled, config: {array: store.staking.pools }}
        if no and store.staking.chosen-pool?
            .pug.single-section.form-group(id="choosen-pull")
                .pug.section
                    .title.pug
                        h3.pug #{lang.becomeStaker}
                    .description.pug
                        .pug.left.float-left
                            span.pug #{lang.to_delegate}
                            span.pug.color #{your-balance} VLX
                            span.pug #{lang.delegate_to}
                            .pug.chosen-pool(title="#{store.staking.chosen-pool.address}")
                                span.pug
                                    | #{store.staking.chosen-pool.address}
                                    img.pug.check(src="#{icons.img-check}")
                        button { store, classes="float-right" on-click: delegate , type: \secondary , icon : \apply , text: \btnApply }
pool-chosing = ({ store, web3t })->
    lang = get-lang store
    { go-back } = history-funcs store, web3t
    goto-search = ->
        navigate store, web3t, \search
    info = get-primary-info store
    style=
        background: info.app.wallet
        color: info.app.text
    border-style =
        color: info.app.text
        border-bottom: "1px solid #{info.app.border}"
        background: info.app.background
        background-color: info.app.bgspare
    border-style2 =
        color: info.app.text
        border-bottom: "1px solid #{info.app.border}"
        background: "#4b2888"
    border-right =
        color: info.app.text
        border-right: "1px solid #{info.app.border}"
    header-table-style=
        border-bottom: "1px solid #{info.app.border}"
        background: info.app.wallet-light
    lightText=
        color: info.app.color3
    icon-color=
        filter: info.app.icon-filter
    show-class =
        if store.current.open-menu then \hide else \ ""
    .pug.staking
        .pug.title(style=border-style)
            .pug.header(class="#{show-class}") #{lang.delegateStake}
            .pug.close(on-click=go-back)
                img.icon-svg.pug(src="#{icons.arrow-left}" style=icon-color)
            burger store, web3t
            epoch store, web3t
            switch-account store, web3t
        staking-content store, web3t
stringify = (value) ->
    if value? then
        round-human(parse-float value `div` (10^18))
    else
        '..'
module.exports = pool-chosing