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
                (updateModel model newInput, Cmd.none)

        SetFocalLength value ->
            let
                oldInput = model.input
                newInput = { oldInput | focalLength = value }
            in
                (updateModel model newInput, Cmd.none)

        SetAperture value ->
            let
                oldInput = model.input
                newInput = { oldInput | aperture = value }
            in
                (updateModel model newInput, Cmd.none)


updateModel : Model -> InputParameters -> Model
updateModel model newInput =
    { model | input = newInput
    , dof = calcDOF(newInput)
    }


calcDOF : InputParameters -> DOF
calcDOF input =
    let
        coc = 0.03
        focalLength = Result.withDefault 0 (String.toFloat input.focalLength)
        aperture = Result.withDefault 0 (String.toFloat input.aperture)
        distance = Result.withDefault 0 (String.toFloat input.distance)
        hyperFocal = (focalLength * focalLength) / (aperture * coc)
        nearpoint = (hyperFocal * distance) / (hyperFocal + distance - focalLength)
        farpoint = (hyperFocal * distance) / (hyperFocal - (distance - focalLength))
    in
        -- convert to cm
        { near = nearpoint / 10
        , far = farpoint/ 10
        , diff = (farpoint - nearpoint) / 10
        }
