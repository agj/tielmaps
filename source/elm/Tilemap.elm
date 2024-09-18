module Tilemap exposing
    ( Tilemap
    , empty8x8Tile
    , fromString
    , height
    , map
    , tileHeight
    , tileWidth
    , tiles
    , width
    )

import Array exposing (Array)
import Array2d exposing (Array2d)
import Bitmap exposing (Bitmap)
import Dict exposing (Dict)
import Graphic exposing (Graphic)
import Helper
import List.Extra
import Maybe.Extra as Maybe
import Size exposing (Size8x8)


type Tilemap tileSize
    = Tilemap
        { width_ : Int
        , height_ : Int
        , tileWidth_ : Int
        , tileHeight_ : Int
        , tiles_ : Array Graphic
        , map_ : Array2d Int
        }


empty8x8Tile : Int -> Int -> Tilemap Size8x8
empty8x8Tile w h =
    Tilemap
        { width_ = w
        , height_ = h
        , tileWidth_ = 8
        , tileHeight_ = 8
        , tiles_ = Array.repeat 1 Graphic.empty8x8
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
fromString : Dict Char Graphic -> String -> Maybe (Tilemap Size8x8)
fromString tiles_ str =
    let
        tilesList =
            Dict.values tiles_
    in
    case tilesList of
        t :: _ ->
            let
                tw =
                    Graphic.width t

                th =
                    Graphic.height t

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

                bitmaps : Maybe (Array2d (Bitmap Size8x8))
                bitmaps =
                    map_
                        |> Maybe.map
                            (\m ->
                                m
                                    |> Array2d.map
                                        (\tileIndex ->
                                            Array.get tileIndex tilesArray
                                                |> Maybe.withDefault t
                                                |> Graphic.bitmap
                                        )
                            )
            in
            case ( map_, bitmaps ) of
                ( Just mapOk, Just bitmapsOk ) ->
                    Just
                        (Tilemap
                            { width_ = Array2d.width mapOk
                            , height_ = Array2d.height mapOk
                            , tileWidth_ = tw
                            , tileHeight_ = th
                            , tiles_ = tilesArray
                            , map_ = mapOk
                            }
                        )

                _ ->
                    Nothing

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


tiles : Tilemap a -> Array Graphic
tiles (Tilemap { tiles_ }) =
    tiles_


map : Tilemap a -> Array2d Int
map (Tilemap { map_ }) =
    map_
