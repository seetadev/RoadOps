require! {
    \react
    \../components/amount-field.ls
    \../components/text-field.ls
    \../components/button.ls
    \./confirmation.ls : { alert }
    \../staking/can-make-staking.ls
    \../../web3t/addresses.js : { vlxToEth, ethToVlx }
    \../get-lang.ls
    \../math.ls : { div, times, plus, minus }
    \../api.ls : { is-valid-address }
    \prelude-ls : { filter } 
    \../round-number.ls   
}
.section
    .not-enough
        color: red  
        min-height: 33px
        padding: 0 4px
        font-size: 12px
        max-height: 20px
        overflow: hidden
try-parse-address = (address, cb)->
    try 
        cb null, vlxToEth(address)
    catch err
        cb err
module.exports = (store, web3t)->
    return null if not store.staking.chosen-pool?
    return null if +store.staking.stake-amount-total is 0
    return null if +store.staking.maxWithdrawAllowed is 0
    staking-address = store.staking.keystore.staking?address
    return null if not staking-address?
    lang = get-lang store
    store.staking.error = store.staking.error ? ""     
    cb = console.log
    wallets = store.current.account.wallets |> filter (it) -> it.coin.token is \vlx2 
    return cb "VLX Wallet not found" if wallets.length is 0
    wallet = wallets.0   
    move-stake = ->
        return if (store.staking.error? and ("#{store.staking.error}" .length > 0)) or store.staking.add.new-address is ""         
        pool-address = store.staking.chosen-pool.address
        my-stake = store.staking.chosen-pool.my-stake `div` (10^18) 
        err, new-pool-address <- try-parse-address store.staking.add.new-address
        return alert store, err, cb if err?      
        err, new-pool-staked <- web3t.velas.Staking.stakeAmount new-pool-address, staking-address
        return cb err if err? 
        new-pool-stake-rounded = +(new-pool-staked.to-fixed! `div` (10^18))
        # check if pool FROM has stake at least 10k and move-amount minus From stake is more or eq 10k 
        if +my-stake < 10000 then
            return alert store, "Your stake must be more than 10000 VLX in order to move stake to another pool", cb
        # If try to move NOT FULL stake
        if (+my-stake - +store.staking.add.move-stake) isnt 0 then
            # if after moving stake amount, pool FROM amount become LESS than 10k 
            if (+my-stake - +store.staking.add.move-stake) < 10000 then
                max-move-amount = Math.max (+my-stake - +store.staking.add.move-stake), 0
                return alert store, "The pool stake amount after moving #{store.staking.add.move-stake} VLX must be at least 10000 VLX or no stake at all.", cb             
        # check if new-pool has ZERO (<10k) STAKE & stake amount IS LESS than 10k 
        if +new-pool-stake-rounded < 10000 and +store.staking.add.move-stake < 10000 then
            return alert store, "Move stake amount must be more or equal to 10000 VLX.", cb        
        err <- can-make-staking store, web3t
        return alert store, err, cb if err?
        stake = store.staking.add.move-stake
        err, max <- web3t.velas.Staking.maxWithdrawAllowed(pool-address, staking-address)
        return alert store, err, cb if err?
        max-allowed = max.to-fixed! `div` (10^18)
        return alert store, "You cannot move from the pool which is a validator or going to become one. Please use Request Exit feature instead." if +max-allowed is 0  
        return alert store, "Stake must be lower or equal to max allowed #{max-allowed}", cb if +stake > +max-allowed
        return alert store, "Stake must be more then 0", cb if +stake is 0 
        amount = stake `times`(10^18)
        data = web3t.velas.Staking.move-stake.get-data pool-address, new-pool-address, amount
        to = web3t.velas.Staking.address
        err <- web3t.vlx2.send-transaction { to, data, amount: 0 }
    change-stake = (it)->
        amount = it.target.value    
        decimalsConfig = wallet.network.decimals
        decimals = amount.toString!.split(".").1
        if decimals? and (decimals.length > decimalsConfig) then
            amount = round-number amount, {decimals: decimalsConfig}   
        max-amount = 1e18
        return no if +amount > max-amount
        store.staking.add.move-stake = amount 
    change-address = (it)!->
        address = (it.target.value ? "").trim!  
        store.staking.add.new-address = address 
        return store.staking.error = "Address is empty" if address.length is 0    
        cb = console.log  
        err <- is-valid-address { address: store.staking.add.new-address, network: wallet.network } 
        return store.staking.error = "Address is not valid" if err? and ("#{err}".index-of "Given address is not valid Velas address") > -1   
        store.staking.error = ''
    .pug.section
        .title.pug
            h3.pug #{lang.moveStake}
        .description.pug
            .pug
                label.pug #{lang.moveAmount}
                amount-field { store, value: store.staking.add.move-stake , on-change: change-stake , placeholder: lang.stake }
            .pug
                label.pug #{lang.newPoolAddress}
                text-field { store, value: store.staking.add.new-address , on-change: change-address , placeholder: lang.stake }
                .pug.control-label.not-enough.text-left(title="#{store.staking.error}") #{store.staking.error}
            .pug
                button { store, on-click: move-stake , type: \secondary , icon : \apply , text: \btnApply }