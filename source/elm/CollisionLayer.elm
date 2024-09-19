module CollisionLayer exposing
    ( CollisionLayer
    , empty
    , fromString
    , getAt
    , height
    , solid
    , width
    )

import Array2d exposing (Array2d)
import Helper


type CollisionLayer
    = CollisionLayer Int Int (Array2d Bool)


empty : Int -> Int -> CollisionLayer
empty w h =
    CollisionLayer w h (Array2d.repeat w h False)


solid : Int -> Int -> CollisionLayer
solid w h =
    CollisionLayer w h (Array2d.repeat w h True)


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
            (\array2d -> CollisionLayer (Array2d.width array2d) (Array2d.height array2d) array2d)


width : CollisionLayer -> Int
width (CollisionLayer w _ _) =
    w


height : CollisionLayer -> Int
height (CollisionLayer _ h _) =
    h


getAt : Int -> Int -> CollisionLayer -> Bool
getAt x y (CollisionLayer _ _ collisions) =
    collisions
        |> Array2d.get x y
        |> Maybe.withDefault False
