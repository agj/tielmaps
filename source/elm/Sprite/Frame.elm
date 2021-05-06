module Sprite.Frame exposing (Frame, duration, make, tile)

import Tile exposing (Tile)


type Frame size
    = Frame Int (Tile size)


make : Int -> Tile a -> Frame a
make dur t =
    Frame dur t



-- ACCESSORS


tile : Frame a -> Tile a
tile (Frame _ t) =
    t


duration : Frame a -> Int
duration (Frame dur _) =
    dur
