module View.Phone exposing (view)


import Animator
import Element as E
import Element.Background as EBackground
import Element.Border as EBorder
import Element.Events as EEvents
import Element.Font as EFont
import Element.Input as EInput
import Color

import Html
import Html.Attributes
import Icons

import Msg

import Palette

import Svg as S
import Svg.Attributes as SA
import View.Lib


view title model =
    let
        body =
            E.layout
                [ E.width E.fill
                , E.height E.fill
                ]
                <| mainCol model
    in
        { title = title
        , body = [ body ]
        }


mainCol model =
    let
        imgSize =
            if model.viewportGeometry.height < 680 then
                model.viewportGeometry.height
            else
                680
    in
    E.column
        [ E.width E.fill
        , EFont.family
            [ EFont.typeface Palette.font0
            -- , EFont.typeface "Roboto"
            ]
        ]
        [ E.el
            [ E.width E.fill
            , E.spacing Palette.spacing2
            , E.height <| E.px imgSize
            , E.paddingXY 20 0
            , EBackground.color Palette.color7
            ]
            <| E.el
                [ E.width E.fill
                , E.height E.fill
                , E.inFront
                    <| E.el 
                        [ E.alignTop
                        , E.width E.fill
                        ]
                        <| phoneNavbar model
                , EFont.color <| Palette.color0
                ]
                <| E.column
                    [ EFont.size Palette.fontSize4
                    , E.centerY
                    , E.height E.fill
                    , E.width E.fill
                    ]
                    [ E.el
                        [ E.width E.fill
                        -- , EBackground.color <| E.rgb255 80 80 80
                        , E.height E.fill
                        , EFont.semiBold
                        ]
                        <| E.column
                            [ E.alignBottom
                            , E.spacing 10
                            -- , E.paddingEach { top = 0, right = 20, bottom = 0, left = 0 }
                            ]
                            [ E.paragraph
                                -- , E.htmlAttribute <| Html.Attributes.style "text-align" "center"
                                -- , EBackground.color <| E.rgb255 80 80 80
                                [
                                ]
                                [ E.text "Hi, my name is Adrian."
                                ]
                            , E.paragraph
                                -- , E.htmlAttribute <| Html.Attributes.style "text-align" "center"
                                -- , EBackground.color <| E.rgb255 80 80 80
                                [
                                ]
                                [ E.text "I design and create website frontends."
                                ]
                            ]
                    , E.el
                        [ E.height E.fill
                        , E.width E.fill
                        ]
                        <| E.column
                            [ E.spacing 10
                            , E.paddingEach { top = 80, right = 0, bottom = 0, left = 0 }
                            ]
                            [ E.paragraph
                                [ EFont.family
                                    [ EFont.typeface Palette.font1
                                    ]
                                -- , EFont.color Palette.color1
                                , EFont.size 42
                                , EFont.regular
                                , E.htmlAttribute <| Html.Attributes.style "text-transform" "uppercase"
                                ]
                                [ E.text "Available for hire!"
                                ]
                            , E.row
                                [ EFont.size Palette.fontSize0
                                , EFont.medium
                                , E.spacing Palette.spacing0
                                ]
                                [ View.Lib.solidRoundedButton "contact me" (Msg.SmoothScroll View.Lib.contactMeSectionId)
                                , View.Lib.regularRoundedButton model.mouseOverContactMe "See my work" (Msg.SmoothScroll View.Lib.latestWorkSectionId)
                                ]
                            ]
                    ]
        , latestWork model
        , aboutMeBlock model
        , contactMeBlock model
        , View.Lib.footer
        ]

truncateDescription desc =
    if String.length desc > 120 then
        (String.left 120 desc) ++ "..."
    else
        desc

