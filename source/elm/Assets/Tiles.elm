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


bottomLeftSlant : Tile Size8x8
bottomLeftSlant =
    bottomLeftSlantBitmap
        |> toTile


bottomRightSlant : Tile Size8x8
bottomRightSlant =
    bottomLeftSlantBitmap
        |> Bitmap.rotateCounterClockwise
        |> toTile


topLeftSlant : Tile Size8x8
topLeftSlant =
    bottomLeftSlantBitmap
        |> Bitmap.rotateClockwise
        |> toTile


topRightSlant : Tile Size8x8
topRightSlant =
    bottomLeftSlantBitmap
        |> Bitmap.rotate180
        |> toTile



-- PRIVATE


bottomLeftSlantBitmap : Bitmap
bottomLeftSlantBitmap =
    """
█ . . . . . . .
█ █ . . . . . .
█ █ █ . . . . .
█ █ █ █ . . . .
█ █ █ █ █ . . .
█ █ █ █ █ █ . .
█ █ █ █ █ █ █ .
█ █ █ █ █ █ █ █
"""
        |> Bitmap.fromString Color.defaultMap
        |> Maybe.withDefault Bitmap.error


toTile : Bitmap -> Tile Size8x8
toTile =
    Tile.make8x8 >> Maybe.withDefault Tile.error8x8
