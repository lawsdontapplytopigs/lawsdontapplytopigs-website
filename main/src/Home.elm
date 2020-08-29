module Home exposing (..)

import Animator

type alias Model =
    { candyBarPercentOffset : Animator.Timeline Float
    , mouseOverContactMe : Bool
    }

init =
    { candyBarPercentOffset = Animator.init 0.0
    , mouseOverContactMe = False
    }

updateCandyBarPercentOffset val model =
    { model
        | candyBarPercentOffset = val
    }

getCandyBarPercentOffset model =
    model.candyBarPercentOffset

getMouseOverContactMe model =
    model.mouseOverContactMe

updateCandyBarPercentOffset value model =
    { model
        | value




