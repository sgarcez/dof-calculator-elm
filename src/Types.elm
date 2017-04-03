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

type alias InputParameters =
    { distance : String
    , focalLength: String 
    , aperture: String
    }
