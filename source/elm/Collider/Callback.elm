module Collider.Callback exposing (Callback, Position)


type alias Position =
    { x : Int
    , y : Int
    , width : Int
    , height : Int
    , prevX : Int
    , prevY : Int
    }


type alias Callback =
    Position -> Point



-- INTERNAL


type alias Point =
    ( Int, Int )
