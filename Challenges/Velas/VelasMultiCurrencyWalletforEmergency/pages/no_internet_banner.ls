require! {
    \react
    \./project-links.ls
    \../menu-funcs.ls
    \../get-primary-info.ls
    \../get-lang.ls
    \./icon.ls
    \../icons.ls : { unable_connect_icon }
}
.offline-mode-banner
    width: 100%
    text-align: center
    color: white
    box-sizing: border-box
    position: relative
    overflow: hidden
    z-index: 999999999
    height: 100vh
    position: fixed
    top: 0
    left: 0
    right: 0
    bottom: 0

    .iron
        -webkit-mask-image: linear-gradient(75deg, rgba(0, 0, 0, 0.6) 30%, #000 50%, rgba(0, 0, 0, 0.6) 70%)
        -webkit-mask-size: 50% 100%
        animation: shine 2s infinite
    @keyframes shine
        0%
            -webkit-mask-position: right
        100%
            -webkit-mask-position: left
    img
        width: 120px
        filter: drop-shadow(0 3mm 9mm rgb(160, 0, 210))

    .banner-content
        max-width: 700px
        background: var(--bg-primary-light)
        margin: auto
        padding: 60px
        border-radius: 20px
        width: auto
        box-shadow: 1px 2px 52px rgba(21, 20, 20, 0.41)
        border: 1px solid rgba(255, 255, 255, 0.07)
        @media (max-width: 500px)
            margin: 20px
            padding: 40px

        .offline-title
            letter-spacing: 0.5px
            color: white
            font-weight: bold
            margin-bottom: 30px
            margin-top: 30px

        .offline-text
            font-size: 14px
            max-width: 340px
            margin: auto
            opacity: .7

    .row
        display: flex
        align-items: center
        height: 100vh
        .h1
            font-size: 40px
            line-height: 40px
            text-transform: uppercase
            @media (max-width: 400px)
                font-size: 30px
        .p
            font-size: 14px
            a
                color: #6f6fe2
                text-decoration: underline
                cursor: pointer
        .h2
            font-size: 25px
            margin: 10px 0
            text-transform: uppercase
            color: orange

module.exports = ({ store, web3 })->
    style = get-primary-info store
    lang = get-lang store
    offline-mode-banner-style =
        background: style.app.background
    .offline-mode-banner.pug(style=offline-mode-banner-style)
        .pug.row
            .pug.banner-content
                img.pug.check(src="#{unable_connect_icon}")
                .pug.h3.offline-title Unable to connect to the network
                .pug.p.offline-text
                    | Oops.. Network connection was lost.
                    | For security reasons, we locked your wallet, you can continue using your wallet once connection is restored.
