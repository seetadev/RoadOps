require! {
    \prelude-ls : { map, split, filter, find, foldl, drop, take, sum, unique, pairs-to-obj, sort-by, reverse, each , findIndex}
    \./math.ls : { div, times, plus, minus }
    \./round-human.ls
    '../web3t/providers/superagent.js' : { get }
    "../web3t/providers/solana/index.cjs" : \velasWeb3
    \./api.ls : { get-transaction-info }
}
down = (it)->
    (it ? "").toLowerCase!
SIMULATION_COUNT = 14600
EPOCHS_PER_YEAR = 1460
VALIDATOR_COUNT = 19
as-callback = (p, cb)->
    p.catch (err) -> cb err
    p.then (data)->
        cb null, data
get-stakes-from-stakes-accounts = (store, item)->
    found = store.staking.accounts
        |> filter (it)->
            +it.activationEpoch < +it.deactivationEpoch and it?voter is item.key
    stakes =
        | found.length > 0 =>
            found |> map (-> {seed: it.seed, item: it, stake: it.stake})
        | _ => []
    return stakes
fill-pools = ({ store, web3t, on-progress}, on-finish, [item, ...rest]) ->
    if not item? then
        store.staking.all-pools-loaded = yes
        store.staking.pools-are-loading = no
        return on-finish null, []
    if (([\validators, \info, \account_details, \poolchoosing, \pool_details].index-of(store.current.page)) is -1) then
        store.staking.all-pools-loaded = no
        store.staking.pools-are-loading = no
        return on-finish null, []
#    store.staking.loadingValidatorIndex += 1
    item.activatedStake = item.activatedStake
    item.balanceRaw = item.activatedStake
    item.address = item.key
    item.stake = item.stake
    item.stake-initial = item.activatedStake
    item.status = status
    item.commission = item.commission
    item.credits_observed =
        item.epochCredits
            |> map (it)->
                it[1]
            |> foldl plus, 0
    item.delegators = store.staking.delegators[down(item.votePubkey)] ? 0
    stakes = get-stakes-from-stakes-accounts(store, item)
    item.stakes = stakes
    on-progress [item, ...rest] if on-progress?
    on-finish-local = (err, pools) ->
        on-finish err, [item, ...pools]
    on-progress-local = (pools) ->
        on-progress [item, ...pools]
    fill-pools { store, web3t, on-progress: on-progress-local}, on-finish-local, rest
load-validators-from-cache = ({store, web3t}, cb)->
    DEADLINE = 60000 # 1 minute
    last-time = store.staking.last-time ? new Date().getTime()
    now = new Date().getTime()
    network = store.current.network
    cachedNetwork = store.staking.cachedValidatorsNetwork
    if now `minus` last-time <= DEADLINE and store.staking.cachedValidators? and store.staking.cachedValidators.length
        if cachedNetwork is network then
            cache-result = store.staking.cachedValidators  
            return cb null, cache-result  
    err, validators <- as-callback web3t.velas.NativeStaking.getStakingValidators()
    console.error "GetStakingValidators err: " err if err?
    return cb err if err?
    store.staking.cachedValidators = validators  
    store.staking.cachedValidatorsNetwork = network
    store.staking.last-time = new Date().getTime()
    cb null, validators    
query-pools-web3t = ({store, web3t, on-progress}, on-finish) -> 
    err, validators <- load-validators-from-cache { store, web3t }
    return on-finish err if err?
    store.staking.totalValidators = validators.length
    store.staking.pools-are-loading = yes
    fill-pools { store, web3t, on-progress}, on-finish, validators
query-pools = ({store, web3t, on-progress}, on-finish) ->
    fill-delegators(store, web3t)      
    err, pools <- query-pools-web3t {store, web3t, on-progress}
    return on-finish err if err?
    on-finish null, pools
fill-delegators = (store, web3t)->
    accounts = store.staking.parsedProgramAccounts
    Array.from(accounts, fill-delegator(store, web3t))
fill-delegator = (store, web3t, acc)-->
    return if not acc?
    { voter, activationEpoch, deactivationEpoch } = acc
    if (voter and (Number(deactivationEpoch) > Number(activationEpoch) or activationEpoch is web3t.velas.NativeStaking.max_epoch))
        store.staking.delegators[down(voter)] = if store.staking.delegators[down(voter)]? then (store.staking.delegators[down(voter)] + 1) else 1
