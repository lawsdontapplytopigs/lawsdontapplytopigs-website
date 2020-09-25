port module Main exposing (..)

import Animator
import Browser
import Browser.Navigation as Nav
import Ease
-- import Home
import Json.Decode
import Json.Encode
import Msg
import SmoothScroll
import Url
import Url.Parser

import View.Lib
import View.Home
import View.Tablet
import View.SmallPhone
import View.Phone
import Task


port windowData : (Json.Decode.Value -> msg) -> Sub msg

main = Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlRequest = Msg.LinkClicked
    , onUrlChange = Msg.UrlChanged
    }

type alias Model =
    { debug : String 
    , viewportGeometry : ViewportGeometry
    -- , homePage : HomeModel
    , mouseOverContactMe : Animator.Timeline Bool
    , candyBarPercentOffset : Animator.Timeline Float
    , key : Nav.Key
    , url : Url.Url
    }
    
init : ViewportGeometry -> Url.Url -> Nav.Key -> ( Model, Cmd Msg.Msg )
init viewportG url key =
    let
        model_ =
            { debug = ""
            , viewportGeometry = { height = viewportG.height, width = viewportG.width }
            -- , homePage = initHome
            , mouseOverContactMe = Animator.init False
            , candyBarPercentOffset = Animator.init 0.0
            , url = url
            , key = key
            }
        cmd_ = Cmd.none
    in
        ( model_ , cmd_ )

update : Msg.Msg -> Model -> ( Model, Cmd Msg.Msg )
update msg model =
    case msg of
        Msg.LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( { model | url = url }
                    -- , (Nav.pushUrl model.key (Url.toString url) )
                    , Cmd.none
                    )
                Browser.External href ->
                    ( model, Nav.load href )
        Msg.UrlChanged url ->
            ( { model | url = url }
            -- , Nav.load <| Url.toString url
            -- , (Nav.pushUrl model.key (Url.toString url))
            , Cmd.none
            )
        Msg.NoOp ->
            (model, Cmd.none)
        Msg.GotViewportGeometry data ->
            let
                newM = 
                    { model
                        | viewportGeometry = { width = data.width, height = data.height }
                    }
            in
            (newM, Cmd.none)
        Msg.JsonParseError str ->
            let
                newM = 
                    { model
                        | debug = str
                    }
            in
            (newM, Cmd.none)
        Msg.RuntimeAnimationTick time ->
            ( Animator.update time animator model, Cmd.none )
        Msg.MouseEnteredButton ->
            let
                model_ =
                    { model
                        | mouseOverContactMe = Animator.go (Animator.millis 40) True model.mouseOverContactMe
                    }
                cmd_ = Cmd.none
            in
                ( model_, cmd_ )
        Msg.MouseLeftButton ->
            let
                model_ =
                    { model
                        | mouseOverContactMe = Animator.go (Animator.millis 40) False model.mouseOverContactMe
                    }
                cmd_ = Cmd.none
            in
                ( model_, cmd_ )
        Msg.SmoothScroll id ->
            let
                scrollConfig =
                    { offset = 12
                    , speed = 65
                    , easing = Ease.inOutCubic
                    }
                model_ = model
                cmd_ = Task.attempt 
                    (always Msg.NoOp) 
                    (SmoothScroll.scrollToWithOptions scrollConfig id)
            in
                ( model_, cmd_ )


animator =
    Animator.animator
        |> Animator.watching
            getCandyBarPercentOffset
            (\newAnimationState model -> 
                { model
                    | candyBarPercentOffset = newAnimationState
                }
            )
        |> Animator.watching
            getMouseOverContactMe
            (\newButtonState model ->
                { model
                    | mouseOverContactMe = newButtonState
                }
            )
            
subscriptions : Model -> Sub Msg.Msg
subscriptions model =
    Sub.batch
        [ windowData decodeViewportGeometry
        , Animator.toSubscription Msg.RuntimeAnimationTick model animator
        ]

type alias ViewportGeometry =
    { width : Int
    , height : Int
    }

