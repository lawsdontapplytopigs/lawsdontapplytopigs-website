port module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Json.Decode
import Json.Encode
import Msg
import Url
import Url.Parser
import View.Home

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
    , key : Nav.Key
    , url : Url.Url
    }
    
init : ViewportGeometry -> Url.Url -> Nav.Key -> ( Model, Cmd Msg.Msg )
init viewportG url key =
    let
        model_ = 
            { debug = ""
            , viewportGeometry = { height = viewportG.height, width = viewportG.width }
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
                        | debug = Debug.log "" str
                    }
            in
            (newM, Cmd.none)

subscriptions : Model -> Sub Msg.Msg
subscriptions model =
    Sub.batch
        [ windowData decodeViewportGeometry
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
    case toRoute model.url of
        Home ->
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