# Accounts
query-accounts = (store, web3t, on-progress, on-finish) ->
    accountIndex = store.current.accountIndex
    network = store.current.network
    cachedNetwork = store.staking.cachedAccountsNetwork
    if (store.staking.getAccountsFromCashe is yes) and store.staking.accountsCached[accountIndex]? and store.staking.accountsCached[accountIndex].length > 0
        if cachedNetwork is network then
            #console.log "get accounts from cache"
            store.staking.all-accounts-loaded = yes
            store.staking.accounts-are-loading = no
            return on-finish null, store.staking.accountsCached[accountIndex]
    err, accounts <- query-accounts-web3t store, web3t, on-progress
    return on-finish err if err?
    store.staking.accountsCached[accountIndex] = accounts
    store.staking.cachedAccountsNetwork = network
    on-finish err, accounts
update-loader-var = (store, config, value)!->
    return if value not in <[ yes no ]>
    return if not config?
    return if not store?
    if config.acc_type is \split
        store.staking.splitting-staking-account = value
    if  config.acc_type is \create
        store.staking.creating-staking-account = value
add-stake-account = (store, web3t, tx-info, config, on-progress, on-finish) ->
    console.log "[add-stake-account]"
    accounts = store.staking.accounts
    acc_type = config.acc_type
    if acc_type not in <[ split create ]>
        return on-finish "Unknown type for acc_type"
    update-loader-var(store, config, yes)
    { instructions } = tx-info?data?transaction?message
    if instructions[0]?parsed?type isnt "createAccountWithSeed" then
        update-loader-var(store, config, no)
        return on-finish "Not expected transaction type. Expected 'createAccountWithSeed' type."
    seed = instructions?0?parsed?info?seed
    info =
        | acc_type is \split => instructions?1?parsed?info
        | _ => instructions?0?parsed?info
    stakeAccount =
        | acc_type is \split => info?newSplitAccount
        | _ => info?newAccount
    /* Avoid duplicates of stake accounts on UI */
    already-exists = store.staking.parsedProgramAccounts |> find (-> it.pubkey is stakeAccount)
    if already-exists?
        console.error "acc already exists"
        return
    staker =
        | acc_type is \split => info?stakeAuthority
        | _ => info?source
    lamports     = info?lamports
    custodian    = staker
    { activationEpoch, deactivationEpoch } = config
    balanceRaw = lamports `minus` '2282880'
    pubKey = new velasWeb3.PublicKey(stakeAccount)
    account = {
        activationEpoch: activationEpoch
        address: stakeAccount
        balanceRaw
        balance: Math.round(balanceRaw `div` (10^9))
        creditsObserved: 0
        credits_observed: 0
        custodian
        deactivationEpoch: deactivationEpoch
        epoch: 0
        key: stakeAccount
        lamports
        pubkey: stakeAccount
        pubKey
        rent: "2282880" `div` (10^9)
        rentRaw: "2282880"
        rentExemptReserve: "2282880"
        seed: "stake:#{seed}"
        seedIndex: seed
        staker
        status: 'loading'
        voter: config.voter
        validator: config.voter
        withdrawer: staker
        highlight: yes
    }
    store.staking.parsedProgramAccounts.push(account)
    err, accs <- as-callback web3t.velas.NativeStaking.getOwnStakingAccounts(store.staking.parsedProgramAccounts)
    if err?
        update-loader-var(store, config, no)
        return on-finish err
    web3t.velas.NativeStaking.setAccounts(accs);
    store.staking.accounts.push(account)
    update-loader-var(store, config, no)
    /* Subscribe to the changes of created stake account */
    store.staking.accounts
        |> filter (a)->
            a.address is stakeAccount
        |> each (it)->
            publicKey  = it.pubKey
            subscribe-to-stake-account({store, web3t, account: it, publicKey: pubKey})
    search-new-account(store, stakeAccount)
    on-finish null
filter-pools = (pools)->
    store.staking.pools = convert-pools-to-view-model pools
        |> sort-by (-> it.myStake.length )
    delinquent = store.staking.pools |> filter (-> it.status is "delinquent")
    running = store.staking.pools
        |> filter (it)->
            delinquent.index-of(it) < 0
        |> reverse
    store.staking.pools = running ++ delinquent
