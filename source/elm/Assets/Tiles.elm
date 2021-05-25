module Assets.Tiles exposing (..)

import Bitmap exposing (Bitmap)
import Bitmap.Color as Color
import Size exposing (Size8x8)
import Tile exposing (Tile)


empty : Tile Size8x8
empty =
    """
    . . . . . . . .
    . . . . . . . .
    . . . . . . . .
    . . . . . . . .
    . . . . . . . .
    . . . . . . . .
    . . . . . . . .
    . . . . . . . .
    """
        |> Bitmap.fromString Color.defaultMap
        |> Maybe.withDefault Bitmap.error
        |> toTile


solid : Tile Size8x8
solid =
    """
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    """
        |> Bitmap.fromString Color.defaultMap
        |> Maybe.withDefault Bitmap.error
        |> toTile


hollow : Tile Size8x8
hollow =
    """
    . █ █ █ █ █ █ .
    █ . . . . . . █
    █ . . . . . . █
    █ . . . . . . █
    █ . . . . . . █
    █ . . . . . . █
    █ . . . . . . █
    . █ █ █ █ █ █ .
    """
        |> Bitmap.fromString Color.defaultMap
        |> Maybe.withDefault Bitmap.error
        |> toTile


topLeftCurvedSolid : Tile Size8x8
topLeftCurvedSolid =
    topLeftCurvedSolidBitmap
        |> toTile


topRightCurvedSolid : Tile Size8x8
topRightCurvedSolid =
    topLeftCurvedSolidBitmap
        |> Bitmap.rotateClockwise
        |> toTile


bottomLeftCurvedSolid : Tile Size8x8
bottomLeftCurvedSolid =
    topLeftCurvedSolidBitmap
        |> Bitmap.rotateCounterClockwise
        |> toTile


topCurvedSolid : Tile Size8x8
topCurvedSolid =
    topCurvedSolidBitmap
        |> toTile


rightCurvedSolid : Tile Size8x8
rightCurvedSolid =
    topCurvedSolidBitmap
        |> Bitmap.rotateClockwise
        |> toTile



-- PRIVATE


topLeftCurvedSolidBitmap : Bitmap
topLeftCurvedSolidBitmap =
    """
    . █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    """
        |> Bitmap.fromString Color.defaultMap
        |> Maybe.withDefault Bitmap.error


topCurvedSolidBitmap : Bitmap
topCurvedSolidBitmap =
    """
    . █ █ █ █ █ █ .
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    """
        |> Bitmap.fromString Color.defaultMap
        |> Maybe.withDefault Bitmap.error


toTile : Bitmap -> Tile Size8x8
toTile =
    Tile.make8x8 >> Maybe.withDefault Tile.error8x8
