module Msg exposing (..)

import Browser
import Url
import Time

type Msg 
    = UrlChanged Url.Url
    | LinkClicked Browser.UrlRequest
    | RuntimeAnimationTick Time.Posix
    | GotViewportGeometry { width : Int, height : Int }
    | JsonParseError String
    | NoOp

type UrlRequest 
    = Internal Url.Url
    | External String
