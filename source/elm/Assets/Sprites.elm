module Assets.Sprites exposing (avatarSprites)

import Avatar.AvatarSprites exposing (AvatarSprites)
import Bitmap exposing (Bitmap)
import Size exposing (Size8x8)
import Sprite exposing (Sprite)
import Sprite.Frame as Frame exposing (HeldFrame)


avatarSprites : AvatarSprites
avatarSprites =
    { runningRight = runningRight
    , runningLeft = runningLeft
    , standingRight = standingRight
    , standingLeft = standingLeft
    , jumpingRight = jumpingRight
    , jumpingLeft = jumpingLeft
    }



-- INTERNAL


standingRight : Sprite
standingRight =
    Sprite.animated
        (Frame.make 7 Frame.FrameStandingRight)
        [ Frame.make 7 Frame.FrameBobRight
        ]


standingLeft : Sprite
standingLeft =
    Sprite.animated
        (Frame.make 7 Frame.FrameStandingLeft)
        [ Frame.make 7 Frame.FrameBobLeft
        ]


runningRight : Sprite
runningRight =
    Sprite.animated
        (Frame.make 4 Frame.FrameAirborneRight)
        [ Frame.make 4 Frame.FrameStandingRight
        , Frame.make 4 Frame.FrameHopRight
        , Frame.make 4 Frame.FrameStandingRight
        ]


runningLeft : Sprite
runningLeft =
    Sprite.animated
        (Frame.make 4 Frame.FrameAirborneLeft)
        [ Frame.make 4 Frame.FrameStandingLeft
        , Frame.make 4 Frame.FrameHopLeft
        , Frame.make 4 Frame.FrameStandingLeft
        ]


jumpingRight : Sprite
jumpingRight =
    Frame.FrameAirborneRight
        |> Sprite.static


jumpingLeft : Sprite
jumpingLeft =
    Frame.FrameAirborneLeft
        |> Sprite.static
