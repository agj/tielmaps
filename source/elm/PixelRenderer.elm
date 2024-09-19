module PixelRenderer exposing (element)

import Array
import Array2d exposing (Array2d)
import Bitmap exposing (Bitmap)
import Bitmap.Color
import Bitmap.Stamp exposing (BitmapStamp)
import Color exposing (Color)
import Colors exposing (Colors)
import Html exposing (Html)
import Html.Attributes
import Json.Encode
import Palette


element : Int -> Int -> Colors -> List (Bitmap a) -> List BitmapStamp -> List (Html.Attribute msg) -> Html msg
element width height colors bitmaps bitmapStamps attrs =
    let
        encodedColors : Json.Encode.Value
        encodedColors =
            [ colors.darkColor, colors.lightColor, Palette.transparent ]
                |> Json.Encode.list encodeColor

        encodedBitmaps : Json.Encode.Value
        encodedBitmaps =
            Json.Encode.list encodeBitmap bitmaps

        encodedBitmapStamps : Json.Encode.Value
        encodedBitmapStamps =
            Json.Encode.list encodeBitmapStamp bitmapStamps
    in
    Html.node "pixel-renderer"
        ([ Html.Attributes.width width
         , Html.Attributes.height height
         , Html.Attributes.property "colors" encodedColors
         , Html.Attributes.property "bitmaps" encodedBitmaps
         , Html.Attributes.property "bitmapStamps" encodedBitmapStamps
         ]
            ++ attrs
        )
        []



-- ENCODERS


encodeBitmapStamp : BitmapStamp -> Json.Encode.Value
encodeBitmapStamp { x, y, bitmapIndex } =
    Json.Encode.object
        [ ( "x", Json.Encode.int x )
        , ( "y", Json.Encode.int y )
        , ( "bitmapIndex", Json.Encode.int bitmapIndex )
        ]


encodeBitmap : Bitmap a -> Json.Encode.Value
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
                        2
            )
        |> Json.Encode.array Json.Encode.int


encodeColor : Color -> Json.Encode.Value
encodeColor color =
    let
        { red, green, blue, alpha } =
            Color.toRgba color
    in
    Json.Encode.object
        [ ( "red", Json.Encode.float red )
        , ( "green", Json.Encode.float green )
        , ( "blue", Json.Encode.float blue )
        , ( "alpha", Json.Encode.float alpha )
        ]
