port module Js exposing (paintCanvas)

import Bitmap exposing (Bitmap)
import Color exposing (Color)
import Json.Encode as E
import Levers


paintCanvas : Color -> Color -> Bitmap -> Cmd msg
paintCanvas lightColor darkColor bm =
    command
        { kind = "paintCanvas"
        , value = encodeBitmapAndColors lightColor darkColor bm
        }



-- INTERNAL


type alias ToJs =
    { kind : String
    , value : E.Value
    }


port command : ToJs -> Cmd msg


encodeBitmapAndColors : Color -> Color -> Bitmap -> E.Value
encodeBitmapAndColors lightColor darkColor bm =
    E.object
        [ ( "lightColor", encodeColor lightColor )
        , ( "darkColor", encodeColor darkColor )
        , ( "bitmap"
          , Bitmap.encode bm
          )
        , ( "canvasId", E.string Levers.canvasId )
        ]


encodeColor : Color -> E.Value
encodeColor color =
    let
        { red, green, blue } =
            Color.toRgba color
    in
    E.object
        [ ( "red", encodeColorChannel red )
        , ( "green", encodeColorChannel green )
        , ( "blue", encodeColorChannel blue )
        ]


encodeColorChannel : Float -> E.Value
encodeColorChannel channel =
    E.float channel
