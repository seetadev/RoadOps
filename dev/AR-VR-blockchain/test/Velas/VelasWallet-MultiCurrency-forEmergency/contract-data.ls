require! {
    \./math.ls : { times, minus, div, plus }
    \./browser/window.ls
    \bignumber.js
    \./round.ls
    \./round5.ls
    \./round5edit.ls
    \./round-number.ls  
    \./round-human.ls  
    \prelude-ls : { map, find }
    \./web3.ls
    \./api.ls : { calc-fee }
    \./apply-transactions.ls
    \./get-tx-details.ls
    \ethereumjs-util : {BN}
    \bs58
    \assert   
    \./velas/velas-web3.ls
}
abis =
    EvmToNativeBridge: require("../web3t/contracts/EvmToNativeBridge.json").abi 
    HomeBridgeNativeToErc  : require("../web3t/contracts/HomeBridgeNativeToErc.json").abi 
    ForeignBridgeNativeToErc : require("../web3t/contracts/ForeignBridgeNativeToErc.json").abi 
    ERC20BridgeToken: require("../web3t/contracts/ERC20BridgeToken.json").abi    
    ERC677BridgeToken: require("../web3t/contracts/ERC20BridgeToken.json").abi
    HomeERC677Bridge: require("../web3t/contracts/HomeBridgeNativeToErc.json").abi 
    ForeignBridgeErcToErc: require("../web3t/contracts/ForeignBridgeErcToErc.json").abi
