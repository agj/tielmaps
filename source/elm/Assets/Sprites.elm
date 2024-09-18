module Assets.Sprites exposing (avatarSprites, jumpingLeft, runningLeft, standingLeft)

import Avatar.AvatarSprites exposing (AvatarSprites)
import Bitmap exposing (Bitmap)
import Bitmap.Color as Color
import Size exposing (Size8x8)
import Sprite exposing (Sprite)
import Sprite.Frame as Frame exposing (Frame)
import Tile exposing (Tile)


avatarSprites : AvatarSprites Size8x8
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


standingRight : Sprite Size8x8
standingRight =
    Sprite.animated
        (frame 7 pictures.standing)
        [ frame 7 pictures.bob
        ]


standingLeft : Sprite Size8x8
standingLeft =
    Sprite.animated
        (frame 7 (Bitmap.flipX pictures.standing))
        [ frame 7 (Bitmap.flipX pictures.bob)
        ]


runningRight : Sprite Size8x8
runningRight =
    Sprite.animated
        (frame 4 pictures.airborne)
        [ frame 4 pictures.standing
        , frame 4 pictures.hop
        , frame 4 pictures.standing
        ]


runningLeft : Sprite Size8x8
runningLeft =
    Sprite.animated
        (frame 4 (Bitmap.flipX pictures.airborne))
        [ frame 4 (Bitmap.flipX pictures.standing)
        , frame 4 (Bitmap.flipX pictures.hop)
        , frame 4 (Bitmap.flipX pictures.standing)
        ]


jumpingRight : Sprite Size8x8
jumpingRight =
    pictures.airborne
        |> toTile
        |> Sprite.static


jumpingLeft : Sprite Size8x8
jumpingLeft =
    pictures.airborne
        |> Bitmap.flipX
        |> toTile
        |> Sprite.static


frame : Int -> Bitmap Size8x8 -> Frame Size8x8
frame n bm =
    bm
        |> toTile
        |> Frame.make n


toBitmap : String -> Bitmap Size8x8
toBitmap str =
    str
        |> Bitmap.fromString8x8 Color.defaultMap
        |> Maybe.withDefault Bitmap.error8x8


toTile : Bitmap Size8x8 -> Tile Size8x8
toTile =
    Tile.make8x8 >> Maybe.withDefault Tile.error8x8