updateStakeAccount = ({ store, account, updatedAccount, cb })->
    updateStakeAccount[account.pubkey] = account.pubkey
    console.log "updateStakeAccount" {account, updatedAccount}
    if not account?
        updateStakeAccount[account.pubkey] = null
        console.log("No account was found")
        return
    { lamports, data } = updatedAccount
    if not data?parsed?info
        index = store.staking.accounts |> findIndex (-> it.pubkey is account.pubkey)
        if index > -1
            store.staking.accounts.splice(index,1)
    else
        { meta, stake } = data?parsed?info
        { lockup, rentExemptReserve, authorized } = meta
        creditsObserved = stake?creditsObserved
        delegation = stake?delegation
        activationEpoch = delegation?activationEpoch ? 0
        deactivationEpoch = delegation?deactivationEpoch ? 0
        stake = delegation?stake ? 0
        voter = delegation?voter ? null
        updates = { lamports: updatedAccount.lamports, stake, validator: voter, voter, rentExemptReserve, creditsObserved, activationEpoch, deactivationEpoch }
        account <<<< updates
    on-progress = ->
        store.staking.pools = convert-pools-to-view-model [...it]
    err, pools <- query-pools { store, web3t, on-progress }
    return cb err if err?
    filter-pools(pools)
/* If find set to true, then we first found account from store.staking.accounts by publicKey */
subscribe-to-stake-account = ({store, web3t, account, publicKey, find, cb})->
    if account.subscriptionID?
        return cb null if cb?
        return
    #console.log "[subscribe-to-stake-account]" publicKey.toBase58()
    commitment = 'confirmed'
    callback   = (updatedAccount)->
        updateStakeAccount({ store, account, updatedAccount, cb })
    subscriptionID = web3t.velas.NativeStaking.connection.onAccountChange(publicKey, callback, commitment)
    account.subscriptionID = subscriptionID
    store.staking.subscribedAccounts[account.pubkey] = yes
highlight = (store, AccountIndex)->
    return if not store.staking.accounts[AccountIndex]?
    <- set-timeout _, 6500
    store.staking.accounts[AccountIndex].highlight = no
query-accounts-web3t = (store, web3t, on-progress, on-finish) ->
    native-wallet = store.current.account.wallets |> find(-> it.coin.token is "vlx_native")
    validatorsBackend = native-wallet.network.api.validatorsBackend + \/v1/staking-accounts
    err, data <- get validatorsBackend .end
    console.log "[get validatorsBackend err]" err if err?
    return on-finish err if err?
    nativeAccountsFromBackendResult = data?body?stakingAccounts ? []
    console.error "[query-accounts-web3t] get parsedProgramAccounts err:", err if err?
    parsedProgramAccounts = nativeAccountsFromBackendResult ? []
    store.staking.parsedProgramAccounts = parsedProgramAccounts
    err, accs <- as-callback web3t.velas.NativeStaking.getOwnStakingAccounts(parsedProgramAccounts)
    accs = [] if err?
    web3t.velas.NativeStaking.setAccounts(accs);
    store.staking.totalOwnStakingAccounts = accs.length
    return on-finish err if err?
    store.staking.accounts-are-loading = yes
    fill-accounts { store, web3t, on-progress, on-finish }, accs
fill-accounts = ({ store, web3t, on-progress, on-finish }, [item, ...rest]) ->
    if not item? then
        store.staking.all-accounts-loaded = yes
        store.staking.accounts-are-loading = no
        return on-finish null, []
    if (([\validators, \info, \account_details, \pool_details].index-of(store.current.page)) is -1) then
        store.staking.all-accounts-loaded = no
        store.staking.accounts-are-loading = no
        return on-finish null, []
    store.staking.loadingAccountIndex += 1
    rent = item?rentExemptReserve
    #TODO: in future change seed with address and do not display this field
    err, seed <- as-callback web3t.velas.NativeStaking.checkSeed(item.pubkey)
    item.seed    = seed
    item.seed-index  = +((item.seed + "").split(":").1 )
    item.address = item.pubkey
    item.pubKey   = new velasWeb3.PublicKey(item.pubkey)
    item.key     = item.pubkey
    item.rentRaw = rent
    item.balanceRaw = if rent? then (item.lamports `minus` rent) else '-'
    item.balance = if rent? then (Math.round((item.lamports `minus` rent) `div` (10^9)) `times` 100) `div` 100  else "-"
    item.rent    = if rent? then (rent `div` (10^9)) else "-"
    item.credits_observed = item.creditsObserved ? 0
    item.status  = "inactive"
    item.validator = item.voter
    { activationEpoch, deactivationEpoch, voter } = item
    if (activationEpoch and deactivationEpoch) then
        if (Number(deactivationEpoch) > Number(activationEpoch) or Number(activationEpoch) is web3t.velas.NativeStaking.max_epoch) then
            item.status    = "loading"
            item.validator = voter
    on-progress [item, ...rest] if on-progress?
    on-finish-local = (err, pools) ->
        on-finish err, [item, ...pools]
    on-progress-local = (pools) ->
        on-progress [item, ...pools]
    fill-accounts { store, web3t, on-progress: on-progress-local, on-finish: on-finish-local }, rest
