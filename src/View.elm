module View exposing (root)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Types exposing (..)


root : Model -> Html Msg
root model =
    div []
        [ input [ type_ "text"
                , value model.input.distance
                , onInput SetDistance
                ] []
        , input [ type_ "text"
                , value model.input.focalLength
                , onInput SetFocalLength
                ] []
        , input [ type_ "text"
                , value model.input.aperture
                , onInput SetAperture
                ] []
        , p [] [text (toString model.dof.near)]
        , p [] [text (toString model.dof.far)]
        , p [] [text (toString model.dof.diff)]
        ]
