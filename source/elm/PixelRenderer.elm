module PixelRenderer exposing (element)

import Array exposing (Array)
import Array2d
import Bitmap exposing (Bitmap)
import Bitmap.Color
import Color exposing (Color)
import Colors exposing (Colors)
import Html exposing (Html)
import Html.Attributes
import Json.Encode
import Tile exposing (Tile)
import Tilemap exposing (Tilemap)


element : Int -> Int -> List (Html.Attribute msg) -> Colors -> Tilemap x -> Html msg
element width height attrs colors tilemap =
    let
        tilemapBitmaps =
            Tilemap.tiles tilemap
                |> Array.toList
                |> List.map Tile.bitmap
    in
    Html.node "pixel-renderer"
        ([ Html.Attributes.width width
         , Html.Attributes.height height
         , Html.Attributes.property "colors"
            (encodeColors [ colors.darkColor, colors.lightColor ])
         , Html.Attributes.property "bitmaps"
            (encodeBitmaps tilemapBitmaps)
         , Html.Attributes.property "bitmapStamps"
            (encodeTilemapAsBitmapStamps tilemap
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
