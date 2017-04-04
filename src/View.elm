module View exposing (root)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Types exposing (..)


root : Model -> Html Msg
root model =
    div []
        [ textInput model.input.distance SetDistance
        , textInput model.input.focalLength SetFocalLength
        , textInput model.input.aperture SetAperture
        , p [] [text (toString model.dof.near)]
        , p [] [text (toString model.dof.far)]
        , p [] [text (toString model.dof.diff)]
        ]

textInput : InputParameter -> (String -> Msg) -> Html Msg
textInput param msg =
    let
        class_name = if param.valid then  "valid" else "invalid"
    in
        input [ type_ "text"
                , value param.input
                , onInput msg
                , class class_name
                ] []
