module Assets.Sprites exposing (avatarSprites, jumpingLeft, runningLeft, standingLeft)

import Avatar.AvatarSprites exposing (AvatarSprites)
import Bitmap exposing (Bitmap)
import Bitmap.Color as Color
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


pictures =
    { airborne =
        toBitmap
            """
            █ █ █ █ █ █ █ █
            █ . . . . . . █
            █ . . █ . █ . █
            █ . . . . . . █
            █ █ █ █ █ █ █ █
            / █ / / █ █ / /
            █ █ / / / / █ /
            / / / / / / / /
            """
    , hop =
        toBitmap
            """
            █ █ █ █ █ █ █ █
            █ . . . . . . █
            █ . . █ . █ . █
            █ . . . . . . █
            █ █ █ █ █ █ █ █
            / / █ / █ / / /
            / / █ █ / / / /
            / / / / / / / /
            """
    , standing =
        toBitmap
            """
            / / / / / / / /
            █ █ █ █ █ █ █ █
            █ . . . . . . █
            █ . . █ . █ . █
            █ . . . . . . █
            █ █ █ █ █ █ █ █
            / █ / / / █ / /
            / █ / / / █ / /
            """
    , bob =
        toBitmap
            """
            █ █ █ █ █ █ █ █
            █ . . . . . . █
            █ . . █ . █ . █
            █ . . . . . . █
            █ █ █ █ █ █ █ █
            / █ / / / █ / /
            / █ / / / █ / /
            / █ / / / █ / /
            """
    }


standingRight : Sprite
standingRight =
    Sprite.animated
        (frame 7 pictures.standing)
        [ frame 7 pictures.bob
        ]


standingLeft : Sprite
standingLeft =
    Sprite.animated
        (frame 7 (Bitmap.flipX pictures.standing))
        [ frame 7 (Bitmap.flipX pictures.bob)
        ]


runningRight : Sprite
runningRight =
    Sprite.animated
        (frame 4 pictures.airborne)
        [ frame 4 pictures.standing
        , frame 4 pictures.hop
        , frame 4 pictures.standing
        ]


runningLeft : Sprite
runningLeft =
    Sprite.animated
        (frame 4 (Bitmap.flipX pictures.airborne))
        [ frame 4 (Bitmap.flipX pictures.standing)
        , frame 4 (Bitmap.flipX pictures.hop)
        , frame 4 (Bitmap.flipX pictures.standing)
        ]


jumpingRight : Sprite
jumpingRight =
    pictures.airborne
        |> Sprite.static


jumpingLeft : Sprite
jumpingLeft =
    pictures.airborne
        |> Bitmap.flipX
        |> Sprite.static


frame : Int -> Bitmap Size8x8 -> HeldFrame
frame n bm =
    bm
        |> Frame.make n


toBitmap : String -> Bitmap Size8x8
toBitmap str =
    str
        |> Bitmap.fromString8x8 Color.defaultMap
        |> Maybe.withDefault Bitmap.error8x8
