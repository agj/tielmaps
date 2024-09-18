module Tile exposing
    ( Tile
    , bitmap
    , empty8x8
    , error8x8
    , height
    , make8x8
    , solid8x8
    , width
    )

import Bitmap exposing (Bitmap)
import Bitmap.Color exposing (Color(..))
import Size exposing (Size8x8)


type Tile size
    = Tile (Bitmap size)


empty8x8 : Tile Size8x8
empty8x8 =
    Tile Bitmap.empty8x8


solid8x8 : Color -> Tile Size8x8
solid8x8 color =
    Tile (Bitmap.solid8x8 color)


make8x8 : Bitmap Size8x8 -> Maybe (Tile Size8x8)
make8x8 bm =
    if checkSize 8 8 bm then
        Just (Tile bm)

    else
        Nothing


error8x8 : Tile Size8x8
error8x8 =
    Bitmap.error8x8
        |> Tile



-- ACCESSORS


bitmap : Tile a -> Bitmap a
bitmap (Tile bm) =
    bm


width : Tile a -> Int
width (Tile bm) =
    Bitmap.width bm


height : Tile a -> Int
height (Tile bm) =
    Bitmap.height bm



-- INTERNAL


checkSize : Int -> Int -> Bitmap Size8x8 -> Bool
checkSize w h bm =
    Bitmap.width bm == w && Bitmap.height bm == h
