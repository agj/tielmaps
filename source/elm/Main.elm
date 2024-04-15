module Main exposing (Msg(..), main, update, view)

import Assets.Sprites as Sprites
import Assets.Worlds as Worlds
import Avatar exposing (Avatar)
import Avatar.Padding exposing (zero)
import Bitmap exposing (Bitmap)
import Browser
import Browser.Events
import Collider
import Colors exposing (Colors)
import Css exposing (alignItems, backgroundColor, center, displayFlex, hsl, justifyContent, margin, padding, pct, px, scale)
import Css.Global exposing (global, selector)
import Html exposing (Attribute)
import Html.Attributes
import Html.Styled exposing (Html, div, toUnstyled)
import Html.Styled.Attributes exposing (css, height, width)
import Json.Decode as D
import Keys exposing (Keys)
import Keys.Key as Key exposing (Key)
import Levers
import PixelRenderer
import Screen exposing (Screen)
import Size exposing (Size22x22, Size8x8)
import Sprite exposing (Sprite)
import Tilemap exposing (Tilemap)
import Time
import Viewport exposing (Viewport)
import World exposing (World)



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
    { world : World Size22x22 Size8x8
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
    ( { world = Worlds.testWorld
      , character =
            Avatar.fromSprites
                { zero
                    | left = 1
                    , right = 1
                    , top = 2
                }
                Sprites.avatarSprites
                |> Avatar.repositionTopLeft
                    (2 * Levers.tileWidth)
                    (17 * Levers.tileHeight + ((World.heightInScreens Worlds.testWorld - 1) * Levers.screenHeightInTiles * Levers.tileHeight))
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
                        |> Collider.collideAvatar model.world
            in
            ( { model | character = newCharacter }
            , Cmd.none
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
    { title = "Tielmaps"
    , body =
        List.map toUnstyled <|
            [ globalStyles
            , mainView model
            ]
    }


globalStyles : Html Msg
globalStyles =
    global
        [ selector "body, html"
            [ margin (px 0)
            , padding (px 0)
            , Css.height (pct 100)
            ]
        ]


mainView : Model -> Html Msg
mainView { world, character, scale } =
    let
        colors =
            world
                |> World.currentScreen (Avatar.baseX character) (Avatar.baseY character)
                |> Maybe.map Screen.colors
                |> Maybe.withDefault Colors.default

        currentScreenTilemap =
            world
                |> World.render character
                |> Maybe.map Screen.tilemap
                |> Maybe.withDefault (Tilemap.empty8x8Tile Levers.screenWidthInTiles Levers.screenHeightInTiles)

        pixelRendererAttributes : List (Attribute msg)
        pixelRendererAttributes =
            [ Html.Attributes.style "transform"
                ("scale({scale})"
                    |> String.replace "{scale}" (String.fromInt scale)
                )
            ]
    in
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
        [ PixelRenderer.element
            Levers.screenWidth
            Levers.screenHeight
            pixelRendererAttributes
            colors
            currentScreenTilemap
            |> Html.Styled.fromUnstyled
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
