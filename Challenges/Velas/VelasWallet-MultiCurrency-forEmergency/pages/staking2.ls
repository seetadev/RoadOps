require! {
    \react
    \react-dom
    \../navigate.ls
    \../get-primary-info.ls
    \react-copy-to-clipboard : { CopyToClipboard }
    \../copied-inform.ls
    \../copy.ls
    \../web3.ls
    \../get-lang.ls
    \../history-funcs.ls
    \./icon.ls
    \./switch-account.ls
    \../icons.ls
    \./epoch.ls
    \./alert-demo.ls
    \../components/burger.ls
    \prelude-ls : { find }
    \@velas/staking.2.0 : Staking
    '@velas/staking.2.0/lib/modules/staking-store.js' : { StakingStore }
}
.staking2
    $mobile: 500px
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
    text-align: left
    @media(max-width:$ipad)
        width: 100%
        margin: 0
    .ss
        background: rgb(22, 26, 66)
    .staking
        top: 40%
        @media(max-width: $mobile)
            width: 100% !important
    .index-style-block-not-staked
        @media(max-width: $mobile)
            height: 460px !important
    .index-style-box
        width: 70% !important
        @media(max-width:800px)
            width: 600px
        @media(max-width: $mobile)
            width: 95%
            display: contents
            background: transparent
            border: none
    .index-style-box-size
        width: 70% !important
        position: relative
        top: 0
        left: 0
        transform: none
        margin-top: 10px
        @media(max-width:800px)
            width: 600px
        @media(max-width: $mobile)
            width: 95%
            display: contents
            background: transparent
            border: none
    .style-container
        min-width: 430px
        @media(max-width:$mobile)
            min-width: auto
            width: 90%
            top: 375px !important
    .style-container-size
        min-width: 430px
        position: relative
        top: 0
        left: 0
        transform: none
        margin-top: 10px
        @media(max-width:$mobile)
            min-width: auto
            width: 90%
            top: 375px !important
    select option
        background-color: #1b1b1be6 !important
        color: white !important
    .css-5o0em1
        @media(max-width:$mobile)
            min-width: 90%
            position: relative
            top: 0px
            left: 0px
            -webkit-transform: none
            -moz-transform: none
            -ms-transform: none
            transform: none
            height: auto
        position: relative
        top: 35px
        left: 0px
        -webkit-transform: none
        -moz-transform: none
        -ms-transform: none
        transform: none
        min-height: 600px
    .index-container-details
        @media(max-width:800px)
            margin: auto
    .index-width-container
        margin: 0 auto
        @media(max-width:800px)
            margin: auto
    .full-width
        @media(min-width: $mobile)
            width: 100% !important
            display: flex !important
            justify-content: center !important
    .button-block-style-btn-green
        @media(max-width:$mobile)
            width: 45% !important
            margin-inline: 5px !important
            padding: 10px !important
    .button-block-style-btn-red
        @media(max-width:$mobile)
            width: 45% !important
            margin-inline: 5px !important
            padding: 10px !important
    .css-1qgma8u-MuiButtonBase-root-MuiTableSortLabel-root:hover
        color: #fff !important
    .css-1qgma8u-MuiButtonBase-root-MuiTableSortLabel-root.Mui-active
        color: #fff !important
    .css-1qgma8u-MuiButtonBase-root-MuiTableSortLabel-root.Mui-active .MuiTableSortLabel-icon
        opacity: 1
        color: #fff !important
    .css-1mxz8qt-MuiPaper-root
        background-color: transparent !important
    .section-item-container
        @media(max-width:$mobile)
            display: inline-block
            width: 95%
            margin-inline: 10px
    .sectionlist-container
        @media(max-width:$mobile)
            overflow: inherit !important
            height: auto !important
    .search-container
        @media(max-width:$mobile)
            padding-inline: 10px
    .search-table
        @media(max-width:$mobile)
            height: 1000px !important
    .search-container
        margin-top: 0px !important
        @media(max-width:$mobile)
            margin-top: 10px !important
    .index-title-row-staked
        padding-inline: 0px !important
        margin-top: -5px !important
        @media(max-width:$mobile)
            background-color: rgb(21, 24, 57)
            margin: 0 !important
            padding-top: 5px !important
            padding-inline: 3px !important
    .section-header, .section-description
        display: flex
        padding: 15px 0 !important
        color: #fff !important
        font-size: 15px
        @media(max-width:$mobile)
            margin-left: 10px !important
    button
        font-size: 11px !important
    .enterance-style-link
        color: #0bffb7 !important
    div.section-item
        display: flex
        align-items: center
        padding-block: 5px !important
        padding: 0 !important
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
            @media(max-width:800px)
                text-align: center
staking2 = ({ store, web3t })->
    lang = get-lang store
    { go-back } = history-funcs store, web3t
    goto-search = ->
        navigate store, web3t, \search
    info = get-primary-info store
    action = ->
        store.current.active = not store.current.active
    active =
        if store.current.active then \active else \ ""
    style=
        background: info.app.wallet
        color: info.app.text
    border-style =
        color: info.app.text
        border-bottom: "1px solid #{info.app.border}"
        background: info.app.background
        background-color: info.app.bgspare
    resource =
        color: info.app.text
        border: "1px solid #{info.app.border}"
        background: info.app.header
        border-radius: info.app.border-btn
    show-class =
        if store.current.open-menu then \hide else \ ""
    /* Render */
    .pug.staking2
        .pug.title(style=border-style)
            .pug.header(class="#{show-class}") #{lang.staking}
            burger store, web3t
        .container.pug
            Staking.pug(stakingStore=store.stakingStore lang=lang info=info)
staking2.init = ({store, web3t}, cb)->
    wallet_native = store.current.account.wallets |> find (-> it.coin.token is \vlx_native)
    nativeData = wallet_native?network?api
    wallet_evm = store.current.account.wallets |> find (-> it.coin.token is \vlx_evm)
    evmData = wallet_evm?network?api
    config = {
        API_HOST: nativeData.apiUrl,
        evmAPI: evmData.web3Provider,
        nativeApi: nativeData.web3Provider,
        validatorsBackend: nativeData.validatorsBackend,
        publicKey: wallet_native.publicKey,
        evmAddress: wallet_evm.address,
        evmPrivateKey: wallet_evm.privateKey,
        network: store.current.network,
        nativePrivateKey: wallet_native.privateKey,
        fetchAccountsFromBackend: no
        refresh: yes
    }
    stakingStore = new StakingStore(config)
    store.stakingStore = stakingStore;
    cb null
module.exports = staking2