import Html exposing (Html, button, div, text, a, img)
import Html.Attributes exposing (href, alt)
import Html.Events exposing (onClick)

main =
  Html.beginnerProgram { model = 0, view = view, update = update }

type Msg = Increment | Decrement

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
    , div [] [ a 
                  [ href "https://glitch.com/edit/#!/remix/elm-sample-app"
                  , alt "Remix On Glitch"
                  ] 
                [ img [] ] 
              ]
    ]