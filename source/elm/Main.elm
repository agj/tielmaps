module Main exposing (Msg(..), main, update, view)

import Assets.Screens as Screens
import Assets.Sprites as Sprites
import Avatar exposing (Avatar)
import Bitmap exposing (Bitmap)
import Browser
import Browser.Events
import Collider
import Css exposing (alignItems, backgroundColor, center, display, displayFlex, hsl, justifyContent, margin, padding, pc, pct, property, px, scale, transform)
import Css.Global exposing (global, selector)
import Html.Styled exposing (Html, canvas, div, text, toUnstyled)
import Html.Styled.Attributes exposing (css, height, id, style, width)
import Js
import Json.Decode as D
import Key exposing (Key)
import Keys exposing (Keys)
import Levers
import Screen exposing (Screen)
import Size exposing (Size22x22, Size8x8)
import Sprite exposing (Sprite)
import Tilemap exposing (Tilemap)
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
    { screen : Screen Size22x22 Size8x8
    , character : Avatar Size8x8
    , keys : Keys
    , scale : Int
    }



-- INIT


type alias Flags =
    { viewport : Viewport
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { screen = Screens.testScreen
      , character =
            Avatar.make Sprites.runningCharacter
                |> Avatar.reposition (1 * Levers.tileWidth) (1 * Levers.tileHeight)
      , keys = Keys.empty
      , scale = getScale flags.viewport
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Ticked Time.Posix
    | Resized Viewport
    | PressedKey Key
    | ReleasedKey Key
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        ignore =
            ( model, Cmd.none )
    in
    case msg of
        Ticked _ ->
            let
                newCharacter =
                    model.character
                        |> Avatar.tick model.keys
                        |> Collider.collideAvatar model.screen
            in
            ( { model | character = newCharacter }
            , Js.paintCanvas
                (Tilemap.toBitmap (Screen.tilemap model.screen)
                    |> Bitmap.paintBitmap
                        (Avatar.x newCharacter)
                        (Avatar.y newCharacter)
                        (Avatar.bitmap newCharacter)
                )
            )

        PressedKey key ->
            ( { model | keys = Keys.press key model.keys }
            , Cmd.none
            )

        ReleasedKey key ->
            ( { model | keys = Keys.release key model.keys }
            , Cmd.none
            )

        Resized viewport ->
            ( { model | scale = getScale viewport }
            , Cmd.none
            )

        NoOp ->
            ignore



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "Elm platformer"
    , body =
        List.map toUnstyled <|
            [ global
                [ selector "body, html"
                    [ margin (px 0)
                    , padding (px 0)
                    , Css.height (pct 100)
                    ]
                , selector "canvas"
                    [ property "image-rendering" "crisp-edges"
                    , property "image-rendering" "pixelated"
                    ]
                ]
            , mainView model
            ]
    }


mainView : Model -> Html Msg
mainView model =
    div
        [ css
            [ displayFlex
            , justifyContent center
            , alignItems center
            , Css.height (pct 100)
            , Css.width (pct 100)
            , margin (px 0)
            , padding (px 0)
            , backgroundColor (hsl 0 0 0.97)
            ]
        ]
        [ canvas
            [ id "canvas"
            , width Levers.screenWidth
            , height Levers.screenHeight
            , css
                [ transform (scale (toFloat model.scale))
                ]
            ]
            []
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Browser.Events.onResize (\w h -> Resized (Viewport w h))
        , Time.every (toFloat Levers.framesPerSecond) Ticked
        , Browser.Events.onKeyDown (decodeKeyWith PressedKey)
        , Browser.Events.onKeyUp (decodeKeyWith ReleasedKey)
        ]


decodeKeyWith : (Key -> Msg) -> D.Decoder Msg
decodeKeyWith msg =
    Key.decodeEvent
        |> D.map
            (\maybeKey ->
                case maybeKey of
                    Just key ->
                        msg key

                    Nothing ->
                        NoOp
            )



-- UTILITIES


getScale : Viewport -> Int
getScale { width, height } =
    let
        scaleX =
            width // Levers.screenWidth

        scaleY =
            height // Levers.screenHeight
    in
    min scaleX scaleY
