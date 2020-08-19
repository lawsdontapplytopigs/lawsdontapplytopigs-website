module View exposing (view)

import Element as E
import Element.Background as EBackground
import Element.Border as EBorder
import Element.Font as EFont
import Element.Input as EInput

import Html
import Html.Attributes
import Icons

import Msg

import Palette

import Svg
import Svg.Attributes


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
        imageSizeRatioBreakpoint = 1.574
        widthOrHeight = 
            if (((toFloat model.viewportGeometry.width) / 2 ) / (toFloat imgSize)) < imageSizeRatioBreakpoint then
                E.height <| E.px imgSize
            else
                E.width <| E.px (round ((toFloat model.viewportGeometry.width) / 2))
    in
    E.column
        [ E.width E.fill
        , EFont.family
            [ EFont.typeface Palette.font0
            -- , EFont.typeface "Roboto"
            ]
        ]
        [ E.row
            [ E.width E.fill
            -- , E.height <| E.px 300
            -- , EBackground.color <| E.rgb255 255 225 246
            -- , EBackground.color <| E.rgb255 255 220 234
            -- , EBackground.color <| E.rgb255 255 135 172
            -- , E.paddingXY Palette.spacing1 Palette.spacing4
            , E.spacing Palette.spacing2
            , E.height <| E.px imgSize
            -- , EBackground.color <| E.rgb255 80 80 80
            ]
            [ E.el
                -- [
                -- ]
                -- <| E.html
                --     <| Html.div
                --         [ Html.Attributes.style "width" "700px"
                --         , Html.Attributes.style "height" "700px"
                --         , Html.Attributes.style "background-image" ("url(pog.jpg)")
                --         , Html.Attributes.style "background-size" "cover"
                --         ]
                --         [
                --         ]
                [ E.inFront
                    <| E.image
                        -- [ E.height <| E.px imgSize
                        [ widthOrHeight
                        , E.centerX
                        , E.htmlAttribute <| Html.Attributes.style "right" "25px"
                        , E.alignTop
                        ]
                        { src = "./pog.jpg"
                        , description = "fat pog"
                        }
                , E.width E.fill
                , E.height <| E.px imgSize
                -- , E.centerY
                -- , E.centerX
                , E.htmlAttribute <| Html.Attributes.style "overflow" "hidden"
                , E.alignLeft
                , E.alignTop
                -- , EBackground.color <| E.rgb255 80 80 80
                ]
                <| E.none
            , E.el
                [ E.width E.fill
                , E.height E.fill
                , E.inFront
                    <| E.el 
                        [ E.alignTop
                        , E.width E.fill
                        ]
                        <| desktopNavbar model
                ]
                <| E.column
                    [ EFont.size Palette.fontSize4
                    , E.centerY
                    -- , EBackground.color <| E.rgb255 20 20 20
                    -- , EFont.color <| E.rgb255 255 255 255
                    -- , EFont.color Palette.color1
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
                            , E.paddingEach { top = 0, right = 20, bottom = 0, left = 0 }
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
                                [ solidRoundedButton "contact me" Msg.NoOp
                                , regularRoundedButton "See my work" Msg.NoOp
                                ]
                            ]
                    ]
            ]
        , viewProjects model
        ]

truncateDescription desc =
    if String.length desc > 120 then
        (String.left 120 desc) ++ "..."
    else
        desc

viewProjects model =
    E.el
        [ E.height <| E.px 680
        -- , EBackground.color <| E.rgb255 80 80 80
        , E.width E.fill
        ]
        <| E.column
            [ E.centerY
            , E.centerX
            , E.spacing <| Palette.spacing2 + Palette.spacing1
            -- , EBackground.color <| Palette.color1
            ]
            [ E.el 
                [ E.centerX
                -- , EBackground.color <| E.rgb255 80 80 80
                ]
                <| E.paragraph
                    [ EFont.size Palette.fontSize6
                    , EFont.bold
                    -- , EFont.italic
                    , EFont.letterSpacing 1
                    -- , EBackground.color <| E.rgb255 80 80 80
                    -- , E.htmlAttribute <| Html.Attributes.style "text-transform" "uppercase"
                    ]
                    [ E.text "My latest work"
                    ]
            , E.row
                [ E.width E.fill
                , E.spacing 40
                ]
                [ E.el [ E.alignTop ] <| viewPost
                    "./0.png"
                    "Sewerslvt website concept"
                    "https://eloquent-turing-60c6e0.netlify.app/"
                    "https://github.com/lawsdontapplytopigs/Sewer"
                    (truncateDescription """In the span of 3 months I challenged my comfort zone and decided to make a windows95 themed website for the electronic music artist Sewerslvt.""")
                    "/sewerslvt"
                , E.el [ E.alignTop ] <| viewPost
                    "./1.png"
                    "Waneella landing page"
                    "https://musing-williams-2e3d7d.netlify.app/"
                    "https://github.com/lawsdontapplytopigs/waneella_site"
                    (truncateDescription """In 1 week I designed a (yet unfinished) concept landing page for Waneella, a popular pixel artist.""")
                    "/waneella"
                , E.el [ E.alignTop ] <| viewPost
                    "./2.png"
                    "AwesomeWM website concept"
                    "https://jovial-lovelace-8eb5a0.netlify.app/"
                    "https://github.com/lawsdontapplytopigs/awesomewm_website"
                    (truncateDescription """In the span of 2 months I took it upon myself to try to solve one of the biggest problems the AwesomeWM project was facing: accurately portraying the graphical capabilities of the window manager.""")
                    "/awesomewm"
                ]
            ]

