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
    , toBitmapMemoized
    , width
    )

import Array exposing (Array)
import Array2d exposing (Array2d)
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
        , bitmaps : Array2d Bitmap
        , bitmapMemo : Maybe Bitmap
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
                , bitmaps = Array2d.repeat w h (Bitmap.empty tileW tileH)
                , bitmapMemo = Nothing
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
        |> Tilemap.fromString
            (Dict.fromList
                [ ( '.', emptyTile )
                , ( 'A', tileA )
                , ( 'B', tileB )
                ]
            )

This will produce a 4 × 4 tiles Tilemap, wrapped in a Just if all's correct.
Note that spaces are always ignored.

-}
fromString : Dict Char (Tile a) -> String -> Maybe (Tilemap a)
fromString tiles str =
    case Dict.values tiles of
        t :: _ ->
            let
                tw =
                    Tile.width t

                th =
                    Tile.height t

                charToBitmap ch =
                    Dict.get ch tiles
                        |> Maybe.map Tile.bitmap

                bitmaps : Maybe (Array2d Bitmap)
                bitmaps =
                    Helper.stringToArray2d charToBitmap str
            in
            bitmaps
                |> Maybe.map
                    (\array2d ->
                        Tilemap
                            { width_ = Array2d.width array2d
                            , height_ = Array2d.height array2d
                            , tileWidth_ = tw
                            , tileHeight_ = th
                            , bitmaps = array2d
                            , bitmapMemo = Nothing
                            }
                    )

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
tile x y (Tilemap { bitmaps }) =
    bitmaps
        |> Array2d.get x y



-- SETTERS


setTile : Int -> Int -> Tile a -> Tilemap a -> Tilemap a
setTile x y t (Tilemap ({ bitmaps } as state)) =
    Tilemap
        { state
            | bitmaps =
                bitmaps
                    |> Array2d.set x y (Tile.bitmap t)
            , bitmapMemo = Nothing
        }


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


toBitmapMemoized : Tilemap a -> ( Bitmap, Tilemap a )
toBitmapMemoized ((Tilemap ({ bitmapMemo } as state)) as tilemap) =
    case bitmapMemo of
        Just bitmap ->
            ( bitmap, tilemap )

        Nothing ->
            let
                bitmap =
                    toBitmap tilemap
            in
            ( bitmap, Tilemap { state | bitmapMemo = Just bitmap } )
