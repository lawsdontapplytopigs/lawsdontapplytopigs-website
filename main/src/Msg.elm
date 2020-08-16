module Msg exposing (..)

type Msg 
    = NoOp
    | GotViewportGeometry { width : Int, height : Int }
    | JsonParseError String
