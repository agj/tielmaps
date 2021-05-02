module Canvas exposing (..)

import Array exposing (Array)
import Json.Encode as Encode exposing (Value)


type Canvas
    = Canvas Int Int (Array Bool)


create : Int -> Int -> Canvas
create w h =
    Canvas w h (Array.initialize (w * h) (always False))



-- ACCESSORS


width : Canvas -> Int
width (Canvas w _ _) =
    w


height : Canvas -> Int
height (Canvas _ h _) =
    h


pixel : Int -> Int -> Canvas -> Maybe Bool
pixel x y (Canvas w h pixels) =
    pixels
        |> Array.get (pos h x y)


encode : Canvas -> Value
encode (Canvas w h pixels) =
    Encode.object
        [ ( "width", w |> Encode.int )
        , ( "height", h |> Encode.int )
        , ( "pixels", pixels |> Encode.array boolEncoder )
        ]



-- SETTERS


paintPixel : Int -> Int -> Bool -> Canvas -> Canvas
paintPixel x y on (Canvas w h pixels) =
    pixels
        |> Array.set (pos h x y) on
        |> Canvas w h



-- INTERNAL


pos : Int -> Int -> Int -> Int
pos h x y =
    (h * y) + x


boolEncoder : Bool -> Value
boolEncoder value =
    if value then
        Encode.int 1

    else
        Encode.int 0
