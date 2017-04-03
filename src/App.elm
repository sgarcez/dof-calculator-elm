module App exposing (main)


{-|Entry point

@docs main
-}


import Html
import State
import Types exposing (..)
import View


{-| Run the application.
-}
main : Program Never Model Msg
main =
    Html.program
        { init = State.init
        , update = State.update
        , subscriptions = (always Sub.none)
        , view = View.root
        }
