require! {
    \react
    \react-dom
    \bignumber.js
    \../../navigate.ls
    \../../get-primary-info.ls
    \../../get-lang.ls
    \../../history-funcs.ls
    \../icon.ls
    \prelude-ls : { map, split, filter, find, foldl, sort-by, unique, head, each, findIndex }
    \../../math.ls : { div, times, plus, minus }
    \safe-buffer : { Buffer }
    \../../../web3t/addresses.js : { ethToVlx }
    \../../round-human.ls
    \../../components/checkbox.ls
    \../../icons.ls
    \../placeholder.ls
    \../../staking/can-make-staking.ls
    \../../components/button.ls
    \../../components/address-holder.ls
    \../../components/address-holder-popup.ls
    \../alert-txn.ls
    \../../components/amount-field.ls
    \../../seed.ls : seedmem
    \moment
    \../confirmation.ls : { prompt2, prompt-stake-account-amount, alert, confirm, notify }
    \../../components/pagination.ls
    \./error-funcs.ls : { get-error-message }
    #'@solana/web3.js' : web3Solana
    \../../staking-funcs.ls : { creation-account-subscribe }
    \../../components/popups/loader.ls
}
as-callback = (p, cb)->
    p.catch (err) -> cb err
    p.then (data)->
        cb null, data
.staking-accounts-content
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
        display: block
        padding: 40px
        text-align: center
        .inner-section
            padding: 40px
            .item
                display: inline
    .notification-entity
        @media(max-width: 540px)
            display: block
            margin-top: 20px !important
    .hint
        .tooltip
            position: absolute
            text-transform: uppercase
            left: 25px
            top: -8px
            z-index: 1
            line-height: 14px
            font-size: 9px
            font-weight: 600
            color: #fff
            padding: 5px
            background: #000
            visibility: hidden
            &:after, &:before
                right: 100%
                top: 21%
                border: solid transparent
                content: " "
                height: 0
                width: 0
                position: absolute
                pointer-events: none
            &:after
                border-color: rgba(136, 183, 213, 0)
                border-right-color: #000
                border-width: 6px
                margin-top: 2px
            &:before
                border-color: rgba(194, 225, 245, 0)
                border-width: 8px
                margin-top: 0px
    .hint
        &:hover
            .tooltip
                visibility: visible
    .title
        h3
            display: inline
        .amount
            color: white
            font-size: 11px
            opacity: 0.5    
    .form-group
        .subtitle
            margin: 20px 0 10px
        .settings
            margin-top: 20px
            .settings-item
                margin-bottom: 20px
                & > label
                    margin-bottom: 6px
                    display: inline-block
        .outer-checkbox
            display: inline-block
            margin: 0 15px 0 0
            & + label
                margin: 5px 0
        .table-scroll
            transition: max-height .5s
            table
                thead
                    td
                        cursor: pointer
                        &:hover
                            color: #dde6ff
                td
                    &.account-status
                        text-transform: capitalize
                        &.deactivating
                            color: #ff5555
                        &.activating
                            color: orange
                        &.active
                            color: green
                        &.inactive
                            color: gray
                    &.validator-address
                        text-align: center
                    border: none
    .stake-account-item
        &.highlight
            box-shadow: 1px 2px 12px inset rgba(60, 213, 175, 0.35)
cb = console.log
show-validator = (store, web3t)-> (validator)->
    li.pug(key="validator-#{validator}") #{validator}
export paginate = (array, per-page, page)->
    page = page - 1
    array.slice page * per-page, (page + 1) * per-page
