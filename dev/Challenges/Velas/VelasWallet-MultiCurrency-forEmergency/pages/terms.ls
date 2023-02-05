require! {
    \react
    \../navigate.ls
    \../get-primary-info.ls
    \../web3.ls
    \../get-lang.ls
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
    info = get-primary-info store
    style=
        background: info.app.wallet
        color: info.app.text
    button-style=
        color: info.app.text
    accept = ->
        navigate store, web3t, \:init
        <- web3t.refresh
    .pug.terms
        .pug.terms-body
            .pug.header Terms of Use
            textarea.pug(value="#{store.terms}" style=style)
            .pug.buttons
                .pug #{lang.terms}
                button { store, text: \accept , on-click: accept, type: \primary }
terms.init = ({ store }, cb)->
    #err, res <- get \https://raw.githubusercontent.com/askucher/expo-web3/dev/TERMS.md .end
    #return cb err if not res?text
    terms = "VELAS WALLET — TERMS AND CONDITIONS
        PLEASE READ THESE TERMS CAREFULLY AS THEY AFFECT YOUR OBLIGATIONS AND LEGAL RIGHTS. SECTION 13 CONTAINS BINDING ARBITRATION AND WAIVER OF CLASS ACTIONS PROVISIONS. IN ACCORDANCE WITH SECTION 7, OUR LIABILITY TO YOU IS LIMITED, AND CERTAIN TYPES OF LIABILITY ARE EXCLUDED.
        Last updated: July 3, 2020
        Any use of the Velas Wallet through the website available at https://wallet.velas.com/, browser extension (plugin), desktop or mobile application, or otherwise (the “Velas Wallet”), is subject to these Terms and Conditions (the “Terms”). By downloading, using, or otherwise accessing the Velas Wallet, or by accepting these Terms, you agree without modifications to these Terms. If you are unwilling or unable to be bound by these Terms, you shall not use the Velas Wallet and you shall cease any such use immediately.
        Throughout these Terms, the terms “you” and “your” are used to refer to you as a user of the Velas Wallet, including you as a holder of a digital wallet on the Velas Wallet (the “Wallet”) and/or any person authorised to use your Wallet. If you are entering into these Terms on behalf of an entity, you hereby warrant and represent that you are authorised to act on behalf of such entity and to bind such entity to these Terms, and you accept these Terms on behalf of such entity and on your own behalf. In such case, the references in these Terms to “you” and “your” shall refer to both the above entity on whose behalf an individual using the Velas Wallet is acting, and to such individual.
        The terms “we”, “our”, “us”, or “Velas” are used to refer to VELAS Networks AG, a company established under the laws of Switzerland, the owner and operator of the Velas Wallet.
            •  MODIFICATION
            •   Velas reserves the right, at its sole discretion, to modify or replace these Terms in any manner whatsoever. In case we modify these Terms, we will change the “Last Updated” date at the beginning of these Terms. An up-to-date version of these Terms will be available for access on the Velas Wallet. 
            •   If you continue to use the Velas Wallet after these Terms have been updated, this means that you agree on the updated version of the Terms. It is your sole responsibility to check these Terms regularly for updates.
            •  SECURITY
        When you use the Velas Wallet, Velas does not gain access to or control over your virtual assets, and does not have such technical ability. You are solely responsible for maintaining the confidentiality of your credentials (private key, mnemonic phrase (12 or 24 words seed) used to derive the private key) and other information that may be used to gain control over the virtual assets that you use with the Wallet (collectively, the “Credentials”). You are responsible for safeguarding your Credentials and making backup copies thereof offline or on your other devices. Velas Wallet does not have a “forgot the password” feature and cannot recover your Credentials, meaning that if you lose your Credentials, you may not be able to restore access to your Wallet and related assets. Do not share your Credentials with any other person, as this will give such person ability to dispose of your virtual assets. We do not store your Credentials on our servers, this information is encrypted and stored locally on your device. We are not liable for any loss or damage arising from your failure to comply with the obligations to maintain the confidentiality of your Credentials.
            •  LICENSE
        Subject to your compliance with these Terms, Velas hereby grants you limited, personal, non-exclusive, non-transferable, non-assignable, royalty-free, revocable license to use the Velas Wallet. If you commit a breach of these Terms or violate applicable legislation, the license granted hereunder shall automatically terminate and cease.
            •  PROHIBITED USE
        You shall not:
            •   Use the Velas Wallet for any illegal purposes, including, but not limited to, terrorism financing and money laundering.
            •   Circumvent or attempt to circumvent any access or functionality restrictions or limitations with respect to the Velas Wallet or underlying software.
            •   Use robots, spiders, or other similar automated means to access the Velas Wallet or its parts.
            •   Use the Velas Wallet in any manner that could disrupt, interfere with, or inhibit other users from using it, or that could disable, impair, or harm the functioning of the Velas Wallet or servers.
            •   Copy, duplicate, reproduce, clone the Velas Wallet, create derivative works from the Velas Wallet or related content. In addition, you shall not attempt to modify, translate, adapt, edit, decompile, disassemble, or reverse engineer the Velas Wallet or related content without our prior written authorisation.
            •   “Frame”, “mirror”, or incorporate any part of the Velas Wallet into another software, website, network, platform, or application without our prior written authorisation.
            •  REPRESENTATIONS AND WARRANTIES
        You represent and warrant that you:
            •   Are eligible and have full capacity for setting up and holding a Wallet under the laws of the country of your residence.
            •   Are of the necessary legal age, in accordance with the laws of the country of your residence, to use the Velas Wallet, however, in any case, you shall be older than 14 (fourteen) years old.
            •   Are not a subject of any sanctions administered or enforced by any country, government, or international authority nor are you a resident or established (in the case of a corporate entity) in a country or territory that is the subject of a country-wide or territory-wide sanction imposed by any country, government, or international authority.
            •   Have all necessary rights to set up and hold your Wallet and this does not infringe any rights of third parties.
            •   Will use the Velas Wallet only for legitimate purposes and you will not use it for any illegal or fraudulent activity.
            •   Will use funds within the Velas Wallet, which are from legitimate sources and were lawfully acquired.
            •   Will carefully check the address of the recipient before making any transfers and that your transactions with virtual assets are done with correct blockchain addresses.
            •  INDEMNITY
        You shall indemnify and hold Velas, its directors, officers, employees, agents, and representatives harmless from and against any and all third-party claims, actions, demands, losses, costs, expenses, fines, penalties, liabilities, and other amounts that arise out of or related to your use of the Velas Wallet or your violation of any provision of these Terms.
            •  LIMITATION ON LIABILITY
        TO THE EXTENT PERMITTED BY LAW, IN NO EVENT SHALL VELAS OR ANY OF ITS DIRECTORS, OFFICERS, EMPLOYEES, AGENTS, OR REPRESENTATIVES (COLLECTIVELY, “VELAS PARTIES”) BE LIABLE FOR ANY INDIRECT, PUNITIVE, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES, INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF PROFITS, LOSS OF OR DAMAGE TO DATA, LOSS OF BUSINESS, DIMINUTION OF VALUE, OR ANY OTHER SIMILAR DAMAGES, LOST REVENUES, ARISING OUT OF THESE TERMS OR IN ANY WAY RELATED TO YOUR USE OR INABILITY TO USE THE VELAS WALLET OR YOUR WALLET REGARDLESS OF THE THEORY OF LIABILITY AND EVEN IF VELAS PARTIES HAVE BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. UNDER NO CIRCUMSTANCES SHALL VELAS PARTIES BE LIABLE FOR ANY DAMAGE, LOSS, OR INJURY RESULTING FROM THE HACKING, TAMPERING, OR UNAUTHORISED USE OF OR ACCESS TO YOUR WALLET. IN ADDITION, VELAS PARTIES SHALL NOT BE LIABLE FOR ANY WEAKNESSES, VULNERABILITIES, AND BUGS IN THE SMART CONTRACT, BLOCKCHAIN, AND OTHER NETWORKS, AND/OR TECHNOLOGIES USED WITH THE VELAS WALLET; LOSS OF DIGITAL ASSETS; THEFT OF DIGITAL ASSETS, INCLUDING, AS A RESULT OF AN ATTACK. IN ANY CASE, WITHOUT LIMITING THE GENERALITY OF THE FOREGOING AND TO THE MAXIMUM EXTENT LEGALLY PERMISSIBLE, VELAS PARTIES’ TOTAL AGGREGATE LIABILITY TO YOU ARISING OUT OF THESE TERMS OR IN ANY WAY RELATED TO YOUR USE OR INABILITY TO USE THE VELAS WALLET SHALL BE LIMITED TO EUR 1,000 (ONE THOUSAND EURO).
            •  NO WARRANTY
        THE VELAS WALLET IS PROVIDED TO YOU FOR FREE, ON “AS IS” AND “AS AVAILABLE” BASIS. THE VELAS WALLET IS PROVIDED WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF TITLE, NON-INFRINGEMENT, INTEGRATION, MERCHANTABILITY, AND FITNESS FOR A PARTICULAR PURPOSE, AND ANY WARRANTIES IMPLIED BY ANY COURSE OF PERFORMANCE OR USAGE OF TRADE, ALL OF WHICH ARE EXPRESSLY DISCLAIMED. VELAS DOES NOT WARRANT THAT: (A) ANY INFORMATION WILL BE TIMELY, ACCURATE, RELIABLE OR CORRECT; (B) THE VELAS WALLET WILL BE SECURE OR AVAILABLE AT ANY PARTICULAR TIME OR PLACE; (C) ANY DEFECTS OR ERRORS WILL BE CORRECTED; OR (D) THE VELAS WALLET WILL BE FREE OF DEFECTS, BUGS, VIRUSES, OR OTHER HARMFUL COMPONENTS. 
        CONSIDERING THAT YOU ARE ABLE TO VERIFY AND VALIDATE THE SOURCE CODE OF THE VELAS WALLET, YOUR USE OF THE VELAS WALLET IS SOLELY AT YOUR OWN RISK.
            •  INTELLECTUAL PROPERTY
            •   All and any intellectual property rights in and to the Velas Wallet remain in sole ownership of Velas or its licensors. You shall not to copy, modify, rent, lease, loan, sell, distribute, perform, display, or create derivative works based on the Velas Wallet in whole or in part, unless Velas’s prior written consent has been obtained.
            •   Except as expressly stated herein, we do not grant you any rights to, under or in, any patents, copyright, database right, trade secrets, trade names, trademarks (whether registered or unregistered), or any other rights or licenses in respect of the Velas Wallet or any other software or items. The Velas Wallet is protected under the laws and, unless expressly provided herein, may not be copied, decompiled, imitated or used, in whole or in part, without our prior written authorisation.
            •  TERMINATION 
            •   In case we reasonably believe that you have violated or may violate any provision of these Terms, applicable rules, policies, laws, or regulations, we have the right to immediately terminate these Terms and your access to the Velas Wallet without your prior written consent or notification.
            •   You may terminate these Terms if you cease using the Velas Wallet and deactivate (delete) your Wallet.
            •   In case of any termination of these Terms, the license provided to you under Section 3 shall automatically terminate and cease accordingly.
            •   Sections 5 “REPRESENTATIONS AND WARRANTIES”, 6 “INDEMNITY”, 7 “LIMITATION OF LIABILITY”, 8 “NO WARRANTY”, 9 “INTELLECTUAL PROPERTY”, 11 “NOTICES”, 13 “GOVERNING LAW AND DISPUTE RESOLUTION”, 14 “MISCELLANEOUS” and this Clause 10.4 shall survive any termination or expirations of these Terms regardless of the reason.
            •  NOTICES
            •   You hereby agree to receive all disclosures, notices, communication, change in Terms, and other documents related to these Terms and use of the Velas Wallet (collectively, “Notices”) electronically by means of an email or by displaying them on the Velas Wallet. Such electronic Notices shall be deemed to be in writing, valid, and of full legal force. You shall be deemed to have received any such Notice on the day following the date when it is displayed or send in accordance with this Section.
            •   Any Notices to Velas shall be sent to info@velas.com.
            •  FORCE MAJUERE
        Velas shall not have any liability under or be deemed to be in breach of these Terms for any delays or failures in performance of these Terms which result from circumstances beyond its reasonable control. Such circumstances include, without limitation, riot, war (whether declared or not), sanctions, invasion, acts of foreign enemies, hostilities, terrorism, civil war, rebellion, revolution, coup, requisition, or compulsory acquisition by any governmental or competent authority, ionising radiation or contamination, earthquakes, floods, fire, natural disasters, strikes at national level, epidemic, and pandemic; system interference and/or destruction by any malicious programs, other circumstances beyond our control, interfering the performance hereof.
            •  GOVERNING LAW AND DISPUTE RESOLUTION
            •   These Terms are governed by the Swiss law, without regard to conflict of law principles.
            •   Any dispute arising out of or in connection with these Terms, including any question regarding their existence, validity or termination, shall be referred to and finally resolved by arbitration in accordance with the Swiss Rules of International Arbitration of the Swiss Chambers’ Arbitration Institution in force on the date on which the Notice of Arbitration is submitted in accordance with these Rules. The number of arbitrators shall be one. The seat, or legal place, of arbitration shall be Zurich, Switzerland. The language to be used in the arbitral proceedings shall be English.
            •   Any dispute arising out of or related to these Terms is personal to you and Velas and will be resolved solely through individual arbitration and will not be brought as a class arbitration, class action, or any other type of representative proceeding in any circumstances. 
        THERE WILL BE NO CLASS OR OTHER TYPE OR REPRESENTATIVE ACTION, WHETHER WITHIN OR OUTSIDE OF ARBITRATION WHERE AN INDIVIDUAL ATTEMPTS TO RESOLVE A DISPUTE AS A REPRESENTATIVE OF ANOTHER INDIVIDUAL OR GROUP OF INDIVIDUALS AND YOU HEREBY WAIVE YOUR RIGHT TO COMMENCE, TO BECOME A PARTY TO, OR TO REMAIN A PARTICIPANT IN, ANY GROUP, REPRESENTATIVE, CLASS, COLLECTIVE, OR HYBRID CLASS/COLLECTIVE ACTION IN ANY COURT, ARBITRATION PROCEEDING, OR ANY OTHER FORUM, AGAINST VELAS IN RESPECT TO THESE TERMS.
            •  To the maximum extent permitted under the law, you and Velas hereby agree that any claim arising out of or related to these Terms or the Velas Wallet must be filed within 1 (one) year after the ground for such claim arose; if the claim is not filed within this term, such claim shall be permanently barred, which means that neither you, nor Velas will have the right to assert such claim.
            •  MISCELLANEOUS
            •   Any failure to enforce these Terms made by you or us does not constitute a waiver of the respective rights or remedies.
            •   We have the right to transfer all and any rights under these Terms to anyone without your prior written consent or permission. You are not allowed to transfer any rights under these Terms to anyone without our prior written consent.
            •   The section titles in the Terms are for convenience only and have no legal or contractual effect.
            •   There shall be no third-party beneficiaries to these Terms, except as otherwise expressly provided herein.
            •   If any provision or part-provision of these Terms is or becomes invalid, illegal or unenforceable, it shall be deemed deleted, but that shall not affect the validity and enforceability of the rest of these Terms. If any provision or part-provision of these Terms is deemed deleted under the previous sentence, you and us shall negotiate in good faith to agree a replacement provision that, to the greatest extent possible, achieves the intended commercial result of the original provision.
            •   These Terms constitute the entire agreement between you and Velas regarding the subject matter hereof and supersede all and any previous agreements.
            •   These Terms shall not be construed for or against Velas because of Velas’s role in drafting these Terms."
    store.terms = terms
    cb null
module.exports = terms