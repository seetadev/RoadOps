require! {
    \prelude-ls : { map, pairs-to-obj }
    \./seed.ls : seedmem
    \./browser/location.ls
    \./langs/langs.json
    \./icons.ls
    \./get-device.ls
    \./get-size.ls
    \./package.json : { version }
    \qs
    \localStorage
}
saved-seed = seedmem.saved!
create-send =->
    id: ""
    to: ""
    chosen-network: null
    contract-address: null
    fee-calculating: no
    details: yes
    propose-escrow: no
    address: ''
    value: \0
    fee-type: \auto
    fee-custom-amount: \0
    tx-type: \regular
    checking-allowed: no
    amount-buffer:
        val: "0"
        usdVal: "0"
        address: ""
        gas-price: "0"
    amount-send: \0
    amount-charged: \0
    amount-charged-usd: \0
    amount-send-usd: \0
    amount-send-eur: \0
    amount-send-fee: \0
    amount-send-fee-usd: \0
    amount-obtain: \0
    data: ""
    gas: null
    gas-price: null
    gas-price-auto: \0
    gas-price-custom-amount: \0
    gas-price-type: \auto
    typing-amount-time-ms: 0
    TYPING_THRESHOLD_MS: 500
    gasEstimate: \0
    feeMode: \percent
    homeFee: 0
    homeFeePercent: 0
    is-swap: no
    decoded-data: ""
    show-data-mode: \encoded
    error: ''
    parseError: ''
    amount-send-fee-options:
        cheap: 0
        auto: 0
url-params =
    | window? => qs.parse window.location.search.replace('?', '')
    | _ => {}
network =
    | url-params.network? and url-params.network is "testnet" => "testnet"
    | url-params.network? and url-params.network is "devnet" => "devnet"
    | _ => "mainnet"
url-hash-params =
    | window? => qs.parse window.location.hash.replace('#', '')
    | _ => {}