staking-accounts-content = (store, web3t)->
    style = get-primary-info store
    lang = get-lang store
    button-primary3-style=
        border: "1px solid #{style.app.primary3}"
        color: style.app.text2
        background: style.app.primary3
        background-color: style.app.primary3-spare
    { go-back } = history-funcs store, web3t
    lang = get-lang store
    get-balance = ->
        wallet =
            store.current.account.wallets
                |> find -> it.coin.token is \vlx_native
        wallet?balance ? 0
    get-options = (cb)->
        err, data <- web3t.velas.Staking.candidateMinStake
        return cb err if err?
        min =
            | +store.staking-accounts.stake-amount-total >= 10000 => 1
            | _ => data `div` (10^18)
        balance = (store.staking-accounts.chosen-lockup.locked-funds-raw `div` (10^18)) `minus` 0.1
        stake = store.staking-accounts.add.add-validator-stake
        return cb lang.amountLessStaking if 10000 > +stake
        return cb lang.balanceLessStaking if +balance < +stake
        max = +balance
        cb null, { min, max }
    use-min = ->
        #err, options <- get-options
        #return alert store, err, cb if err?
        store.staking-accounts.add.add-validator-stake = 10000
    use-max = ->
        #err, options <- get-options
        #return alert store, err, cb if err?
        balance = store.staking-accounts.chosen-lockup.locked-funds-raw `div` (10^18)
        store.staking-accounts.add.add-validator-stake = Math.max (balance `minus` 0.1), 0
    isSpinned = if ((store.staking.all-accounts-loaded is no or !store.staking.all-accounts-loaded?) and store.staking.accounts-are-loading is yes) then "spin disabled" else ""
    refresh = ->
        store.errors.fetchAccounts = null
        store.errors.fetchValidators = null
        return if store.staking.all-accounts-loaded isnt yes
        store.staking.getAccountsFromCashe = no
        navigate store, web3t, "validators"
    perPage =  store.staking.accounts_per_page
    page = store.staking.current_accounts_page
    _index = 1 + ((page - 1) * perPage)
    build = (store, web3t)-> (item)->
        index = _index++
        return null if not item? or not item.key?
        {
            account,
            lamports,
            address,
            key,
            rent,
            seed,
            status,
            validator,
            activationEpoch,
            deactivationEpoch,
            active_stake,
            lockupUnixTimestamp,
            inactive_stake
        } = item
        balance = if rent? then (Math.round((lamports `minus` rent) `div` (10^9)) `times` 100) `div` 100  else "-"
        balanceRaw = if rent? then lamports `minus` rent else lamports
        highlight = item.highlight
        activeBalanceIsZero =  +active_stake is 0
        max-epoch = web3t.velas.NativeStaking.max_epoch
        is-activating = activeBalanceIsZero and validator?
        has-validator = (item.validator? and item.validator isnt '') and (activationEpoch? and deactivationEpoch?) and (activationEpoch isnt deactivationEpoch)
        $status =
            | item.status is "inactive" and (not has-validator) => "Not Delegated"
            | item.status is "inactive" and has-validator => "Delegated (Inactive)"
            | _ => status
        vlx =
            store.current.account.wallets |> find (.coin.token is \vlx_native)
        return null if not vlx?
        wallet =
            address: item.address
            network: vlx.network
            coin: vlx.coin
        wallet-validator =
            address: validator
            network: vlx.network
            coin: vlx.coin
        # Select contract from list  
        undelegate = ->
            #err, options <- get-options
            #return alert store, err, cb if err?
            #err <- can-make-staking store, web3t
            #return alert store, err, cb if err?
            undelegate-amount = item.balance
            agree <- confirm store, lang.areYouSureToUndelegate + " #{undelegate-amount} VLX \nfrom #{item.validator} ?"
            return if agree is no 
            #
            err, result <- as-callback web3t.velas.NativeStaking.undelegate(item.address)
            console.error "Undelegate error: " err if err?
            return alert store, err.toString! if err?
            <- notify store, lang.fundsUndelegated
            store.staking.getAccountsFromCashe = no
            if store.staking.webSocketAvailable is no
                navigate store, web3t, \validators
        choose = ->
            store.staking.chosen-account = item
            navigate store, web3t, \poolchoosing
            cb null
        remove-stake-acc = (public_key)->
            index = store.staking.accounts |> findIndex (-> it.pubkey is public_key)
            if index > -1
                store.staking.accounts.splice(index,1)
            accountIndex = store.current.accountIndex
            index2 = (store.staking.accountsCached[accountIndex] ? []) |> findIndex (-> it.pubkey is public_key)
            if index2 > -1
                (store.staking.accountsCached[accountIndex] ? []).splice(index2,1)
        withdraw = ->
            if (deactivationEpoch? and activationEpoch?) and +deactivationEpoch >= +store.staking.current-epoch
                return
            agree <- confirm store, lang.areYouSureToWithdraw
            return if agree is no
            { balanceRaw, rent, address, account, pubkey } = item
            amount = lamports `plus` rent
            err, result <- as-callback web3t.velas.NativeStaking.withdraw(address, amount)
            err-message = get-error-message(err, result)
            return alert store, err-message if err-message?
            <- set-timeout _, 1000
            <- notify store, lang.fundsWithdrawn
            store.staking.getAccountsFromCashe = no
            store.current.page = \validators
            remove-stake-acc(pubkey)
        now = moment!.unix!        
        locked-and-can-withdraw = lockupUnixTimestamp? and (lockupUnixTimestamp <= now)
        not-locked = not lockupUnixTimestamp? || +lockupUnixTimestamp is 0 || +lockupUnixTimestamp < now
        can-delegate =
            | has-validator => no
            | _ => yes
        $button =
            | can-delegate =>
                button { classes: "action-delegate", store, text: lang.to_delegate, on-click: choose, type: \secondary , icon : \arrowRight }
            | (not-locked or locked-and-can-withdraw) and (+deactivationEpoch isnt +max-epoch) and (+store.staking.current-epoch >= +deactivationEpoch) =>
                disabled =
                    | (deactivationEpoch? and activationEpoch?) and +deactivationEpoch >= +store.staking.current-epoch => yes
                    | _ => no
                button { classes: "action-withdraw", store, text: lang.withdraw, on-click: withdraw, type: \secondary , icon : \arrowLeft, makeDisabled:disabled }
            | _ =>
                disabled = item.status in <[ deactivating ]>
                icon =
                    | not-locked => 'arrowLeft'
                    | _ => 'lock'
                if activationEpoch? and deactivationEpoch? and (activationEpoch !== deactivationEpoch)
                    if +activationEpoch < +deactivationEpoch and +deactivationEpoch isnt +max-epoch
                        disabled = yes
                button { store, classes: "action-undelegate" text: lang.to_undelegate, on-click: undelegate , type: \secondary , icon, makeDisabled: disabled }
        highlighted = if highlight is yes then "highlight" else ""
        tr.pug(class="stake-account-item #{item.status} #{highlighted}" key="#{address}")
            td.pug
                span.pug.circle(class="#{item.status}") #{index}
            td.pug(datacolumn='Staker Address' title="#{address}")
                address-holder-popup { store, wallet, item}
            td.pug #{balance}
            td.pug(class="validator-address" title="#{validator}")
                if has-validator
                    address-holder-popup { store, wallet: wallet-validator, item }
                else
                    "---"
            td.pug
                .pug.seed #{seed}
            if no
                td.pug(class="account-status #{status}") #{$status}
            td.pug
                $button
    cancel = ->
        store.staking-accounts.chosen-lockup = null
        store.staking-accounts.add.add-validator-stake = 0
    icon-style =
        color: style.app.loader
        margin-top: "10px"
        width: "inherit"
    staker-pool-style =
        max-width: 200px
        background: style.app.stats
    stats=
        background: style.app.stats
    notification-border =
        border: "1px solid orange"
        padding: 5px
        border-radius: 5px
        width: "auto"
        margin: "10px 20px 0"
    block-style = 
        display: "block"
    create-staking-account = ->
        cb = console.log
        buffer = {}
        amount <- prompt2 store, lang.howMuchToDeposit
        return if not amount?
        return if amount+"".trim!.length is 0
        buffer.amount = amount
        create-staking-account.InProcess = yes
        store.staking.creating-staking-account = yes
        min_stake = web3t.velas.NativeStaking.min_stake
        main_balance = get-balance!
        tx-fee = 5000 `div` (10^9)
        rest = 0.1
        amount = amount `minus` (store.staking.rent `plus` tx-fee `plus` rest) if +(main_balance `minus` amount) <= 0
        if +min_stake > +main_balance
            store.staking.creating-staking-account = no
            create-staking-account.InProcess = no
            return alert store, lang.balanceIsNotEnoughToCreateStakingAccount
        if +min_stake  > +(amount)
            store.staking.creating-staking-account = no
            create-staking-account.InProcess = no
            return alert store, lang.minimalStakeMustBe + " #{(min_stake)} VLX"
        if +main_balance < +amount
            store.staking.creating-staking-account = no
            create-staking-account.InProcess = no
            return alert store, lang.balanceIsNotEnoughToSpend + " #{(amount)} VLX"
        amount = buffer.amount * 10^9
        err, result <- as-callback web3t.velas.NativeStaking.createAccount(amount)
        if err?
            create-staking-account.InProcess = no
            store.staking.creating-staking-account = no
            if ((err.toString! ? "").index-of("custom program error: 0x1")) > -1
                err = lang.balanceIsNotEnoughToCreateStakingAccount
            return alert store, err.toString!
        if result.error? then
            create-staking-account.InProcess = no
            store.staking.creating-staking-account = no
            error-msg = result.description ? "An unexpected error occurred during account creation."
            return alert store, error-msg, cb
        signature = result
        err <- creation-account-subscribe({ store, web3t, signature, acc_type: "create", inProcess: create-staking-account.InProcess })
        if err?
            console.log "creation-account-subscribe err"
            create-staking-account.InProcess = no
            store.staking.creating-staking-account = no
            return alert store, err, cb
        create-staking-account.InProcess = no
        store.staking.creating-staking-account = no
        if store.staking.webSocketAvailable is no
            <- notify store, lang.accountCreatedAndFundsDeposited
    totalOwnStakingAccounts = store.staking.totalOwnStakingAccounts ? 0
    loadingAccountIndex = Math.min(totalOwnStakingAccounts, store.staking.loadingAccountIndex)
    perPage =  store.staking.accounts_per_page
    page = store.staking.current_accounts_page
    pagination-disabled = store.staking.accounts-are-loading is yes
    fetch-error-occurred =
        | store.errors.fetchAccounts? and store.staking.accounts-are-loading is no => yes
        | _ => no
    svg-icon =
        svg.pug(width='15px' height='15px' viewBox='0 0 15 15' version='1.1' xmlns='http://www.w3.org/2000/svg')
            g.pug(xmlns="http://www.w3.org/2000/svg" transform="matrix(0.026385223 0 0 0.026385223 -0 0.029023906)")
                g.pug(xmlns="http://www.w3.org/2000/svg" transform="matrix(0.1 0 -0 -0.1 0 340)")
                    path.pug(xmlns="http://www.w3.org/2000/svg" d="M1796 2907C 1749 2827 1701 2743 1515 2420C 1407 2230 1275 2001 1222 1910C 1170 1819 1110 1716 1090 1680C 950 1438 891 1334 845 1255C 816 1206 747 1084 690 985C 633 886 554 749 514 680L514 680L441 555L1130 552C 1510 551 2130 551 2508 552L2508 552L3197 555L3102 720C 3050 811 2991 914 2970 950C 2950 986 2856 1150 2761 1315C 2665 1480 2510 1750 2415 1915C 1758 3060 1827 2940 1820 2940C 1817 2940 1806 2925 1796 2907z" stroke="none" fill="rgb(255 215 0)" fill-rule="nonzero")
    .pug.staking-accounts-content
        loader { loading: store.staking.creating-staking-account, text: "Creating staking account..." }
        .pug
            .form-group.pug(id="create-staking-account")
                .pug.section.create-staking-account 
                    .title.pug
                        h3.pug #{lang.createStakingAccount}
                    .description.pug
                        if store.staking.creating-staking-account is yes
                            span.pug
                                button {store, classes: "width-auto", text: "Creating...", no-icon:yes, on-click: create-staking-account, makeDisabled: yes, style: {width: \auto, display: \block}}
                        else
                            span.pug
                                button {store, classes: "width-auto", text: lang.createAccount, no-icon:yes, on-click: create-staking-account, style: {width: \auto, display: \block}}
                        if store.staking.accounts.length is 0
                            span.pug.notification-entity(style=notification-border) Please create a staking account before you stake
                        else 
                            span.pug.notification-entity(style=notification-border) #{lang.youCanStakeMore}
        .pug
            .form-group.pug(id="staking-accounts")
                .pug.section
                    .title.pug
                        h3.pug.section-title #{lang.yourStakingAccounts} 
                            span.pug.amount (#{store.staking.accounts.length})
                        if not store.staking.webSocketAvailable or fetch-error-occurred or (store.errors.fetchValidators? and store.staking.pools-are-loading is no)
                            .pug
                                .loader.pug(on-click=refresh style=icon-style title="refresh" class="#{isSpinned}")
                                    icon \Sync, 25
                        if fetch-error-occurred
                            .pug.pointer-container
                                svg-icon
                                .shadow-icon.pug
                    .description.pug
                        if store.errors.fetchAccounts?
                            .pug.error
                                span.pug.warning-icon ⚠️
                                .pug.message An error occurred during fetching stake accounts. Please try one more time...
                        else
                            .pug.cont
                                if store.staking.accounts-are-loading is no then
                                    .pug.table-scroll
                                        table.pug
                                            thead.pug
                                                tr.pug
                                                    td.pug(width="3%" style=stats) #
                                                    td.pug(width="40%" style=staker-pool-style title="Your Staking Account") #{lang.account} (?)
                                                    td.pug(width="10%" style=stats title="Your Deposited Balance") #{lang.balance} (?)
                                                    td.pug(width="30%" style=stats title="Where you staked") #{lang.validator} (?)
                                                    td.pug(width="7%" style=stats title="The ID of your stake. This is made to simplify the search of your stake in validator list") ID (?)
                                                    if no
                                                        td.pug(width="10%" style=stats title="Current staking status. Please notice that you cannot stake / unstake immediately. You need to go through the waiting period. This is made to reduce attacks by staking and unstaking spam.") #{lang.status} (?)
                                                    td.pug(width="10%" style=stats) #{(lang.action ? "Action")}
                                            tbody.pug
                                                paginate( (store.staking.accounts |> sort-by (.seed-index)), perPage, page)
                                                    |> map build store, web3t
                                if store.staking.accounts-are-loading is no then
                                    pagination {store, type: \accounts, disabled: pagination-disabled, config: {array: store.staking.accounts }}
                                else
                                    .pug.table-scroll
                                        span.pug.entities-loader
                                            span.pug.inner-section
                                                h3.pug.item.blink Loading...
                                                    span.pug.item  #{loadingAccountIndex}
                                                    span.pug.item of
                                                    span.pug.item  #{totalOwnStakingAccounts}
staking-accounts = ({ store, web3t })->
    .pug.staking-accounts-content
        staking-accounts-content store, web3t
stringify = (value) ->
    if value? then
        round-human(parse-float value `div` (10^18))
    else
        '..'
module.exports = staking-accounts