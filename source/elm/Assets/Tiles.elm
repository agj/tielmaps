module Assets.Tiles exposing
    ( bottomLeftCurvedSolid
    , brick
    , bush
    , dirt
    , doorBottom
    , doorTop
    , empty
    , grass
    , hollow
    , pillarBottom
    , pillarMiddle
    , pillarTop
    , rightCurvedSolid
    , solid
    , stone
    , topCurvedSolid
    , topLeftCurvedSolid
    , topRightCurvedSolid
    )

import Bitmap exposing (Bitmap)
import Bitmap.Color as Color
import Size exposing (Size8x8)


empty : Bitmap Size8x8
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
        |> toTile


solid : Bitmap Size8x8
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
        |> toTile


dirt : Bitmap Size8x8
dirt =
    """
    █ █ █ █ █ █ . █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    █ █ █ █ . █ █ █
    █ █ █ . . . █ █
    █ . █ █ . █ █ █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    """
        |> toTile


grass : Bitmap Size8x8
grass =
    """
    . █ █ . . █ █ .
    █ . . █ █ . . █
    . . . . █ . . █
    █ . . . . . . .
    . . . █ . . . █
    █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █
    █ . █ █ █ . █ █
    """
        |> toTile


brick : Bitmap Size8x8
brick =
    """
    █ █ . █ █ █ . █
    █ █ . █ █ █ . █
    █ █ . █ █ █ . █
    . . . . . . . .
    . █ █ █ . █ █ █
    . █ █ █ . █ █ █
    . █ █ █ . █ █ █
    . . . . . . . .
    """
        |> toTile


stone : Bitmap Size8x8
stone =
    """
    █ █ █ █ █ █ █ █
    █ . . . . . . █
    █ . █ █ █ █ . █
    █ . █ █ █ █ . █
    █ . █ █ . █ . █
    █ . █ █ . █ . █
    █ . . . . █ . █
    █ █ █ █ █ █ █ █
    """
        |> toTile


hollow : Bitmap Size8x8
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
        |> toTile


topLeftCurvedSolid : Bitmap Size8x8
topLeftCurvedSolid =
    topLeftCurvedSolidBitmap


topRightCurvedSolid : Bitmap Size8x8
topRightCurvedSolid =
    topLeftCurvedSolidBitmap
        |> Bitmap.rotateClockwise


bottomLeftCurvedSolid : Bitmap Size8x8
bottomLeftCurvedSolid =
    topLeftCurvedSolidBitmap
        |> Bitmap.rotateCounterClockwise


topCurvedSolid : Bitmap Size8x8
topCurvedSolid =
    topCurvedSolidBitmap


rightCurvedSolid : Bitmap Size8x8
rightCurvedSolid =
    topCurvedSolidBitmap
        |> Bitmap.rotateClockwise


pillarMiddle : Bitmap Size8x8
pillarMiddle =
    """
    . █ . . . . █ .
    . █ . . . . █ .
    . █ . . . . █ .
    . █ . . . . █ .
    . █ . . . . █ .
    . █ . . . . █ .
    . █ . . . . █ .
    . █ . . . . █ .
    """
        |> toTile


pillarTop : Bitmap Size8x8
pillarTop =
    pillarTopBitmap


pillarBottom : Bitmap Size8x8
pillarBottom =
    pillarTopBitmap
        |> Bitmap.flipY


bush : Bitmap Size8x8
bush =
    """
    . . . . . . . .
    . . . . . . . .
    . . █ █ █ █ . .
    . █ . . . . █ .
    █ . . . . █ . █
    █ . . . . . . █
    █ . . █ . . . █
    . █ . . . . █ .
    """
        |> toTile


doorTop : Bitmap Size8x8
doorTop =
    """
    . . . . . . . .
    . . . . . . . .
    . . . . . . . .
    . █ . █ █ . █ .
    █ . █ █ █ █ . █
    . █ . . . . █ .
    █ █ . . . . █ █
    . █ . . . . █ .
    """
        |> toTile


doorBottom : Bitmap Size8x8
doorBottom =
    """
    █ █ . . . . █ █
    . █ . . . . █ .
    █ █ . . █ █ █ █
    . █ . . █ █ █ .
    █ █ . . . . █ █
    . █ . . . . █ .
    █ █ . . . . █ █
    . █ . . . . █ .
    """
        |> toTile



-- PRIVATE


topLeftCurvedSolidBitmap : Bitmap Size8x8
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
        |> Bitmap.fromString8x8 Color.defaultMap
        |> Maybe.withDefault Bitmap.error8x8


topCurvedSolidBitmap : Bitmap Size8x8
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
        |> Bitmap.fromString8x8 Color.defaultMap
        |> Maybe.withDefault Bitmap.error8x8


pillarTopBitmap : Bitmap Size8x8
pillarTopBitmap =
    """
    █ . . . . . . █
    . █ █ █ █ █ █ .
    . █ . . . . █ .
    . █ . . . . █ .
    . █ . . . . █ .
    . █ . . . . █ .
    . █ . . . . █ .
    . █ . . . . █ .
    """
        |> Bitmap.fromString8x8 Color.defaultMap
        |> Maybe.withDefault Bitmap.error8x8


toTile : String -> Bitmap Size8x8
toTile string =
    string
        |> Bitmap.fromString8x8 Color.defaultMap
        |> Maybe.withDefault Bitmap.error8x8
