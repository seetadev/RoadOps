require! {
    \./velas-web3.ls
    \./addresses.ls
    \./velas-solana-web3.ls
    \./velas-staking.js : \NStaking
    \prelude-ls : {find}
}
abis =
    Staking      : require("../../web3t/contracts/StakingAuRa.json").abi
    ValidatorSet : require("../../web3t/contracts/ValidatorSetAuRa.json").abi
    BlockReward  : require("../../web3t/contracts/BlockRewardAuRa.json").abi
    Development  : require("../../web3t/contracts/VelasDevelopment.json").abi
    Resolver     : require("../../web3t/contracts/LockupResolver.json").abi
    Timelock     : require("../../web3t/contracts/LockupTimelock.json").abi
    EvmToNativeBridge: require("../../web3t/contracts/EvmToNativeBridge.json").abi 
    HomeBridgeNativeToErc  : require("../../web3t/contracts/HomeBridgeNativeToErc.json").abi 
    ForeignBridgeNativeToErc : require("../../web3t/contracts/ForeignBridgeNativeToErc.json").abi 
    ERC20BridgeToken: require("../../web3t/contracts/ERC20BridgeToken.json").abi    
    ERC677BridgeToken: require("../../web3t/contracts/ERC20BridgeToken.json").abi
    HomeERC677Bridge: require("../../web3t/contracts/HomeBridgeNativeToErc.json").abi 
    ForeignBridgeErcToErc: require("../../web3t/contracts/ForeignBridgeErcToErc.json").abi
module.exports = (store)->
    web3 = velas-web3 store
    network = store.current.network
    staking-address = addresses[network].Staking if addresses[network]?Staking?
    validatorSet-address = addresses[network].ValidatorSet if addresses[network]?ValidatorSet?
    blockReward-address = addresses[network].BlockReward if addresses[network]?BlockReward?
    development-contract-address = addresses[network].Development if addresses[network]?Development?
    resolver-contract-address = addresses[network].ResolverAuRa if addresses[network]?ResolverAuRa?
    homeBridgeAddress = addresses[network].HomeBridge if addresses[network]?HomeBridge?
    foreignBridgeAddress = addresses[network].ForeignBridge if addresses[network]?ForeignBridge?
    ERC20BridgeToken = addresses[network].ERC20BridgeToken if addresses[network]?ERC20BridgeToken?
    ERC677BridgeTokenAddress = addresses[network].ERC677BridgeToken if addresses[network]?ERC677BridgeToken?
    EvmToNativeBridgeAddress = addresses[network].EvmToNative if addresses[network]?EvmToNative?
    HomeERC677BridgeAddress = addresses[network].HomeERC677Bridge if addresses[network]?HomeERC677Bridge?
    ForeignBridgeErcToErcAddress = addresses[network].ForeignBridgeErcToErcAddress if addresses[network]?ForeignBridgeErcToErcAddress?
    web3Solana = velas-solana-web3 store
    networks =
        mainnet: \https://api.velas.com
        testnet: \https://api.testnet.velas.com/rpc
        devnet: \https://api.devnet.velas.com
    api =
        Staking      : web3.eth.contract(abis.Staking).at(staking-address) if staking-address?
        NativeStaking: new NStaking({NODE_HOST: networks[network]})
        Connection   : new web3Solana.Connection(web3Solana._rpcEndpoint)
        StakingLockup: web3.eth.contract(abis.Staking)
        ValidatorSet : web3.eth.contract(abis.ValidatorSet).at(validatorSet-address) if validatorSet-address?
        BlockReward  : web3.eth.contract(abis.BlockReward).at(blockReward-address) if blockReward-address?
        Development  : web3.eth.contract(abis.Development).at(development-contract-address) if development-contract-address?
        Resolver     : web3.eth.contract(abis.Resolver).at(resolver-contract-address) if resolver-contract-address?
        Timelock     : web3.eth.contract(abis.Timelock) 
        web3         : web3.eth
        EvmToNativeBridge : web3.eth.contract(abis.EvmToNativeBridge).at(EvmToNativeBridgeAddress) if EvmToNativeBridgeAddress?
        HomeBridgeNativeToErc : web3.eth.contract(abis.HomeBridgeNativeToErc).at(homeBridgeAddress) if homeBridgeAddress?
        ForeignBridgeNativeToErc : web3.eth.contract(abis.ForeignBridgeNativeToErc).at(foreignBridgeAddress) if foreignBridgeAddress?
        ERC20BridgeToken : web3.eth.contract(abis.ERC20BridgeToken).at(ERC20BridgeToken) if ERC20BridgeToken?
        ERC677BridgeToken : web3.eth.contract(abis.ERC677BridgeToken).at(ERC677BridgeTokenAddress) if ERC677BridgeTokenAddress?
        HomeERC677BridgeLegacyToErc : web3.eth.contract(abis.HomeERC677Bridge).at(HomeERC677BridgeAddress) if HomeERC677BridgeAddress?
        ForeignBridgeErcToErc : web3.eth.contract(abis.ForeignBridgeErcToErc).at(ForeignBridgeErcToErcAddress) if ForeignBridgeErcToErcAddress? 
        ForeignBridgeErcToErcDefault: web3.eth.contract(abis.ForeignBridgeErcToErc) 
        HomeBridgeNativeToErc677: web3.eth.contract(abis.HomeBridgeNativeToErc)
    api