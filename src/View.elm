module View exposing (root)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Types exposing (..)


root : Model -> Html Msg
root model =
    div [ class "container" ]
        [ div [ class "form-wrap" ]
            [ textInput "Distance" model.input.distance SetDistance
            , textInput "Focal Length" model.input.focalLength SetFocalLength
            , textInput "Aperture" model.input.aperture SetAperture
            , output model.dof
            ]
        ]

textInput : String -> InputParameter -> (String -> Msg) -> Html Msg
textInput title param msg =
    let
        class_name = "form-control " ++ if param.valid then "valid" else "invalid"
    in
        div [ class "form-group" ]
            [ label [] [ text title ] 
            , input [ type_ "text"
                    , value param.input
                    , onInput msg
                    , class class_name
                    ] []
            ]

output : DOF -> Html Msg
output dof =
    div []
        [ p [] [ text ("Near Point: " ++ (outputLine dof.near)) ]
        , p [] [ text ("Far Point: " ++ (outputLine dof.far)) ]
        , p [] [ text ("Difference: " ++ (outputLine dof.diff)) ]
        ]

outputLine : Maybe Float -> String
outputLine value =
    case value of
        Just num -> toString num ++ " cm"
        Nothing -> "" 

