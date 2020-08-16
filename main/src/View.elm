module View exposing (view)

import Element as E
import Element.Background as EBackground
import Element.Border as EBorder
import Element.Font as EFont

import Html
import Html.Attributes
import Icons

import Palette


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
    -- let
        
    -- in
    E.column
        [ E.width E.fill
        , EFont.family
            [ EFont.typeface Palette.font0
            ]
        ]
        [ E.row
            [ E.width E.fill
            -- , E.height <| E.px 300
            -- , EBackground.color <| E.rgb255 255 225 246
            -- , EBackground.color <| E.rgb255 255 135 172
            -- , E.paddingXY Palette.spacing1 Palette.spacing4
            , E.spacing (0 - (Palette.spacing4* 2))
            , E.height <| E.px 700
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
                        [ E.height <| E.px 700
                        -- , E.width <| E.px 180
                        , E.centerY
                        , E.centerX
                        , E.htmlAttribute <| Html.Attributes.style "right" "25px"
                        ]
                        { src = "./pog.jpg"
                        , description = "fat pog"
                        }
                , E.width <| E.px 700
                , E.height <| E.px 700
                , E.centerY
                , E.centerX
                , E.htmlAttribute <| Html.Attributes.style "overflow" "hidden"
                , E.alignLeft
                ]
                <| E.none
            , E.column
                [ EFont.size Palette.fontSize3
                , E.centerX
                -- , EBackground.color <| E.rgb255 20 20 20
                -- , EFont.color <| E.rgb255 255 255 255
                , EFont.medium
                ]
                [ E.paragraph
                    [ E.centerX
                    -- , EBackground.color <| E.rgb255 80 80 80
                    , E.htmlAttribute <| Html.Attributes.style "text-align" "center"
                    ]
                    [ E.text "Hi, my name is Adrian. I design and create website frontends."
                    ]
                ]
            ]
        , viewProjects model
        ]

viewProjects model =
    E.column
        [ E.centerX
        , E.spacing Palette.spacing2
        -- , EBackground.color <| E.rgb255 80 80 80
        ]
        [ E.el 
            [ E.centerX
            ]
            <| E.paragraph
                [ EFont.size Palette.fontSize3
                , EFont.bold
                -- , EFont.italic
                -- , EBackground.color <| E.rgb255 80 80 80
                -- , E.htmlAttribute <| Html.Attributes.style "text-transform" "uppercase"
                ]
                [ E.text "My projects"
                ]
        , E.column
            [ E.width E.fill
            ]
            [ viewPost
                "./0.png"
                "Sewerslvt website concept"
                "https://eloquent-turing-60c6e0.netlify.app/"
                "https://github.com/lawsdontapplytopigs/Sewer"
                """In the span of 3 months I challenged my comfort zone and decided to make a windows95 themed website for the electronic music artist Sewerslvt."""
            ]
        ]

viewPost imgSrc title livePreviewLink githubLink text =
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
        ]


