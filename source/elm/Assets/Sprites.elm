module Assets.Sprites exposing (avatarSprites)

import Avatar.AvatarSprites exposing (AvatarSprites)
import Graphic
import Levers
import Sprite exposing (Sprite)
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
        (HeldFrame.make (Levers.durationGiven60Fps 14) Graphic.AvatarStandingRight)
        [ HeldFrame.make (Levers.durationGiven60Fps 14) Graphic.AvatarBobRight
        ]


standingLeft : Sprite
standingLeft =
    Sprite.animated
        (HeldFrame.make (Levers.durationGiven60Fps 14) Graphic.AvatarStandingLeft)
        [ HeldFrame.make (Levers.durationGiven60Fps 14) Graphic.AvatarBobLeft
        ]


runningRight : Sprite
runningRight =
    Sprite.animated
        (HeldFrame.make (Levers.durationGiven60Fps 4) Graphic.AvatarAirborneRight)
        [ HeldFrame.make (Levers.durationGiven60Fps 4) Graphic.AvatarStandingRight
        , HeldFrame.make (Levers.durationGiven60Fps 4) Graphic.AvatarHopRight
        , HeldFrame.make (Levers.durationGiven60Fps 4) Graphic.AvatarStandingRight
        ]


runningLeft : Sprite
runningLeft =
    Sprite.animated
        (HeldFrame.make (Levers.durationGiven60Fps 4) Graphic.AvatarAirborneLeft)
        [ HeldFrame.make (Levers.durationGiven60Fps 4) Graphic.AvatarStandingLeft
        , HeldFrame.make (Levers.durationGiven60Fps 4) Graphic.AvatarHopLeft
        , HeldFrame.make (Levers.durationGiven60Fps 4) Graphic.AvatarStandingLeft
        ]


jumpingRight : Sprite
jumpingRight =
    Graphic.AvatarAirborneRight
        |> Sprite.static


jumpingLeft : Sprite
jumpingLeft =
    Graphic.AvatarAirborneLeft
        |> Sprite.static
