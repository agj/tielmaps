module Canvas exposing (..)

import Array exposing (Array)


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
