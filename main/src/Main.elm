module Main exposing (main)

import Browser
import Msg
import View

main = Browser.document
    { init = init
    , view = View.view "lawsdontapplytopigs"
    , update = update
    , subscriptions = \_ -> Sub.none
    }


type alias Model = 
    { dope : String }
    
init : () -> ( Model, Cmd Msg.Msg )
init _ =
    let
        model_ = { dope = "Sup" }
        cmd_ = Cmd.none
    in
        ( model_ , cmd_ )


update : Msg.Msg -> Model -> ( Model, Cmd Msg.Msg )
update msg model =
    case msg of
        Msg.NoOp ->
            (model, Cmd.none)


