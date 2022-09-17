require! {
    \react
    \react-dom
    \../navigate.ls
    \../get-primary-info.ls
    \../web3.ls
    \../get-lang.ls
    \../history-funcs.ls
    \./icon.ls
    \./switch-account.ls
    \../icons.ls
    \./epoch.ls
    \./alert-demo.ls
    \../components/burger.ls
}
.notice
    @import scheme
    $border-radius: $border
    $smooth: opacity .15s ease-in-out
    position: relative
    display: block
    width: auto
    overflow: hidden
    margin-left: $left-margin
    top: 0
    height: 100%
    min-height: 100vh
    padding-top: 5%
    box-sizing: border-box
    padding: 0px
    background: transparent
    .section-reward
        @import scheme
        border-bottom: 1px solid rgba(240, 237, 237, 0.16)
        padding: 30px 20px
        display: flex
        .claim-table
            margin: 10px auto
        button
            float: left
            background-color: #6595F5
            border: 1px solid #6595F5
            border-radius: 0px
            color: white
            height: 36px
            width: auto
            margin-top: 10px
            padding: 0 6px
            text-decoration: none
            text-transform: uppercase
            font-size: 10px
            font-weight: bold
            cursor: pointer
            outline: none
            display: inline-block
            text-overflow: ellipsis
            overflow: hidden
            white-space: nowrap
            @media (max-width: 800px)
                margin: 10px auto
                float: none
        @media (max-width: 800px)
            display: flow-root
            padding: 20px
        &:last-child
            border: 0
        &.reward
            background-image: $reward
            background-repeat: no-repeat
            background-position: 16%
            background-size: auto
            background-color: rgba(111, 50, 162, 0.15)
            @media(max-width: 800px)
                background-image: none
            @media(max-width: 540px)
                background-image: none
        .title
            padding: 0px
            width: 30%
            text-align: left
            text-transform: uppercase
            font-size: 14px
            h3
                font-size: 12px
                text-transform: uppercase
                letter-spacing: 2px
                opacity: .8
                font-weight: 400
                margin: 0
            @media (max-width: 800px)
                width: 100%
                margin-bottom: 20px
                text-align: center
            .less
                font-size: 10px
                opacity: 0.9
        .description
            padding: 0px
            font-size: 14px
            width: 70%
            text-align: left
            .table
                width: 240px
                .balance
                    text-align: right
                    .header
                        float: left
            hr
                margin: 15px auto
                border: 1px solid rgba(240, 237, 237, 0.16)
                border-top: 0
            .chosen-pool
                margin-bottom: 10px
                .color
                    color: orange
                    font-weight: 600
                    &.green
                        color: green
            &.table-scroll
                overflow-x: scroll
                max-height: 200px
                background: linear-gradient(#321260 30%, rgba(50, 18, 96, 0)), linear-gradient(rgba(50, 18, 96, 0), #321260 70%) 0 100%, radial-gradient(farthest-side at 50% 0, #594aaa, rgba(0, 0, 0, 0)), radial-gradient(farthest-side at 50% 100%, #594aaa, rgba(0, 0, 0, 0)) 0 100%
                background-repeat: no-repeat
                background-attachment: local, local, scroll, scroll
                background-size: 100% 30px, 100% 30px, 100% 15px, 100% 15px
                animation: breathe 3s ease-in infinite
                -moz-transition: breathe 3s ease-in infinite
                -web-kit-transition: breathe 3s ease-in infinite
            table
                width: 100%
                border-collapse: collapse
                margin: 0px auto
            tr:nth-of-type(odd)
                background: rgba(107, 38, 142, 0.2)
            th
                background: rgb(67, 32, 124)
                color: white
                font-weight: 400
                &:first-child
                    text-align: center
                    width: 5%
                &:nth-child(2)
                    width: 25%
                &:nth-child(3)
                    width: 45%
                &:nth-child(4)
                    width: 15%
            td, th
                padding: 10px
                border: 1px solid rgba(240, 237, 237, 0.16)
            .left
                position: relative
                .small-btns
                    line-height: 36px
                    button.small
                        outline: none
                        border-radius: 0px
                        line-height: 10px
                        text-align: center
                        height: 16px
                        font-size: 10px
                        font-weight: 600
                        margin-top: 0
                        width: auto
                        margin-right: 10px
                        padding: 2px 5px
                        cursor: pointer
            @media (max-width: 800px)
                width: 100%
                text-align: center
            .important
                color: orange
            .left-node
                width: 40%
                float: left
                @media (max-width: 800px)
                    width: 100%
                    text-align: center
                    margin-bottom: 20px
                @media (min-width: 801px) and (max-width: 992px)
                    width: 50%
                img
                    width: 240px
                    &.icon-svg
                        height: 12px
                        width: auto
                        padding-right: 5px
            .right-node
                width: 60%
                float: right
                @media (max-width: 800px)
                    width: 100%
                    text-align: center
                @media (min-width: 801px) and (max-width: 992px)
                    width: 50%
                    text-align: left
            &.node
                width: 80%
            .tabs
                display: inline-block
                margin: 20px 0 20px
                width: 100%
                .tab
                    width: 25%
                    display: inline-block
                    opacity: 0.5;
                    text-align: center
                    border-bottom: 1px solid
                    line-height: 37px
                    text-transform: uppercase
                    font-size: 10px
                    font-weight: bold
                    cursor: pointer
                    height: 36px
                    background: #2c0d5f
                    border-color: #6b258e
                    @media (max-width: 800px)
                        width: 50%
                    &.active
                        opacity: 1
                        border-bottom: 1px solid #6e1d96
                        background: #37156d
            .btn
                margin: 10px 0
            .code
                overflow: scroll
                background: #1b1b1b
                text-align: left
                .copy
                    float: right
                    margin-top: 11px
                    margin-right: 10px
                    width: 15px
                .cursor
                    -webkit-animation: blink 0.9s infinite
                    animation: blink 0.9s infinite
                    font: initial
                    display: inline-block
                    opacity: 1
                    margin-left: 5px
                @-webkit-keyframes blink
                    0%
                        opacity: 1
                    50%
                        opacity: 0
                    100%
                        opacity: 1
                @keyframes blink
                    0%
                        opacity: 1
                    50%
                        opacity: 0
                    100%
                        opacity: 1
                &.comming
                    background: transparent
                    text-align: center
            .window
                position: sticky
                top: 0
                left: 0
                height: 39px
                background: #040404
                .icons
                    padding: 0.75em
                    position: absolute
                    span
                        background: #040404
                    &:before
                        content: ""
                        background: #040404
                    &:after
                        content: ""
                        background: #040404
                    span, &:before, &:after
                        display: inline-block
                        float: left
                        width: 1em
                        height: 1em
                        border-radius: 50%
                        margin-right: 0.5em
            .balance
                font-size: 14px
                margin-bottom: 5px
                span
                    margin-right: 5px
                    &.green
                        color: #3cd5af
                .color
                    color: orange
                    font-weight: 600
                .label-coin
                    left: 3px
                    top: 2px
                    padding-right: 2px
                    height: 15px
                    position: relative
                    color: orange
                    font-weight: 600
            textarea
                border: 0
                padding: 10px
                font-size: 13px
                width: 100%
                box-sizing: border-box
                min-height: 120px
                font-family: monospace
        .content
            width: 30%
            position: relative
            button, .switch-index
                margin: 0
                position: absolute
                top: 50%
                left: 40%
                -ms-transform: translateY(-50%)
                transform: translateY(-50%)
    .active-download
        bottom: 10px
        right: 10px
        width: 226px
        background: inherit
        position: fixed
        display: inline-grid
        z-index: 3
        >.hide-progress
            display: none
        .file-name
            text-overflow: ellipsis
            overflow: hidden
            width: 90px
        progress
            width: 45px
            height: 16px
        .pending
            opacity: .5
        .progress
            float: right
        .cancel
            text-transform: uppercase
            float: right
            cursor: pointer
            font-weight: 600
            font-size: 11px !important
            text-align: right
            color: #6f6fe2 !important
        .action
            position: absolute
            right: 0px
            li
                display: inline-block
                margin-left: 12px
                cursor: pointer
                &.hide-progress
                    transform: rotate(180deg)
        .top
            border: 0
        img
            width: 20px
            height: 15px
            margin-right: 10px
        .col
            font-size: 12px
            padding: 10px 15px
            margin: 0
            display: inline-block
            vertical-align: top
            box-sizing: border-box
            color: rgb(204, 204, 204)
            overflow-y: hidden
            &.folder-menu
                text-align: left
                display: inline-flex
                span
                    margin-right: 10px
        .table-row-menu
            text-align: left
            &.active
                background: rgba(75, 40, 136, 0.2)
        .bottom, .middle
            padding: 10px
        .middle
            button
                outline: none
                cursor: pointer
                border: 1px solid
                padding: 0
                box-sizing: border-box
                border-radius: $border
                font-size: 10px
                padding: 0 6px
                height: 36px
                color: #6CA7ED
                text-transform: uppercase
                font-weight: bold
                background: transparent
                transition: all .5s
                text-overflow: ellipsis
                overflow: hidden
                width: 100%
                margin: 0 auto
                opacity: 1
                margin-top: 10px
    .menu
        width: 160px
        background: inherit
        position: absolute
        top: 188px
        right: 0px
        display: inline-grid
        z-index: 3
        .col
            font-size: 12px
            padding: 10px 15px
            margin: 0
            display: inline-block
            vertical-align: top
            box-sizing: border-box
            color: rgb(204, 204, 204)
            overflow-y: hidden
            &.folder-menu
                text-align: left
                display: inline-flex
                span
                    margin-right: 10px
        .table-row-menu
            text-align: left
            &:hover
                cursor: pointer
                background: rgba(75, 40, 136, 0.2)
            &.active
                background: rgba(75, 40, 136, 0.2)
        .bottom, .middle
            padding: 10px
        .middle
            button
                outline: none
                cursor: pointer
                border: 1px solid
                padding: 0
                box-sizing: border-box
                border-radius: $border
                font-size: 10px
                padding: 0 6px
                height: 36px
                color: #6CA7ED
                text-transform: uppercase
                font-weight: bold
                background: transparent
                transition: all .5s
                text-overflow: ellipsis
                overflow: hidden
                width: 100%
                margin: 0 auto
                opacity: 1
                margin-top: 10px
    @media(max-width:$ipad)
        width: 100%
        margin: 0
    .search-input
        position: fixed
        background: var(--background)
        z-index: 1
        width: 100%
        .add
            line-height: 35px
            cursor: pointer
            position: absolute
            right: 80px
        .close
            line-height: 2.4
            cursor: pointer
            width: 20px
            margin-right: 20px
            img
                height: 15px
                width: 15px
    @media(max-width:$ipad)
        width: 100%
        margin: 0
    .search-field
        .left
            position: relative
        .icon
            position: absolute
            top: 1px
            right: 0
            background: #532b94
            padding: 8px 20px 9px
    .section
        border-bottom: 1px solid rgba(240, 237, 237, 0.16)
        padding: 15px 20px 15px
        display: flex
        width: 100%
        @media(max-width: 800px)
            width: auto
        img
            height: 140px
            opacity: .8
            transition: .5s
            &.icon-svg-menu
                height: 12px
                margin-right: 10px
                width: auto
        &.filter
            padding: 0px
        &:last-child
            border: 0
        .title
            padding: 0px
            width: 25%
            text-align: left
            font-size: 14px
            @media(max-width: 800px)
                display: none
            h3, h2
                margin: 0
                line-height: 36px
                font-weight: 400
        .description
            padding: 0px
            font-size: 14px
            width: 40%
            text-align: left
            &.tabs
                overflow: hidden
                ul
                    overflow-x: scroll
                    scrollbar-width: none
                    white-space: nowrap
            @media(max-width: 800px)
                width: 100%
            ul
                list-style: none
                padding: 0
                margin: 10px 0 0
                li
                    display: inline-block
                    padding: 15px
                    cursor: pointer
                    &:first-child
                        padding-left: 0
                    .icon
                        margin-right: 5px
                        svg
                            vertical-align: middle !important
                    &.active
                        color: #c671f1
                        border-bottom: 1px solid
            input
                outline: none
                width: 100%
                box-sizing: border-box
                height: 36px
                line-height: 36px
                border-radius: $border-radius
                padding: 0px 10px
                font-size: 14px
                margin: 1px
                border: 0px
                box-shadow: none
    button
        background-color: $primary
        border: 1px solid $primary
        border-radius: $border
        color: white
        height: 36px
        width: 104px
        margin-top: 5px
        padding: 0 6px
        text-decoration: none
        text-transform: uppercase
        font-size: 10px
        font-weight: bold
        cursor: pointer
        outline: none
        display: inline-block
        text-overflow: ellipsis
        overflow: hidden
        white-space: nowrap
        &:hover
            background: transparent
            color: $primary
        &.link
            min-width: 190px
        float: right
        margin-top: 12px
        margin-right: 10px
    >.title
        position: sticky
        position: -webkit-sticky
        background: var(--background)
        box-sizing: border-box
        top: 0
        width: 100%
        color: gray
        font-size: 22px
        padding: 10px
        height: 60px
        z-index: 3
        >.header
            margin: 5px
            text-align: center
            @media(max-width:800px)
                text-align: center
    >.toolbar
        position: relative
        height: 60px
        ul
            display: inline-flex
            float: left
            list-style: none
            padding: 0 20px
            line-height: 1.8
            &.path
    >.wrapper
        height: 540px
        display: flex
        padding: 0px
        flex-wrap: wrap
        overflow-y: scroll
        scrollbar-width: none
        margin-top: 0px
        @media(max-width: 800px)
            padding: 0px
        >.panel-content
            margin-left: 300px
            padding: 20px
            box-sizing: border-box
            width: 100%
            .block-content
                padding-bottom: 20px
                margin-bottom: 20px
            &.dragarea
                overflow: inherit
            &.subscr
                display: grid
            &.file-tree
                margin-left: 0px
                @media(max-width: 800px)
                    margin-left: 0px
            .dragfile
                position: absolute
                height: 100vh
                background: rgba(35, 16, 68, 0.85)
                display: none
                &.dragarea
                    display: block
                    width: calc(100% - 180px)
                    display: block
                    top: 190px
                    left: 181px
                    z-index: 2
                    @media(max-width:800px)
                        left: 0
                        width: 100%
                div
                    top: 10rem
                    text-align: center !important
                    position: relative
                    width: 60% !important
                    padding: 50px 20px
                    border: 1px dashed
                    margin: 0 auto
                    display: block
                    @media (max-width: 800px)
                        width: 80% !important
                    img
                        display: block
                        width: 40px
                        margin: 0 auto 20px
                    span
                        color: #6f6fe2
                        cursor: pointer
                        display: block
            @media(max-width: 800px)
                width: 100%
                margin-left: 0
            .results
                text-align: left
                font-size: 13px
                margin: 0
            .header
                text-align: left
                font-size: 18px
                font-weight: 400
                margin: 0 0 20px
            .section
                padding: 0 15px 0 0
                display: inline-block
                width: 25%
                min-width: 205px
                min-height: 230px
                border: 0
                box-sizing: border-box
                vertical-align: text-top
                margin-bottom: 20px
                float: left
                @media(max-width:800px)
                    &:nth-child(odd)
                        padding: 0
                    width: 50%
                @media(max-width:640px)
                    width: 100%
                    padding: 0
                .source
                    position: relative
                &.developing
                    opacity: .5
                    .source
                        cursor: pointer
                        &:hover
                            .header, .address
                                text-decoration: none
                                cursor: not-allowed
                .address, .header, .description
                    width: 100%
                    text-align: left
                    margin: 5px 0
                .address
                    color: #969696
                    font-size: 13px
                    cursor: pointer
                .header
                    font-weight: 500
                    color: #fff
                    font-size: 17px
                    -webkit-line-clamp: 2
                    -webkit-box-orient: vertical
                    overflow: hidden
                    text-overflow: ellipsis
                    display: block
                    display: -webkit-box
                .description
                    opacity: .8
                    line-height: 1.6
                    font-size: 13px
                ul.stat
                    list-style: none
                    padding: 0
                    margin-bottom: 0
                    color: #969696
                    font-size: 13px
                    text-align: left
                    margin-top: 0
                    li
                        display: inline-block
                        margin-left: 4px
                        cursor: pointer
                        + li
                            &:before
                                content: ' · '
                        &:first-child
                            margin-left: 0
        >.msg-content
            margin-left: 300px
            padding: 0 0px
            width: 100%
            box-sizing: border-box
            .content-msg
                margin-top: 50px
                width: 100%
                height: 100vh
                ul
                    list-style: none
                    padding: 10px 30px
                    .in, .out
                        padding: 10px 0px
                        span
                            padding: 5px 10px
                            border-radius: 5px
                            display: inline-block
                            max-width: 50%
                            position: relative
                            font-size: 15px
                            span
                                float: right
                                opacity: .6
                                font-size: 10px
                                padding-right: 0
                    .in
                        text-align: left
                        >span
                            background: var(--bg-primary-light)
                            &:after
                                border-left: 15px solid transparent
                                left: -10px
                                position: absolute
                                bottom: 0
                                content: ''
                                width: 0
                                height: 0
                                border-bottom: 15px solid var(--bg-primary-light)
                    .out
                        text-align: right
                        >span
                            background: var(--bg-secondary)
                            &:after
                                border-right: 15px solid transparent
                                right: -10px
                                position: absolute
                                bottom: 0
                                content: ''
                                width: 0
                                height: 0
                                border-bottom: 15px solid var(--bg-secondary)
            &.file-tree
                margin-left: 0px
                @media(max-width: 800px)
                    margin-left: 0px
            .content-right
                width: 100%
                margin-left: 0px
                @media screen and (max-width: 800px)
                    width: 100%
                .star
                    width: 11px
                    height: 11px
                    margin-right: 10px
                    top: 4px
                    position: relative
            img
                width: 100%
                height: 140px
                opacity: .8
                transition: .5s
            @media(max-width: 800px)
                width: 100%
                margin-left: 0
                padding: 0
            .results
                text-align: left
                font-size: 13px
                margin: 0
            .search
                transform: translateY(0%)
                transition: .5s
                &.active
                    transform: translateY(100%)
                    transition: .5s
                input
                    outline: none
                    width: calc(100vw - 390px)
                    text-align: center
                    box-sizing: border-box
                    height: 30px
                    line-height: 36px
                    border-radius: 0px
                    border-radius: 4px
                    padding: 0px 10px
                    font-size: 14px
                    margin-top: 8px
                    transition: all .5s
                    border: 0px
                    box-shadow: none
                    &:active, &:focus
                        transition: all .5s
                        text-align: left
                    @media(max-width: 800px)
                        width: 100%
            .header, .textarea, .search
                text-align: left
                font-size: 17px
                line-height: 48px
                padding: 0 15px
                height: 50px
                box-sizing: border-box
                font-weight: 600
                margin: 0 0 30px
                position: fixed
                width: 100%
                >img
                    width: 30px
                    height: auto
                    margin-top: 10px
                    background: #909090
                    border-radius: 50px
                    margin-right: 10px
                span
                    display: inline-block
                    width: calc(100vw - 460px)
                    @media(max-width: 800px)
                        width: calc(100vw - 100px)
                    .name
                        font-size: 14px
                        line-height: 20px
                    .activity
                        font-size: 12px
                        line-height: 17px
                        opacity: .6
                .action
                    margin: 0
                    padding: 0
                    list-style: none
                    line-height: 0
                    vertical-align: super
                    width: 100%
                    display: inline
                    li
                        display: inline-block
                        img
                            width: 15px !important
                            height: 15px !important
                            margin-left: 10px
                            cursor: pointer
            .header, .textarea, .search
                text-align: left
                font-size: 18px
                font-weight: 400
                margin: 0 0 20px
                z-index: 1
            .header
                z-index: 2
            .textarea
                bottom: 0
                margin: 0
                input
                    outline: none
                    width: 60%
                    background: transparent !important
                    text-align: left
                    box-sizing: border-box
                    height: 30px
                    line-height: 36px
                    border-radius: 0px
                    border-radius: 4px
                    padding: 0px 10px
                    font-size: 14px
                    margin-top: 8px
                    margin-left: 8px
                    border: 0px
                    box-shadow: none
            .sub-header
                text-align: left
                font-size: 18px
                font-weight: 400
                margin: 0 0 50px
                opacity: .7
            .section
                padding: 0
                display: inline-block
                width: 100%
                min-width: 205px
                min-height: auto
                border: 0
                box-sizing: border-box
                vertical-align: text-top
                margin-bottom: 30px
                float: left
                .source
                    position: relative
                    display: flex
                .address, .header, .description
                    width: 100%
                    text-align: left
                    margin: 5px 0
                .address
                    color: #969696
                    font-size: 13px
                    cursor: pointer
                .header
                    font-weight: 500
                    color: #fff
                    font-size: 17px
                    -webkit-line-clamp: 2
                    -webkit-box-orient: vertical
                    overflow: hidden
                    text-overflow: ellipsis
                    display: block
                    display: -webkit-box
                    &.question
                        cursor: pointer
                        display: inline-flex
                        &.active
                            text-decoration: underline
                        &:hover
                            text-decoration: underline
                        &.placeholder
                            height: 20px
                            margin-bottom: 0px
                            img
                                display: none
                .description
                    opacity: .8
                    line-height: 1.6
                    font-size: 13px
                ul.answer
                    list-style: none
                    padding: 0
                    margin-bottom: 0
                    color: rgba(255, 255, 255, 0.8)
                    font-size: 15px
                    text-align: left
                    margin-top: 0
                    padding-top: 8px
                    margin-left: 25px
                    font-style: italic
                    li
                        display: inline-block
                        margin-bottom: 20px
                        &:last-child
                            margin-bottom: 0px
                        &.attention
                            background: rgba(89, 74, 170, 0.24)
                            padding: 20px 25px
                            border-left: 4px solid #6d48ce
                        img
                            height: 100%
                            width: 100%
                            box-shadow: 0px 10px 15px 0px rgba(24, 8, 64, 0.3)
        >.main-content
            width: 300px
            position: fixed
            box-sizing: border-box
            @media(max-width: 800px)
                display: inline-table
                position: relative
                margin-bottom: 40px
                display: none
            &.file-tree
                display: none
                @media(max-width: 800px)
                    display: none
            .tabs
                height: 100vh
                @media(max-width: 800px)
                    width: 100%
                    height: auto
                ul
                    overflow-x: scroll
                    scrollbar-width: none
                    text-align: left
                    height: calc(100vh - 170px)
                    .action
                        margin: 0
                        padding: 0
                        list-style: none
                        line-height: 0
                        vertical-align: super
                        width: 100%
                        display: inline
                        li
                            display: inline-block
                            img
                                width: 15px !important
                                height: 15px !important
                                margin-left: 10px
                                cursor: pointer
                .left-menu
                    height: 50px
                    background: #331462
                    border-top: 1px solid #6b268e
                    border-right: 1px solid #6b268e
                    position: fixed
                    box-sizing: border-box
                    width: 300px
                    bottom: 0
            @media(max-width: 800px)
                width: 100%
            ul
                list-style: none
                margin: 0
                padding: 0
                li
                    display: inline-block
                    padding: 10px
                    font-size: 14px
                    cursor: pointer
                    width: 100%
                    box-sizing: border-box
                    transition: .5s
                    &:first-child
                        padding: 0
                        display: inline-flex
                        height: 50px
                        background: #331462
                        width: 300px
                        position: fixed
                        z-index: 1
                        border-right: 1px solid #6b268e
                        input
                            outline: none
                            width: 230px
                            text-align: center
                            box-sizing: border-box
                            height: 30px
                            line-height: 36px
                            border-radius: 0px
                            border-radius: 4px
                            padding: 0px 10px
                            font-size: 14px
                            margin-top: 8px
                            margin-left: 8px
                            transition: .5s
                            border: 0px
                            box-shadow: none
                            &:active, &:focus
                                width: 280px
                                transition: .5s
                                text-align: left
                                ~ .edit
                                    transition: .5s
                                    position: absolute
                                    opacity: 0
                                    transform: translateX(100%)
                        .edit
                            width: 15px
                            height: 15px
                            margin-top: 15px
                            margin-left: 25px
                            cursor: pointer
                            transition: .5s
                    &:nth-child(2)
                        margin-top: 50px
                    span.notification
                        display: inline-block
                        width: 10%
                        vertical-align: top
                        text-align: right
                        .count
                            width: 20px
                            height: 20px
                            background: #a0a0a0
                            display: inline-block
                            text-align: center
                            float: right
                            margin-top: 13px
                            border-radius: 50px
                            font-size: 10px
                            line-height: 20px
                            color: #2a0f56
                        .time
                            font-size: 10px
                    .ava
                        width: 50px
                        height: 50px
                        background: #8e8e8e
                        display: inline-block
                        margin-right: 10px
                        border-radius: 100px
                        margin-top: 0
                    .preview
                        display: inline-block
                        width: 190px
                        vertical-align: top
                        .msg
                            font-size: 12px
                            height: 30px
                            overflow: hidden
                            text-overflow: ellipsis
                            display: -webkit-box
                            -webkit-box-orient: vertical
                            -webkit-line-clamp: 2
                            opacity: .6
                    .icon-svg
                        opacity: .8
                        transition: .5s
                        position: relative
                        height: 12px
                        top: 2px
                        opacity: 1
                        float: right
                        margin-right: 3px
                    .icon
                        margin-right: 15px
                        svg
                            vertical-align: middle !important
                    &.active
                        background: var(--bg-secondary)
                        .icon-svg
                            opacity: 1
                    &:hover
                        background: var(--bg-secondary)
                        transition: .5s
                        &:first-child
                            background: transparent
                            cursor: auto
    .staking-info
        display: block
        overflow-y: scroll
        scrollbar-width: none
        margin-top: 0
        display: flex
        flex-wrap: wrap
        margin-right: -10px
        margin-left: -10px
        .value
            color: orange
            text-align: center
            &.green
                color: rgb(60, 213, 175)
                text-align: center
        .header
            font-size: 12px
            text-transform: uppercase
            letter-spacing: 2px
            opacity: .8
            font-weight: 400
            margin-top: 10px
            text-align: center
        .col
            box-sizing: border-box
            padding: 0 5px
            margin-bottom: 10px
            &.col-4
                -webkit-box-flex: 0
                flex: 0 0 25%
                max-width: 25%
                @media(max-width: 992px)
                    -webkit-box-flex: 0
                    flex: 0 0 50%
                    max-width: 50%
            > div
                background: #3b1771
                padding: 30px 20px
item = (store, web3t)->
    lang = get-lang store
    { go-back } = history-funcs store, web3t
    info = get-primary-info store
    style=
        background: info.app.wallet
        color: info.app.text
    border-style =
        color: info.app.text
        border-bottom: "1px solid #{info.app.border}"
    border-right =
        color: info.app.text
        border-right: "1px solid #{info.app.border}"
    border-style2 =
        color: info.app.text
        border-bottom: "1px solid #{info.app.border}"
        background: "#4b2888"
    border-style3 =
        color: info.app.text
        border-bottom: "0"
    border-right =
        color: info.app.text
        border-right: "1px solid #{info.app.border}"
    button-primary2-style=
        border: "1px solid #{info.app.primary2}"
        color: info.app.text
        background: info.app.primary2
        background-color: info.app.primary2-spare
    header-table-style=
        border-bottom: "1px solid #{info.app.border}"
        background: info.app.wallet-light
        position: "sticky"
    dashed-border=
        border-color: "#{info.app.border}"
        color: info.app.color3
    filter-body =
        border: "1px solid #{info.app.border}"
        background: info.app.header
    border-b =
        border-bottom: "1px solid #{info.app.border}"
        background: info.app.header
    border-t =
        border-top: "1px solid #{info.app.border}"
        background: info.app.header
    button-primary1-style=
        border: "1px solid #{info.app.primary1}"
        color: info.app.text
        background: info.app.primary1
        background-color: info.app.primary1-spare
    input-style=
        background: info.app.wallet
        border: "0"
        color: info.app.text
    lightText=
        color: info.app.color3
    icon-style=
        filter: info.app.nothingIcon
    switch-files = ->
        store.current.files = not store.current.files
    search = ->
        store.notice.search = not store.notice.search
    search-show =
        if store.notice.search then \active else \ ""
    file-tree =
        if store.current.files then \file-tree else \ ""
    imgs=
        ava: "data:image/png;base64,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"
    .pug.msg-content(class="#{file-tree}")
        .header.pug(style=border-b)
            img.pug(src="#{imgs.ava}")
            span.pug
                .pug.name Paul Smith
                .pug.activity last seen 2 minutes ago
            ul.action.pug
                li.pug(key="icon-serach" )
                    img.icon-svg-video.pug(on-click=search src="#{icons.search}")
        .search.pug(style=border-b class="#{search-show}")
            input.pug(type='text' style=input-style value="" placeholder="#{lang.search}")
        .textarea.pug(style=border-t)
            input.pug(type='text' style=input-style value="" placeholder="#{lang.writemsg}")
        .pug.content-msg
            ul.pug
                li.pug.in(key="dialog1" )
                    span.pug 
                        | Hello
                        span.pug 22:53
                li.pug.out(key="dialog2" )
                    span.pug 
                        | Hi
                        span.pug 22:53
                li.pug.in(key="dialog-message-3" )
                    span.pug 
                        | How are you?
                        span.pug 22:53
                li.pug.out(key="dialog-message-4" )
                    span.pug 
                        | Fine
                        span.pug 22:53
                li.pug.out(key="dialog-message-5" )
                    span.pug 
                        | And you?
                        span.pug 22:53
                li.pug.in(key="dialog-message-6" )
                    span.pug 
                        | Inconspicuous motes of rock and gas how far away brain is the seed of intelligence gathered by gravity concept of the number one Orions sword.
                        span.pug 22:53
item2 = (store, web3t)->
    lang = get-lang store
    { go-back } = history-funcs store, web3t
    info = get-primary-info store
    style=
        background: info.app.wallet
        color: info.app.text
    border-style =
        color: info.app.text
        border-bottom: "1px solid #{info.app.border}"
    border-right =
        color: info.app.text
        border-right: "1px solid #{info.app.border}"
    border-style2 =
        color: info.app.text
        border-bottom: "1px solid #{info.app.border}"
        background: "#4b2888"
    border-style3 =
        color: info.app.text
        border-bottom: "0"
    border-right =
        color: info.app.text
        border-right: "1px solid #{info.app.border}"
    button-primary2-style=
        border: "1px solid #{info.app.primary2}"
        color: info.app.text
        background: info.app.primary2
        background-color: info.app.primary2-spare
    header-table-style=
        border-bottom: "1px solid #{info.app.border}"
        background: info.app.wallet-light
        position: "sticky"
    dashed-border=
        border-color: "#{info.app.border}"
        color: info.app.color3
    filter-body =
        border: "1px solid #{info.app.border}"
        background: info.app.header
    border-b =
        border-bottom: "1px solid #{info.app.border}"
        background: info.app.header
    border-t =
        border-top: "1px solid #{info.app.border}"
        background: info.app.header
    button-primary1-style=
        border: "1px solid #{info.app.primary1}"
        color: info.app.text
        background: info.app.primary1
        background-color: info.app.primary1-spare
    input-style=
        background: info.app.wallet
        border: "0"
        color: info.app.text
    lightText=
        color: info.app.color3
    icon-style=
        filter: info.app.nothingIcon
    switch-files = ->
        store.current.files = not store.current.files
    search = ->
        store.notice.search = not store.notice.search
    search-show =
        if store.notice.search then \active else \ ""
    file-tree =
        if store.current.files then \file-tree else \ ""
    imgs=
        ava: "data:image/png;base64,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"
    .pug.msg-content(class="#{file-tree}")
        .header.pug(style=border-b)
            img.pug(src="#{imgs.ava}")
            span.pug
                .pug.name Nicolas Gate
                .pug.activity last seen 2 minutes ago
            ul.action.pug
                li.pug(key="search-video" )
                    img.icon-svg-video.pug(on-click=search src="#{icons.search}")
        .search.pug(style=border-b class="#{search-show}")
            input.pug(type='text' style=input-style value="" placeholder="#{lang.search}")
        .textarea.pug(style=border-t)
            input.pug(type='text' style=input-style value="" placeholder="#{lang.writemsg}")
        .pug.content-msg
            ul.pug
                li.pug.in(key="dialog-message-8" )
                    span.pug 
                        | Hi, bro
                        span.pug 22:53
                li.pug.out(key="dialog-message-9" )
                    span.pug 
                        | Hello
                        span.pug 22:53
                li.pug.in(key="dialog-message-10" )
                    span.pug 
                        | How are you feeling?
                        span.pug 22:53
                li.pug.out(key="dialog-message-11" )
                    span.pug 
                        | Good
                        span.pug 22:53
                li.pug.out(key="dialog-message-12" )
                    span.pug 
                        | And you?
                        span.pug 22:53
                li.pug.in(key="dialog-message-13" )
                    span.pug 
                        | Also good!
                        span.pug 22:53
notice = ({ store, web3t })->
    lang = get-lang store
    { go-back } = history-funcs store, web3t
    goto-search = ->
        navigate store, web3t, \search
    info = get-primary-info store
    filter-body =
        border: "1px solid #{info.app.border}"
        background: info.app.header
    header-table-style=
        border-bottom: "1px solid #{info.app.border}"
        background: info.app.wallet-light
        position: "sticky"
    active =
        if store.current.active then \active else \ ""
    switch-progress = ->
        store.current.progress = not store.current.progress
    hide-progress =
        if store.current.progress then \hide-progress else \ ""
    switch-files = ->
        store.current.files = not store.current.files
    file-tree =
        if store.current.files then \file-tree else \ ""
    style=
        background: info.app.wallet
        color: info.app.text
    border-style =
        color: info.app.text
        border-bottom: "1px solid #{info.app.border}"
        background: info.app.background
        background-color: info.app.bgspare
    border-users =
        color: info.app.text
        border-right: "1px solid #{info.app.border}"
    border-style3 =
        color: info.app.text
        border-bottom: "0"
    border-right =
        color: info.app.text
    button-primary2-style=
        border: "1px solid #{info.app.primary2}"
        color: info.app.text
        background: info.app.primary2
        background-color: info.app.primary2-spare
    header-table-style=
        border-bottom: "1px solid #{info.app.border}"
        background: info.app.wallet-light
        position: "sticky"
    dashed-border=
        border-color: "#{info.app.border}"
        color: info.app.color3
    filter-body =
        border: "1px solid #{info.app.border}"
        background: info.app.header
    border-b =
        border-bottom: "1px solid #{info.app.border}"
    search-bg =
        border-bottom: "1px solid #{info.app.border}"
        border-right: "1px solid #{info.app.border}"
        background: info.app.header
    button-primary1-style=
        border: "1px solid #{info.app.primary1}"
        color: info.app.text
        background: info.app.primary1
        background-color: info.app.primary1-spare
    input-style=
        background: info.app.wallet
        border: "0"
        color: info.app.text
    lightText=
        color: info.app.color3
    icon-style=
        filter: info.app.nothingIcon
    border-t =
        border-top: "1px solid #{info.app.border}"
        border-right: "1px solid #{info.app.border}"
        background: info.app.header
    activate = (tab)-> ->
        store.faq.tab = tab 
    activate-item = activate \item
    activate-item2 = activate \item2
    activate-item3 = activate \item3
    activate-item4 = activate \item4
    active-class = (tab)->
        if store.faq.tab is tab then 'active' else ''
    active-item = active-class \item
    active-item2 = active-class \item2
    active-item3 = active-class \item3
    active-item4 = active-class \item4
    show-class =
        if store.current.open-menu then \hide else \ ""
    imgs=
        ava: "data:image/png;base64,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"
    .pug.notice
        alert-demo store, web3t
        .pug.title(style=border-style)
            .pug.header(class="#{show-class}") #{lang.velas-messenger}
            .pug.close(on-click=goto-search)
                img.icon-svg.pug(src="#{icons.arrow-left}")
            burger store, web3t
            epoch store, web3t
            switch-account store, web3t
        if no    
            .pug.search-input
                .pug.section(style=border-style)
                    span.pug.close(on-click=switch-files)
                        img.icon-svg-video.pug(src="#{icons.menu}")
                    .title.pug
                    .description.search-field.pug
                        .pug.left
                            input.pug(type='text' style=input-style value="velas" placeholder="velas")
                            .pug.icon
                                icon \Search, 15
        .pug.wrapper
            .pug.main-content(class="#{file-tree}" style=border-users)
                .pug.section.filter(style=border-right)
                    .tabs.pug
                        .pug.left-menu(style=border-t)
                        ul.pug(style=border-style3)
                            li.pug(key="icons-create" style=search-bg)
                                input.pug(type='text' style=input-style value="" placeholder="#{lang.search}")
                                img.edit.pug(src="#{icons.create}")
                            li.pug(key="avatar" on-click=activate-item class="#{active-item}" style=border-b)
                                img.pug.ava(src="#{imgs.ava}")
                                span.pug.preview
                                    .pug.name Paul Smith
                                    .pug.msg Inconspicuous motes of rock and gas how far away brain is the seed of intelligence gathered by gravity concept of the number one Orions sword.
                                span.pug.notification
                                    .pug.time 22:51
                                    .pug.count 2
                            li.pug(key="avatar2" on-click=activate-item2 class="#{active-item2}" style=border-b)
                                img.pug.ava(src="#{imgs.ava}")
                                span.pug.preview
                                    .pug.name Nicolas Gate
                                    .pug.msg Hey
                                span.pug.notification
                                    .pug.time Thu
                                    .pug.count 10
            if active-item is \active
                item store, web3t
            if active-item2 is \active
                item2 store, web3t
module.exports = notice