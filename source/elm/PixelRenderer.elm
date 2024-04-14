module PixelRenderer exposing (element)

import Bitmap exposing (Bitmap)
import Color exposing (Color)
import Colors exposing (Colors)
import Html exposing (Html)
import Html.Attributes
import Json.Encode


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


encodeBitmapAndColors : Color -> Color -> Bitmap -> Json.Encode.Value
encodeBitmapAndColors lightColor darkColor bm =
    Json.Encode.object
        [ ( "lightColor", encodeColor lightColor )
        , ( "darkColor", encodeColor darkColor )
        , ( "bitmap"
          , Bitmap.encode bm
          )
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
