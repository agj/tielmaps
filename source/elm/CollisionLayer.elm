module CollisionLayer exposing
    ( CollisionLayer
    , empty
    , fromString
    , getAt
    , height
    , width
    )

import Array exposing (Array)
import Array2d exposing (Array2d)
import Helper


type CollisionLayer
    = CollisionLayer Int Int (Array2d Bool)


empty : Int -> Int -> CollisionLayer
empty w h =
    CollisionLayer w h (Array2d.repeat w h False)


fromString : List Char -> String -> Maybe CollisionLayer
fromString solids str =
    let
        mapper ch =
            Just (List.member ch solids)

        mapped =
            Helper.stringToArray2d mapper str
    in
    mapped
        |> Maybe.map
            (\r -> CollisionLayer r.width r.height r.array2d)


width : CollisionLayer -> Int
width (CollisionLayer w _ _) =
    w


height : CollisionLayer -> Int
height (CollisionLayer _ h _) =
    h


getAt : Int -> Int -> CollisionLayer -> Bool
getAt x y (CollisionLayer w _ collisions) =
    collisions
        |> Array2d.get x y
        |> Maybe.withDefault False
