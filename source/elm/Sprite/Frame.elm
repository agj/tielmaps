module Sprite.Frame exposing
    ( HeldFrame
    , bitmap
    , duration
    , height
    , make
    , width
    )

import Bitmap exposing (Bitmap)
import Size exposing (Size8x8)


type HeldFrame
    = Frame Int (Bitmap Size8x8)


make : Int -> Bitmap Size8x8 -> HeldFrame
make dur b =
    Frame dur b



-- ACCESSORS


bitmap : HeldFrame -> Bitmap Size8x8
bitmap (Frame _ bm) =
    bm


duration : HeldFrame -> Int
duration (Frame dur _) =
    dur


width : HeldFrame -> Int
width (Frame _ bm) =
    Bitmap.width bm


height : HeldFrame -> Int
height (Frame _ bm) =
    Bitmap.height bm
