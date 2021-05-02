port module Main exposing (Msg(..), main, update, view)

import Bitmap exposing (Bitmap)
import Browser
import Browser.Events
import Dict
import Html.Styled exposing (Html, canvas, div, text, toUnstyled)
import Html.Styled.Attributes exposing (height, id, width)
import Json.Encode as E
import Levers
import Map exposing (Map)
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
        (Bitmap.encode
            -- (testBitmap
            --     |> Bitmap.paintBitmap 8 8 testBitmap
            --     |> Bitmap.paintBitmap -8 -8 testBitmap
            -- )
            -- (Map.empty 4 4 8 8
            --     |> Map.setTile 0 0 testTile
            --     |> Map.setTile 1 1 testTile
            --     |> Map.setTile 1 0 testTile
            --     |> Map.setTile 2 2 testTile
            --     |> Map.setTile 3 0 testTile
            --     |> Map.setTile 1 3 testTile
            --     |> Map.toBitmap
            -- )
            (testMap |> Map.toBitmap)
        )
    )


testMap : Map
testMap =
    """
? . . .
. ? . .
. . ? .
? . . ?
"""
        |> Map.fromString
            (Dict.fromList
                [ ( '.', emptyTile )
                , ( '?', testTile )
                ]
            )
        |> Maybe.withDefault (Map.empty 0 0 0 0)


testBitmap : Bitmap
testBitmap =
    """
. . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . .
. . . . # . . . . . # . . . . .
. . . . . # . . . # . . . . . .
. . . . # # # # # # # . . . . .
. . . # # . # # # . # # . . . .
. . # # # # # # # # # # # . . .
. . # . # # # # # # # . # . . .
. . # . # . . . . . # . # . . .
. . . . . # # . # # . . . . . .
. . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . .
"""
        |> Bitmap.fromString


testTile : Bitmap
testTile =
    """
# . . . . . . .
# # . . . . . .
# # # . . . . .
# # # # . . . .
# # # # # . . .
# # # # # # . .
# # # # # # # .
# # # # # # # #
"""
        |> Bitmap.fromString


emptyTile : Bitmap
emptyTile =
    """
. . . . . . . .
. . . . . . . .
. . . . . . . .
. . . . . . . .
. . . . . . . .
. . . . . . . .
. . . . . . . .
. . . . . . . .
"""
        |> Bitmap.fromString



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
