module Map exposing (Map, empty, fromString, height, setTile, tile, toBitmap, width)

import Array exposing (Array)
import Bitmap exposing (Bitmap)
import Dict exposing (Dict)
import Maybe.Extra as Maybe


type Map
    = Map ( Int, Int ) ( Int, Int ) (Array Bitmap)


empty : Int -> Int -> Int -> Int -> Map
empty w h tileW tileH =
    Map ( w, h ) ( tileW, tileH ) (Array.initialize (w * h) (always (Bitmap.empty tileW tileH)))


fromString : Dict Char Bitmap -> String -> Maybe Map
fromString tiles str =
    let
        rawLines =
            str
                |> String.lines
                |> List.map removeSpaces
                |> List.filter (not << String.isEmpty)

        w =
            rawLines
                |> List.map String.length
                |> List.foldl max 0

        h =
            List.length rawLines

        lines =
            rawLines
                |> List.map (String.padRight w '.')

        toTile ch =
            Dict.get ch tiles
    in
    case Dict.values tiles of
        t :: _ ->
            let
                tw =
                    Bitmap.width t

                th =
                    Bitmap.height t
            in
            lines
                |> List.map (String.toList >> List.map toTile)
                |> List.foldr (++) []
                |> Maybe.combine
                |> Maybe.map Array.fromList
                |> Maybe.map (Map ( w, h ) ( tw, th ))

        _ ->
            Nothing



-- ACCESSORS


width : Map -> Int
width (Map ( w, _ ) _ _) =
    w


height : Map -> Int
height (Map ( _, h ) _ _) =
    h


tile : Int -> Int -> Map -> Maybe Bitmap
tile x y (Map ( w, _ ) _ tiles) =
    tiles
        |> Array.get (pos w x y)



-- SETTERS


setTile : Int -> Int -> Bitmap -> Map -> Map
setTile x y bm (Map (( w, _ ) as size) tileSize tiles) =
    tiles
        |> Array.set (pos w x y) bm
        |> Map size tileSize


toBitmap : Map -> Bitmap
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



-- INTERNAL


pos : Int -> Int -> Int -> Int
pos w x y =
    x + (w * y)


removeSpaces : String -> String
removeSpaces =
    String.filter (\ch -> ch /= ' ')
