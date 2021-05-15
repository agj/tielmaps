module Tilemap exposing
    ( Tilemap
    , empty8x8Tile
    , fromString
    , height
    , setTile
    , tile
    , tileHeight
    , tileWidth
    , toBitmap
    , width
    )

import Array exposing (Array)
import Bitmap exposing (Bitmap)
import Dict exposing (Dict)
import Helper
import Maybe.Extra as Maybe
import Size exposing (Size8x8)
import Tile exposing (Tile)


type Tilemap tileSize
    = Tilemap
        { width_ : Int
        , height_ : Int
        , tileWidth_ : Int
        , tileHeight_ : Int
        , bitmaps : Array Bitmap
        }


empty8x8Tile : Int -> Int -> Tilemap Size8x8
empty8x8Tile w h =
    let
        make tileW tileH =
            Tilemap
                { width_ = w
                , height_ = h
                , tileWidth_ = tileW
                , tileHeight_ = tileH
                , bitmaps = Array.initialize (w * h) (always (Bitmap.empty tileW tileH))
                }
    in
    make 8 8


{-| Takes a specially formatted string and a Dict of Char to tile (Bitmap) mappings,
and converts them into a Map. Here's an example:

    """
    . . . .
    . A B .
    . B A .
    . . . .
    """
        |> Map.fromString
            (Dict.fromList
                [ ( '.', emptyTile )
                , ( 'A', tileA )
                , ( 'B', tileB )
                ]
            )

This will produce a 4 × 4 tiles Map.
Note that spaces are always ignored.

-}
fromString : Dict Char (Tile a) -> String -> Maybe (Tilemap a)
fromString tiles str =
    case Dict.values tiles of
        t :: _ ->
            let
                bm =
                    Tile.bitmap t

                tw =
                    Bitmap.width bm

                th =
                    Bitmap.height bm

                mapper ch =
                    Dict.get ch tiles
                        |> Maybe.map Tile.bitmap

                r =
                    Helper.stringToArray mapper str

                toTilemap bitmaps =
                    Tilemap
                        { width_ = r.width
                        , height_ = r.height
                        , tileWidth_ = tw
                        , tileHeight_ = th
                        , bitmaps = bitmaps
                        }
            in
            r.array
                |> Maybe.combineArray
                |> Maybe.map toTilemap

        _ ->
            Nothing



-- ACCESSORS


width : Tilemap a -> Int
width (Tilemap { width_ }) =
    width_


height : Tilemap a -> Int
height (Tilemap { height_ }) =
    height_


tileWidth : Tilemap a -> Int
tileWidth (Tilemap { tileWidth_ }) =
    tileWidth_


tileHeight : Tilemap a -> Int
tileHeight (Tilemap { tileHeight_ }) =
    tileHeight_


tile : Int -> Int -> Tilemap a -> Maybe Bitmap
tile x y (Tilemap { width_, bitmaps }) =
    bitmaps
        |> Array.get (Helper.pos width_ x y)



-- SETTERS


setTile : Int -> Int -> Tile a -> Tilemap a -> Tilemap a
setTile x y t (Tilemap ({ width_, bitmaps } as state)) =
    let
        toMap bms =
            Tilemap { state | bitmaps = bms }
    in
    bitmaps
        |> Array.set (Helper.pos width_ x y) (Tile.bitmap t)
        |> toMap


toBitmap : Tilemap a -> Bitmap
toBitmap ((Tilemap { width_, height_, tileWidth_, tileHeight_ }) as tilemap) =
    let
        iterator row col bm =
            let
                nextRow =
                    if row >= width_ - 1 then
                        0

                    else
                        row + 1

                nextCol =
                    if nextRow == 0 then
                        col + 1

                    else
                        col

                curTile =
                    tile row col tilemap

                newBm =
                    case curTile of
                        Just ct ->
                            Bitmap.paintBitmap (tileWidth_ * row) (tileHeight_ * col) ct bm

                        Nothing ->
                            bm
            in
            if nextCol >= height_ then
                newBm

            else
                iterator nextRow nextCol newBm
    in
    Bitmap.empty (width_ * tileWidth_) (height_ * tileHeight_)
        |> iterator 0 0
