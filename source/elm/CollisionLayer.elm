module CollisionLayer exposing
    ( CollisionLayer
    , empty
    , fromString
    , getAt
    , height
    , width
    )

import Array exposing (Array)
import Helper


type CollisionLayer
    = CollisionLayer Int Int (Array Bool)


empty : Int -> Int -> CollisionLayer
empty w h =
    CollisionLayer w h (Array.initialize (w * h) (always False))


fromString : List Char -> String -> CollisionLayer
fromString solids str =
    let
        mapper ch =
            List.member ch solids

        r =
            Helper.stringToArray mapper str
    in
    CollisionLayer r.width r.height r.array


width : CollisionLayer -> Int
width (CollisionLayer w _ _) =
    w


height : CollisionLayer -> Int
height (CollisionLayer _ h _) =
    h


getAt : Int -> Int -> CollisionLayer -> Maybe Bool
getAt x y (CollisionLayer w _ collisions) =
    collisions
        |> Array.get (Helper.pos w x y)
