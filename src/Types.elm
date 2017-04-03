module Types exposing (..)


type Msg
    = SetDistance String
    | SetFocalLength String
    | SetAperture String

type alias Model =
    { input: InputParameters
    , dof: DOF
    }

type alias DOF = 
    { near: Float
    , far: Float
    , diff: Float
    }

type alias InputParameters =
    { distance : String
    , focalLength: String 
    , aperture: String
    }
