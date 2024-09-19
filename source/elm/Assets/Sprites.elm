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
        (HeldFrame.make (Levers.durationGiven60Fps 14) Graphic.avatarStandingRight)
        [ HeldFrame.make (Levers.durationGiven60Fps 14) Graphic.avatarBobRight
        ]


standingLeft : Sprite
standingLeft =
    Sprite.animated
        (HeldFrame.make (Levers.durationGiven60Fps 14) Graphic.avatarStandingLeft)
        [ HeldFrame.make (Levers.durationGiven60Fps 14) Graphic.avatarBobLeft
        ]


runningRight : Sprite
runningRight =
    Sprite.animated
        (HeldFrame.make (Levers.durationGiven60Fps 4) Graphic.avatarAirborneRight)
        [ HeldFrame.make (Levers.durationGiven60Fps 4) Graphic.avatarStandingRight
        , HeldFrame.make (Levers.durationGiven60Fps 4) Graphic.avatarHopRight
        , HeldFrame.make (Levers.durationGiven60Fps 4) Graphic.avatarStandingRight
        ]


runningLeft : Sprite
runningLeft =
    Sprite.animated
        (HeldFrame.make (Levers.durationGiven60Fps 4) Graphic.avatarAirborneLeft)
        [ HeldFrame.make (Levers.durationGiven60Fps 4) Graphic.avatarStandingLeft
        , HeldFrame.make (Levers.durationGiven60Fps 4) Graphic.avatarHopLeft
        , HeldFrame.make (Levers.durationGiven60Fps 4) Graphic.avatarStandingLeft
        ]


jumpingRight : Sprite
jumpingRight =
    Graphic.avatarAirborneRight
        |> Sprite.static


jumpingLeft : Sprite
jumpingLeft =
    Graphic.avatarAirborneLeft
        |> Sprite.static
