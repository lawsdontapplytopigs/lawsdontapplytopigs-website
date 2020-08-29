module View.SmallPhone exposing (view)


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
        [ E.el
            [ E.width E.fill
            , E.spacing Palette.spacing2
            , E.height <| E.px imgSize

            --     [ E.inFront
            --         <| E.image
            --             -- [ E.height <| E.px imgSize
            --             [ widthOrHeight
            --             , E.centerX
            --             , E.htmlAttribute <| Html.Attributes.style "right" "100px"
            --             , E.alignTop
            --             ]
            --             { src = "./pog.jpg"
            --             , description = "fat pog"
            --             }
            --     , E.width E.fill
            --     , E.height <| E.px imgSize
            --     -- , E.centerY
            --     -- , E.centerX
            --     , E.htmlAttribute <| Html.Attributes.style "overflow" "hidden"
            --     , E.alignLeft
            --     , E.alignTop
            --     -- , EBackground.color <| E.rgb255 80 80 80
            --     ]
            -- , EBackground.color <| E.rgb255 80 80 80
            , E.paddingXY 20 0
            ]
            -- [ E.el
            --     [ E.inFront
            --         <| E.image
            --             -- [ E.height <| E.px imgSize
            --             [ widthOrHeight
            --             , E.centerX
            --             , E.htmlAttribute <| Html.Attributes.style "right" "100px"
            --             , E.alignTop
            --             ]
            --             { src = "./pog.jpg"
            --             , description = "fat pog"
            --             }
            --     , E.width E.fill
            --     , E.height <| E.px imgSize
            --     -- , E.centerY
            --     -- , E.centerX
            --     , E.htmlAttribute <| Html.Attributes.style "overflow" "hidden"
            --     , E.alignLeft
            --     , E.alignTop
            --     -- , EBackground.color <| E.rgb255 80 80 80
            --     ]
            --     <| E.none
            <| E.el
                [ E.width E.fill
                , E.height E.fill
                , E.inFront
                    <| E.el 
                        [ E.alignTop
                        , E.width E.fill
                        ]
                        <| phoneNavbar model
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
                            , E.wrappedRow
                                [ EFont.size Palette.fontSize0
                                , EFont.medium
                                , E.spacing Palette.spacing0
                                ]
                                [ solidRoundedButton "contact me" Msg.NoOp
                                , regularRoundedButton model.mouseOverContactMe "See my work" Msg.NoOp
                                ]
                            ]
                    ]
        , viewProjects model
        , cuteSeparator 150
        , aboutMeBlock model
        , cuteSeparator 150
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
        , E.paddingXY 0 Palette.spacing5
        , E.spacing Palette.spacing3
        ]
        [ E.el 
            [ E.centerX
            -- , EBackground.color <| E.rgb255 80 80 80
            , E.htmlAttribute <| Html.Attributes.id "latest-work-section"
            ]
            <| E.paragraph
                [ EFont.size Palette.fontSize3
                , EFont.bold
                -- , EFont.italic
                , EFont.letterSpacing 1
                -- , EBackground.color <| E.rgb255 80 80 80
                , E.htmlAttribute <| Html.Attributes.style "text-align" "center"
                ]
                [ E.text "My latest work"
                ]
        , E.column
            [ E.centerY
            , E.centerX
            -- , EBackground.color <| Palette.color1
            ]
            [ E.column
                [ E.width E.fill
                , E.spacing 40
                ]
                [ E.el [ E.alignTop ] <| viewPost
                    "./0.png"
                    "Sewerslvt website concept"
                    "https://eloquent-turing-60c6e0.netlify.app/"
                    "https://github.com/lawsdontapplytopigs/Sewer"
                    (truncateDescription """In the span of 3 months I challenged my comfort zone and decided to make a windows95 themed website for the electronic music artist Sewerslvt.""")
                    "https://github.com/lawsdontapplytopigs/Sewer"
                , E.el [ E.alignTop ] <| viewPost
                    "./1.png"
                    "Waneella landing page"
                    "https://musing-williams-2e3d7d.netlify.app/"
                    "https://github.com/lawsdontapplytopigs/waneella_site"
                    (truncateDescription """In 1 week I designed a (yet unfinished) concept landing page for Waneella, a popular pixel artist.""")
                    "https://github.com/lawsdontapplytopigs/waneella_site"
                , E.el [ E.alignTop ] <| viewPost
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
    E.el
        -- [ E.height <| E.px 480
        [ E.paddingXY 20 Palette.spacing4
        -- , EBackground.color <| E.rgb255 0 0 0
        , E.width E.fill
        ]
        <| E.el
            -- [ E.width <| E.maximum 960 E.fill
            [ E.centerX
            -- , EFont.color <| E.rgb255 255 255 255
            , E.centerY
            , E.spacing Palette.spacing4
            ]
            <| E.column
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
                        , EFont.letterSpacing 2
                        , EFont.bold
                        , E.htmlAttribute <| Html.Attributes.style "text-transform" "uppercase"
                        , EFont.size Palette.fontSize2
                        ]
                        <| E.text "About me"
                , E.textColumn
                    [ E.spacing Palette.spacing1
                    , EFont.letterSpacing 0.5
                    , EFont.size Palette.fontSize1
                    , E.htmlAttribute <| Html.Attributes.style "text-align" "center"
                    , E.width E.shrink
                    ]
                    [ E.paragraph
                        [
                        ]
                        [ E.text """I've been programming for 2 years, and currently my primary interest is to monetize my UI, UX and frontend web development skills."""
                        ]
                    , E.paragraph
                        [
                        ]
                        [ E.text """I love challenges and getting out of my comfort zone. In the future I would like to work more with backend technologies and eventually I would love to work with machine learning, AI, statistical analysis, data visualization or related fields."""
                        ]
                    ]
                ]

            -- , E.el
            --     -- , EBackground.color <| E.rgb255 20 200 12
            --     -- , EBackground.color  <| E.rgb255 80 80 80
            --     [
            --     ]
            --     <| E.el
            --         -- [ E.height <| E.px 200
            --         -- , E.width <| E.px 200
            --         [ E.centerX
            --         , E.centerY
            --         -- , E.width <| E.px  60-- doing this because the original file was 60x60px
            --         -- , E.height <| E.px 60
            --         ]
            --         <| E.html (candyBg model)

cuteSeparator width =
    E.el
        [ EBackground.color <| E.rgb255 80 80 80
        , E.width <| E.px width
        , E.height <| E.px 1
        , E.centerX
        ]
        <| E.none

contactMeBlock model =
    E.el
        -- [ E.height <| E.px 480
        [ E.paddingXY 20 Palette.spacing4
        -- , EBackground.color <| E.rgb255 0 0 0
        , E.width E.fill
        ]
        <| E.row
            -- , EFont.color <| E.rgb255 255 255 255
            -- , EBackground.color <| E.rgb255 120 12 20
            [ E.centerX
            , E.centerY
            , E.spacing Palette.spacing4
            ]
            -- [ E.el
            --     -- , EBackground.color <| E.rgb255 20 200 12
            --     [ E.width <| E.px (60*5) -- doing this because the original file was 60x60px
            --     , E.height <| E.px (60*5) -- doing this because the original file was 60x60px
            --     -- , EBackground.color  <| E.rgb255 80 80 80
            --     ]
            --     <| E.el
            --         -- [ E.height <| E.px 200
            --         -- , E.width <| E.px 200
            --         [ E.htmlAttribute <| Html.Attributes.style "transform" "scale(5)"
            --         , E.centerX
            --         , E.centerY
            --         ]
            --         <| E.html (Icons.logo "#000000")
            [ E.column
                [ E.width <| E.maximum 640 E.fill
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

                        [ E.width E.fill
                        ]
                        <| E.el
                            [ EFont.size Palette.fontSize2
                            , E.htmlAttribute <| Html.Attributes.style "text-transform" "uppercase"
                            , EFont.bold
                            , EFont.letterSpacing 2
                            , E.centerX
                            ]
                            <| E.text "Contact me"
                , E.column
                    [ E.spacing Palette.spacing1
                    , EFont.letterSpacing 0.5
                    , EFont.size Palette.fontSize1
                    , E.htmlAttribute <| Html.Attributes.style "text-align" "center"
                    -- , EBackground.color <| E.rgb255 80 80 80
                    , E.width E.shrink
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
                        -- , EFont.color <| E.rgb255 85 35 72
                -- , EBackground.color <| E.rgb255 255 225 246

                -- , EBackground.color <| E.rgb255 255 220 234
                -- , EBackground.color <| E.rgb255 255 135 172
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

-- candyRoundedButton text msg =
--     EInput.button
--         -- , E.htmlAttribute <| Html.Attributes.style "border-radius" "50%"
--         -- , E.width <| E.px 180
--         -- , E.height <| E.px 60
--         [
--         ]
--         { onPress = Just msg
--         , label = 
--             E.el
--                 [ E.htmlAttribute <| Html.Attributes.style "overflow" "hidden"
--                 , E.paddingXY 20 10 
--                 , EBorder.rounded 99999999
--                 , EBorder.width 3
--                 ]
--                 <| E.el 
--                     [ E.behindContent
--                         <| E.el
--                             [ E.htmlAttribute <| Html.Attributes.style "transform" "translate(-120px, -80px)"
--                             ]
--                             <| E.html candyBg
--                     ]
--                     <| E.text text
--         }

regularRoundedButton mouseOverContactMe text msg = -- TODO: clean this up
    EInput.button
        [ EBorder.width 3
        -- , E.htmlAttribute <| Html.Attributes.style "border-radius" "50%"
        , EBorder.rounded 99999999
        , EBorder.color <| E.rgb255 0 0 0
        , EBackground.color 
            <| E.fromRgb <| Color.toRgba
                <| Animator.color mouseOverContactMe <| 
                    \btn ->
                        case btn of
                            False ->
                                Color.rgb255 255 255 255
                            True ->
                                Color.rgb255 0 0 0
                    
        , EFont.color
            <| E.fromRgb <| Color.toRgba
                <| Animator.color mouseOverContactMe <| 
                    \btn ->
                        case btn of
                            False ->
                                Color.rgb255 0 0 0
                            True ->
                                Color.rgb255 255 255 255
        , EEvents.onMouseEnter <| Msg.MouseEnteredButton
        , EEvents.onMouseLeave <| Msg.MouseLeftButton
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

    in
    E.row
        [ E.width E.fill
        , E.height <| E.px 70
        -- , EBackground.color Palette.color1
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
                    <| E.html (Icons.logo "#000000")
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
            [ makeLink "Work" Msg.NoOp
            , makeLink "About" Msg.NoOp
            , makeLink "Contact" Msg.NoOp
            ]
        ]


vSeparator height =
    E.el
        [ E.width <| E.px 1
        , E.height <| E.px height
        , EBackground.color <| E.rgb255 80 80 80
        ]
        <| E.none


