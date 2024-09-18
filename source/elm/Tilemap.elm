module Tilemap exposing
    ( Tilemap
    , empty8x8Tile
    , fromString
    , height
    , map
    , tiles
    , width
    )

import Array exposing (Array)
import Array2d exposing (Array2d)
import Dict exposing (Dict)
import Graphic exposing (Graphic)
import Helper
import List.Extra
import Maybe.Extra as Maybe


type Tilemap
    = Tilemap
        { width_ : Int
        , height_ : Int
        , tiles_ : Array Graphic
        , map_ : Array2d Int
        }


empty8x8Tile : Int -> Int -> Tilemap
empty8x8Tile w h =
    Tilemap
        { width_ = w
        , height_ = h
        , tiles_ = Array.repeat 1 Graphic.Empty
        , map_ = Array2d.repeat w h 0
        }


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
fromString : Dict Char Graphic -> String -> Maybe Tilemap
fromString tiles_ str =
    let
        tilesList =
            Dict.values tiles_

        tilesArray : Array Graphic
        tilesArray =
            Dict.values tiles_
                |> Array.fromList

        charToTileIndex : Char -> Maybe Int
        charToTileIndex ch =
            Dict.get ch tiles_
                |> Maybe.andThen (\tile_ -> List.Extra.findIndex ((==) tile_) tilesList)

        map_ : Maybe (Array2d Int)
        map_ =
            Helper.stringToArray2d charToTileIndex str
    in
    case map_ of
        Just mapOk ->
            Just
                (Tilemap
                    { width_ = Array2d.width mapOk
                    , height_ = Array2d.height mapOk
                    , tiles_ = tilesArray
                    , map_ = mapOk
                    }
                )

        _ ->
            Nothing



-- ACCESSORS


width : Tilemap -> Int
width (Tilemap { width_ }) =
    width_


height : Tilemap -> Int
height (Tilemap { height_ }) =
    height_


tiles : Tilemap -> Array Graphic
tiles (Tilemap { tiles_ }) =
    tiles_


map : Tilemap -> Array2d Int
map (Tilemap { map_ }) =
    map_
