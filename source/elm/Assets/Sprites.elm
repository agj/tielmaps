module Assets.Sprites exposing (avatarSprites)

import Avatar.AvatarSprites exposing (AvatarSprites)
import Graphic
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
        (HeldFrame.make 7 Graphic.AvatarStandingRight)
        [ HeldFrame.make 7 Graphic.AvatarBobRight
        ]


standingLeft : Sprite
standingLeft =
    Sprite.animated
        (HeldFrame.make 7 Graphic.AvatarStandingLeft)
        [ HeldFrame.make 7 Graphic.AvatarBobLeft
        ]


runningRight : Sprite
runningRight =
    Sprite.animated
        (HeldFrame.make 4 Graphic.AvatarAirborneRight)
        [ HeldFrame.make 4 Graphic.AvatarStandingRight
        , HeldFrame.make 4 Graphic.AvatarHopRight
        , HeldFrame.make 4 Graphic.AvatarStandingRight
        ]


runningLeft : Sprite
runningLeft =
    Sprite.animated
        (HeldFrame.make 4 Graphic.AvatarAirborneLeft)
        [ HeldFrame.make 4 Graphic.AvatarStandingLeft
        , HeldFrame.make 4 Graphic.AvatarHopLeft
        , HeldFrame.make 4 Graphic.AvatarStandingLeft
        ]


jumpingRight : Sprite
jumpingRight =
    Graphic.AvatarAirborneRight
        |> Sprite.static


jumpingLeft : Sprite
jumpingLeft =
    Graphic.AvatarAirborneLeft
        |> Sprite.static
