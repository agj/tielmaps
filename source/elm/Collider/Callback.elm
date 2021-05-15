module Collider.Callback exposing
    ( Callback
    , Position
    )

{-| -}


{-| Position information that a moving object can supply,
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


{-| Returns new coordinates for the moving object after doing collision detection
against the provided position information.
-}
type alias Callback =
    Position -> Point



-- INTERNAL


type alias Point =
    ( Int, Int )
