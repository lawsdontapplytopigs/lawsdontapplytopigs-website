module Msg exposing (..)

import Browser
import Url
import Time

type Msg 
    = NoOp
    | UrlChanged Url.Url
    | LinkClicked Browser.UrlRequest
    | RuntimeAnimationTick Time.Posix
    | GotViewportGeometry { width : Int, height : Int }
    | JsonParseError String
    | MouseEnteredButton
    | MouseLeftButton
    | SmoothScroll String

type UrlRequest 
    = Internal Url.Url
    | External String
