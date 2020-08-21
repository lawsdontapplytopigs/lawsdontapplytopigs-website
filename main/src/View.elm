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

import Svg as S
import Svg.Attributes as SA


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
        , aboutMeBlock model
        , contactMeBlock model
        ]

truncateDescription desc =
    if String.length desc > 120 then
        (String.left 120 desc) ++ "..."
    else
        desc

viewProjects model =
    E.column
        [ E.width E.fill
        , E.paddingXY 0 Palette.spacing4
        , E.spacing Palette.spacing3
        ]
        [ E.el 
            [ E.centerX
            -- , EBackground.color <| E.rgb255 80 80 80
            , E.htmlAttribute <| Html.Attributes.id "latest-work-section"
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
        , E.column
            [ E.centerY
            , E.centerX
            -- , EBackground.color <| Palette.color1
            ]
            [ E.row
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
        ]

aboutMeBlock model =
    E.el
        -- [ E.height <| E.px 480
        [ E.paddingXY 0 Palette.spacing4
        -- , EBackground.color <| E.rgb255 0 0 0
        , E.width E.fill
        ]
        <| E.row
            [ E.width <| E.maximum 780 E.fill
            -- , EFont.color <| E.rgb255 255 255 255
            -- , EBackground.color <| E.rgb255 120 12 20
            , E.centerX
            , E.centerY
            , E.spacing Palette.spacing2
            ]
            [ E.column
                [ E.width <| E.fillPortion 172
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

                    [ EFont.size Palette.fontSize2
                    , E.htmlAttribute <| Html.Attributes.style "text-transform" "uppercase"
                    , EFont.bold
                    , EFont.letterSpacing 2
                    ]
                    <| E.text "About me"
                , E.textColumn
                    [ E.spacing Palette.spacing1
                    , EFont.letterSpacing 0.5
                    , EFont.size Palette.fontSize0
                    ]
                    [ E.paragraph
                        [
                        ]
                        [ E.text """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras mauris urna, bibendum nec augue vitae, vulputate tempus leo. """
                        ]
                    , E.paragraph
                        [
                        ]
                        [ E.text """Nam venenatis semper lorem. Cras imperdiet erat mauris, vitae fermentum tellus venenatis vel. Fusce semper scelerisque lorem, id tristique dui facilisis in. Sed ultrices viverra egestas. Aliquam rutrum eros et blandit ultrices. """
                        ]
                    ]
                ]
            , E.el
                -- , EBackground.color <| E.rgb255 20 200 12
                -- [ E.width <| E.px (60*5) -- doing this because the original file was 60x60px
                -- , E.height <| E.px (60*5) -- doing this because the original file was 60x60px
                -- , EBackground.color  <| E.rgb255 80 80 80
                [ E.height <| E.px 320
                , E.width <| E.px 200
                ]
                <| E.el
                    -- [ E.height <| E.px 200
                    -- , E.width <| E.px 200
                    -- [ E.htmlAttribute <| Html.Attributes.style "transform" "scale(5)"
                    [ E.centerX
                    , E.centerY
                    ]
                    <| E.html Icons.codePanelBackground
            ]

contactMeBlock model =
    E.el
        -- [ E.height <| E.px 480
        [ E.paddingXY 0 Palette.spacing4
        -- , EBackground.color <| E.rgb255 0 0 0
        , E.width E.fill
        ]
        <| E.row
            [ E.width <| E.maximum 780 E.fill
            -- , EFont.color <| E.rgb255 255 255 255
            -- , EBackground.color <| E.rgb255 120 12 20
            , E.centerX
            , E.centerY
            , E.spacing Palette.spacing2
            ]
            [ E.el
                -- , EBackground.color <| E.rgb255 20 200 12
                [ E.width <| E.px (60*5) -- doing this because the original file was 60x60px
                , E.height <| E.px (60*5) -- doing this because the original file was 60x60px
                -- , EBackground.color  <| E.rgb255 80 80 80
                ]
                <| E.el
                    -- [ E.height <| E.px 200
                    -- , E.width <| E.px 200
                    [ E.htmlAttribute <| Html.Attributes.style "transform" "scale(5)"
                    , E.centerX
                    , E.centerY
                    ]
                    <| E.html (Icons.logo "#000000")
            , E.column
                [ E.width <| E.fillPortion 172
                , E.spacing Palette.spacing2
                ]
                [ E.el
                    [ E.width E.fill
                    ]
                    <| E.el
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

                        [ EFont.size Palette.fontSize2
                        , E.htmlAttribute <| Html.Attributes.style "text-transform" "uppercase"
                        , EFont.bold
                        , EFont.letterSpacing 2
                        , E.alignRight
                        ]
                        <| E.text "Contact me"
                , E.textColumn
                    [ E.spacing Palette.spacing1
                    , EFont.letterSpacing 0.5
                    , EFont.size Palette.fontSize0
                    , E.htmlAttribute <| Html.Attributes.style "text-align" "right"
                    ]
                    [ E.paragraph
                        [
                        ]
                        [ E.text """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras mauris urna, bibendum nec augue vitae, vulputate tempus leo. """
                        ]
                    , E.paragraph
                        [
                        ]
                        [ E.text """Nam venenatis semper lorem. Cras imperdiet erat mauris, vitae fermentum tellus venenatis vel. Fusce semper scelerisque lorem, id tristique dui facilisis in. Sed ultrices viverra egestas. Aliquam rutrum eros et blandit ultrices. """
                        ]
                    ]
                ]
            ]

viewPost imgSrc title livePreviewLink githubLink text viewProjectLink =
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
                    , description = "project preview image"
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
                E.el 
                    [ E.htmlAttribute <| Html.Attributes.style "text-transform" "uppercase"  
                    -- , EFont.color <| E.rgb255 85 35 72
            -- , EBackground.color <| E.rgb255 255 225 246

            -- , EBackground.color <| E.rgb255 255 220 234
            -- , EBackground.color <| E.rgb255 255 135 172
                    ]
                    <| E.text "view project"
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
                    , SA.fill "#ff3168"
                    ]
                    []
                ]
    in
    S.svg
        [ SA.viewBox "0 0 200 200"
        , SA.width "400"
        , SA.height "400"
        ]
        [ S.g
            [ SA.transform "rotate(-25)"
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
                <| E.html (Icons.logo "#000000")
        ]


-- dopeSMatter nestedGeometry model =
--     let
--         width = nestedGeometry.width
--         height = nestedGeometry.height
--     in
--     S.svg
--         [ SA.version "1.1"
--         , SA.x "0px"
--         , SA.y "0px"
--         , SA.viewBox <| "0 0 " ++ (String.fromInt width) ++ " " ++ (String.fromInt height)
--         ]
--         [ 
--         ]








