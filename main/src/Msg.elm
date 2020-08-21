module Msg exposing (..)

import Browser
import Url

type Msg 
    = UrlChanged Url.Url
    | LinkClicked Browser.UrlRequest
    | GotViewportGeometry { width : Int, height : Int }
    | JsonParseError String
    | NoOp

type UrlRequest 
    = Internal Url.Url
    | External String
