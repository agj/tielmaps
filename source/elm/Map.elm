module Map exposing
    ( Map
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


type Map tileSize
    = Map
        { width_ : Int
        , height_ : Int
        , tileWidth_ : Int
        , tileHeight_ : Int
        , bitmaps : Array Bitmap
        }


empty8x8Tile : Int -> Int -> Map Size8x8
empty8x8Tile w h =
    let
        make tileW tileH =
            Map
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
fromString : Dict Char (Tile a) -> String -> Maybe (Map a)
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

                toMap bitmaps =
                    Map
                        { width_ = r.width
                        , height_ = r.height
                        , tileWidth_ = tw
                        , tileHeight_ = th
                        , bitmaps = bitmaps
                        }
            in
            r.array
                |> Maybe.combineArray
                |> Maybe.map toMap

        _ ->
            Nothing



-- ACCESSORS


width : Map a -> Int
width (Map { width_ }) =
    width_


height : Map a -> Int
height (Map { height_ }) =
    height_


tileWidth : Map a -> Int
tileWidth (Map { tileWidth_ }) =
    tileWidth_


tileHeight : Map a -> Int
tileHeight (Map { tileHeight_ }) =
    tileHeight_


tile : Int -> Int -> Map a -> Maybe Bitmap
tile x y (Map { width_, bitmaps }) =
    bitmaps
        |> Array.get (Helper.pos width_ x y)



-- SETTERS


setTile : Int -> Int -> Tile a -> Map a -> Map a
setTile x y t (Map ({ width_, bitmaps } as state)) =
    let
        toMap bms =
            Map { state | bitmaps = bms }
    in
    bitmaps
        |> Array.set (Helper.pos width_ x y) (Tile.bitmap t)
        |> toMap


toBitmap : Map a -> Bitmap
toBitmap ((Map { width_, height_, tileWidth_, tileHeight_ }) as map) =
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
                    tile row col map

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