type Route 
    = Home
    | About
    | Contact
    | AwesomeWMProjectPage
    | WaneellaProjectPage
    | SewerslvtProjectPage

routeParser : Url.Parser.Parser (Route -> a) a
routeParser = 
    Url.Parser.oneOf
        [ Url.Parser.map Home (Url.Parser.s "home")
        , Url.Parser.map About (Url.Parser.s "about")
        , Url.Parser.map Contact (Url.Parser.s "contact")
        , Url.Parser.map AwesomeWMProjectPage (Url.Parser.s "awesomewm")
        , Url.Parser.map WaneellaProjectPage (Url.Parser.s "waneella")
        , Url.Parser.map SewerslvtProjectPage (Url.Parser.s "sewerslvt")
        ]

view model =
    let
        device = View.Lib.classifyDevice model.viewportGeometry
    in
    case toRoute model.url of
        Home ->
            case device.class of 
                View.Lib.SmallPhone ->
                    case device.orientation of
                        View.Lib.Portrait ->
                            View.SmallPhone.view "lawsdontapplytopigs" model -- TODO
                        View.Lib.Landscape ->
                            View.Tablet.view "lawsdontapplytopigs" model -- TODO
                View.Lib.Phone ->
                    case device.orientation of
                        View.Lib.Portrait ->
                            View.Phone.view "lawsdontapplytopigs" model -- TODO
                        View.Lib.Landscape ->
                            View.Tablet.view "lawsdontapplytopigs" model -- TODO
                View.Lib.Tablet ->
                    case device.orientation of
                        View.Lib.Portrait ->
                            View.Phone.view "lawsdontapplytopigs" model -- TODO
                        View.Lib.Landscape ->
                            View.Tablet.view "lawsdontapplytopigs" model -- TODO
                View.Lib.Desktop ->
                    case device.orientation of
                        View.Lib.Portrait ->
                            View.Phone.view "lawsdontapplytopigs" model -- TODO
                        View.Lib.Landscape ->
                            View.Home.view "lawsdontapplytopigs" model
                View.Lib.BigDesktop ->
                    View.Home.view "lawsdontapplytopigs" model
        About ->
            View.Home.view "lawsdontapplytopigs" model
        Contact ->
            View.Home.view "lawsdontapplytopigs" model
        AwesomeWMProjectPage ->
            View.Home.view "lawsdontapplytopigs" model
        WaneellaProjectPage ->
            View.Home.view "lawsdontapplytopigs" model
        SewerslvtProjectPage ->
            View.Home.view "lawsdontapplytopigs" model

toRoute url =
    Maybe.withDefault Home (Url.Parser.parse routeParser url)

decodeViewportGeometry json =
    case Json.Decode.decodeValue viewportGeometryDecoder json of
        Ok val ->
            Msg.GotViewportGeometry val
        Err er ->
            Msg.JsonParseError (Json.Decode.errorToString er)

viewportGeometryDecoder : Json.Decode.Decoder ViewportGeometry
viewportGeometryDecoder =
    Json.Decode.map2 ViewportGeometry
        (Json.Decode.field "width" Json.Decode.int)
        (Json.Decode.field "height" Json.Decode.int)



-- type alias HomeModel =
--     { candyBarPercentOffset : Animator.Timeline Float
--     , mouseOverContactMe : Animator.Timeline Bool
--     }

-- initHome =
--     { candyBarPercentOffset = Animator.init 0.0
--     , mouseOverContactMe = Animator.init False
--     }



getCandyBarPercentOffset model =
    model.candyBarPercentOffset

getMouseOverContactMe model =
    model.mouseOverContactMe



updateCandyBarPercentOffset val model =
    let
        -- current = Animator.current model.candyBarPercentOffset
        goSlow = Animator.go Animator.slowly True model.mouseOverContactMe
                -- model_ =
                --     Animator.go Animator.slowly (updateMouseOverContactMe True model.homePage) model.homePage
        -- mdl = model.homePage
    in
        { model
            | candyBarPercentOffset = goSlow
        }

updateMouseOverContactMe value model =
    { model
        | mouseOverContactMe = value
    }
