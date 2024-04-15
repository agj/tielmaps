module PixelRenderer exposing (element)

import Array exposing (Array)
import Array2d exposing (Array2d)
import Avatar exposing (Avatar)
import Bitmap exposing (Bitmap)
import Bitmap.Color
import Color exposing (Color)
import Colors exposing (Colors)
import Html exposing (Html)
import Html.Attributes
import Json.Encode
import Levers
import Screen
import Size exposing (Size22x22, Size8x8)
import Tile exposing (Tile)
import Tilemap exposing (Tilemap)
import World exposing (World)


element : Int -> Int -> List (Html.Attribute msg) -> World Size22x22 Size8x8 -> Avatar x -> Html msg
element width height attrs world avatar =
    let
        colors =
            world
                |> World.screenAt (Avatar.baseX avatar) (Avatar.baseY avatar)
                |> Maybe.map Screen.colors
                |> Maybe.withDefault Colors.default

        tilemap =
            world
                |> World.currentScreen avatar
                |> Maybe.map Screen.tilemap
                |> Maybe.withDefault (Tilemap.empty8x8Tile Levers.screenWidthInTiles Levers.screenHeightInTiles)

        tilemapBitmaps =
            Tilemap.tiles tilemap
                |> Array.toList
                |> List.map Tile.bitmap

        avatarBitmaps =
            Avatar.bitmaps avatar

        tilemapBitmapStamps =
            encodeTilemapAsBitmapStamps tilemap

        ( avatarX, avatarY ) =
            World.avatarPositionOnScreen avatar world

        avatarBitmapStamp =
            encodeBitmapStamp
                avatarX
                avatarY
                (Avatar.bitmapIndex avatar + List.length tilemapBitmaps)
    in
    Html.node "pixel-renderer"
        ([ Html.Attributes.width width
         , Html.Attributes.height height
         , Html.Attributes.property "colors"
            (encodeColors [ colors.darkColor, colors.lightColor ])
         , Html.Attributes.property "bitmaps"
            (encodeBitmaps (tilemapBitmaps ++ avatarBitmaps))
         , Html.Attributes.property "bitmapStamps"
            ((tilemapBitmapStamps ++ [ avatarBitmapStamp ])
                |> Json.Encode.list identity
            )
         ]
            ++ attrs
        )
        []



-- ENCODERS


encodeTilemapAsBitmapStamps : Tilemap a -> List Json.Encode.Value
encodeTilemapAsBitmapStamps tilemap =
    let
        tileWidth =
            Tilemap.tileWidth tilemap

        tileHeight =
            Tilemap.tileHeight tilemap

        tileToBitmapStampValue : Int -> Int -> Int -> List Json.Encode.Value -> List Json.Encode.Value
        tileToBitmapStampValue tileX tileY tileIndex acc =
            encodeBitmapStamp (tileX * tileWidth) (tileY * tileHeight) tileIndex
                :: acc
    in
    Tilemap.map tilemap
        |> Array2d.indexedFoldl tileToBitmapStampValue []
        |> List.reverse


encodeBitmapStamp : Int -> Int -> Int -> Json.Encode.Value
encodeBitmapStamp x y bitmapIndex =
    Json.Encode.object
        [ ( "x", Json.Encode.int x )
        , ( "y", Json.Encode.int y )
        , ( "bitmapIndex", Json.Encode.int bitmapIndex )
        ]


encodeBitmaps : List Bitmap -> Json.Encode.Value
encodeBitmaps bitmaps =
    Json.Encode.list encodeBitmap bitmaps


encodeBitmap : Bitmap -> Json.Encode.Value
encodeBitmap bitmap =
    Json.Encode.object
        [ ( "width", Json.Encode.int (Bitmap.width bitmap) )
        , ( "pixels", encodePixels (Bitmap.pixels bitmap) )
        ]


encodePixels : Array2d Bitmap.Color.Color -> Json.Encode.Value
encodePixels bitmap =
    bitmap
        |> Array2d.toUnidimensional
        |> Array.map
            (\color ->
                case color of
                    Bitmap.Color.Dark ->
                        0

                    Bitmap.Color.Light ->
                        1

                    Bitmap.Color.Transparent ->
                        -1
            )
        |> Json.Encode.array Json.Encode.int


encodeColors : List Color -> Json.Encode.Value
encodeColors =
    Json.Encode.list encodeColor


encodeColor : Color -> Json.Encode.Value
encodeColor color =
    let
        { red, green, blue } =
            Color.toRgba color
    in
    Json.Encode.object
        [ ( "red", Json.Encode.float red )
        , ( "green", Json.Encode.float green )
        , ( "blue", Json.Encode.float blue )
        ]