###################    
convert-accounts-to-view-model = (accounts) ->
    res =
        accounts
            |> map -> {
                address: it.key ? '..'
                activationEpoch: it.activationEpoch,
                deactivationEpoch: it.deactivationEpoch,
                key: it.key
                pubKey: it.pubKey
                balanceRaw: it.balanceRaw ? 0
                balance: if it.balance? then round-human(it.balance) else '..'
                rent: if it.rent? then it.rent else "-"
                lastVote: it.lastVote ? '..'
                seed: it.seed ? '..'
                validator:  it?validator ? ""
                status: it.status ? "inactive"
                active_stake: it?active_stake ? 0
                inactive_stake: it?inactive_stake ? 0
                seed-index:  it.seed-index
                credits_observed: it.credits_observed
                voter: it.voter
            }
    res
##################
convert-pools-to-view-model = (pools) ->
    pools
        |> map -> {
            address: it.key ? '..',
            balanceRaw: it.activatedStake,
            checked: no,
            stake: if it.stake? then it.stake else '..',
            stake-initial: if it.activatedStake? then parse-float it.activatedStake `div` (10^9) else 0,
            commission: it.commission
            lastVote: if it.lastVote then round-human(it.lastVote) else '..'
            stakers: if it.delegators? then it.delegators else '..',
            is-validator:  (it?stakes? and it.stakes.length isnt 0) ? false,
            status: if it?delinquent is yes then "delinquent" else it.status,
            my-stake: if it?stakes then it.stakes else []
            credits_observed : it.credits_observed
        }
check-tx-confirmation = ({start, network, tx}, cb)->
    ->
        if Date.now! > (start + 60000)
            return cb "Transaction approve timeout has expired. Try to repeat later."
        err, more-info <- get-transaction-info { token: "vlx_native", network, tx }
        if more-info?status is \confirmed or more-info?info?status is "0x1"
            cb null, more-info
check-tx = ({start, network, tx}, cb)->
    timer-cb = (err, res)->
        clearInterval(check-tx.timer)
        return cb err, res
    check-tx.timer = set-interval check-tx-confirmation({start, network, tx}, timer-cb), 1000
creation-account-subscribe = ({ store, web3t, signature, timeout, acc_type, activationEpoch, deactivationEpoch, voter, inProcess }, cb)->
    return cb "[Creation-account-subscribe] error: Signature is required" if not signature?
    commitment = 'confirmed'
    if store.staking.webSocketAvailable is no
        return cb null
    callback = (data)->
        if data.err? then
            store.staking.creating-staking-account = no
            return cb "An error occurred during stake account creation."
        store.staking.getAccountsFromCashe = yes
        wallet = store.current.account.wallets |> find -> it.coin.token is \vlx_native
        if not wallet?
            store.staking.creating-staking-account = no
            return cb "Velas Native wallet not found!"
        err, info <- check-tx({network: wallet.network, tx: signature, start: Date.now()})
        if info?status is "pending" then
            store.staking.creating-staking-account = no
            return cb "Split transaction still in process. It may take several minutes"
        if err?
            store.staking.creating-staking-account = no
            return cb "An error occurred during stake account creation: " + err
        on-progress = ->
        err <- add-stake-account(store, web3t, info, { acc_type, activationEpoch, deactivationEpoch, voter, inProcess }, on-progress)
        if err?
            store.staking.creating-staking-account = no
            return cb err
        store.staking.creating-staking-account = no
        info-data = info?data?transaction?message?instructions?0?parsed?info
        return cb null if not info-data?
        pubkey = info-data?newAccount
        search-new-account(store, pubkey)
        return cb null if acc_type isnt \split
        on-progress = ->
            store.staking.pools = convert-pools-to-view-model [...it]
        err, pools <- query-pools {store, web3t, on-progress}
        filter-pools(pools)
        cb null
    try
        web3t.velas.NativeStaking.connection.onSignature(signature, callback, commitment)
    catch err
        store.staking.creating-staking-account = no
        console.log "Account creation error: ", err
        return cb "An error occurred during stake account creation."
search-new-account = (store, pubkey)->
    index = store.staking.accounts
        |> sort-by (.seed-index)
        |> findIndex (-> it.pubkey is pubkey)
    return if index < 0
    return if not store.staking.accounts[index]?
    perPage =  store.staking.accounts_per_page
    store.staking.current_accounts_page = Math.ceil((index + 1) `div` perPage)
    highlight(store, index)
module.exports = { creation-account-subscribe, add-stake-account, filter-pools, subscribe-to-stake-account, query-pools, query-accounts, convert-accounts-to-view-model, convert-pools-to-view-model }