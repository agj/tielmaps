module Main exposing (Msg(..), main, update, view)

import Assets.Sprites as Sprites
import Assets.Worlds as Worlds
import Avatar exposing (Avatar)
import Avatar.Padding exposing (zero)
import Bitmap exposing (Bitmap)
import Browser
import Browser.Events
import Collider
import Color exposing (Color)
import Colors exposing (Colors)
import Css exposing (alignItems, backgroundColor, center, display, displayFlex, hsl, justifyContent, margin, padding, pc, pct, property, px, scale, transform)
import Css.Global exposing (global, selector)
import Html
import Html.Attributes
import Html.Styled exposing (Html, canvas, div, text, toUnstyled)
import Html.Styled.Attributes exposing (css, height, id, style, width)
import Html.Styled.Lazy exposing (lazy)
import Json.Decode as D
import Json.Encode
import Keys exposing (Keys)
import Keys.Key as Key exposing (Key)
import Levers
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
    , bitmap : Bitmap
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
      , bitmap = Bitmap.error
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

                ( bitmap, newWorld ) =
                    model.world
                        |> World.render newCharacter
            in
            ( { model
                | character = newCharacter
                , world = newWorld
                , bitmap = bitmap
              }
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
mainView { world, bitmap, character, scale } =
    let
        colors =
            world
                |> World.currentScreen (Avatar.baseX character) (Avatar.baseY character)
                |> Maybe.map Screen.colors
                |> Maybe.withDefault Colors.default
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
        [ customElement
            Levers.screenWidth
            Levers.screenHeight
            [ Html.Attributes.style "transform"
                ("scale({scale})"
                    |> String.replace "{scale}" (String.fromInt scale)
                )
            ]
            colors
            bitmap
            |> Html.Styled.fromUnstyled
        ]


customElement : Int -> Int -> List (Html.Attribute msg) -> Colors -> Bitmap -> Html.Html msg
customElement w h attrs colors bm =
    Html.node "pixel-renderer"
        ([ Html.Attributes.width w
         , Html.Attributes.height h
         , Html.Attributes.property "scene"
            (encodeBitmapAndColors colors.lightColor colors.darkColor bm)
         ]
            ++ attrs
        )
        []


encodeBitmapAndColors : Color -> Color -> Bitmap -> Json.Encode.Value
encodeBitmapAndColors lightColor darkColor bm =
    Json.Encode.object
        [ ( "lightColor", encodeColor lightColor )
        , ( "darkColor", encodeColor darkColor )
        , ( "bitmap"
          , Bitmap.encode bm
          )
        , ( "canvasId", Json.Encode.string Levers.canvasId )
        ]


encodeColor : Color -> Json.Encode.Value
encodeColor color =
    let
        { red, green, blue } =
            Color.toRgba color
    in
    Json.Encode.object
        [ ( "red", encodeColorChannel red )
        , ( "green", encodeColorChannel green )
        , ( "blue", encodeColorChannel blue )
        ]


encodeColorChannel : Float -> Json.Encode.Value
encodeColorChannel channel =
    Json.Encode.float channel



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
