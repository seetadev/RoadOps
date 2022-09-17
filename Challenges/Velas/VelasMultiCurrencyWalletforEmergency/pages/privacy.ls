require! {
    \react
    \../navigate.ls
    \../get-primary-info.ls
    \../web3.ls
    \../get-lang.ls
    \../history-funcs.ls
    \../icons.ls
    \../components/button.ls
    \../../web3t/providers/superagent.js : { get }
}
.terms
    @import scheme
    text-align: center
    .terms-body
        >.header
            font-size: 19px
            padding: 10px
        display: inline-block
        min-width: 250px
        >.buttons
            color: inherit
            text-align: center
            button
                display: inline-block
                cursor: pointer
                width: auto
                margin: 15px 5px 0
                text-transform: uppercase
                font-weight: bold
                padding: 0px 6px
                height: 36px
                border: 0
                background: #248295
                border-radius: $border
                font-size: 10px
                min-width: 80px
                width: auto
                white-space: nowrap
                text-overflow: ellipsis
                overflow: hidden
        textarea
            padding: 10px
            overflow: auto
            width: 100%
            box-sizing: border-box
            height: 445px
            width: 300px
            border: 0
            border-radius: $border
            outline: none
            font-family: inherit
            @media(min-width: 600px)
                width: 600px
terms = ({ store, web3t })->
    lang = get-lang store
    go-back = ->
        navigate store, web3t, \settings
    info = get-primary-info store
    style=
        background: info.app.wallet
        color: info.app.text
    button-style=
        color: info.app.text
    btn-icon =
        filter: info.app.btn-icon
    accept = ->
        navigate store, web3t, \:init
        <- web3t.refresh
    .pug.terms
        .pug.terms-body
            .pug.header #{lang.privacy-policy}
            textarea.pug(value="#{store.terms}" style=style)
            .pug.buttons
                button { store, text: \back , on-click: go-back, icon: \arrowLeft, type: \primary }
terms.init = ({ store }, cb)->
    #err, res <- get \https://raw.githubusercontent.com/askucher/expo-web3/dev/Privacy.md .end
    #return cb err if not res?text
    privacy = """Velas Wallet Privacy Notice
        Last updated: July 2, 2020
        The Velas Wallet available at https://wallet.velas.com/, including its browser extension (plugin), desktop or mobile application (the “Velas Wallet”) is operated by Velas Network AG (“Velas”, “we”, “us”).
        The terms “you” and “your” are used to refer to you as a user of the Velas Wallet, including you as a holder of a digital wallet on the Velas Wallet and/or any person authorised to use your Wallet.
        “Personal data” or “personal information” means information that relates to an identified or identifiable individual.
            •  NO PERSONAL DATA PROCESSED
        Velas informs you that we do not collect, process, or store any personal information. Moreover, you do not have an opportunity to provide your personal data to us through the Velas Wallet.
        Velas is not able and will not identify you as an individual.
        Your PIN-code, private key, and mnemonic phrase are encrypted and processed locally on your device and are not processed on our servers.
            •  SECURITY OF YOUR PERSONAL DATA
        Since Velas does not process your personal data, you are solely responsible for maintaining the confidentiality of your personal information.
            •  CONTACT DETAILS
        Should you have any questions regarding this Privacy Notice, please contact us at:
        Velas Network AG
        Dammstrasse 16,
        Zug 6300, Switzerland
        Email: info@velas.com.
            •  CHANGES TO THIS PRIVACY NOTICE
        Velas may unilaterally make changes to this Privacy Notice. In such case, we will update the “Last updated” date above. Such changes will take effect as soon as they are posed unless otherwise is decided by Velas. Please check back frequently to see any updates or changes to this Privacy Notice.
        """
    store.terms = privacy
    cb null
module.exports = terms