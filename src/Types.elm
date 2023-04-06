module Types exposing (..)

type alias Coordinates =
    { latitude : Float
    , longitude : Float
    }

type alias Model =
    { coordinates : Maybe Coordinates
    , error : Maybe String
    }
