module View.Lib exposing (..)

import Animator
import Color
import Element as E
import Element.Background as EBackground
import Element.Border as EBorder
import Element.Events as EEvents
import Element.Font as EFont
import Element.Input as EInput

import Html.Attributes
import Msg
import Palette


{-| -}
type alias Device =
    { class : DeviceClass
    , orientation : Orientation
    }


{-| -}
type DeviceClass
    = SmallPhone
    | Phone
    | Tablet
    | Desktop
    | BigDesktop


{-| -}
type Orientation
    = Portrait
    | Landscape


{-| Takes in a Window.Size and returns a device profile which can be used for responsiveness.

If you have more detailed concerns around responsiveness, it probably makes sense to copy this function into your codebase and modify as needed.

-}
classifyDevice : { window | height : Int, width : Int } -> Device
classifyDevice window =
    -- Tested in this ellie:
    -- https://ellie-app.com/68QM7wLW8b9a1
    { class =
        let
            longSide =
                max window.width window.height

            shortSide =
                min window.width window.height
        in
        if shortSide < 500 then
            SmallPhone
        else if shortSide < 800 then
            Phone

        else if longSide <= 1400 then
            Tablet

        else if longSide > 1200 && longSide <= 1920 then
            Desktop

        else
            BigDesktop
    , orientation =
        if window.width < window.height then
            Portrait

        else
            Landscape
    }


regularRoundedButton mouseOverContactMe text msg =
    EInput.button
        [ EBorder.width 3
        -- , E.htmlAttribute <| Html.Attributes.style "border-radius" "50%"
        , EBorder.rounded 99999999
        , EBorder.color Palette.color0
        , EBackground.color 
            <| E.fromRgb <| Color.toRgba
                <| Animator.color mouseOverContactMe <| 
                    \btn ->
                        case btn of
                            False ->
                                Color.rgba 0 0 0 0
                            True ->
                                Color.rgb255 26 20 36
                    
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
        , EBackground.color Palette.color0
        ]
        { onPress = Just msg
        , label = E.el 
            [ E.paddingXY 23 13
            , EFont.color Palette.white
            ]
            <| E.text text
        }

footer =
    E.el
        [ E.width E.fill
        , E.height <| E.px 90
        , EBackground.color Palette.color0
        ]
        <| E.el
            -- [ EBackground.color Palette.color2
            -- [ EBorder.rounded 999999
            [ E.centerX
            , E.centerY
            ]
            <| E.paragraph 
                [ E.padding 16 
                , EFont.color Palette.color6
                , EFont.size Palette.fontSize1
                ]
                [ E.text "Made with "
                , E.newTabLink 
                    [ EFont.medium
                    ]
                    { url = "https://elm-lang.org"
                    , label = E.text "elm"
                    }
                , E.text " and "

                , E.newTabLink
                    [ EFont.medium
                    ]
                    { url = "https://github.com/mdgriffith/elm-ui"
                    , label = E.text "elm-ui"
                    }
                ]

wrapColor color content =
    E.el
        [ E.padding 5
        , EBackground.color color
        , EBorder.rounded 4
        ]
        <| content

wrapColorCircle color content =
    E.el
        [ E.padding 5
        , EBackground.color color
        , EBorder.rounded 99999
        ]
        <| content


makeNavbarLink label_ msg_ =
    EInput.button
        [
        ]
        { onPress = Just msg_
        , label = E.el 
            [
            ]
            <| E.text label_
        }


aboutMeText =
    [ E.paragraph
        [
        ]
        [ E.text """Currently my primary interest is to monetize my UI, UX and frontend web development skills."""
        ]
    , E.paragraph
        [
        ]
        [ E.text """I love challenges and getting out of my comfort zone. In the future I would like to work more with backend technologies and eventually I would love to work with machine learning, AI, statistical analysis, data visualization or related fields."""
        ]
    , E.paragraph
        [
        ]
        [ E.text "(In case you're wondering, the name comes from "
        , E.newTabLink
            [ EFont.medium
            ]
            { url = "https://www.imdb.com/title/tt0104652/?ref_=fn_al_tt_1"
            , label = E.text "Porco Rosso"
            }
        , E.text ".)"
        ]
    ]

latestWorkSectionId = "latest-work-section"
aboutMeSectionId = "about-me-section"
contactMeSectionId = "contact-me-section"
