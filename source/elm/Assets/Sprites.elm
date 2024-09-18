module Assets.Sprites exposing (avatarSprites)

import Avatar.AvatarSprites exposing (AvatarSprites)
import Sprite exposing (Sprite)
import Sprite.Frame as Frame
import Sprite.HeldFrame as HeldFrame


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
        (HeldFrame.make 7 Frame.FrameStandingRight)
        [ HeldFrame.make 7 Frame.FrameBobRight
        ]


standingLeft : Sprite
standingLeft =
    Sprite.animated
        (HeldFrame.make 7 Frame.FrameStandingLeft)
        [ HeldFrame.make 7 Frame.FrameBobLeft
        ]


runningRight : Sprite
runningRight =
    Sprite.animated
        (HeldFrame.make 4 Frame.FrameAirborneRight)
        [ HeldFrame.make 4 Frame.FrameStandingRight
        , HeldFrame.make 4 Frame.FrameHopRight
        , HeldFrame.make 4 Frame.FrameStandingRight
        ]


runningLeft : Sprite
runningLeft =
    Sprite.animated
        (HeldFrame.make 4 Frame.FrameAirborneLeft)
        [ HeldFrame.make 4 Frame.FrameStandingLeft
        , HeldFrame.make 4 Frame.FrameHopLeft
        , HeldFrame.make 4 Frame.FrameStandingLeft
        ]


jumpingRight : Sprite
jumpingRight =
    Frame.FrameAirborneRight
        |> Sprite.static


jumpingLeft : Sprite
jumpingLeft =
    Frame.FrameAirborneLeft
        |> Sprite.static
