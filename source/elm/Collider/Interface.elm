module Collider.Interface exposing
    ( Collider
    , PointChecker
    , Position
    )

import Point exposing (Point)


{-| Function that returns new coordinates for the moving object
after doing collision detection against the provided position information.
-}
type alias Collider =
    Position -> Point


{-| Function that given x and y coordinates returns whether that point
is in collision or not.
-}
type alias PointChecker =
    Int -> Int -> Bool


{-| Position information that a moving object can supply
for collision detection purposes.
-}
type alias Position =
    { x : Int
    , y : Int
    , width : Int
    , height : Int
    , prevX : Int
    , prevY : Int
    }
