module Main exposing (Msg(..), main, update, view)

import Bitmap exposing (Bitmap)
import Browser
import Browser.Events
import Html.Styled exposing (Html, canvas, div, text, toUnstyled)
import Html.Styled.Attributes exposing (height, id, width)
import Js
import Levers
import Map exposing (Map)
import Maps
import Size exposing (Size8x8)
import Sprite exposing (Sprite)
import Sprites
import Time
import Viewport exposing (Viewport)



-- MAIN


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { map : Map Size8x8
    , character : Sprite Size8x8
    }



-- INIT


type alias Flags =
    { viewport : Viewport
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { map = Maps.testMap
      , character = Sprites.runningCharacter
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Ticked Time.Posix
    | Resized Viewport
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        ignore =
            ( model, Cmd.none )
    in
    case msg of
        Ticked _ ->
            ( { model | character = Sprite.tick model.character }
            , Js.paintCanvas
                (Map.toBitmap model.map
                    |> Bitmap.paintBitmap 0 0 (Sprite.bitmap model.character)
                )
            )

        Resized { width, height } ->
            ignore

        NoOp ->
            ignore



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "Elm platformer"
    , body =
        [ mainView model |> toUnstyled
        ]
    }


mainView : Model -> Html Msg
mainView model =
    div []
        [ canvas
            [ id "canvas"
            , width 500
            , height 500
            ]
            []
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Browser.Events.onResize (\w h -> Resized (Viewport w h))
        , Time.every (toFloat Levers.framesPerSecond) Ticked
        ]
