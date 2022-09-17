require! {
    \react
    \../components/button.ls
    \prelude-ls : { map, filter, head, find } 
    \../../web3t/providers/superagent.js : { get }
    \../get-primary-info.ls
    \../icons.ls
    \../navigate.ls
    \../components/burger.ls
    \../seed.ls : seedmem
}
.wallets
    @import scheme
    @media(max-width:$ipad)
        width: 100%
        margin: 0
    margin-left: 0
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
            text-align: center
            @media(max-width:800px)
                text-align: center
    >.header
        padding: 50px
        font-size: 40px
    >.platforms
        text-align: center
        padding: 40px 0
        >.platform
            display: inline-block
            width: 300px
            padding: 20px
            vertical-align: top
            text-overflow: ellipsis
            border: 1px solid white
            overflow: hidden
            margin: 10px 1%
            border-radius: $border
            >.tag_name
                margin-bottom: 10px
            .title-icons
                height: 40px
                margin: 10px 0
                filter: brightness(4)
            a
                padding: 10px
            >.title
                font-size: 15px
                font-weight: bold
            >.source
                &.link
                    a
                        text-decoration: underline
                        padding: 0
            >.source, >.download
                padding: 10px 0 0
                box-sizing: content-box
                a
                    text-decoration: none
                    text-transform: uppercase
                    font-size: 10px
                    font-weight: bold
                    cursor: pointer
                    outline: none
                    display: inline-block
                    overflow: hidden
                    white-space: nowrap
                    width: 80px
                    border-radius: $border
build-version = (store, release)-->
    style = get-primary-info store
    button-primary1-style=
        border: "0"
        color: style.app.text-invert
        background: style.app.primary1
        background-color: style.app.primary1-spare
    button-primary3-style=
        border: "0"
        color: style.app.text2
        background: style.app.primary3
        background-color: style.app.primary3-spare
    button-primary2-style=
        border: "1px solid #{style.app.primary2}"
        color: style.app.text
        background: style.app.primary2
        background-color: style.app.primary2-spare
    button-link=
        border: "0"
        color: style.app.text2
        background: "transparent"
    resource =
        color: style.app.text
        border: "1px solid #{style.app.border}"
        background: style.app.header
    #md5-file = store.releases |> filter (.name is "#{name}.md5") |> head
    #md5 = md5-file.release.browser_download_url
    [...parts, last] = release.name.split('.')
    source = "https://github.com/velas/JsWalletDesktop"
    name = 
        | last is 'dmg' => \MacOS
        | last is 'exe' => \Windows
        | last is 'snap' => \Linux
    icon = 
        | last is 'dmg' => "#{icons.macos}"
        | last is 'exe' => "#{icons.windows}"
        | last is 'snap' => "#{icons.linux}"
    console.log "#{release.name}.md5"
    download-container-style-for-two-btns = {display: "flex", align-items: "center",  justify-content: "space-evenly", }
    download-container-style = 
        | last is 'snap' => download-container-style-for-two-btns 
        | _ => {}

    md5-file =
        store.releases
            |> map (it)->
                if it.name.endsWith(".exe")
                    it.name = it.name.replace("-Setup-", ".Setup.")
                it
            |> find (-> it.name is "#{release.name}.md5")
    .pug.platform(style=resource id="platform-#{name}")
        img.pug.title-icons(src="#{icon}")
        .pug.title #{name}
        .pug.tag_name #{release.tag_name}
        .pug.source
            a.pug(href="#{source}" style=button-primary3-style target="_blank" rel="noopener noreferrer nofollow") Source Code
        .pug.download(style=download-container-style)
            a.pug(href="#{release.browser_download_url}" style=button-primary1-style target="_blank" rel="noopener noreferrer nofollow") Install
            if last is 'snap' 
                    a.pug(href="https://snapcraft.io/velas-desktop-wallet" style=button-primary1-style target="_blank" rel="noopener noreferrer nofollow") Snapcraft
        .pug.source.link
            a.pug(href="#{md5-file?browser_download_url}" style=button-link target="_blank" rel="noopener noreferrer nofollow") MD5
only-version = (item)->
    [...parts, last] = item.name.split('.')
    last in <[ dmg exe snap ]>
only-md5 = (item)->
    [...parts, last] = item.name.split('.')
    last in <[ md5 ]>
header = (store, web3t)->
    info = get-primary-info store
    border-style =
        color: info.app.text
        border-bottom: "1px solid #{info.app.border}"
        background: info.app.background
        background-color: info.app.bgspare
    lock = ->
        saved-seed = seedmem.saved!
        prev-page = if saved-seed then \locked else \chooseinit
        navigate store, web3t, prev-page
    .pug.title(style=border-style)
        .pug.header Install Wallets
        .pug.close(on-click=lock)
            img.icon-svg.pug(src="#{icons.arrow-left}")
module.exports = ({ store, web3t })->
    .pug.wallets
        header store, web3t
        .pug.platforms
            store.releases |> filter only-version |> map build-version store
#update-md5 = ([release, ...releases], cb)->
#    return cb null if not release?
#    err, data <- get release.browser_download_url .end
#    return cb err if err?
#    console.log data.text
#    release.content = data.text 
#    update-md5 releases, cb
module.exports.init = ({ store, web3t}, cb)->
    #https://github.com/velas/JsWalletDesktop/releases/download/v0.12.111/velas-desktop-wallet-0.12.111-mac.zip
    #https://uploads.github.com/repos/velas/JsWalletDesktop/releases/27269358/assets{?name,label}
    err, data <- get \https://api.github.com/repos/velas/JsWalletDesktop/releases .end
    return cb err if err?
    latest-release =
        data.body |> head
    return cb "latest release is not found" if not latest-release? 
    err, data <- get latest-release.assets_url .end
    return cb err if err?
    store.releases = data.body |> map (it)->
        { ...it, latest-release.tag_name }
    cb null