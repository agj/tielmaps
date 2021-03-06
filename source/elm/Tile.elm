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
    = Tile Bitmap


empty8x8 : Tile Size8x8
empty8x8 =
    Tile (Bitmap.empty 8 8)


solid8x8 : Color -> Tile Size8x8
solid8x8 color =
    Tile (Bitmap.solid color 8 8)


make8x8 : Bitmap -> Maybe (Tile Size8x8)
make8x8 bm =
    if checkSize 8 8 bm then
        Just (Tile bm)

    else
        Nothing


error8x8 : Tile Size8x8
error8x8 =
    Bitmap.error
        |> Tile



-- ACCESSORS


bitmap : Tile a -> Bitmap
bitmap (Tile bm) =
    bm


width : Tile a -> Int
width (Tile bm) =
    Bitmap.width bm


height : Tile a -> Int
height (Tile bm) =
    Bitmap.height bm



-- INTERNAL


checkSize : Int -> Int -> Bitmap -> Bool
checkSize w h bm =
    Bitmap.width bm == w && Bitmap.height bm == h