viewPost imgSrc title livePreviewLink githubLink text viewProjectLink=
    E.column
        [ E.width <| E.maximum 400 E.fill
        , E.centerX
        , E.spacing Palette.spacing0
        ]
        [ E.newTabLink
            [
            ]
            { url = livePreviewLink
            , label =
                E.image
                    [ E.width <| E.px 400
                    ]
                    { src = imgSrc
                    , description = "uhh"
                    }
            }
        , E.paragraph
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
                E.el [ E.htmlAttribute <| Html.Attributes.style "text-transform" "uppercase"  ] <| E.text "view project"
            }
        ]

candyBg =
    let
        numberOfBarPairs = 20
        maxH = 400
        barW = 10

        drawBarPair ind makeBarPairFunc =
            makeBarPairFunc (ind*barW*2)
        makeBarPair xPos =
            Svg.g
                [
                ]
                [ Svg.rect
                    [ Svg.Attributes.x <| String.fromInt xPos
                    , Svg.Attributes.y "0"
                    , Svg.Attributes.width <| String.fromInt barW
                    , Svg.Attributes.height (String.fromInt maxH)
                    , Svg.Attributes.fill "#ffffff"
                    ]
                    []
                , Svg.rect
                    [ Svg.Attributes.x <| String.fromInt (xPos + barW)
                    , Svg.Attributes.y "0"
                    , Svg.Attributes.width <| String.fromInt barW
                    , Svg.Attributes.height (String.fromInt maxH)
                    , Svg.Attributes.fill "#ff3168"
                    ]
                    []
                ]
    in
    Svg.svg
        [ Svg.Attributes.viewBox "0 0 200 200"
        , Svg.Attributes.width "400"
        , Svg.Attributes.height "400"
        ]
        [ Svg.g
            [ Svg.Attributes.transform "rotate(-25)"
            ]
            <| List.indexedMap drawBarPair (List.repeat numberOfBarPairs makeBarPair)
        ]

candyRoundedButton text msg =
    EInput.button
        -- , E.htmlAttribute <| Html.Attributes.style "border-radius" "50%"
        -- , E.width <| E.px 180
        -- , E.height <| E.px 60
        [
        ]
        { onPress = Just msg
        , label = 
            E.el
                [ E.htmlAttribute <| Html.Attributes.style "overflow" "hidden"
                , E.paddingXY 20 10 
                , EBorder.rounded 99999999
                , EBorder.width 3
                ]
                <| E.el 
                    [ E.behindContent
                        <| E.el
                            [ E.htmlAttribute <| Html.Attributes.style "transform" "translate(-120px, -80px)"
                            ]
                            <| E.html candyBg
                    ]
                    <| E.text text
        }

regularRoundedButton text msg =
    EInput.button
        [ EBorder.width 3
        -- , E.htmlAttribute <| Html.Attributes.style "border-radius" "50%"
        , EBorder.rounded 99999999
        , EBackground.color <| E.rgb255 255 255 255
        ]
        { onPress = Just msg
        , label = E.el 
            [ E.paddingXY 20 10 
            ] <| E.text text
        }


solidRoundedButton text msg =
    EInput.button
        [ EBorder.width 0
        -- , E.htmlAttribute <| Html.Attributes.style "border-radius" "50%"
        , EBorder.rounded 99999999
        -- , EBackground.color Palette.color1
        , EBackground.color Palette.black
        ]
        { onPress = Just msg
        , label = E.el 
            [ E.paddingXY 23 13
            , EFont.color Palette.white
            ]
            <| E.text text
        }


desktopNavbar model =
    let
        makeLink label_ msg_ =
            EInput.button
                [ 
                ]
                { onPress = Just msg_
                , label = E.el 
                    [
                    ]
                    <| E.text label_
                }

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
    in
    E.row
        [ E.width E.fill
        , E.height <| E.px 70
        -- , EBackground.color Palette.color1
        ]
        [ E.row
            -- [ EBackground.color Palette.color1
            [ E.spacing 10
            ]
            [ makeIconLink Icons.github "https://github.com/lawsdontapplytopigs"
            , E.el
                [ E.htmlAttribute <| Html.Attributes.style "transform" "scale(1.2)"
                ]
                <| makeIconLink Icons.gmail "mailto:lawsdontapplytopigs@gmail.com"

            ]
        , E.row
            [ EFont.size Palette.fontSize0
            , EFont.medium
            , E.spacing 30
            , E.alignRight
            ]
            [ makeLink "Work" Msg.NoOp
            , makeLink "About" Msg.NoOp
            , makeLink "Contact" Msg.NoOp
            ]
        , E.el
            [ E.paddingEach { top = 0, right = 30, bottom = 0, left = 30 }
            , E.alignRight
            ]
            <| E.el
                [ E.width <| E.px 48
                , E.height <| E.px 48
                ]
                <| E.html Icons.logo
        ]




