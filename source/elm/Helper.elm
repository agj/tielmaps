module Helper exposing
    ( pos
    , stringToArray
    )

import Array exposing (Array)


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



-- INTERNAL


removeSpaces : String -> String
removeSpaces =
    String.filter (\ch -> ch /= ' ')
