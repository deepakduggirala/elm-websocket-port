port module Main exposing (main)

import Browser
import Html exposing (button, div, h2, text)
import Html.Events exposing (onClick)
import Json.Encode as E


type alias Model =
    String


type Msg
    = Send
    | Receive String


subscriptions : Model -> Sub Msg
subscriptions model =
    pull Receive


view : Model -> Html.Html Msg
view model =
    div []
        [ h2 [] [ text model ]
        , button [ onClick Send ] [ text "Send" ]
        ]


init : () -> ( Model, Cmd Msg )
init _ =
    ( "hello", Cmd.none )


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Send ->
            ( model ++ " sent", push <| E.string model )

        Receive m ->
            ( model ++ m, push <| E.string model )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


port push : E.Value -> Cmd msg


port pull : (String -> msg) -> Sub msg
