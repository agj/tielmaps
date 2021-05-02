port module Main exposing (Msg(..), main, update, view)

import Browser
import Browser.Events
import Canvas
import Html.Styled exposing (Html, canvas, div, text, toUnstyled)
import Html.Styled.Attributes exposing (height, id, width)
import Json.Encode as E
import Levers
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
    { ready : Bool
    }



-- INIT


type alias Flags =
    { viewport : Viewport
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { ready = True
      }
    , paintCanvas
        (Canvas.encode
            (Canvas.create 32 32
                |> Canvas.paintPixel 0 0 True
                |> Canvas.paintPixel 1 1 True
                |> Canvas.paintPixel 2 2 True
            )
        )
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
            ignore

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
            , width 32
            , height 32
            ]
            []
        , text "bla"
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Browser.Events.onResize (\w h -> Resized (Viewport w h))
        , Time.every (toFloat Levers.framesPerSecond) Ticked
        ]



-- PORTS


port paintCanvas : E.Value -> Cmd msg
