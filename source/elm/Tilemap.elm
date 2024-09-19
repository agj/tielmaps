module Tilemap exposing
    ( Tilemap
    , empty
    , fromString
    , height
    , tiles
    , width
    )

import Array2d exposing (Array2d)
import Dict exposing (Dict)
import Graphic exposing (Graphic)
import Helper


type Tilemap
    = Tilemap
        { width_ : Int
        , height_ : Int
        , tiles_ : Array2d Graphic
        }


empty : Int -> Int -> Tilemap
empty w h =
    Tilemap
        { width_ = w
        , height_ = h
        , tiles_ = Array2d.repeat w h Graphic.Empty
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
fromString charToGraphicMap str =
    let
        charToTileIndex : Char -> Maybe Graphic
        charToTileIndex ch =
            Dict.get ch charToGraphicMap
    in
    Helper.stringToArray2d charToTileIndex str
        |> Maybe.map
            (\tiles_ ->
                Tilemap
                    { width_ = Array2d.width tiles_
                    , height_ = Array2d.height tiles_
                    , tiles_ = tiles_
                    }
            )



-- ACCESSORS


width : Tilemap -> Int
width (Tilemap { width_ }) =
    width_


height : Tilemap -> Int
height (Tilemap { height_ }) =
    height_


tiles : Tilemap -> Array2d Graphic
tiles (Tilemap { tiles_ }) =
    tiles_
