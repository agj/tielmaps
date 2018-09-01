module Main exposing (Msg(..), main, update, view)

import Html exposing (Html, a, button, div, img, text)
import Html.Attributes exposing (alt, href, src)
import Html.Events exposing (onClick)


main =
    Html.beginnerProgram { model = 0, view = view, update = update }


type Msg
    = Increment
    | Decrement


update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1


view model =
    div []
        [ div [] [ text "Counter" ]
        , button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (toString model) ]
        , button [ onClick Increment ] [ text "+" ]
        , div []
            [ a
                [ href "https://glitch.com/edit/#!/remix/elm-sample-app"
                , alt "Remix On Glitch"
                ]
                [ img [ src "https://cdn.glitch.com/2703baf2-b643-4da7-ab91-7ee2a2d00b5b%2Fremix-button.svg" ] [] ]
            ]
        ]
