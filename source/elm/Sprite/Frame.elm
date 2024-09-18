module Sprite.Frame exposing
    ( Frame
    , bitmap
    , duration
    , height
    , make
    , width
    )

import Bitmap exposing (Bitmap)
import Size exposing (Size8x8)


type Frame size
    = Frame Int (Bitmap size)


make : Int -> Bitmap Size8x8 -> Frame Size8x8
make dur b =
    Frame dur b



-- ACCESSORS


bitmap : Frame a -> Bitmap a
bitmap (Frame _ bm) =
    bm


duration : Frame a -> Int
duration (Frame dur _) =
    dur


width : Frame a -> Int
width (Frame _ bm) =
    Bitmap.width bm


height : Frame a -> Int
height (Frame _ bm) =
    Bitmap.height bm
