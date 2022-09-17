require! {
    \react
    \../../get-lang.ls
}
.loader-page
    @import scheme
    $gradient: $primary - 20
    text-align: center
    overflow: hidden
    height: 100%
    $base-line-height: 34px
    $white: #7153e8
    $off-white: rgba($white, 0.2)
    $spin-duration: 1s
    $pulse-duration: 750ms
    z-index: 111
    opacity: 1;
    position: fixed
    top: 0 
    bottom: 0 
    left: 0 
    right: 0 
    background: rgba(0, 0, 0,  0.34) 
    @-webkit-keyframes text-blink
        0%
            opacity: 1
        50%
            opacity: 0.5
        100%
            opacity: 1
    @keyframes text-blink
        0%
            opacity: 1
        50%
            opacity: 0.5
        100%
            opacity: 1  
    .loader-text
        position: absolute;
        top: calc(50% + 8px);
        left: auto;
        right: auto;
        display: block;
        margin: auto;
        width: 100%;
        text-shadow: 1px 2px 12px #26e0f3d9;
        color: #34d9ba; 
        -webkit-animation: text-blink 0.9s infinite
        animation: text-blink 0.9s infinite      
    .loading-pulse
        position: absolute
        top: calc(50% - 32px)
        left: 50%
        width: ($base-line-height / 4)
        height: $base-line-height
        background: rgba(43, 140, 116,  0.64)
        animation: pulse $pulse-duration infinite
        animation-delay: ($pulse-duration / 3)
        &:before, &:after
            content: ''
            position: absolute
            display: block
            height: ($base-line-height / 1.5)
            width: ($base-line-height / 4)
            background: rgba(43, 140, 116,  0.64)
            top: 50%
            transform: translateY(-50%)
            animation: pulse $pulse-duration infinite
        &:before
            left: -($base-line-height / 2)
        &:after
            left: ($base-line-height / 2)
            animation-delay: ($pulse-duration / 1.5)
    .placeholder
        width: 100%
        margin-bottom: 10px
        display: inline-block
        border-radius: $border
        padding: 10px
        height: 60px
        text-align: left
        box-sizing: border-box
    >.loading
        position: absolute
        top: calc(50% - 32px)
        left: calc(50% - 32px)
        width: 64px
        height: 64px
        border-radius: 50%
        perspective: 800px
        >.inner
            position: absolute
            box-sizing: border-box
            width: 100%
            height: 100%
            border-radius: 50%
            &.one
                left: 0%
                top: 0%
                animation: rotate-one 1s linear infinite
                border-bottom: 3px solid #EFEFFA
                &.black
                    border-bottom: 3px solid #7083e8
            &.two
                right: 0%
                top: 0%
                animation: rotate-two 1s linear infinite
                border-right: 3px solid #EFEFFA
                &.black
                    border-right: 3px solid #7083e8
            &.three
                right: 0%
                bottom: 0%
                animation: rotate-three 1s linear infinite
                border-top: 3px solid #EFEFFA
                &.black
                    border-right: 3px solid #7083e8
        @keyframes rotate-one
            0%
                transform: rotateX(35deg) rotateY(-45deg) rotateZ(0deg)
            100%
                transform: rotateX(35deg) rotateY(-45deg) rotateZ(360deg)
        @keyframes rotate-two
            0%
                transform: rotateX(50deg) rotateY(10deg) rotateZ(0deg)
            100%
                transform: rotateX(50deg) rotateY(10deg) rotateZ(360deg)
        @keyframes rotate-three
            0%
                transform: rotateX(35deg) rotateY(55deg) rotateZ(0deg)
            100%
                transform: rotateX(35deg) rotateY(55deg) rotateZ(360deg)
module.exports = ({loading, text, styles})->
    return null if not loading
    loaderPageStyles = styles?loaderPage ? {}
    .loader-page.pug(key="loading" style=loaderPageStyles)
        if text? and (text ? "").length > 0
            .pug.h3.loader-text #{text} 
        .loading-pulse.pug