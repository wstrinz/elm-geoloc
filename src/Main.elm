module Main exposing (..)

import Browser
import Geolocation exposing (Msg(..), init, update, view)
import Html exposing (Html)
import Ports
import Types exposing (Model)


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> ( init, Ports.requestGeolocation () )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Ports.updateCoordinates UpdateCoordinates

        -- , Ports.sendError UpdateError
        ]