store =
    walletIsOffline: no
    showTooltip: false
    tooltipCoordinates: { x: 0, y: 0 }
    tooltipMessage: "" 
    stakingStore: null
    loading-wallet: no
    inputCaretPosition: 0
    url-params: url-params
    url-hash-params: url-hash-params
    root: null
    theme: localStorage.get-item('theme') ? \velas
    lang: localStorage.get-item('lang') ? \en
    langs: langs
    icons: \icons
    registry: []
    terms: "Loading..."
    terms2: "Loading..."
    collapse: ""
    just-added-token: null
    development:
        proposals: []
        new-proposal:
            description: ""
            name: ""
            opened: no
            progress: \0
            update-progress: null
    forceReload: yes
    forceReloadTxs: yes
    previous:
        page: ''
    custom-token:
        add: no
        isLoading: no
        contract-address: ""
        decimals: 0
        symbol: ""
        symbol-display: ""
        network: null
        selected-network: network
        switch-network: false
        edit-symbol: no
        icon: ""
        errors:
            contract-address: ""
            network: ""
            decimals: ""
            symbol: ""
    preference:
        settings-visible: yes
        invoice-visible: yes
        username-visible: no
        refresh-visible: yes
        lock-visible: yes
    tor:
        enabled: no
        real:
            ip: "n/a"
            country: "n/a"
        proxy:
            ip: "n/a"
            country: "n/a"
    wallet-tab:
        tab: 0
    search:
        tab: "dapps"
    video:
        tab: "home"
        menu-open: no
        drag: no
        upload-link: no
        action: "upload"
        uploading-files: []
    sound:
        tab: "home"
        menu-open: no
        drag: no
    notice:
        search: no
    faq:
        tab: "item"
        answer: ""
        answer2: ""
    dashboard:
        epoch-percent: ".."
        epoch-next: '..'
        current-block: '..'
        epoch: '..'
    peerinfo:
        peers: []
    interop:
        is-address-queried: no
        origin: no
    HomeBridgeNativeToErc: {}
    ForeignBridgeNativeToErc: {}
    lockups:
        currentTimelock: null
        stake-amount-total: 0
        exit-tab: ''
        wait-for-epoch-change: no
        maxWithdrawAllowed: 0
        orderedWithdrawAmount: 0
        maxWithdrawOrderAllowed: 0
        withdraw-amount: 0
        unstake-amount: 0
        current-pool: null
        lockup-was-choosed: no
        chosen-lockup: null
        chosen-lockup-action: ''
        lockupStaking: {}
        lockupContracts: []
        success-cb: null
        error: ""
        stake:
            step: ""
        add:
            move-stake: 0
            add-validator-stake: ""
            add-validator-topup: ""
    errors:
        fetchValidators: null
        fetchAccounts: null
    staking:
        webSocketAvailable: yes
        splitting-staking-account: no
        creating-staking-account: no
        REWARDS_PER_PAGE: 10
        rewards_page: 1
        rewards-index: 0
        fetchAccounts: yes
        accounts: []
        myStakeMaxPart: null
        reward-info: []
        rent: 0
        exit-tab: ''
        maxWithdrawOrderAllowed: 0
        withdrawAmount: 0
        maxWithdrawAllowed: 0
        orderedWithdrawAmount: 0
        poolsAreLoading: no
        loadingAccountIndex: 0
        totalOwnStakingAccounts: 0
        totalValidators: 0
        loadingValidatorIndex: 0
        get-accounts-last-time: null
        cachedValidatorsNetwork: null
        cachedAccountsNetwork: null
        cachedAccounts: null
        cachedValidators: null
        getAccountsFromCashe: yes
        parsedProgramAccounts: []
        accountsCached: {}
        validators_per_page: 10
        accounts_per_page: 10
        visible_per_page_accounts_selector: no
        visible_per_page_validators_selector: no
        add:
            add-validator: ""
            add-validator-stake: ""
            result: ""
            new-address: ""
            move-stake: 0
        validators:
            pending: []
            active: []
        reward: null
        reward-claim: 0
        rewards: []
        keystore:
            staking:
                keystore: ""
            mining:
                keystore: ""
        data-generation: 1
        tab: "line"
        pools: []
        pool-was-choosed: no
        chosen-pool: null
        chosen-account: null
        stake-amount-total: 0
        max-withdraw: 0
        delegators: 0
        reward-loading: no
        wait-for-epoch-change: no
        lockups: []
        current_validators_page: 1
        validators-per-page: 5
        accounts-per-page: 3
        current_accounts_page: 1
    filestore:
        menu-open: no
        file-tree: no
        extension-icons:
            txt: "data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIj8+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiBpZD0iRmxhdCIgaGVpZ2h0PSI1MTJweCIgdmlld0JveD0iMCAwIDUxMiA1MTIiIHdpZHRoPSI1MTJweCI+PHBhdGggZD0ibTM5MiA0ODhoLTI3MmE0OCA0OCAwIDAgMSAtNDgtNDh2LTM2OGE0OCA0OCAwIDAgMSA0OC00OGgyMjRsOTYgOTZ2MzIwYTQ4IDQ4IDAgMCAxIC00OCA0OHoiIGZpbGw9IiNjZmQyZmMiLz48cGF0aCBkPSJtNzIgMzYwaDM2OGEwIDAgMCAwIDEgMCAwdjgwYTQ4IDQ4IDAgMCAxIC00OCA0OGgtMjcyYTQ4IDQ4IDAgMCAxIC00OC00OHYtODBhMCAwIDAgMCAxIDAgMHoiIGZpbGw9IiM1MTUzZmYiLz48ZyBmaWxsPSIjODY5MGZhIj48cGF0aCBkPSJtNDQwIDEyMGgtNDhhNDggNDggMCAwIDEgLTQ4LTQ4di00OHoiLz48cGF0aCBkPSJtMzc2IDE3NmgtMTc2YTggOCAwIDAgMSAwLTE2aDE3NmE4IDggMCAwIDEgMCAxNnoiLz48cGF0aCBkPSJtMjgwIDIwOGgtMTQ0YTggOCAwIDAgMSAwLTE2aDE0NGE4IDggMCAwIDEgMCAxNnoiLz48cGF0aCBkPSJtMzc2IDI0MGgtMTI4YTggOCAwIDAgMSAwLTE2aDEyOGE4IDggMCAwIDEgMCAxNnoiLz48cGF0aCBkPSJtMzIwIDI3MmgtMTg0YTggOCAwIDAgMSAwLTE2aDE4NGE4IDggMCAwIDEgMCAxNnoiLz48cGF0aCBkPSJtMTY4IDE3NmgtMzJhOCA4IDAgMCAxIDAtMTZoMzJhOCA4IDAgMCAxIDAgMTZ6Ii8+PHBhdGggZD0ibTM3NiAyMDhoLTY0YTggOCAwIDAgMSAwLTE2aDY0YTggOCAwIDAgMSAwIDE2eiIvPjxwYXRoIGQ9Im0yMTYgMjQwaC04MGE4IDggMCAwIDEgMC0xNmg4MGE4IDggMCAwIDEgMCAxNnoiLz48cGF0aCBkPSJtMzc2IDI3MmgtMjRhOCA4IDAgMCAxIDAtMTZoMjRhOCA4IDAgMCAxIDAgMTZ6Ii8+PHBhdGggZD0ibTE4NCAzMDRoLTQ4YTggOCAwIDAgMSAwLTE2aDQ4YTggOCAwIDAgMSAwIDE2eiIvPjxwYXRoIGQ9Im0yMTYgMTQ0aC04MGE4IDggMCAwIDEgMC0xNmg4MGE4IDggMCAwIDEgMCAxNnoiLz48cGF0aCBkPSJtMjk2IDMwNGgtODBhOCA4IDAgMCAxIDAtMTZoODBhOCA4IDAgMCAxIDAgMTZ6Ii8+PHBhdGggZD0ibTM3NiAzMDRoLTQ4YTggOCAwIDAgMSAwLTE2aDQ4YTggOCAwIDAgMSAwIDE2eiIvPjwvZz48cGF0aCBkPSJtMTY4IDM4NGE4IDggMCAwIDAgLTggOHY2NGE4IDggMCAwIDAgOCA4IDQwIDQwIDAgMCAwIDAtODB6bTggNjIuNjI5di00NS4yNThhMjQgMjQgMCAwIDEgMCA0NS4yNTh6IiBmaWxsPSIjZmZmIi8+PHBhdGggZD0ibTI1NiAzODRjLTE3LjY0NSAwLTMyIDE3Ljk0NC0zMiA0MHMxNC4zNTUgNDAgMzIgNDAgMzItMTcuOTQ0IDMyLTQwLTE0LjM1NS00MC0zMi00MHptMCA2NGMtOC42NzMgMC0xNi0xMC45OTEtMTYtMjRzNy4zMjctMjQgMTYtMjQgMTYgMTAuOTkxIDE2IDI0LTcuMzI3IDI0LTE2IDI0eiIgZmlsbD0iI2ZmZiIvPjxwYXRoIGQ9Im0zMzYgNDAwYTEwLjcwOCAxMC43MDggMCAwIDEgNC41OSAxLjA1OCA4IDggMCAxIDAgNi44Mi0xNC40NzQgMjYuNTgxIDI2LjU4MSAwIDAgMCAtMTEuNDEtMi41ODRjLTE3LjY0NSAwLTMyIDE3Ljk0NC0zMiA0MHMxNC4zNTUgNDAgMzIgNDBhMjYuNiAyNi42IDAgMCAwIDExLjQxMS0yLjU4NCA4IDggMCAwIDAgLTYuODIyLTE0LjQ3MyAxMC43MSAxMC43MSAwIDAgMSAtNC41ODkgMS4wNTdjLTguNjczIDAtMTYtMTAuOTkxLTE2LTI0czcuMzI3LTI0IDE2LTI0eiIgZmlsbD0iI2ZmZiIvPjwvc3ZnPgo="
            xls: ""
            unknown: ""
        path: "/"
        structure:
            *   type: \dir
                name: 'some dir'
            *   type: \dir
                name: 'some dir 2'
            *   type: \dir
                name: 'some dir 3'
            *   type: \file
                name: 'presentation'
                extension: \pdf
            *   type: \file
                name: 'report'
                extension: \xls
    receive:
        wallet: null
    menu:
        active: 's2'
        mobile: no
        show: no
        support: 'https://support.velas.com/'
    ask:
        text: ''
        enabled: no
        callback: null
        image: ""
        type: ''
    contract-address: ''
    contract-vlxaddress: ''
    transactions:
        all: []
        applied: []
    releases: []
    current:
        account: {
            wallets: []
        }
        switch-network: no
        search-language: ""
        current-network-details:
            show: no
        network-details:
            show: no
            dailyLimit: 0
            remainingDailyLimit: 0
            homeFeePercent: 0
            minPerTx: 0
            maxPerTx: 0
        foreign-network-details:
            show: no
            dailyLimit: 0
            remainingDailyLimit: 0
            homeFeePercent: 0
            minPerTx: 0
            maxPerTx: 0
        hideCopiedText: no
        transactions-are-loading: no
        address-suffix: ''
        page-pin: null
        try-copy: null
        hovered-address:
            address: null
            element: null
        verify-seed-index: 0
        verify-seed: ""
        verify-seed-error: no
        device: get-device!
        size: get-size!
        list: 0
        prompt-type: ""
        prompt-answer: ""
        prompt: no
        prompt2: no
        prompt3: no
        prompt-password: no
        prompt-password-answer: ""
        step: "first"
        verify-seed-indexes: []
        switch-account: no
        tor: no
        rate: no
        view: no
        hint: yes
        open-menu: no
        current-epoch: no
        switch-currency: no
        send-menu-open: no
        langs-open: no
        langs-open-side: no
        langs-open-start: no
        add-coin: no
        add-vlxcoin: no
        token-migration: null
        choose-language: yes
        banner: no
        content-migrate: no
        accept-migrate: no
        active: no
        dragfile: no
        files: no
        progress: no
        hide-btn: no
        submenu: no
        language-menu: no
        wallet-index: 0
        group-index: 0
        edit-account-name: ""
        account-index: 1
        manage-account: no
        filter-plugins: ""
        confirmation: null
        notification: null
        alert: null
        choose-token: null
        tokens-dropdown: no
        demo: location.href.index-of('web3.space/wallet') > -1
        network: network
        pin: ""
        last-tx-url: ""
        try-edit-seed: no
        pin-trial: 0
        refreshing: no
        copied: ""
        page: if saved-seed then \locked else \chooseinit
        send-to-mask: ""
        status: \main
        nickname: ""
        nicknamefull: \nickname@domain.com
        message: ""
        custom-domain: no
        can-buy: no
        checking-name: no
        seed: ""
        seed-problem: ""
        seed-words: []
        seed-temp: ""
        seed-generated: no
        saved-seed: saved-seed
        balance-usd: \...
        filter-txs-types: <[ IN OUT ]>
        filter:
            from: null
            to: null
            token: null
        loading: no
        send : create-send!
        invoice : create-send!
        currency: ""
        convert: "usd"
        trx-type: "custom"
        allow-mining-claim-call: undefined
        search: ""
        vote-index: null
    history:
        filter-from: ''
        filter-to: ''
        filter-open: no
        tx-details: no
    pages: [\wallets]
    seed:
        no-copy: no
        about: no
    rates: {}
    coins: []
    version: version
if window.location.hash is \#util
    store.current.page = \util
module.exports = store