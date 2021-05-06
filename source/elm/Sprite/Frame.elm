module Sprite.Frame exposing (Frame, bitmap, duration, make)

import Bitmap exposing (Bitmap)
import Tile exposing (Tile)


type Frame size
    = Frame Int Bitmap


make : Int -> Tile a -> Frame a
make dur t =
    Frame dur (Tile.bitmap t)



-- ACCESSORS


bitmap : Frame a -> Bitmap
bitmap (Frame _ bm) =
    bm


duration : Frame a -> Int
duration (Frame dur _) =
    dur
