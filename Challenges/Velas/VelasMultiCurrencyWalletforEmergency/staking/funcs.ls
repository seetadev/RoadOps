require! {
    \prelude-ls : { map, split, filter, find, foldl, drop, take, sum, unique }
    \../math.ls : { div, times, plus, minus }
    \bs58
    \buffer :{Buffer}
}
toBase58 = (obj)->
    bs58.encode(obj)
toBuffer = (arr) ->
    if arr instanceof Buffer
        arr
    else
        if arr instanceof Uint8Array then Buffer.from arr.buffer, arr.byteOffset, arr.byteLength else Buffer.from arr  
SIMULATION_COUNT = 14600
EPOCHS_PER_YEAR = 1460
VALIDATOR_COUNT = 19
as-callback = (p, cb)->
    p.catch (err) -> cb err
    p.then (data)->
        cb null, data
choose-random-pool = (pools) ->
    total-stake = 0
    for pool in pools
        total-stake += parse-float pool.stake
    point = Math.random! * total-stake
    return 0 if +total-stake is 0
    i = 0
    counter = 0
    while counter < point
        counter += parse-float pools[i].stake
        i++
    return i - 1
simulate-choose-validators = (pools) ->
    pools-copy = [...pools]
    validators = []
    for i from 1 to VALIDATOR_COUNT
        return validators if pools-copy.length is 0
        pool-index = choose-random-pool pools-copy
        validators.push pools-copy[pool-index]
        pools-copy.splice pool-index, 1
    return validators
simulate-validators-stats = (pools, count) ->
    pools-copy = pools.filter((item) -> item).map((item, index) -> {...item, index})
    for pool in pools-copy
        if pool.status isnt \active
            pool.stake = \0
            pool.node-stake = \0
    rewards-per-index = []
    for i from 1 to pools.length
        rewards-per-index.push {rewards: 0, validator-count: 0}
    for i from 1 to count
        validators = simulate-choose-validators pools-copy
        validators-stake = validators.reduce ((acc, curr) -> acc + parse-float curr.stake), 0
        validator-reward = 5/6147.368421052632/100 * validators-stake / VALIDATOR_COUNT
        for validator in validators
            rewards-per-index[validator.index].rewards += validator-reward
            rewards-per-index[validator.index].validator-count++
    return rewards-per-index
calc-pools-rewards = (all-pools) ->
    stat = simulate-validators-stats all-pools, SIMULATION_COUNT
    for i from 0 to all-pools.length - 1
        pool = all-pools[i]
        node-stake = parse-float pool.node-stake
        total-stake = parse-float pool.stake
        delegator-part = Math.min(0.6, (total-stake - node-stake) / total-stake)
        node-part = 1 - delegator-part
        all-pools[i].delegate-reward = delegator-part * stat[i].rewards / SIMULATION_COUNT * EPOCHS_PER_YEAR
        all-pools[i].node-reward = node-part * stat[i].rewards / SIMULATION_COUNT * EPOCHS_PER_YEAR
        all-pools[i].validator-probability = stat[i].validator-count / SIMULATION_COUNT
    return all-pools
fill-pools = ({ store, web3t, on-progress, on-finish }, [item, ...rest]) ->
    staking-address = store.staking.keystore.staking.address
    if not item? then
        store.staking.all-pools-loaded = yes
        store.staking.pools-are-loading = no
        return on-finish null, []
    if (([\validators, \info].index-of(store.current.page)) is -1) then
        store.staking.all-pools-loaded = no
        store.staking.pools-are-loading = no
        return on-finish null, []
    item.stake = item.activatedStake
    #err, delegators <- web3t.velas.Staking.poolDelegators(item.address)
    #return on-finish err if err?
    tokenAccountsFilter = {}
    ownerAddress = item.votePubkey
    err, res <- as-callback web3t.velas.NativeStaking.getInfo()
    console.log ".getInfo" res
    return on-finish err if err?
    item.stakers = delegators.length + 1
    #err, mining-address <- web3t.velas.ValidatorSet.miningByStakingAddress(item.address)
    #return on-finish err if err?
    #item.mining-address = mining-address
    item.mining-address = ''
    err, validator-reward-percent <- web3t.velas.BlockReward.validatorRewardPercent item.address
    return on-finish err if err?
    item.validator-reward-percent = validator-reward-percent `div` 10000
    err, is-validator-banned <- web3t.velas.ValidatorSet.isValidatorBanned(mining-address)
    return on-finish err if err?
    err, amount <- web3t.velas.Staking.stakeAmount item.address, staking-address
    return on-finish err if err?
    err, node-stake <- web3t.velas.Staking.stakeAmount item.address, item.address
    return on-finish err if err?
    err, withdraw-amount <- web3t.velas.Staking.orderedWithdrawAmount item.address, staking-address
    return on-finish err if err?
    item.withdraw-amount = withdraw-amount
    item.my-stake = amount
    status =
        | item.epochVoteAccount is yes => \active
        | is-validator-banned => \banned
        | _ => \inactive
    item.status = status
    item.node-stake = node-stake
    on-progress [item, ...rest] if on-progress?
    on-finish-local = (err, pools) ->
        on-finish err, [item, ...pools]
    on-progress-local = (pools) ->
        on-progress [item, ...pools]
    fill-pools { store, web3t, on-progress: on-progress-local, on-finish: on-finish-local }, rest
query-pools-web3t = (store, web3t, on-progress, on-finish) ->
    err, result <- as-callback web3t.velas.NativeStaking.getStakingValidators()
    return cb err if err?
    pools = result
    console.log "Validators are:" result
    #err, pools-inactive <- web3t.velas.Staking.getPoolsInactive
    #return cb err if err?
    #err, pools <- web3t.velas.Staking.getPools
    #return cb err if err?
    #all-pools = pools ++ pools-inactive
    all-pools = pools
    store.staking.pools-are-loading = yes
    fill-pools { store, web3t, on-progress, on-finish }, all-pools
query-pools = (store, web3t, on-progress, on-finish) ->
    err, pools <- query-pools-web3t store, web3t, on-progress
    return on-finish err if err?
    calc-pools-rewards pools
    on-finish err, pools
module.exports = { query-pools }