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


type HeldFrame size
    = Frame Int (Bitmap size)


make : Int -> Bitmap Size8x8 -> HeldFrame Size8x8
make dur b =
    Frame dur b



-- ACCESSORS


bitmap : HeldFrame a -> Bitmap a
bitmap (Frame _ bm) =
    bm


duration : HeldFrame a -> Int
duration (Frame dur _) =
    dur


width : HeldFrame a -> Int
width (Frame _ bm) =
    Bitmap.width bm


height : HeldFrame a -> Int
height (Frame _ bm) =
    Bitmap.height bm
