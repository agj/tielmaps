module Sprite.Frame exposing
    ( Frame
    , bitmap
    , duration
    , height
    , make
    , width
    )

import Bitmap exposing (Bitmap)
import Tile exposing (Tile)


type Frame size
    = Frame Int (Bitmap size)


make : Int -> Tile a -> Frame a
make dur t =
    Frame dur (Tile.bitmap t)



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
