module Map exposing (Map, empty8x8Tile, fromString, height, setTile, tile, toBitmap, width)

import Array exposing (Array)
import Bitmap exposing (Bitmap)
import Dict exposing (Dict)
import Helper
import Maybe.Extra as Maybe
import Size exposing (Size8x8)
import Tile exposing (Tile)


type Map tileSize
    = Map ( Int, Int ) ( Int, Int ) (Array Bitmap)


empty8x8Tile : Int -> Int -> Map Size8x8
empty8x8Tile w h =
    let
        make tileW tileH =
            Map ( w, h ) ( tileW, tileH ) (Array.initialize (w * h) (always (Bitmap.empty tileW tileH)))
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
            in
            r.array
                |> Maybe.combineArray
                |> Maybe.map (Map ( r.width, r.height ) ( tw, th ))

        _ ->
            Nothing



-- ACCESSORS


width : Map a -> Int
width (Map ( w, _ ) _ _) =
    w


height : Map a -> Int
height (Map ( _, h ) _ _) =
    h


tile : Int -> Int -> Map a -> Maybe Bitmap
tile x y (Map ( w, _ ) _ tiles) =
    tiles
        |> Array.get (Helper.pos w x y)



-- SETTERS


setTile : Int -> Int -> Tile a -> Map a -> Map a
setTile x y t (Map (( w, _ ) as size) tileSize tiles) =
    tiles
        |> Array.set (Helper.pos w x y) (Tile.bitmap t)
        |> Map size tileSize


toBitmap : Map a -> Bitmap
toBitmap ((Map ( w, h ) ( tw, th ) _) as map) =
    let
        iterator row col bm =
            let
                nextRow =
                    if row >= w - 1 then
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
                            Bitmap.paintBitmap (tw * row) (th * col) ct bm

                        Nothing ->
                            bm
            in
            if nextCol >= h then
                newBm

            else
                iterator nextRow nextCol newBm
    in
    Bitmap.empty (w * tw) (h * th)
        |> iterator 0 0
