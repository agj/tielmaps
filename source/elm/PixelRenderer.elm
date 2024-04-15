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
            (encodeTileStamps tilemap)
         ]
            ++ attrs
        )
        []



-- ENCODERS


encodeTileStamps : Tilemap a -> Json.Encode.Value
encodeTileStamps tilemap =
    let
        tileWidth =
            Tilemap.tileWidth tilemap

        tileHeight =
            Tilemap.tileHeight tilemap

        tileToTileStampValue : Int -> Int -> Int -> List Json.Encode.Value -> List Json.Encode.Value
        tileToTileStampValue tileX tileY tileIndex acc =
            Json.Encode.object
                [ ( "x", Json.Encode.int (tileX * tileWidth) )
                , ( "y", Json.Encode.int (tileY * tileHeight) )
                , ( "bitmapIndex", Json.Encode.int tileIndex )
                ]
                :: acc
    in
    Tilemap.map tilemap
        |> Array2d.indexedFoldl tileToTileStampValue []
        |> List.reverse
        |> Json.Encode.list identity


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