latestWork model =
    E.column
        [ E.width E.fill
        , EBackground.color Palette.color7
        ]
        [ E.el 
            [ E.centerX
            -- , EBackground.color <| E.rgb255 80 80 80
            , E.htmlAttribute <| Html.Attributes.id View.Lib.latestWorkSectionId
            , E.paddingEach { top = 60, right = 0, bottom = 0, left = 0 }
            ]
            <| E.paragraph
                [ EFont.size Palette.fontSize5
                , EFont.bold
                , EFont.color Palette.color0
                -- , EFont.italic
                , EFont.letterSpacing 2
                -- , EBackground.color <| E.rgb255 80 80 80
                -- , E.htmlAttribute <| Html.Attributes.style "text-transform" "uppercase"
                , E.htmlAttribute <| Html.Attributes.style "text-align" "center"
                ]
                [ E.text "My latest work"
                ]
        , E.column
            [ E.centerY
            , E.centerX
            -- , EBackground.color <| Palette.color1
            , E.paddingXY 0 60
            , EFont.color Palette.color0
            ]
            [ E.column
                [ E.width E.fill
                , E.spacing 40
                ]
                [ viewPost
                    "./0.png"
                    "Sewerslvt website concept"
                    "https://eloquent-turing-60c6e0.netlify.app/"
                    "https://github.com/lawsdontapplytopigs/Sewer"
                    (truncateDescription """In the span of 3 months I challenged my comfort zone and decided to make a windows95 themed website for the electronic music artist Sewerslvt.""")
                    "https://github.com/lawsdontapplytopigs/Sewer"
                , viewPost
                    "./1.png"
                    "Waneella landing page"
                    "https://musing-williams-2e3d7d.netlify.app/"
                    "https://github.com/lawsdontapplytopigs/waneella_site"
                    (truncateDescription """In 1 week I designed a (yet unfinished) concept landing page for Waneella, a popular pixel artist.""")
                    "https://github.com/lawsdontapplytopigs/waneella_site"
                , viewPost
                    "./2.png"
                    "AwesomeWM website concept"
                    "https://jovial-lovelace-8eb5a0.netlify.app/"
                    "https://github.com/lawsdontapplytopigs/awesomewm_website"
                    (truncateDescription """In the span of 2 months I took it upon myself to try to solve one of the biggest problems the AwesomeWM project was facing: accurately portraying the graphical capabilities of the window manager.""")
                    "https://github.com/lawsdontapplytopigs/awesomewm_website"
                ]
            ]
        ]

