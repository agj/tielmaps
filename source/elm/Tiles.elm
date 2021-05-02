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
# # # # # # # #
# # # # # # # #
# # # # # # # #
# # # # # # # #
# # # # # # # #
# # # # # # # #
# # # # # # # #
# # # # # # # #
"""
        |> Bitmap.fromString


bottomLeftSlant : Bitmap
bottomLeftSlant =
    """
# . . . . . . .
# # . . . . . .
# # # . . . . .
# # # # . . . .
# # # # # . . .
# # # # # # . .
# # # # # # # .
# # # # # # # #
"""
        |> Bitmap.fromString
