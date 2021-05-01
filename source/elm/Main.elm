module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Html, a, button, div, img, text)
import Html.Attributes exposing (alt, href, src)
import Html.Events exposing (onClick)

type alias Model = Int

init : Model
init =
  0

main =
    Browser.sandbox { init = init, view = view, update = update }


type Msg
    = Increment
    | Decrement

update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1

view : Model -> Html Msg
view model =
    div []
        [ div [] [ text "Test! :/" ]
        , button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (String.fromInt model) ]
        , button [ onClick Increment ] [ text "+" ]
        ]
