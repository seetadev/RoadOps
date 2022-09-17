require! {
    \react
    \react-dom
    \../../navigate.ls
    \../../get-primary-info.ls
    \../../web3.ls
    \bignumber.js
    \../../get-lang.ls
    \../../history-funcs.ls
    \../../staking-funcs.ls : { get-all-active-stake, creation-account-subscribe }
    \../icon.ls
    \prelude-ls : { map, split, filter, find, foldl, sort-by, unique, head, each, findIndex }
    \../../math.ls : { div, times, plus, minus }
    \../../velas/velas-node-template.ls
    \../../../web3t/providers/deps.js : { hdkey, bip39 }
    \md5
    \../../menu-funcs.ls
    \btoa
    \safe-buffer : { Buffer }
    \../../copied-inform.ls
    \../../round5.ls
    \../../../web3t/addresses.js : { ethToVlx, vlxToEth }
    \../switch-account.ls
    \../../round-human.ls
    \../../round-number.ls
    \../../icons.ls
    \../placeholder.ls
    \../epoch.ls
    \../confirmation.ls : { alert, notify, confirm, prompt2, prompt3 }
    \../../components/button.ls
    \../../components/address-holder.ls
    \../alert-txn.ls
    \../../components/amount-field.ls
    \../../seed.ls : seedmem
    \../../components/burger.ls
    \./error-funcs.ls : { get-error-message }
    \./rewards-stats.ls : RewardsStats
    \moment
    \../../components/popups/loader.ls
    \../../components/copy.ls

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
    @keyframes blink-animation
        50%
            opacity: 0.3
    @-webkit-keyframes blink-animation
        50%
            opacity: 0.3
    .blink
        animation: 1s linear blink-animation  infinite
        -webkit-animation: 1s linear blink-animation  infinite
    .entities-loader
        position: absolute;
        top: 0
        bottom: 0
        left: 0
        right: 0
        display: flex
        align-items: center
        .inner-section
            margin: auto
    .syncing
        -webkit-mask-image: linear-gradient(90deg, rgba(255, 255, 255, 0.6) 0%, #000000 50%, rgba(255, 255, 255, 0.6) 70%)
        -webkit-mask-size: 50%
        animation: fb 1s infinite
        animation-fill-mode: forwards
        background: var(--placeholder)
    @keyframes gradient
        0%
            background-position: 0% 50%
        50%
            background-position: 100% 50%
        100%
            background-position: 0% 50%
    @keyframes fb
        0%
            -webkit-mask-position: left
        100%
            -webkit-mask-position: right
    @media (max-width: 800px)
        .wallet-main, >.content, .history, .search, .filestore, .resources, .staking, .settings-menu, .staking-res, .stats, .monitor
            margin: 60px 0 0
            >.title
                margin: 0
                position: fixed
                z-index: 11
    .error-no-connection
        -webkit-mask-image: linear-gradient(90deg, rgba(255, 255, 255, 0.6) 0%, #000000 50%, rgba(255, 255, 255, 0.6) 70%)
        -webkit-mask-size: 50%
        animation: fb 1s infinite
        animation-fill-mode: forwards
        background: var(--placeholder)
        padding: 10px 20px
        display: inline-block
    .buttons
        display: flex
    .usd-amount
        opacity: 0.65
        font-size: 10px
        margin-left: 10px
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
    .myStakeMaxPart
        margin-left: 20px
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
        overflow: hidden
        background: transparent
        width: 100%
        border-radius: 0px
        position: relative
        box-sizing: border-box
        .table-scroll
            position: relative
            overflow-x: scroll
            background: linear-gradient(var(--color1) 30%, rgba(50,18,96, 0)), linear-gradient(rgba(50,18,96, 0), var(--color1) 70%) 0 100%, radial-gradient(farthest-side at 50% 0, var(--color2), rgba(0,0,0,0)), radial-gradient(farthest-side at 50% 100%, var(--color2), rgba(0,0,0,0)) 0 100%
            background-repeat: no-repeat
            background-attachment: local, local, scroll, scroll
            background-size: 100% 30px, 100% 30px, 100% 15px, 100% 15px
            animation: breathe 3s ease-in infinite
            -moz-transition: breathe 3s ease-in infinite
            -web-kit-transition: breathe 3s ease-in infinite
            height: auto
            min-height: 100px
            max-height: 400px
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
                &.current-epoch
                    background: transparent
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
            tr:nth-of-type(odd)
                background: rgba(gray, 0.2)
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
                padding: 20px 20px
                display: flex
                &.rewards
                    display: block
                .chosen-account
                    .buttons
                        text-align: left
                        @media(max-width:800px)
                            text-align: center
                            flex-wrap: wrap
                    span
                        @media (max-width: 800px)
                            font-size: 14px
                    .copy
                        margin-left: 10px
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
                    padding-right: 10px
                    width: 30%
                    min-width: 150px
                    text-align: left
                    text-transform: uppercase
                    font-size: 14px
                    @media (max-width: 800px)
                        width: 100%
                        margin-bottom: 20px
                        text-align: left
                    .less
                        font-size: 10px
                        opacity: 0.9
                .description
                    padding: 0px
                    font-size: 14px
                    width: 80%
                    text-align: left
                    .notification
                        @media(max-width:800px)
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
                        text-align: right
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
                        margin: 10px 20px 10px 0
                        @media (max-width: 800px)
                            margin: 10px 15px 0 0
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
    li.pug #{validator}
Rewards = (props)->
    lang = get-lang store
    style = get-primary-info store
    account = store.staking.chosenAccount
    activationEpoch = account.activationEpoch
    [rewards, setRewards] = react.useState([])
    [isLoading, setLoading] = react.useState(true)
    build-rewards = (item)->
        {
            epoch
            rewardSlot
            amount
            newBalance
            percentChange
            apr
        } = item
        return null if epoch is store.staking.current-epoch   
        $amount = round-human(amount `div` (10^9), {decimals: 9})
        $newBalance = round-human(newBalance `div` (10^9), {decimals: 9})
        if store.staking.current-epoch is epoch then
            rewardSlot = $amount = $newBalance = percentChange = apr =  "Loading..."
        $class = if epoch is store.staking.current-epoch then "syncing" else ""
        $tr-class = if epoch is store.staking.current-epoch then "current-epoch " else ""
        tr.pug(key="epoch#{epoch}" class="#{$tr-class} #{epoch}")
            td.pug(key="epoch#{epoch}1" class="#{$class}") #{epoch}
            td.pug(key="epoch#{epoch}2" class="#{$class}") #{rewardSlot}
            td.pug(key="epoch#{epoch}3" class="#{$class}") #{$amount}
            td.pug(key="epoch#{epoch}4" class="#{$class}") #{$newBalance}
            td.pug(key="epoch#{epoch}5" class="#{$class}") #{percentChange}
            td.pug(key="epoch#{epoch}6" class="#{$class}") #{apr}
    staker-pool-style =
        max-width: 200px
        background: style.app.stats
    stats=
        background: style.app.stats
    mountedRef = react.useRef(true)
    return-fn = ->
        mountedRef.current = no
    fetchRewards = react.useCallback (!~>>
        err, $rewards <- fetchEpochRewards(account.address, activationEpoch)
        return null if not mountedRef.current 
        setLoading(no)
        setRewards($rewards)
        store.staking.chosenAccount.rewards = $rewards
        return ), [mountedRef]
    react.useEffect (->
        fetchRewards!
        return return-fn ), [fetchRewards]
    .pug.section.rewards
        .title.pug
            h2.pug #{lang.uRewards}
        .pug.table-scroll
            if isLoading then
                span.pug.entities-loader
                    span.pug.inner-section
                        h3.pug.item.blink Loading... 
            else        
                table.pug
                    thead.pug
                        tr.pug
                            td.pug(width="3%" style=staker-pool-style title="Epoch") #{lang.epoch} (?)
                            td.pug(width="25%" style=stats title="Reward Slot") Reward Slot (?)
                            td.pug(width="25%" style=stats title="Amount") #{lang.amount} (?)
                            td.pug(width="25%" style=stats title="New Balance") #{lang.newBalance} (?)
                            td.pug(width="7%" style=stats title="Percent Change") Percent Change (?)
                            td.pug(width="7%" style=stats title="APR") APR (?)
                    tbody.pug
                        rewards |> map build-rewards 
        RewardsStats.pug(rewards=rewards)
staking-content = (store, web3t)->
    { go-back } = history-funcs store, web3t
    style = get-primary-info store
    lang = get-lang store
    down = (it)-> it.toLowerCase!
    account = store.staking.chosenAccount
    {
        address,
        activationEpoch,
        deactivationEpoch,
        rentExemptReserve,
        checked,
        stake,
        stake-initial,
        commission,
        lastVote,
        lockup,
        stakers,
        is-validator,
        status,
        myStake,
        credits_observed,
        validator,
        pubkey
        lamports
    } = account
    rent = rentExemptReserve `div` (10^9)
    balanceRaw = if (not isNaN(rent) and rent?) then lamports `minus` rent else lamports
    button-primary3-style=
        border: "1px solid #{style.app.primary3}"
        color: style.app.text2
        background: style.app.primary3
        background-color: style.app.primary3-spare
    seed-style =
        background: style.app.primary2
        background-color: style.app.primary2-spare
        padding: 5px
    filter-icon=
        filter: style.app.filterIcon
    comming-soon =
        opacity: ".3"
    pairs = store.staking.keystore
    i-stake-choosen-pool = ->
        myStake = +myStake
        myStake >= 10000
    wallet =
        store.current.account.wallets
            |> find -> it.coin.token is \vlx_native
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
    your-balance = balanceRaw `div` (10^9)
    isSpinned = if ((store.staking.all-pools-loaded is no or !store.staking.all-pools-loaded?) and store.staking.pools-are-loading is yes) then "spin disabled" else ""
    cancel-pool = ->
        store.staking.chosenAccount = null
    refresh = ->
        store.staking.all-pools-loaded = no
        store.staking.getAccountsFromCashe = no
        if ((store.staking.all-pools-loaded is no or !store.staking.all-pools-loaded?) and store.staking.pools-are-loading is yes)
            return no
        store.staking.pools-are-loading = yes
        cb = console.log
        #store.staking.accountIndex = "non-exists"
        err <- staking.init { store, web3t }
        return cb err if err?
        cb null, \done
    remove-stake-acc = (public_key)->
        console.log "pubKey to remove" public_key
        index = store.staking.accounts |> findIndex (-> it.pubkey is public_key)
        if index > -1
            store.staking.accounts.splice(index,1)
        console.log "index to remove" index
        accountIndex = store.current.accountIndex
        index2 = (store.staking.accountsCached[accountIndex] ? []) |> findIndex (-> it.pubkey is public_key)
        console.log "index cache to remove" index2
        if index2 > -1
            (store.staking.accountsCached[accountIndex] ? []).splice(index2,1)
    withdraw = ->
        agree <- confirm store, lang.areYouSureToWithdraw
        return if agree is no
        amount = account.lamports `plus` account.rent
        err, result <- as-callback web3t.velas.NativeStaking.withdraw(address, amount)
        err-message = get-error-message(err, result)
        return alert store, err-message if err-message?
        <- notify store, lang.fundsWithdrawn
        store.staking.getAccountsFromCashe = yes
        remove-stake-acc(account.pubkey)
        if store.staking.webSocketAvailable is no
            return navigate store, web3t, \validators
        store.current.page = \validators
    delegate = ->
        navigate store, web3t, \poolchoosing
    undelegate = ->
        agree <- confirm store, lang.areYouSureToUndelegate
        return if agree is no
        #
        err, result <- as-callback web3t.velas.NativeStaking.undelegate(store.staking.chosenAccount.address)
        console.error "Undelegate error: " err if err?
        err-message = get-error-message(err, result)
        return alert store, err-message if err-message?
        <- set-timeout _, 1000
        <- notify store, lang.fundsUndelegated
        #store.staking.getAccountsFromCashe = no
        if store.staking.webSocketAvailable is no
            return navigate store, web3t, \validators
        store.current.page = \validators
    split-account = ->
        cb = console.log
        buffer = {}
        amount <- prompt3 store, lang.howMuchToSplit
        buffer.amount = amount
        if amount+"".trim!.length is 0
            store.staking.splitting-staking-account = no
            return
        min_stake = web3t.velas.NativeStaking.min_stake
        balance = balanceRaw `div` (10^9)
        if +buffer.amount > +balance
            store.staking.splitting-staking-account = no
            return alert store, lang.balanceIsNotEnoughToSpend + " #{buffer.amount} VLX"
        if +min_stake > +balance
            threshold-amount = min_stake `plus` 0.00228288
            store.staking.splitting-staking-account = no
            return alert store, lang.balanceIsNotEnoughToCreateStakingAccount + " (#{threshold-amount} VLX)"
        if +(min_stake) > +buffer.amount
            store.staking.splitting-staking-account = no
            return alert store, lang.minimalStakeMustBe + " #{min_stake} VLX"
        err <- as-callback web3t.velas.NativeStaking.getStakingAccounts(store.staking.parsedProgramAccounts)
        return cb err if err?
        store.staking.splitting-staking-account = yes
        /* Get next account seed */
        err, seed <- as-callback web3t.velas.NativeStaking.getNextSeed()
        err-message = get-error-message(err, seed)
        if err-message?
            store.staking.splitting-staking-account = no
            return alert store, err-message
        amount = buffer.amount * 10^9
        /* Create new account */
        fromPubkey$ = store.staking.chosenAccount.address
        err, splitStakePubkey <- as-callback web3t.velas.NativeStaking.createNewStakeAccountWithSeed()
        if err?
            store.staking.splitting-staking-account = no
            return alert store, err.toString!
        try
            splitStakePubkeyBase58 = splitStakePubkey.toBase58()
        catch error
            store.staking.splitting-staking-account = no
            return alert store, error.toString!
        /* Split account */
        stakeAccount = store.staking.chosenAccount.address
        $voter = store.staking.chosenAccount.voter
        err, signature <- as-callback web3t.velas.NativeStaking.splitStakeAccount(stakeAccount, splitStakePubkey, amount)
        console.log "spit signature" signature
        err-message = get-error-message(err, signature)
        if err-message?
            store.staking.splitting-staking-account = no
            return alert store, err-message
        { activationEpoch, deactivationEpoch } = store.staking.chosenAccount
        err <- creation-account-subscribe({ store, web3t, signature, timeout: 1000, acc_type: "split", deactivationEpoch, activationEpoch, voter: $voter })
        if err?
            store.staking.splitting-staking-account = no
            return alert store, err, cb
        /* Update balance of stake account from which split was called */
        fromPubkey$ = store.staking.chosenAccount.address
        err, accountInfo <- as-callback web3t.velas.NativeStaking.getAccountInfo(fromPubkey$)
        if err?
            console.log "Split was confirmed"
            store.staking.splitting-staking-account = no
            return alert store, "Split was confirmed. Please reload stake accounts manually to see updates.", cb
        split_lamports = accountInfo?value?lamports
        /* Find account in store.staking.accounts and update balance */
        found-account = store.staking.accounts |> find (-> down(it.pubkey) is down(fromPubkey$))
        if found-account?
            found-account.balance = split_lamports `div` (10^9)
            found-account.balanceRaw = split_lamports + ""
            found-account.lamports = split_lamports + ""
        <- notify store, lang.accountCreatedAndFundsSplitted + ".\n\nNew stake account address: " + splitStakePubkeyBase58
        store.staking.getAccountsFromCashe = no
        store.current.page = "validators"
        store.staking.splitting-staking-account = no
    icon-style =
        color: style.app.loader
        margin-top: "10px"
        width: "inherit"
    staker-pool-style =
        max-width: 200px
        background: style.app.stats
    stats=
        background: style.app.stats
    has-validator = validator? and validator.toString!.trim! isnt ""
    active_stake = store.staking.chosenAccount.active_stake `div` (10^9)
    inactive_stake = store.staking.chosenAccount.inactive_stake `div` (10^9)
    delegated_stake = active_stake `plus` inactive_stake 
    usd-rate = wallet?usdRate ? 0
    usd-balance = round-number(your-balance `times` usd-rate, {decimals:2})
    usd-rent = round-number(rent `times` usd-rate,{decimals:2})
    usd-active_stake = round-number(active_stake `times` usd-rate, {decimals:2})
    usd-inactive_stake = round-number(inactive_stake `times` usd-rate, {decimals:2})
    usd-delegated_stake = round-number(delegated_stake `times` usd-rate, {decimals:2})
    $validator = if has-validator then validator else "---"
    activeBalanceIsZero =  +store.staking.chosenAccount.active_stake is 0
    max-epoch = web3t.velas.NativeStaking.max_epoch
    myStakeMaxPart = 
        | store.staking.myStakeMaxPart? =>
            myStakeMaxPartVLX = parse-float(store.staking.myStakeMaxPart) `div` (10^9)
            myStakeMaxPartVLX + 
            " VLX"
        | _ => ""
    $status =
        | store.staking.chosenAccount.status is "inactive" and (not has-validator) => "Not Delegated"
        | store.staking.chosenAccount.status is "inactive" and has-validator => "Delegated (Inactive)"
        #| store.staking.chosenAccount.status is "activating" => ""
        | _ => store.staking.chosenAccount.status
    inactiveStakeLabel =
        | store.staking.chosenAccount.status is "activating" => lang.warminUp
        | _ => lang.inactiveStake 
    { lockupUnixTimestamp, epoch, lockup } = store.staking.chosenAccount
    is-locked = lockupUnixTimestamp? and lockupUnixTimestamp > moment!.unix!
    console.log {}
    date-expires =
        | is-locked is yes => moment.unix(lockupUnixTimestamp).format("MMMM D, YYYY");
        | _ => ""
    time-expires =
        | is-locked is yes => moment.unix(lockupUnixTimestamp).format("hh:mm:ss");
        | _ => ""
    lockup-warning-style = 
        padding: "20px"
        background: "rgb(207, 149, 44)"
        font-weight: "bold"
        text-align: "center"
        max-width: "500px"
    address-container-style = 
        display: "flex"
    /* Render */    
    .pug.staking-content.delegate
        loader { loading: store.staking.splitting-staking-account, text: "Splitting in process" }
        .pug.single-section.form-group(id="choosen-pull")
            .pug.section
                .title.pug
                    h2.pug #{lang.stakeAccount}
                if is-locked is yes
                    .description.pug
                        .pug.locked-warning-table(style=lockup-warning-style)
                            span.pug Account is locked! Lockup expires on 
                                | #{date-expires}
                                | at
                                | #{time-expires}
            .pug.section
                .title.pug
                    h3.pug #{lang.address}
                .description.pug
                    .pug.chosen-account(title="#{store.staking.chosenAccount.address}")
                        span.pug(style=address-container-style)
                            | #{store.staking.chosenAccount.address}
                            img.pug.check(src="#{icons.img-check}")
                            copy { store, text: store.staking.chosenAccount.address, elId: "copy-address-chosenAccount" }
            .pug.section
                .title.pug
                    h3.pug ID
                .description.pug
                    span.pug(style=seed-style)
                        | #{store.staking.chosenAccount.seed}
            .pug.section
                .title.pug
                    h3.pug #{lang.rentExemptReserve}
                .description.pug
                    span.pug
                        | #{rent} VLX
                    span.pug.usd-amount
                        | $#{usd-rent}
            .pug.section
                .title.pug
                    h3.pug #{lang.balance}
                .description.pug
                    span.pug
                        | #{round-human(your-balance)} VLX
                    span.pug.usd-amount
                        | $#{round-human(usd-balance)}
            .pug
            .pug
            .pug.section
                .title.pug
                    h2.pug #{lang.stakeDelegation}
            .pug.section
                .title.pug
                    h3.pug #{lang.status}
                .description.pug
                    .pug.chosen-account(title="#{store.staking.chosenAccount.status}")
                        span.pug
                            | #{$status}
            .pug.section
                .title.pug
                    h3.pug #{lang.validator}
                .description.pug
                    span.pug.chosen-account(style=address-container-style)
                        | #{$validator}
                        if has-validator
                            img.pug.check(src="#{icons.img-check}")
                        copy { store, text: validator, elId: "copy-address-validator" }
            .pug.section
                .title.pug
                    h3.pug #{lang.creditsObserved}
                .description.pug
                    span.pug
                        | #{round-human(credits_observed)}
            .pug.section
                .title.pug
                    h3.pug #{lang.delegatedStake}
                .description.pug
                    span.pug
                        | #{round-human(delegated_stake)} VLX
                    span.pug.usd-amount
                        | $#{round-human(usd-delegated_stake)}
            .pug.section
                .title.pug
                    h3.pug #{lang.activeStake}
                .description.pug
                    span.pug
                        | #{round-human(active_stake)} VLX
                    span.pug.usd-amount
                        | $#{round-human(usd-active_stake)}
                    if store.staking.myStakeMaxPart? and no
                        span.pug.myStakeMaxPart
                            .pug.animation
                                .pug.anim-item -
                                .pug.anim-item -
                                .pug.anim-item >
                            | #{myStakeMaxPart}
            .pug.section
                .title.pug
                    h3.pug #{inactiveStakeLabel}
                .description.pug
                    span.pug
                        | #{round-human(inactive_stake)} VLX
                    span.pug.usd-amount
                        | $#{round-human(usd-inactive_stake)}
                    if store.staking.chosenAccount.status is "activating"
                        more-style =
                            text-decoration: "none"
                            opacity: 0.8
                            line-height: 1.6
                            font-size: "14px"
                            letter-spacing: "2px"
                            margin-left: "5px"
                        tip-style =
                            color: "#16ffb2"
                            opacity: 0.8
                        link-style =
                            text-decoration: "none"
                            color: "white"
                            opacity: 0.8
                        notification-style =
                            margin-top: "10px"
                        .pug.notification(style=notification-style)
                            span.pug(style=tip-style) Only 25% of active stake can be activated per epoch.
                            a.pug(href="https://support.velas.com/hc/en-150/articles/360021044820-Delegation-Warmup-and-Cooldown" target="_blank" rel="noopener noreferrer nofollow" style=link-style)
                                span.pug(style=more-style) More...
            .pug.section
                .title.pug
                    h2.pug Actions
                .description.pug
                    .pug.buttons
                        if (store.staking.chosenAccount.status is "inactive") 
                            .pug
                                button { store, on-click: delegate , type: \secondary , text: lang.to_delegate, icon : \arrowRight }
                                if is-locked is no
                                    button { store, on-click: withdraw , type: \secondary , text: lang.withdraw, icon : \arrowLeft }
                        else if store.staking.chosenAccount.status isnt \deactivating then
                            button { store, on-click: undelegate , type: \secondary , text: lang.to_undelegate, icon : \arrowLeft, classes: "action-undelegate" }
                        button { store, on-click: split-account , type: \secondary , text: lang.to_split, classes: "action-split", no-icon: yes }
            Rewards.pug
account-details = ({ store, web3t })->
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
    just-go-back = ->
        store.staking.fetchAccounts = no
        store.staking.chosenAccount.stopLoadingRewards = yes
        store.staking.getAccountsFromCashe = yes
        store.current.page = \validators
    .pug.staking
        .pug.title(style=border-style)
            .pug.header(class="#{show-class}") #{lang.delegateStake}
            .pug.close(on-click=just-go-back)
                img.icon-svg.pug(src="#{icons.arrow-left}" style=icon-color)
            burger store, web3t
            epoch store, web3t
            switch-account store, web3t
        staking-content store, web3t
account-details.init = ({ store, web3t }, cb)!->
    account = store.staking.chosenAccount
    cb2 = (err, data)->
        store.current.page = \validators
    if not account?
        return alert store, "Account not found", cb2
    store.staking.chosenAccount.stopLoadingRewards = no
    store.staking.chosenAccount.rewards = []
    store.staking.rewards-index = 0
    stake-accounts = store.staking.parsedProgramAccounts
    err, accountInfo <- as-callback web3t.velas.NativeStaking.getAccountInfo(store.staking.chosenAccount.pubkey)
    return alert store, err, cb2 if err?
    if !accountInfo.value? then
        return alert store, "Account not found", cb2
    err, epochInfo <- as-callback web3t.velas.NativeStaking.getCurrentEpochInfo()
    console.error err if err?
    store.staking.current-epoch = epochInfo.epoch
    err, stakeActivation <- as-callback web3t.velas.NativeStaking.getStakeActivation(store.staking.chosenAccount.address)
    if not err? and stakeActivation?
        store.staking.chosenAccount.status = stakeActivation.state
        store.staking.chosenAccount.active_stake = stakeActivation.active
        store.staking.chosenAccount.inactive_stake = stakeActivation.inactive
    return alert store, err, cb if err?
    cb null
stringify = (value) ->
    if value? then
        round-human(parse-float value `div` (10^18))
    else
        '..'
fetchEpochRewards = (address, activationEpoch, cb)->    
    return cb null, [] if (not store.staking.chosenAccount.validator? or store.staking.chosenAccount.validator.toString!.length is 0)    
    err, epochSchedule <- as-callback(web3t.velas.NativeStaking.getEpochSchedule!)
    console.error err if err?
    {firstNormalEpoch, firstNormalSlot, leaderScheduleSlotOffset, slotsPerEpoch, warmup} = epochSchedule
    err, slot <- as-callback(web3t.velas.NativeStaking.getSlot!)
    console.error err if err?
    err, firstAvailableBlock <- as-callback(web3t.velas.NativeStaking.getFirstAvailableBlock!)
    console.error err if err?
    err, epochInfo <- as-callback web3t.velas.NativeStaking.getCurrentEpochInfo()
    console.error err if err?
    return cb null if err?
    { epoch, blockHeight, slotIndex, slotsInEpoch, transactionCount } = epochInfo
    # make loop here!
    err, rewards <- query-rewards-loop(address, activationEpoch, firstNormalSlot, slotsPerEpoch, slotsInEpoch, firstAvailableBlock, firstNormalEpoch, epoch)    
    cb null, rewards
#
prev-epoch-data = {epoch_start_time: null, rewards: null, first_confirmed_block: null}
# 
query-rewards-loop = (address, activationEpoch, firstNormalSlot, slotsPerEpoch, slotsInEpoch, firstAvailableBlock, firstNormalEpoch, epoch, cb)->
    return cb null, [] if epoch < (activationEpoch) or epoch < 0
    return cb null, [] if store.staking.chosenAccount.stopLoadingRewards is yes
    return cb null, [] if store.staking.rewards-index >= store.staking.REWARDS_PER_PAGE
    # Get not skipped slot here!  
    err, firstSlotInEpoch <- get_first_slot_in_epoch(firstNormalSlot, slotsPerEpoch, slotsInEpoch, firstNormalEpoch, epoch)
    # Get first comfirmed block/slot in epoch
    limit = 1
    err, result <- as-callback(web3t.velas.NativeStaking.getConfirmedBlocksWithLimit(firstSlotInEpoch, limit))
    first_confirmed_block_in_epoch = result?result?0    
    # Get first confirmed block    
    err, first_confirmed_block <- get_confirmed_block_with_encoding(first_confirmed_block_in_epoch)
    rewards = []
    #
    SECONDS_PER_DAY = 86400
    # Get previous epoch start time
    epoch_start_time = 
        | not first_confirmed_block? => 0
        | _ => first_confirmed_block.blockTime
    epoch_end_time = prev-epoch-data.epoch_start_time
    #set epoch_start_time for previous epoch
    wallclock_epoch_duration =
        | not epoch_end_time? => 0 
        | _ => epoch_end_time `minus` epoch_start_time
    wallclock_epochs_per_year = (SECONDS_PER_DAY * 365.25) `div` wallclock_epoch_duration 
    all-rewards = (prev-epoch-data.rewards ? [])
    rewards = 
        all-rewards 
            |> filter (-> it.pubkey is address)
            |> map (it)->
                percentChange = (it.lamports `div` it.postBalance) `times` 100
                percentChange = round-number(percentChange, {decimals: 2})
                rateChange = it.lamports `div` (it.postBalance - it.lamports)   
                apr = 
                    | not epoch_end_time? => "0" 
                    | _ => (rateChange `times` wallclock_epochs_per_year) `times` 100
                apr = round-number(apr, {decimals: 2})
                {
                    epoch: (epoch)
                    rewardSlot: prev-epoch-data.rewardSlot
                    amount: it.lamports
                    newBalance: it.postBalance 
                    percentChange: percentChange + "%"
                    apr: apr + "%"
                    disabled: not first_confirmed_block?  
                }
    if rewards.length > 0
        store.staking.rewards-index++
    #if not prev-epoch-data.first_confirmed_block?
        #rewards = [
            #{
                #epoch: (epoch)
                #rewardSlot: (prev-epoch-data?rewardSlot ? "no result")
                #amount: "0"
                #newBalance: "0"
                #percentChange: ".."
                #apr: ".." 
                #disabled: yes 
            #}
        #]
    # Set previous block start time and rewards
    prev-epoch-data.first_confirmed_block = first_confirmed_block
    prev-epoch-data.epoch_start_time =  first_confirmed_block?blockTime
    prev-epoch-data.rewards = first_confirmed_block?rewards 
    prev-epoch-data.rewardSlot = firstSlotInEpoch        
    err, rest <- query-rewards-loop(address, activationEpoch, firstNormalSlot, slotsPerEpoch, slotsInEpoch, firstAvailableBlock, firstNormalEpoch, --epoch)
    all = rewards ++ rest
    cb null, all
#    
get_first_slot_in_epoch = (firstNormalSlot, slotsPerEpoch, slotsInEpoch, firstNormalEpoch, epoch, cb)->
    #if epoch <= firstNormalEpoch
        #console.log "Epoch is less or equals to firstNormalEpoch"
        #return (Math.pow(2, epoch) - 1) * slotsInEpoch #MINIMUM_SLOTS_PER_EPOCH
    #return (epoch - firstNormalEpoch) * slotsPerEpoch + firstNormalSlot
    limit = 1
    firstSlotInEpoch = (epoch - firstNormalEpoch) * slotsPerEpoch + firstNormalSlot
    #err, result <- as-callback(web3t.velas.NativeStaking.getConfirmedBlocksWithLimit(firstSlotInEpoch, limit))
    #return cb err if err? or not result?result
    #firstSlot = result?result?0
    #cb null, firstSlot
    return cb null,  firstSlotInEpoch
try-get-extra-slot = (default-response, new-slot, cb)->
    return cb null, default-response, if default-response?
    limit = 1
    err, result <- as-callback(web3t.velas.NativeStaking.getConfirmedBlocksWithLimit(new-slot, limit))
    cb null, result?result?0
#    
get_confirmed_block_with_encoding = (slot, cb)->
    try
        err, confirmedBlock <- as-callback(web3t.velas.NativeStaking.getConfirmedBlock(slot))
        console.error err if err?
        return cb err if err?
        cb null, confirmedBlock
    catch err
        return cb err
#    
retrieveRewardData = (firstSlotInEpoch, firstNormalSlot, slotsPerEpoch, slotsInEpoch, firstAvailableBlock, firstNormalEpoch, epoch, cb)->
    if firstSlotInEpoch < firstAvailableBlock
        # RPC node is out of history data
        return cb "RPC node is out of history data"
    err, confirmed_block_with_encoding <- get_confirmed_block_with_encoding(firstSlotInEpoch)
    cb null, confirmed_block_with_encoding    
module.exports = account-details