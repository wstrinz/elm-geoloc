module Geolocation exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Json.Decode as Decode exposing (Decoder)
import Ports exposing (..)


type alias Coordinates =
    { latitude : Float
    , longitude : Float
    }


type alias Model =
    { coordinates : Maybe Coordinates
    , error : Maybe String
    }


init : Model
init =
    { coordinates = Nothing
    , error = Nothing
    }


type Msg
    = UpdateCoordinates Coordinates
    | UpdateError String
    | GetGeolocation


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateCoordinates coords ->
            ( { model | coordinates = Just coords, error = Nothing }
            , Cmd.none
            )

        UpdateError err ->
            ( { model | error = Just err, coordinates = Nothing }
            , Cmd.none
            )

        GetGeolocation ->
            ( model, Ports.requestGeolocation () )


view : Model -> Html Msg
view model =
    div []
        [ case model.coordinates of
            Just coords ->
                div []
                    [ text ("Latitude: " ++ String.fromFloat coords.latitude)
                    , text ", "
                    , text ("Longitude: " ++ String.fromFloat coords.longitude)
                    ]

            Nothing ->
                text "Waiting for coordinates..."
        , case model.error of
            Just err ->
                div [ style "color" "red" ] [ text err ]

            Nothing ->
                text ""
        , div [ onClick GetGeolocation ]
            [ text "Get Geolocation" ]
        ]
