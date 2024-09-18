module Helper exposing (stringToArray2d)

import Array2d exposing (Array2d)
import Maybe.Extra as Maybe


stringToArray2d : (Char -> Maybe a) -> String -> Maybe (Array2d a)
stringToArray2d mapper str =
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

        lines =
            rawLines
                |> List.map (String.padRight w '.')
    in
    lines
        |> List.map (String.toList >> List.map mapper)
        |> List.foldr (++) []
        |> Maybe.combine
        |> Maybe.andThen (Array2d.fromList w)



-- INTERNAL


removeSpaces : String -> String
removeSpaces =
    String.filter (\ch -> ch /= ' ')
