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
        |> toTile


dirt : Tile Size8x8
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


grass : Tile Size8x8
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


brick : Tile Size8x8
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


stone : Tile Size8x8
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
        |> toTile


topLeftCurvedSolid : Tile Size8x8
topLeftCurvedSolid =
    topLeftCurvedSolidBitmap
        |> bitmapToTile


topRightCurvedSolid : Tile Size8x8
topRightCurvedSolid =
    topLeftCurvedSolidBitmap
        |> Bitmap.rotateClockwise
        |> bitmapToTile


bottomLeftCurvedSolid : Tile Size8x8
bottomLeftCurvedSolid =
    topLeftCurvedSolidBitmap
        |> Bitmap.rotateCounterClockwise
        |> bitmapToTile


topCurvedSolid : Tile Size8x8
topCurvedSolid =
    topCurvedSolidBitmap
        |> bitmapToTile


rightCurvedSolid : Tile Size8x8
rightCurvedSolid =
    topCurvedSolidBitmap
        |> Bitmap.rotateClockwise
        |> bitmapToTile


pillarMiddle : Tile Size8x8
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


pillarTop : Tile Size8x8
pillarTop =
    pillarTopBitmap
        |> bitmapToTile


pillarBottom : Tile Size8x8
pillarBottom =
    pillarTopBitmap
        |> Bitmap.flipY
        |> bitmapToTile


bush : Tile Size8x8
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


doorTop : Tile Size8x8
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


doorBottom : Tile Size8x8
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


bitmapToTile : Bitmap Size8x8 -> Tile Size8x8
bitmapToTile =
    Tile.make8x8 >> Maybe.withDefault Tile.error8x8


toTile : String -> Tile Size8x8
toTile string =
    string
        |> Bitmap.fromString8x8 Color.defaultMap
        |> Maybe.withDefault Bitmap.error8x8
        |> bitmapToTile
