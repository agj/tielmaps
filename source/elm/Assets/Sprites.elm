module Assets.Sprites exposing (avatarSprites)

import Avatar.AvatarSprites exposing (AvatarSprites)
import Bitmap exposing (Bitmap)
import Bitmap.Color as Color
import Size exposing (Size8x8)
import Sprite exposing (Sprite)
import Sprite.Frame as Frame exposing (Frame)
import Tile exposing (Tile)


avatarSprites : AvatarSprites Size8x8
avatarSprites =
    { runningRight = runningCharacter
    , runningLeft = runningCharacter
    , standing = standingCharacter
    , jumping = jumpingCharacter
    }



-- INTERNAL


runningCharacter : Sprite Size8x8
runningCharacter =
    Sprite.animated
        ("""
        █ █ █ █ █ █ █ █
        █ . . . . . . █
        █ . . █ . █ . █
        █ . . . . . . █
        █ █ █ █ █ █ █ █
        / █ / / █ █ / /
        █ █ / / / / █ /
        / / / / / / / /
        """
            |> frame 4
        )
        [ """
        / / / / / / / /
        █ █ █ █ █ █ █ █
        █ . . . . . . █
        █ . . █ . █ . █
        █ . . . . . . █
        █ █ █ █ █ █ █ █
        / █ / / / █ / /
        / █ / / / █ / /
        """
            |> frame 4
        , """
        █ █ █ █ █ █ █ █
        █ . . . . . . █
        █ . . █ . █ . █
        █ . . . . . . █
        █ █ █ █ █ █ █ █
        / / █ / █ / / /
        / / █ █ / / / /
        / / / / / / / /
        """
            |> frame 4
        , """
        / / / / / / / /
        █ █ █ █ █ █ █ █
        █ . . . . . . █
        █ . . █ . █ . █
        █ . . . . . . █
        █ █ █ █ █ █ █ █
        / █ / / / █ / /
        / █ / / / █ / /
        """
            |> frame 4
        ]


standingCharacter : Sprite Size8x8
standingCharacter =
    Sprite.animated
        ("""
        / / / / / / / /
        █ █ █ █ █ █ █ █
        █ . . . . . . █
        █ . . █ . █ . █
        █ . . . . . . █
        █ █ █ █ █ █ █ █
        / █ / / / █ / /
        / █ / / / █ / /
        """
            |> frame 15
        )
        [ """
        █ █ █ █ █ █ █ █
        █ . . . . . . █
        █ . . █ . █ . █
        █ . . . . . . █
        █ █ █ █ █ █ █ █
        / █ / / / █ / /
        / █ / / / █ / /
        / █ / / / █ / /
        """
            |> frame 15
        ]


jumpingCharacter : Sprite Size8x8
jumpingCharacter =
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
        |> Bitmap.fromString Color.defaultMap
        |> Maybe.map toTile
        |> Maybe.withDefault Tile.error8x8
        |> Sprite.static


frame : Int -> String -> Frame Size8x8
frame n str =
    str
        |> Bitmap.fromString Color.defaultMap
        |> Maybe.map toTile
        |> Maybe.withDefault Tile.error8x8
        |> Frame.make n


toTile : Bitmap -> Tile Size8x8
toTile =
    Tile.make8x8 >> Maybe.withDefault Tile.error8x8
