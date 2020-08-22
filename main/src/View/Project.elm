module View.Project exposing (..)




view title model =
    let
        body =
            E.layout
                [ E.width E.fill
                , E.height E.fill
                ]
                <| mainCol model
    in
        { title = title
        , body = [ body ]
        }

type alias Tech =
    { icon : Maybe String
    , name : String
    }

type alias Project =
    { title : String
    , livePreviewLink : String
    , codeLink : String
    , images : List String
    , technologiesUsed : List Tech
    , paragraphs : List String
    }

viewProject : Project -> Element Msg.Msg
viewProject project =
    E.none

