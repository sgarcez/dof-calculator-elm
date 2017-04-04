module State exposing (..)

import Types exposing (..)


defaultInput : InputParameters
defaultInput =
    { distance = { input = "1000"
                 , parsed = 1000.0
                 , valid = True
                 }
    , aperture = { input = "1.4"
                 , parsed = 1.4
                 , valid = True
                 }
    , focalLength = { input = "50"
                    , parsed = 50.0
                    , valid = True
                    }
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
                oldInput  = model.input
            in
                update UpdateDOF {
                    model | input = { oldInput | distance = parseInput value }
                }

        SetFocalLength value ->
            let
                oldInput = model.input
            in
                update UpdateDOF {
                    model | input = { oldInput | focalLength = parseInput value }
                }

        SetAperture value ->
            let
                oldInput = model.input
            in
                update UpdateDOF {
                    model | input = { oldInput | aperture = parseInput value }
                }

        UpdateDOF ->
            ({ model | dof = calcDOF model.input }, Cmd.none)


parseInput : String -> InputParameter
parseInput val =
    case String.toFloat val of
        Ok v ->
            case v > 0 of
                True ->
                    { input = val, parsed = v, valid = True }
                False ->
                    { input = val, parsed = v, valid = False }
        Err _ ->
            { input = val, parsed = -1, valid = False }


calcDOF : InputParameters -> DOF
calcDOF input =
    case
        ( input.focalLength.valid
        , input.aperture.valid
        , input.distance.valid
        ) of
        (True, True, True) ->
            let
                focalLength = input.focalLength.parsed
                aperture = input.aperture.parsed
                distance = input.distance.parsed
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
