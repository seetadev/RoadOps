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
            .pug.header #{lang.terms-of-use}
            textarea.pug(value="#{store.terms}" style=style)
            .pug.buttons
                button { store, text: \back , on-click: go-back, icon: \arrowLeft, type: \primary }
terms.init = ({ store }, cb)->
    #err, res <- get \https://raw.githubusercontent.com/askucher/expo-web3/dev/TERMS.md .end
    #return cb err if not res?text
    text = 
        """
        VELAS WALLET -  TERMS AND CONDITIONS
         Last Updated: August 30, 2021
        Please read these Terms and Conditions (the “Terms”) carefully as they constitute a legally binding agreement that affects your legal rights and obligations. Section 18 of these Terms contains the binding arbitration and waiver of class actions provisions. In accordance with Section 11, our liability to you is limited and certain types of liability are excluded.
        Any access to or use of the Velas Wallet software (the “Velas Wallet”), including the web-based application available at https://wallet.velas.com/, browser extension (plugin), desktop and mobile applications is subject to these Terms. By downloading, using, or otherwise accessing the Velas Wallet, or by accepting these Terms, you agree to be bound by these Terms without modifications. If you are unwilling or unable to be bound by these Terms, you shall not use the Velas Wallet and you shall cease any such use immediately.
        Throughout these Terms, the terms “you” and “your” are used to refer to you as a user of the Velas Wallet. If you are entering into these Terms on behalf of an entity, you hereby warrant and represent that you are authorised to act on behalf of such entity and to bind such entity to these Terms, and you accept these Terms on behalf of such entity and on your own behalf. In such case, the references in these Terms to “you” and “your” shall refer to both the above entity on whose behalf an individual using the Velas Wallet is acting, and to such individual.
        The terms “we”, “our”, “us”, or “Velas” are used to refer to VELAS NETWORK AG, a company established under the laws of Switzerland, the developer and operator of the Velas Wallet.
            •  MODIFICATIONS TO THESE TERMS
        Velas reserves the right, at its sole discretion, to modify or replace these Terms at any time and in any manner whatsoever. In case we modify these Terms, we will change the “Last Updated” date at the beginning of these Terms. Your continued use of the Velas Wallet will indicate your acceptance of the revised Terms and your consent to be bound thereby. An up-to-date version of these Terms will be accessible through the Velas Wallet and it is your sole responsibility to check these Terms regularly for updates.
            •  DIGITAL WALLET
        2.1.   Velas Wallet allows you to set up and manage a digital wallet, or have an existing digital wallet connected to the Velas Wallet (the “Digital Wallet”). The Digital Wallet is essentially a pair of public and private cryptographic keys that can be used to receive and dispose of the digital cryptographic assets.
        2.2.   When you use the Velas Wallet, Velas does not gain access to or control over your digital assets or your Digital Wallet, and does not have such technical ability. You are solely responsible for maintaining the confidentiality of the credentials to your Digital Wallet (including the private key and mnemonic phrase — 12 or 24 words seed used to derive the private key) and other information that may be used to gain control over the digital assets that you store in your Digital Wallet (collectively, the “Credentials”). You are responsible for safeguarding your Credentials and making backup copies thereof offline or on your devices. Velas Wallet does not have a “forgot the password” feature and cannot recover your Credentials, meaning that if you lose your Credentials, you may not be able to restore access to your Digital Wallet and assets held in such Digital Wallet. Do not share your Credentials with any other person, as this will give such person the ability to dispose of your digital assets. We do not store your Credentials on our servers, this information is encrypted and stored locally on your device. In no event shall Velas be liable or held responsible for any loss or damage arising from your failure to comply with the obligations to maintain the confidentiality of your Credentials.
            •  THIRD-PARTY SERVICES
            •  The Velas Wallet may from time to time incorporate or enable integration with certain third-party services, including software, solutions, services, items, or materials that were not created, developed, or provided by Velas (the “Third-Party Services”).
            •  While certain Third-Party Services may be available within the Velas Wallet, Velas does not endorse or make any warranties, whether express or implied, with regard to the Third-Party Services. Velas shall not be responsible for or held liable in connection with any Third-Party Services, your use of such Third-Party Services or interaction therewith.
            •  Velas Wallet may from time to time incorporate a network bridging functionality that enables the transfer of certain digital assets from one blockchain network to another. Network bridges constitute an open-sourced Third-Party Service produced by Multichain Labs Ltd, a company incorporated under the laws of the British Virgin Islands. You hereby acknowledge that Velas does not operate, manage or control the network bridges, and does not endorse their use. Therefore, any use of the network bridges and related functionality shall be at your own risk. Note that the use of the network bridges may be subject to the terms of service or another agreement of the respective Third-Party Service provider. 
            •  You hereby acknowledge and agree that any use of Third-Party Services shall always be at your own risk. Your use of the Third-Party Services shall be subject to Sections 3, 5, 6, 7, 8, 10, 11, 12, 15, 16, and 18 hereof, and the terms provided by the respective providers of the Third-Party Services, if any.
            •  To the maximum extent permitted by the applicable law, in no event shall Velas be responsible for or held liable in connection with any loss or damage of any sort incurred by you as the result of, or in connection with your accessing or using any Third-Party Services. 
            •  LICENSE
        Subject to your continued compliance with these Terms, Velas hereby grants you limited, personal, non-exclusive, non-assignable, royalty-free, revocable license to use the Velas Wallet in a manner permitted by these Terms (the “License”). The License shall automatically terminate and cease if you commit a breach of these Terms, violate applicable laws or regulations, or if these Terms are terminated. 
            •  IMPORTANT DISCLAIMERS
        5.1.   Velas shall not be responsible for or held liable in connection with any operations carried out by you, any other user or group of users through or with the use of the Velas Wallet, including any transfer, delivery, use, or storing of digital assets. Velas shall not be acting as an intermediary in any transaction nor shall it be responsible for ensuring that any transaction made through or with the Velas Wallet or otherwise on a blockchain network is actually completed or performed. Velas does not control or influence transactions with digital assets, and therefore is unable to cancel, reverse, block, or freeze any transactions conducted by you or any other user of the Velas Wallet.
        5.2.   Velas is not your broker, fund manager, or an intermediary to any broker or fund manager. Neither the Velas Wallet nor anything in these Terms shall be considered as broker and/or fund management services, or any intermediation services thereto.
        5.3.   The Velas Wallet, including any information and materials available thereon, is not intended to constitute an offer of securities or digital assets, or a solicitation for investment in or purchase of securities or digital assets in any jurisdiction, nor is it intended to constitute a prospectus or offer document of any type. We do not provide any opinion or any advice to purchase, sell, or otherwise transact with digital assets, and nothing communicated by Velas shall form the basis of, or be relied upon in connection with, any contract or investment decision. Please consult your own legal or financial advisor before making any decision.
            •  NO ADVICE
        No part of the information or content made available in the Velas Wallet should be considered to be business, legal, financial, investment, or tax advice, or advice of a broker regarding any matters to which all or any part of such information relates. You should consult your own legal, financial, tax, or other professional advisor regarding this information. We shall not be responsible for the accuracy of the information and materials displayed or communicated to you within or in connection with the Velas Wallet, therefore any use of such information or materials is at your own discretion and risk and you are solely responsible for any possible damages or losses arising from such use.
            •  UPDATES AND AVAILABILITY
        7.1.   Velas may from time to time and without prior notice make certain updates, improvements, or modifications to the Velas Wallet, including, but not limited to, updates to the software, infrastructure, security protocols, technical configurations, functionality, financial structure, or service features, and Velas shall not be in any case held liable with respect to any such updates. You hereby affirm and acknowledge that occasionally the Velas Wallet may be unavailable or its operation may be interrupted. You hereby accept and assume such risks in full and further acknowledge that Velas shall not be liable in this regard.
        7.2.   Velas does not warrant or guarantee that the Velas Wallet will operate and/or be available at all times without disruption or interruption. The Velas Wallet may be inaccessible or inoperable from time to time for any reason, including, for example, equipment malfunctions, maintenance procedures or repairs, updates, force majeure circumstances, disruptions, sophisticated hacker or malware attacks, and temporary or permanent unavailability of the underlying blockchain infrastructure or software, and/or unavailability of respective Third-Party Services or services of external partners. Accordingly, the access to or use of the Velas Wallet may be prevented or limited without notice.
        7.3.   We may, at our sole and absolute discretion, at any time and without prior notice and liability terminate or discontinue the Velas Wallet or any of its components.
            •  PROHIBITED USE
        You shall not:
            •  use the Velas Wallet for any illegal purposes, including, but not limited to, terrorism financing and money laundering;
            •  circumvent or attempt to circumvent any access or functionality restrictions or limitations with respect to the Velas Wallet or underlying software;
            •  use robots, spiders, or other similar automated means that are not expressly allowed hereunder to access the Velas Wallet or its components;
            •  use the Velas Wallet in any manner that could disrupt, interfere with, or inhibit other users from using it, or that could disable, impair, or harm the functioning of the Velas Wallet or respective servers;
            •  copy, duplicate, reproduce, clone, modify, translate, adapt, edit, decompile, disassemble, reverse engineer, “frame”, “mirror”, or create derivative works from the Velas Wallet or related content without our prior written authorisation (excluding, for this purpose, components distributed under an open-source license).
            •  REPRESENTATIONS AND WARRANTIES
        You represent and warrant that you:
            •  are eligible and have full capacity for setting up and holding a Digital Wallet under the laws of the country of your residence;
            •  are of the necessary legal age, in accordance with the laws of the country of your residence, to use the Velas Wallet, however, in any case, you shall be older than 18 (eighteen) years of age;
            •  are not a subject of any sanctions administered or enforced by any country, government, or international authority nor are you a resident or established (in the case of a corporate entity) in a country or territory that is the subject of a country-wide or territory-wide sanction imposed by any country, government, or international authority;
            •  have all necessary rights to set up and hold your Digital Wallet and this does not infringe any rights of third parties;
            •  will use the Velas Wallet only for legitimate purposes and you will not use it for any illegal or fraudulent activity;
            •  will only use and hold digital assets within the Velas Wallet that are from legitimate sources and were lawfully acquired;
            •  will carefully check the address of the recipient before making any transfers and that your transactions with digital assets are done with correct blockchain addresses.
            •  INDEMNITY
        You shall indemnify and hold Velas, its directors, officers, employees, agents, and representatives harmless from and against any and all third-party claims, actions, demands, losses, costs, expenses, fines, penalties, liabilities, and other amounts that arise out of or related to your use of the Velas Wallet, any functionality available therein, or your violation of any provision of these Terms.
            •  LIMITATION ON LIABILITY
        11.1   To the maximum extent permitted by law, in no event shall Velas, its affiliates, their respective directors, officers, employees, contractors, agents, or representatives (collectively, the “Velas parties”) be liable or held responsible for:
            •  any indirect, punitive, incidental, special, exemplary, or consequential damages, including, without limitation, damages for loss of profits, loss of revenues, loss of or damage to data, loss of business, diminution of value, or any other similar damages arising out of these Terms or in any way related to your access to, use or inability to use the Velas Wallet and your Digital Wallet, regardless of the theory of liability and even if Velas Parties have been advised of the possibility of such damages or losses;
            •  any damages or losses resulting from the hacking, tampering, or unauthorised use of or access to your Digital Wallet;
            •  any weaknesses, vulnerabilities, and bugs in the underlying blockchain networks, smart contracts, and/or technology used with or integrated into the Velas Wallet, 
            •  loss of digital assets, theft of digital assets, including as a result of a hacker or similar attack on, or weakness, vulnerability or bug in, the Velas Wallet;
            •  any damages or losses resulting from or relating to your use of any Third-Party Services, including within the Velas Wallet;
            •  the transactions made through or with the Velas Wallet.
        11.2.  In any event, without limiting the generality of the foregoing Clause 11.1 and to the maximum extent legally permissible, the Velas Parties’ aggregate liability to you arising out of these Terms or in any way related to your use or inability to use the Velas Wallet and functionality available therein shall be limited to EUR 1,000 (one thousand Euro).
            •  NO WARRANTY
        12.1.   The Velas Wallet is provided to you for free, on “as is” and “as available” basis. The Velas Wallet is provided without warranty of any kind, express or implied, including, but not limited to, the implied warranties of title, non-infringement, integration, merchantability, and fitness for a particular purpose, and any warranties implied by any course of performance or usage of trade, all of which are expressly disclaimed. Considering that you are able to verify and validate the source code of the Velas Wallet, your use of the Velas Wallet is solely at your own risk.
        12.2.   Velas does not warrant, whether expressly or impliedly, and expressly disclaims any warranty and representation that: (a) any information displayed in the Velas Wallet or otherwise communicated by Velas will be timely, accurate, reliable, true or correct; (b) the Velas Wallet or any related software will be secure, available at any particular time or place, work as expected; (c) the Velas Wallet or any related software will be maintained, developed or operated, or will continue functioning for any period of time, (d) any defects or errors in the Velas Wallet or related software will be corrected; or (d) the Velas Wallet or any related software will be free of defects, bugs, viruses, or other harmful components. 
            •  INTELLECTUAL PROPERTY
            •  All and any intellectual property rights in and to the Velas Wallet remain in sole ownership of Velas and its licensors. You shall not copy, modify, rent, lease, loan, sell, distribute, perform, display, or create derivative works based on, the Velas Wallet or its components without the Velas’s express prior written consent (excluding, for this purpose, components distributed under an open-source license, if any).
            •  Except as expressly stated herein, nothing in these Terms grants you any rights to, under or in, any patents, copyright, database right, trade secrets, trade names, trademarks (whether registered or unregistered), Velas’ name or distinctive brand features, or any other rights or licenses in respect of the Velas Wallet, any other software or items.
            •  Certain software, components and items used in or associated with the Velas Wallet may be distributed under the respective open-source licenses and you hereby agree to abide by and comply with the terms of such open-source licenses if and when applicable; the License granted under Section 4 of these Terms will not apply to any such software, components and items.
            •  PRIVACY
        Your personal data is processed in accordance with the Velas Wallet Privacy Notice available at: https://velas.com/pdf/velas_wallet_privacy_notice.pdf.
            •  TERMINATION 
            •  Velas has the right to immediately terminate these Terms and/or the License, or terminate your access to the Velas Wallet or any of its features at any time for any or no reason, including, but not limited to, if Velas believes that you have violated or may violate these Terms, applicable laws, rules, policies, or regulations. You may terminate these Terms at any time by ceasing the use of the Velas Wallet and disconnecting your Digital Wallet from the Velas Wallet. 
            •  Sections 3, 5, 6, 10, 11, 13, 18, 18, 24, and this Clause 15.2 shall survive any termination or expirations of these Terms regardless of the reason.
            •  NOTICES
        You hereby agree to receive all disclosures, notices, communication, and other documents related to these Terms and use of the Velas Wallet (collectively, “Notices”) electronically, and that such Notices may be communicated to you by email or by displaying them within the Velas Wallet. All electronic Notices shall be deemed to be in writing, valid, and of full legal force. You shall be deemed to have received any such Notice on the day following the date when it was communicated in accordance with this Section 16. Any Notices to Velas shall be sent to info@velas.com.
            •  FORCE MAJEURE
        In no event shall Velas be responsible or liable for any failure or delay in the performance of its obligations hereunder arising out of or caused by, directly or indirectly, forces beyond its control, including, without limitation, flood, extraordinary weather conditions, earthquake, or other act of God, fire, declared and undeclared war, epidemic, pandemic, insurrection, riot, labour dispute, accident, action of government, court, regulatory or other authorities, including the issuance of cease and desist orders, communications failure, hacker attacks, malware attacks, software weaknesses, malfunctions, 51% attacks or similar attacks, power failure, equipment or software malfunction or error, third-party acts or omissions, or any other cause beyond Velas’ reasonable control.
            •  GOVERNING LAW AND DISPUTE RESOLUTION
            •  These Terms, as well as any and all relationship between you and Velas relating to the Velas Wallet shall be governed by and construed and enforced in accordance with the Swiss laws, without regard to conflict of law rules or principles that would cause the application of the laws of any other jurisdiction. The United Nations Convention on Contracts for the International Sale of Goods shall not apply to these Terms.
            •  Any dispute arising out of or in connection with these Terms, including any question regarding their existence, validity or termination, shall be referred to and finally resolved by arbitration in accordance with the Swiss Rules of International Arbitration of the Swiss Chambers’ Arbitration Institution in force on the date on which the Notice of Arbitration is submitted in accordance with these Rules. The number of arbitrators shall be one. The seat, or legal place, of arbitration shall be Zurich, Switzerland. The language to be used in the arbitral proceedings shall be English. To the maximum extent permitted under the law, you and Velas hereby waive the rights to a jury trial, class action arbitration, and to have any dispute resolved in court.
            •  Any dispute arising out of or related to these Terms is personal to you and Velas and will be resolved solely through individual arbitration and will not be brought as a class arbitration, class action, or any other type of representative proceeding in any circumstances. There will be no class or other type or representative action, whether within or outside of arbitration where an individual attempts to resolve a dispute as a representative of another individual or group of individuals and you hereby waive your right to commence, to become a party to, or to remain a participant in, any group, representative, class, collective, or hybrid class/collective action in any court, arbitration proceeding, or any other forum, against Velas Parties if such action relates to these Terms, the Velas Wallet, or functionality available therein.  
            •  To the maximum extent permitted under the law, you and Velas hereby agree that any claim arising out of or related to these Terms or the Velas Wallet must be filed within 1 (one) year after the ground for such claim arose; if the claim is not filed within this term, such claim shall be permanently barred, which means that neither you, nor Velas will have the right to assert such claim.
            •  NO WAIVER
        No failure or delay to exercise any right or remedy provided under these Terms or by law shall constitute a waiver of that or any other right or remedy, nor shall it preclude or restrict the further exercise of that or any other right or remedy. No single or partial exercise of such right or remedy shall preclude or restrict the further exercise of that or any other right or remedy. 
            •  ENTIRE AGREEMENT 
        These Terms, together with any documents incorporated herein by reference, contain the entire agreement between you and Velas, and supersede all prior and contemporaneous understandings, writings, letters, statements or promises between you and Velas regarding the subject matters hereof. Unless otherwise expressly provided herein, there shall be no third-party beneficiaries hereto. 
            •  LANGUAGE
        Currently, only the English version of these Terms and any of the Velas' communications is considered official. The English version shall prevail in case of differences in translation of any documents, Notices or other content. 
            •  ASSIGNABILITY
        Neither party may assign or transfer any rights or obligations under these Terms without the other party's prior written notice, provided, however, that Velas may assign and transfer these Terms, any or all of the rights and obligations hereunder to its Affiliate or successor without your consent or approval, or any prior notice. 
            •  VALIDITY AND ENFORCEABILITY 
        The invalidity or unenforceability of any provision or part-provision of these Terms shall not affect the validity or enforceability of any other provisions of these Terms, all of which shall remain in full force and effect. 
            •  INTERPRETATION 
        Unless the context otherwise requires, a reference to one gender shall include a reference to the other genders; words in the singular shall include the plural and in the plural shall include the singular; any words following the terms including, include, in particular, for example or any similar expression shall be construed as illustrative and shall not limit the sense of the words, description, definition, phrase or term preceding those terms; Section headings do not affect the interpretation of these Terms. These Terms shall not be construed for or against Velas because of the Velas’ role in drafting these Terms.
        """
    store.terms = text
    cb null
module.exports = terms