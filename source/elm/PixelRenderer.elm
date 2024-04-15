module PixelRenderer exposing (element, element2)

import Array exposing (Array)
import Array2d
import Bitmap exposing (Bitmap)
import Bitmap.Color
import Color exposing (Color)
import Colors exposing (Colors)
import Html exposing (Html)
import Html.Attributes
import Json.Encode
import List.Extra
import Tile exposing (Tile)
import Tilemap exposing (Tilemap)


element : Int -> Int -> List (Html.Attribute msg) -> Colors -> Bitmap -> Html msg
element w h attrs colors bm =
    Html.node "pixel-renderer"
        ([ Html.Attributes.width w
         , Html.Attributes.height h
         , Html.Attributes.property "scene"
            (encodeBitmapAndColors colors.lightColor colors.darkColor bm)
         ]
            ++ attrs
        )
        []


element2 : Int -> Int -> List (Html.Attribute msg) -> Colors -> Tilemap x -> Html msg
element2 width height attrs colors tilemap =
    Html.node "pixel-renderer"
        ([ Html.Attributes.width width
         , Html.Attributes.height height
         , Html.Attributes.property "colors"
            (encodeColors [ colors.darkColor, colors.lightColor ])
         , Html.Attributes.property "tiles"
            (encodeTiles (Tilemap.tiles tilemap))
         , Html.Attributes.property "tileStamps"
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
                , ( "tileIndex", Json.Encode.int tileIndex )
                ]
                :: acc
    in
    Tilemap.map tilemap
        |> Array2d.indexedFoldl tileToTileStampValue []
        |> List.reverse
        |> Json.Encode.list identity


encodeTiles : Array (Tile x) -> Json.Encode.Value
encodeTiles tiles =
    Json.Encode.array encodeTile tiles


encodeTile : Tile x -> Json.Encode.Value
encodeTile tile =
    Json.Encode.object
        [ ( "width", Json.Encode.int (Tile.width tile) )
        , ( "pixels", encodeBitmap (Tile.bitmap tile) )
        ]


encodeBitmap : Bitmap -> Json.Encode.Value
encodeBitmap bitmap =
    Bitmap.pixels bitmap
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


encodeBitmapAndColors : Color -> Color -> Bitmap -> Json.Encode.Value
encodeBitmapAndColors lightColor darkColor bm =
    Json.Encode.object
        [ ( "lightColor", encodeColor lightColor )
        , ( "darkColor", encodeColor darkColor )
        , ( "bitmap"
          , Bitmap.encode bm
          )
        ]


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
        [ ( "red", encodeColorChannel red )
        , ( "green", encodeColorChannel green )
        , ( "blue", encodeColorChannel blue )
        ]


encodeColorChannel : Float -> Json.Encode.Value
encodeColorChannel channel =
    Json.Encode.float channel
