module Types exposing (..)


type Msg
    = SetDistance String
    | SetFocalLength String
    | SetAperture String
    | UpdateDOF

type alias Model =
    { input: InputParameters
    , dof: DOF
    }

type alias DOF =
    { near: Maybe Float
    , far: Maybe Float
    , diff: Maybe Float
    }

type alias InputParameter =
    { input: String
    , parsed: Float
    , valid: Bool
    }

type alias InputParameters =
    { distance : InputParameter
    , focalLength: InputParameter
    , aperture: InputParameter
    }
