module Assets.Sprites exposing (..)

import Bitmap exposing (Bitmap)
import Size exposing (Size8x8)
import Sprite exposing (Sprite)
import Sprite.Frame as Frame exposing (Frame)
import Tile exposing (Tile)


runningCharacter : Sprite Size8x8
runningCharacter =
    Sprite.animated
        ("""
    █ █ █ █ █ █ █ █
    █ . . . . . . █
    █ . . █ . █ . █
    █ . . . . . . █
    █ █ █ █ █ █ █ █
    . █ . . █ █ . .
    █ █ . . . . █ .
    . . . . . . . .
    """
            |> frame 2
        )
        [ """
    . . . . . . . .
    █ █ █ █ █ █ █ █
    █ . . . . . . █
    █ . . █ . █ . █
    █ . . . . . . █
    █ █ █ █ █ █ █ █
    . █ . . . █ . .
    . █ . . . █ . .
    """
            |> frame 1
        , """
    █ █ █ █ █ █ █ █
    █ . . . . . . █
    █ . . █ . █ . █
    █ . . . . . . █
    █ █ █ █ █ █ █ █
    . . █ . █ . . .
    . . █ █ . . . .
    . . . . . . . .
    """
            |> frame 2
        , """
    . . . . . . . .
    █ █ █ █ █ █ █ █
    █ . . . . . . █
    █ . . █ . █ . █
    █ . . . . . . █
    █ █ █ █ █ █ █ █
    . █ . . . █ . .
    . █ . . . █ . .
    """
            |> frame 1
        ]



-- INTERNAL


frame : Int -> String -> Frame Size8x8
frame n str =
    str
        |> Bitmap.fromString
        |> toTile
        |> Frame.make n


toTile : Bitmap -> Tile Size8x8
toTile =
    Tile.make8x8 >> Maybe.withDefault Tile.error8x8
