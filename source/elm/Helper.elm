module Helper exposing
    ( pos
    , stringToArray
    , stringToArray2d
    )

import Array exposing (Array)
import Array2d exposing (Array2d)
import Maybe.Extra as Maybe


pos : Int -> Int -> Int -> Int
pos w x y =
    x + (w * y)


stringToArray : (Char -> a) -> String -> { width : Int, height : Int, array : Array a }
stringToArray mapper str =
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

        mapped =
            lines
                |> List.map (String.toList >> List.map mapper)
                |> List.foldr (++) []
                |> Array.fromList
    in
    { width = w
    , height = h
    , array = mapped
    }


stringToArray2d : (Char -> Maybe a) -> a -> String -> Maybe { width : Int, height : Int, array2d : Array2d a }
stringToArray2d mapper filler str =
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

        mapped =
            lines
                |> List.map (String.toList >> List.map mapper)
                |> List.foldr (++) []
                |> Maybe.combine
                |> Maybe.map (Array2d.fromList w filler)
    in
    mapped
        |> Maybe.map
            (\array2d ->
                { width = w
                , height = h
                , array2d = array2d
                }
            )



-- INTERNAL


removeSpaces : String -> String
removeSpaces =
    String.filter (\ch -> ch /= ' ')