module.exports = ({store})->
    return null if not store??
    { send } = store.current
    { wallet, fee-type } = send
    return null if not wallet?
    up = (str)->
        (str ? "").trim!.to-upper-case!    
    is-self-send = up(wallet.address) is up(store.current.send.to)  
    /* 
    * Swap from USDC to USDC VELAS
    */  
    usdc_to_usdc_velas_swap = (token, chosen-network, cb)->   
        return cb null if not (token is \usdc and chosen-network.id is \vlx_usdc)
        web3 = velas-web3 store
        { FOREIGN_BRIDGE, FOREIGN_BRIDGE_TOKEN } = wallet.network  
        value = store.current.send.amountSend 
        value = (value `times` (10^6))  
        receiver = send.to    
        { coin, gas, gas-price, amount-send, amount-send-fee, fee-type, network, tx-type } = send 
        web3 = new Web3(new Web3.providers.HttpProvider(wallet?network?api?web3Provider))
        web3.eth.provider-url = wallet?network?api?web3Provider            
        contract = web3.eth.contract(abis.ForeignBridgeErcToErc).at(FOREIGN_BRIDGE)          
        data = 
            | is-self-send is yes => contract.transfer.get-data(FOREIGN_BRIDGE, value)
            | _ => contract.relayTokens.get-data(receiver, value) 
        contract-address =
            | is-self-send is yes => FOREIGN_BRIDGE_TOKEN
            | _ => FOREIGN_BRIDGE     
        store.current.send.contract-address = contract-address
        store.current.send.data = data             
        cb null, data  
    /* 
    * Swap from USDC VELAS to USDC
    */     
    usdc_velas_to_usdc_swap = (token, chosen-network, cb)->     
        return cb null if not (token is \vlx_usdc and chosen-network.id is \usdc)
        web3 = velas-web3 store
        { HOME_BRIDGE, HOME_BRIDGE_TOKEN } = wallet.network
        return cb "HOME_BRIDGE is not defined" if not HOME_BRIDGE?
        return cb "HOME_BRIDGE_TOKEN is not defined" if not HOME_BRIDGE_TOKEN?
        value = store.current.send.amountSend 
        value = (value `times` (10^6))  
        web3 = new Web3(new Web3.providers.HttpProvider(wallet?network?api?web3Provider))
        web3.eth.provider-url = wallet?network?api?web3Provider
        contract = web3.eth.contract(abis.ERC20BridgeToken).at(HOME_BRIDGE)    
        data = contract.transferAndCall.get-data(HOME_BRIDGE, value, send.to)
        store.current.send.contract-address = HOME_BRIDGE_TOKEN
        store.current.send.data = data  
        cb null, data
    busd_velas_to_busd_swap = (token, chosen-network, cb)->
        return cb null if not (token is \vlx_busd and chosen-network.id is \busd)
        web3 = velas-web3 store
        { HOME_BRIDGE, HOME_BRIDGE_TOKEN } = wallet.network  
        value = store.current.send.amountSend 
        value = (value `times` (10^18))  
        receiver = send.to 
        web3 = new Web3(new Web3.providers.HttpProvider(wallet?network?api?web3Provider))
        web3.eth.provider-url = wallet?network?api?web3Provider
        contract = web3.eth.contract(abis.ERC20BridgeToken).at(HOME_BRIDGE)    
        data = contract.transferAndCall.get-data(HOME_BRIDGE, value, send.to)
        store.current.send.contract-address = HOME_BRIDGE_TOKEN
        store.current.send.data = data
        cb null, data    
    busd_to_busd_velas_swap = (token, chosen-network, cb)->
        return cb null if not (token is \busd and chosen-network.id is \vlx_busd) 
        { wallets } = store.current.account
        chosen-network-wallet = wallets |> find (-> it.coin.token is chosen-network.id)
        return cb "[Swap error]: wallet #{chosen-network.id} is not found!" if not chosen-network-wallet? 
        { FOREIGN_BRIDGE, FOREIGN_BRIDGE_TOKEN } = wallet.network        
        web3 = new Web3(new Web3.providers.HttpProvider(wallet.network.api.web3Provider))
        web3.eth.provider-url = wallet.network.api.web3Provider
        value = store.current.send.amountSend 
        value = (value `times` (10^18))  
        receiver = send.to  
        contract = web3.eth.contract(abis.ForeignBridgeErcToErc).at(FOREIGN_BRIDGE)         
        data = 
            | up(wallet.address) is up(store.current.send.to) => contract.transfer.get-data(FOREIGN_BRIDGE, value)
            | _ => contract.relayTokens.get-data(receiver, value) 
        contract-address =
            | up(wallet.address) is up(store.current.send.to) => FOREIGN_BRIDGE_TOKEN
            | _ => FOREIGN_BRIDGE  
        store.current.send.contract-address = contract-address
        store.current.send.data = data    
        cb null, data    
    /* 
    * Swap from USDT ETHEREUM to USDT VELAS 
    */     
    eth_usdt-usdt_velas-swap = (token, chosen-network, cb)->     
        return cb null if not (token is \usdt_erc20 and chosen-network.id is \vlx_usdt)
        web3 = velas-web3 store
        { FOREIGN_BRIDGE, FOREIGN_BRIDGE_TOKEN } = wallet.network
        return cb "FOREIGN_BRIDGE is not defined" if not FOREIGN_BRIDGE?
        return cb "FOREIGN_BRIDGE_TOKEN is not defined" if not FOREIGN_BRIDGE_TOKEN?
        value = store.current.send.amountSend 
        value = (value `times` (10^6))  
        receiver = send.to
        web3 = new Web3(new Web3.providers.HttpProvider(wallet?network?api?web3Provider))
        web3.eth.provider-url = wallet?network?api?web3Provider  
        contract = web3.eth.contract(abis.ForeignBridgeErcToErc).at(FOREIGN_BRIDGE)
        data = 
            | up(wallet.address) is up(store.current.send.to) => contract.transfer.get-data(FOREIGN_BRIDGE, value)
            | _ => contract.relayTokens.get-data(receiver, value)
        contract-address =
            | up(wallet.address) is up(store.current.send.to) => FOREIGN_BRIDGE_TOKEN
            | _ => FOREIGN_BRIDGE    
        store.current.send.contract-address = contract-address
        store.current.send.data = data        
        cb null, data 
    /* 
    * Swap from USDT VELAS to USDT ETHEREUM
    */     
    usdt_velas-eth_usdt-swap = (token, chosen-network, cb)->     
        return cb null if not (token is \vlx_usdt and chosen-network.id is \usdt_erc20)
        web3 = velas-web3 store
        { HOME_BRIDGE, HOME_BRIDGE_TOKEN } = wallet.network  
        value = store.current.send.amountSend 
        value = (value `times` (10^6))  
        web3 = new Web3(new Web3.providers.HttpProvider(wallet?network?api?web3Provider))
        web3.eth.provider-url = wallet?network?api?web3Provider
        contract = web3.eth.contract(abis.ERC20BridgeToken).at(HOME_BRIDGE)  
        data = contract.transferAndCall.get-data(HOME_BRIDGE, value, send.to)
        store.current.send.contract-address = HOME_BRIDGE_TOKEN
        store.current.send.data = data
        cb null, data        
    form-contract-data = (cb)->
        if not store.current.send.chosen-network?
            return cb null 
        chosen-network = store.current.send.chosen-network
        token = store.current.send.coin.token
        if chosen-network.id in <[ vlx_evm vlx2 ]> and token in <[ vlx_evm vlx2 ]>   
            store.current.send.contractAddress = null 
            return cb null 
        wallet = store.current.send.wallet  
        contract-address = null    
        data = null 
        send.swap = yes 
        /* DONE! */
        dummy = (a, b, cb)-> 
            cb null       
        func = 
            | token is \usdt_erc20 and chosen-network.id is \vlx_usdt =>
                /* Swap from USDT ETHEREUM to USDT VELAS  */ 
                eth_usdt-usdt_velas-swap 
            | token is \vlx_usdt and chosen-network.id is \usdt_erc20 =>
                /* Swap from USDT VELAS to USDT ETHEREUM */ 
                usdt_velas-eth_usdt-swap
            | token is \busd and chosen-network.id is \vlx_busd =>
                /* Swap from BUSD to BUSD VELAS */ 
                busd_to_busd_velas_swap  
            | token is \vlx_busd and chosen-network.id is \busd =>
                /* Swap from BUSD VELAS to BUSD */
                busd_velas_to_busd_swap
            | token is \usdc and chosen-network.id is \vlx_usdc =>
                /* Swap from USDC to USDC VELAS */
                usdc_to_usdc_velas_swap
            | token is \vlx_usdc and chosen-network.id is \usdc =>
                /* Swap from USDC VELAS to USDC */
                usdc_velas_to_usdc_swap
            | _ => dummy   
        err, data <- func(token, chosen-network)
        return cb err if err?
        /* Swap from VELAS EVM to HECO */
        if token is \vlx_evm and chosen-network.id is \vlx_huobi then
            { wallets } = store.current.account
            chosen-network-wallet = wallets |> find (-> it.coin.token is chosen-network.id)
            return cb "[Swap error]: wallet #{chosen-network.id} is not found!" if not chosen-network-wallet?
            { HECO_SWAP__HOME_BRIDGE } = wallet.network
            web3 = new Web3(new Web3.providers.HttpProvider(wallet?network?api?web3Provider))
            web3.eth.provider-url = wallet?network?api?web3Provider
            contract = web3.eth.contract(abis.HomeBridgeNativeToErc).at(HECO_SWAP__HOME_BRIDGE) 
            receiver = store.current.send.to             
            data = contract.relayTokens.get-data(receiver)
            store.current.send.contract-address = HECO_SWAP__HOME_BRIDGE  
            send.data = data 
        /* Swap from HECO to VELAS EVM */
        if token is \vlx_huobi and chosen-network.id is \vlx_evm
            value = store.current.send.amountSend
            value = value `times` (10^18)
            { FOREIGN_BRIDGE, FOREIGN_BRIDGE_TOKEN } = wallet.network
            return cb "FOREIGN_BRIDGE is not defined" if not FOREIGN_BRIDGE?
            return cb "FOREIGN_BRIDGE_TOKEN is not defined" if not FOREIGN_BRIDGE_TOKEN?    
            web3 = new Web3(new Web3.providers.HttpProvider(wallet?network?api?web3Provider))
            web3.eth.provider-url = wallet?network?api?web3Provider
            contract = web3.eth.contract(abis.ForeignBridgeNativeToErc).at(FOREIGN_BRIDGE_TOKEN)  
            data = 
                | is-self-send is yes => contract.transfer.get-data(FOREIGN_BRIDGE, to-hex(value), send.to)
                | _ => contract.transferAndCall.get-data(FOREIGN_BRIDGE, value, send.to)              
            send.contract-address = FOREIGN_BRIDGE_TOKEN
            send.data = data
        /* Swap from VELAS EVM to HECO */
        if token is \vlx_evm and chosen-network.id is \bsc_vlx then
            { wallets } = store.current.account
            chosen-network-wallet = wallets |> find (-> it.coin.token is chosen-network.id)
            return cb "[Swap error]: wallet #{chosen-network.id} is not found!" if not chosen-network-wallet?
            { BSC_SWAP__HOME_BRIDGE, ERC20BridgeToken } = wallet.network
            web3 = new Web3(new Web3.providers.HttpProvider(wallet?network?api?web3Provider))
            web3.eth.provider-url = wallet?network?api?web3Provider
            contract = web3.eth.contract(abis.HomeBridgeNativeToErc).at(BSC_SWAP__HOME_BRIDGE) 
            receiver = store.current.send.to 
            data = 
                | is-self-send is yes => contract.transfer.get-data(BSC_SWAP__HOME_BRIDGE, value)
                | _ => contract.relayTokens.get-data(receiver) 
            contract-address =
                | is-self-send is yes => ERC20BridgeToken
                | _ => BSC_SWAP__HOME_BRIDGE  
            data = contract.relayTokens.get-data(receiver)
            send.data = data
            store.current.send.contract-address = BSC_SWAP__HOME_BRIDGE
        /* Swap from BSC VELAS to VELAS EVM */
        if token is \bsc_vlx and chosen-network.id is \vlx_evm
            value = store.current.send.amountSend
            value = value `times` (10^18)
            { FOREIGN_BRIDGE, FOREIGN_BRIDGE_TOKEN } = wallet.network
            web3 = new Web3(new Web3.providers.HttpProvider(wallet?network?api?web3Provider))
            web3.eth.provider-url = wallet?network?api?web3Provider      
            contract = web3.eth.contract(abis.ForeignBridgeNativeToErc).at(FOREIGN_BRIDGE_TOKEN) 
            #debugger
            data = 
                | up(wallet.address) is up(store.current.send.to) => contract.transfer.get-data(FOREIGN_BRIDGE, to-hex(value), send.to)
                | _ => contract.transferAndCall.get-data(FOREIGN_BRIDGE, value, send.to)                   
            send.contract-address = FOREIGN_BRIDGE_TOKEN
            send.data = data
        /* Swap from ETH to ETHEREUM (VELAS) */ 
        if token is \eth and chosen-network.id is \vlx_eth then
            { wallets } = store.current.account
            chosen-network-wallet = wallets |> find (-> it.coin.token is chosen-network.id)
            return cb "[Swap error]: wallet #{chosen-network.id} is not found!" if not chosen-network-wallet? 
            value = store.current.send.amountSend 
            value = to-hex (value `times` (10^18)) 
            { HOME_BRIDGE } = wallet.network
            web3 = new Web3(new Web3.providers.HttpProvider(wallet.network.api.web3Provider))
            web3.eth.provider-url = wallet.network.api.web3Provider
            contract = web3.eth.contract(abis.HomeBridgeNativeToErc).at(HOME_BRIDGE)       
            receiver = send.to
            data = contract.relayTokens.get-data(receiver)
            store.current.send.contract-address = HOME_BRIDGE
            send.data = data 
        /* Swap from ETHEREUM (VELAS) to ETH  */ 
        if token is \vlx_eth and chosen-network.id is \eth then
            value = store.current.send.amountSend
            value = (value `times` (10^18))
            network = wallet.network
            { FOREIGN_BRIDGE, FOREIGN_BRIDGE_TOKEN } = wallet.network    
            web3 = new Web3(new Web3.providers.HttpProvider(wallet.network.api.web3Provider))
            web3.eth.provider-url = wallet.network.api.web3Provider
            contract = web3.eth.contract(abis.ERC20BridgeToken).at(FOREIGN_BRIDGE_TOKEN)
            data = contract.transferAndCall.get-data(FOREIGN_BRIDGE, value, send.to)
            send.data = data
            send.contract-address = FOREIGN_BRIDGE_TOKEN
        /* Swap from VLX ERC20 to COIN VLX */    
        if token is \vlx_erc20 and chosen-network.id in <[ vlx_evm vlx2 ]>
            value = store.current.send.amountSend
            value2 = to-hex(value `times` (10^18)).toString(16)
            value = (value `times` (10^18))
            network = wallet.network
            { FOREIGN_BRIDGE, FOREIGN_BRIDGE_TOKEN } = wallet.network
            web3 = new Web3(new Web3.providers.HttpProvider(wallet.network.api.web3Provider))
            web3.eth.provider-url = wallet.network.api.web3Provider           
            sending-to = 
                | send.to.starts-with \V => to-eth-address send.to
                | _ => send.to
            contract = web3.eth.contract(abis.ERC20BridgeToken).at(FOREIGN_BRIDGE_TOKEN)
            data = contract.transferAndCall.get-data(FOREIGN_BRIDGE, value, sending-to)
            send.data = data
            send.contract-address = FOREIGN_BRIDGE_TOKEN            
        /* Swap from COIN VLX to VLX ERC20 */
        if (token is \vlx_evm or token is \vlx2) and chosen-network.id is \vlx_erc20 then
            { wallets } = store.current.account
            chosen-network-wallet = wallets |> find (-> it.coin.token is chosen-network.id)
            return cb "[Swap error]: wallet #{chosen-network.id} is not found!" if not chosen-network-wallet? 
            { HOME_BRIDGE } = wallet.network 
            receiver = store.current.send.to 
            network = wallet.network                 
            web3 = new Web3(new Web3.providers.HttpProvider(wallet.network.api.web3Provider))
            web3.eth.provider-url = wallet.network.api.web3Provider
            contract = web3.eth.contract(abis.HomeBridgeNativeToErc).at(HOME_BRIDGE)
            data = contract.relayTokens.get-data(receiver) 
            store.current.send.contract-address = HOME_BRIDGE 
            send.data = data  
        /* Swap from Legacy or EVM into native */   
        if (token is \vlx_evm or token is \vlx2) and chosen-network.id is \vlx_native then
            { EVM_TO_NATIVE_BRIDGE } = wallet.network
            return cb "EVM_TO_NATIVE_BRIDGE address is not defined" if not EVM_TO_NATIVE_BRIDGE?   
            $recipient = ""
            try
                recipient =
                    | send.to.starts-with \V => to-eth-address(send.to)     
                    | _ => send.to
                $recipient = bs58.decode recipient
                hex = $recipient.toString('hex')
            catch err
                return cb "Please enter valid address"
            eth-address = \0x + hex
            web3 = new Web3(new Web3.providers.HttpProvider(wallet.network.api.web3Provider))
            web3.eth.provider-url = wallet.network.api.web3Provider
            contract = web3.eth.contract(abis.EvmToNativeBridge).at(EVM_TO_NATIVE_BRIDGE)
            data = contract.transferToNative.get-data(eth-address)
            send.data =data           
            store.current.send.contract-address = EVM_TO_NATIVE_BRIDGE
        send.data = data
        cb null
    to-hex = ->
        new BN(it)  
    export form-contract-data       
    out$