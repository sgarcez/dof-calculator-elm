module State exposing (..)

import Types exposing (..)


defaultInput : InputParameters
defaultInput =
    { distance = "10000"
    , aperture = "1.4"
    , focalLength = "50"
    }


init : (Model, Cmd Msg)
init =
    (
        { input = defaultInput
        , dof = calcDOF defaultInput
        }
        , Cmd.none
    )


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SetDistance value ->
            let
                oldInput = model.input
                newInput = { oldInput | distance = value }
            in
                update UpdateDOF {model | input = newInput}

        SetFocalLength value ->
            let
                oldInput = model.input
                newInput = { oldInput | focalLength = value }
            in
                update UpdateDOF {model | input = newInput}

        SetAperture value ->
            let
                oldInput = model.input
                newInput = { oldInput | aperture = value }
            in
                update UpdateDOF { model | input = newInput }

        UpdateDOF ->
            ({ model | dof = calcDOF model.input }, Cmd.none)


calcDOF : InputParameters -> DOF
calcDOF input =
    case
        ( String.toFloat input.focalLength
        , String.toFloat input.aperture
        , String.toFloat input.distance
        ) of
        (Ok focalLength, Ok aperture, Ok distance) ->
            let
                coc = 0.03
                hyperfocal = (focalLength * focalLength) / (aperture * coc)
                nearpoint =
                    (
                        (hyperfocal * distance) /
                        (hyperfocal + distance - focalLength)
                    )
                farpoint =
                    (
                        (hyperfocal * distance) /
                        (hyperfocal - (distance - focalLength))
                    )
            in
                -- convert to cm
                { near = Just (nearpoint / 10)
                , far = Just (farpoint/ 10)
                , diff = Just ((farpoint - nearpoint) / 10)
                }
        _ ->
            { near = Nothing
            , far = Nothing
            , diff = Nothing
            }
