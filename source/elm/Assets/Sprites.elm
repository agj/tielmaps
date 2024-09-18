module Assets.Sprites exposing (avatarSprites)

import Assets.Frames as Frames
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
        (frame 7 Frames.standing)
        [ frame 7 Frames.bob
        ]


standingLeft : Sprite
standingLeft =
    Sprite.animated
        (frame 7 (Bitmap.flipX Frames.standing))
        [ frame 7 (Bitmap.flipX Frames.bob)
        ]


runningRight : Sprite
runningRight =
    Sprite.animated
        (frame 4 Frames.airborne)
        [ frame 4 Frames.standing
        , frame 4 Frames.hop
        , frame 4 Frames.standing
        ]


runningLeft : Sprite
runningLeft =
    Sprite.animated
        (frame 4 (Bitmap.flipX Frames.airborne))
        [ frame 4 (Bitmap.flipX Frames.standing)
        , frame 4 (Bitmap.flipX Frames.hop)
        , frame 4 (Bitmap.flipX Frames.standing)
        ]


jumpingRight : Sprite
jumpingRight =
    Frames.airborne
        |> Sprite.static


jumpingLeft : Sprite
jumpingLeft =
    Frames.airborne
        |> Bitmap.flipX
        |> Sprite.static


frame : Int -> Bitmap Size8x8 -> HeldFrame
frame n bm =
    bm
        |> Frame.make n