aboutMeBlock model =
    let
        pfp =
            E.el
                -- [ E.width <| E.px 180
                -- [ E.width <| E.px 180
                [ E.htmlAttribute <| Html.Attributes.style "border-radius" "50%"
                , E.htmlAttribute <| Html.Attributes.style "overflow" "hidden"
                , E.width <| E.px 180
                , E.height <| E.px 180
                , E.inFront
                    <| E.image
                        [ E.height <| E.px 180
                        , E.htmlAttribute <| Html.Attributes.style "right" "80px"
                        ]
                        { src = "./pog.jpg"
                        , description = "my profile image"
                        }
                ]
                <| E.none
    in
    E.el
        -- [ E.height <| E.px 480
        [ E.paddingXY 0 Palette.spacing4
        , EBackground.color Palette.color7
        , E.width E.fill
        , E.htmlAttribute <| Html.Attributes.id View.Lib.aboutMeSectionId
        ]
        <| E.column
            -- [ E.width <| E.maximum 960 E.fill
            [ E.centerX
            , EFont.color Palette.color0
            -- , EBackground.color <| E.rgb255 120 12 20
            , E.centerY
            , E.spacing Palette.spacing2
            ]
            [ pfp
                -- |> wrapColorCircle Palette.color5
                |> View.Lib.wrapColorCircle Palette.color1
                |> E.el [ E.centerX ]
                    
            , E.column
                [ E.width <| E.maximum 640 E.fill
                , E.spacing Palette.spacing2
                ]
                [ E.el
                    -- [ EFont.size Palette.fontSize4
                    -- , EFont.semiBold
                    -- ]

                    -- [ EFont.family
                    --     [ EFont.typeface Palette.font1
                    --     ]
                    -- -- , EFont.color Palette.color1
                    -- , EFont.size 42
                    -- , EFont.regular
                    -- , E.htmlAttribute <| Html.Attributes.style "text-transform" "uppercase"
                    -- ]

                    [ E.width E.fill
                    ]
                    <| E.el 
                        [ E.centerX
                        , EFont.letterSpacing 1
                        , EFont.bold
                        -- , E.htmlAttribute <| Html.Attributes.style "text-transform" "uppercase"
                        , EFont.size Palette.fontSize2
                        ]
                        <| E.text "About me"

                , E.textColumn
                    [ E.spacing Palette.spacing1
                    , EFont.letterSpacing 0.5
                    , EFont.size Palette.fontSize1
                    , E.width E.shrink
                    , E.htmlAttribute <| Html.Attributes.style "text-align" "center"
                    , E.paddingXY 20 0
                    ]
                    View.Lib.aboutMeText
                ]
            ]


contactMeBlock model =
    E.el
        -- [ E.height <| E.px 480
        [ E.paddingXY 0 Palette.spacing4
        , EBackground.color Palette.color7
        , E.width E.fill
        , E.htmlAttribute <| Html.Attributes.id View.Lib.contactMeSectionId
        ]
        <| E.row
            -- , EFont.color <| E.rgb255 255 255 255
            [ E.centerX
            , E.centerY
            , E.spacing Palette.spacing4
            -- , EBackground.color <| E.rgb255 120 12 20
            ]
            [ E.column
                [ E.width <| E.maximum 640 E.fill
                , E.spacing Palette.spacing2
                ]
                [ E.el
                    [ E.width <| E.px (60*3) -- doing this because the original file was 60x60px
                    , E.height <| E.px (60*3) -- doing this because the original file was 60x60px
                    , E.centerX
                    ]
                    <| E.el
                        [ E.htmlAttribute <| Html.Attributes.style "transform" "scale(3)"
                        , E.centerX
                        , E.centerY
                        ]
                        <| E.html (Icons.logo "#1c1424")
                , E.el
                    [ E.width E.fill
                    ]
                    <| E.el
                        [ E.width E.fill
                        ]
                        <| E.el
                            [ EFont.size Palette.fontSize2
                            , EFont.bold
                            , EFont.letterSpacing 1
                            , E.centerX
                            ]
                            <| E.text "Contact me"
                , E.column
                    [ E.spacing Palette.spacing1
                    , EFont.letterSpacing 0.5
                    , EFont.size Palette.fontSize1
                    , E.htmlAttribute <| Html.Attributes.style "text-align" "center"
                    ]
                    [ E.newTabLink 
                            [ E.centerX
                            ]
                            { url = "mailto:lawsdontapplytopigs@gmail.com"
                            , label = 
                                E.row
                                    [ E.spacing Palette.spacing0
                                    ]
                                    [ E.el
                                        [ E.height <| E.px 16
                                        , E.width <| E.px 16
                                        ]
                                        <| E.html <| Icons.gmail 
                                    , E.text "my email"
                                    ]
                            }
                    , E.newTabLink 
                            [ E.centerX
                            ]
                            { url = "https://github.com/lawsdontapplytopigs"
                            , label = 
                                E.row
                                    [ E.spacing Palette.spacing0
                                    ]
                                    [ E.el
                                        [ E.height <| E.px 16
                                        , E.width <| E.px 16
                                        ]
                                        <| E.html <| Icons.github
                                    , E.text "my github"
                                    ]
                            }
                    , E.paragraph
                        [
                        ]
                        [ E.text "You can also find me on other social media "
                        , E.el [ EFont.italic ] <| E.text "@lawsdontapplytopigs."
                        ]
                    ]
                ]
            ]

viewPost imgSrc title livePreviewLink githubLink text viewProjectLink =
    E.column
        [ E.width <| E.fill
        , E.centerX
        , E.spacing Palette.spacing0
        ]
        [ E.newTabLink
            [
            ]
            { url = livePreviewLink
            , label =
                E.image
                    [ E.width E.fill
                    ]
                    { src = imgSrc
                    , description = title
                    }
            }
        , E.column
            [ E.spacing Palette.spacing0
            , E.paddingXY 10 0
            ]
            [ E.paragraph
                [ EFont.size Palette.fontSize2
                , EFont.semiBold
                -- , E.htmlAttribute <| Html.Attributes.style "text-transform" "uppercase"
                ]
                [ E.text title
                ]
            , E.row
                [ EFont.size Palette.fontSize0
                , EFont.medium
                , E.spacing Palette.spacing0
                ]
                [ E.newTabLink 
                    [
                    ]
                    { url = livePreviewLink
                    , label = 
                        E.row
                            [ E.spacing (Palette.spacing0 // 2)
                            ]
                            [ E.el
                                [ E.height <| E.px 16
                                , E.width <| E.px 16
                                ]
                                <| E.html <| Icons.live
                            , E.text "live preview"
                            ]
                    }
                , E.newTabLink 
                    [
                    ]
                    { url = githubLink
                    , label = 
                        E.row
                            [ E.spacing (Palette.spacing0 // 2)
                            ]
                            [ E.el
                                [ E.height <| E.px 16
                                , E.width <| E.px 16
                                ]
                                <| E.html <| Icons.github
                            , E.text "code"
                            ]
                    }
                ]
            , E.paragraph
                [ E.width E.fill
                , EFont.size Palette.fontSize0
                ]
                [ E.text text
                ]
            , E.newTabLink
                [ EFont.size Palette.fontSize0
                , EFont.semiBold
                , E.paddingEach {top = 5, right = 0, bottom = 0, left = 0}
                ]
                { url = viewProjectLink
                , label = 
                    E.el 
                        [ E.htmlAttribute <| Html.Attributes.style "text-transform" "uppercase"  
                        ]
                        <| E.text "view project"
                }
            ]
        ]

candyBg model =
    let
        numberOfBarPairs = 20
        maxH = 400
        barW = 10

        movement = 
            Animator.loop 
                (Animator.millis 1600)
                (Animator.wrap 0.0 1.0)

        currentVal =
            Animator.move model.candyBarPercentOffset (\val -> movement) -- TODO: refactor this
                |> (*) (barW * 2)
        drawBarPair ind makeBarPairFunc =
            makeBarPairFunc (ind*barW*2)
        makeBarPair xPos =
            S.g
                [
                ]
                [ S.rect
                    [ SA.x <| String.fromInt xPos
                    , SA.y "0"
                    , SA.width <| String.fromInt barW
                    , SA.height (String.fromInt maxH)
                    , SA.fill "#ffffff"
                    ]
                    []
                , S.rect
                    [ SA.x <| String.fromInt (xPos + barW)
                    , SA.y "0"
                    , SA.width <| String.fromInt barW
                    , SA.height (String.fromInt maxH)
                    -- , SA.fill "#ff314c"
                    , SA.fill "#000000"
                    ]
                    []
                ]
    in
    S.svg
        [ SA.viewBox "0 0 200 200"
        , SA.width "400"
        , SA.height "400"
        ]
        [ S.defs
            [
            ]
            [ S.clipPath
                [ SA.id "rounded-rect"
                ]
                [ S.rect
                    [ SA.x "100"
                    , SA.y "40"
                    , SA.width "30"
                    , SA.height "120"
                    , SA.rx "15"
                    ]
                    [
                    ]
                ]
            ]
        , S.g
            [ SA.clipPath "url(#rounded-rect)"
            ]
            [ S.g
                -- , SA.transform "translate(-200px)"
                [ SA.transform "rotate(-76, 100, 200)"
                ]

                [ S.g
                    [ SA.transform <| "translate(" ++ String.fromFloat currentVal ++")"
                    ]

                    <| List.indexedMap drawBarPair (List.repeat numberOfBarPairs makeBarPair)
                ]
            ]
        ]


makeIconLink icon_ url_ =
    E.newTabLink 
        []
        { url = url_
        , label = 
            E.el
                [ E.height <| E.px 16
                , E.width <| E.px 16
                ]
                <| E.html <| icon_
        }

phoneNavbar model =
    E.row
        [ E.width E.fill
        , E.height <| E.px 70
        -- , EBackground.color Palette.color1
        , EFont.color Palette.color0
        ]
        [ E.row
            [ E.spacing 15
            ]
            [ E.el
                [ E.paddingEach { top = 0, right = 10, bottom = 0, left = 0 }
                ]
                <| E.el
                    [ E.width <| E.px 48
                    , E.height <| E.px 48
                    ]
                    <| E.html (Icons.logo "#1c1424")
            , vSeparator 20
            , E.row
                -- [ EBackground.color Palette.color1
                [ E.spacing 10
                ]
                [ makeIconLink Icons.github "https://github.com/lawsdontapplytopigs"
                , E.el
                    [ E.htmlAttribute <| Html.Attributes.style "transform" "scale(1.2)"
                    ]
                    <| makeIconLink Icons.gmail "mailto:lawsdontapplytopigs@gmail.com"
                ]
            ]
        , E.row
            [ EFont.size Palette.fontSize0
            , EFont.medium
            , E.spacing 30
            , E.alignRight
            ]
            [ View.Lib.makeNavbarLink "Work" (Msg.SmoothScroll View.Lib.latestWorkSectionId)
            , View.Lib.makeNavbarLink "About" (Msg.SmoothScroll View.Lib.aboutMeSectionId)
            , View.Lib.makeNavbarLink "Contact" (Msg.SmoothScroll View.Lib.contactMeSectionId)
            ]
        ]



vSeparator height =
    E.el
        [ E.width <| E.px 1
        , E.height <| E.px height
        , EBackground.color <| E.rgb255 80 80 80
        ]
        <| E.none


