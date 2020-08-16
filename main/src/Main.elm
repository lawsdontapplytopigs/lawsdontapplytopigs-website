port module Main exposing (..)

import Browser
import Msg
import View
import Json.Decode
import Json.Encode

port windowData : (Json.Decode.Value -> msg) -> Sub msg

main = Browser.document
    { init = init
    , view = View.view "lawsdontapplytopigs"
    , update = update
    , subscriptions = subscriptions
    }

type alias Model = 
    { debug : String 
    , viewportGeometry : ViewportGeometry
    }
    
init : ViewportGeometry -> ( Model, Cmd Msg.Msg )
init viewportG =
    let
        model_ = 
            { debug = ""
            , viewportGeometry = { height = viewportG.height, width = viewportG.width }
            }
        cmd_ = Cmd.none
    in
        ( model_ , cmd_ )


update : Msg.Msg -> Model -> ( Model, Cmd Msg.Msg )
update msg model =
    case msg of
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
