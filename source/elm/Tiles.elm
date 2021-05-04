module Tiles exposing (..)

import Bitmap exposing (Bitmap)


empty : Bitmap
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
        |> Bitmap.fromString


solid : Bitmap
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
        |> Bitmap.fromString


bottomLeftSlant : Bitmap
bottomLeftSlant =
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
        |> Bitmap.fromString


bottomRightSlant : Bitmap
bottomRightSlant =
    bottomLeftSlant
        |> Bitmap.rotateCounterClockwise


topLeftSlant : Bitmap
topLeftSlant =
    bottomLeftSlant
        |> Bitmap.rotateClockwise


topRightSlant : Bitmap
topRightSlant =
    bottomLeftSlant
        |> Bitmap.rotate180
