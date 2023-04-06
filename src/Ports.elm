port module Ports exposing (..)

import Types exposing (Coordinates)


port updateCoordinates : (Coordinates -> msg) -> Sub msg


port sendError : String -> Cmd msg


port requestGeolocation : () -> Cmd msg
