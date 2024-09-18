module Assets.Bitmaps exposing
    ( avatarAirborneLeft
    , avatarAirborneRight
    , avatarBobLeft
    , avatarHopLeft
    , avatarStandingLeft
    , empty
    , solid
    , tileBottomLeftCurvedSolid
    , tileBrick
    , tileBush
    , tileDirt
    , tileDoorBottom
    , tileDoorTop
    , tileGrass
    , tileHollow
    , tilePillarBottom
    , tilePillarMiddle
    , tilePillarTop
    , tileRightCurvedSolid
    , tileStone
    , tileTopCurvedSolid
    , tileTopLeftCurvedSolid
    , tileTopRightCurvedSolid
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
        |> toBitmap


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
        |> toBitmap



-- AVATAR


avatarAirborneRight =
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
        |> toBitmap


avatarAirborneLeft =
    avatarAirborneRight
        |> Bitmap.flipX


avatarHopRight =
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
        |> toBitmap


avatarHopLeft =
    avatarHopRight
        |> Bitmap.flipX


avatarStandingRight =
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
        |> toBitmap


avatarStandingLeft =
    avatarStandingRight
        |> Bitmap.flipX


avatarBobRight =
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
        |> toBitmap


avatarBobLeft =
    avatarBobRight
        |> Bitmap.flipX



-- TILES


tileDirt : Bitmap Size8x8
tileDirt =
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
        |> toBitmap


tileGrass : Bitmap Size8x8
tileGrass =
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
        |> toBitmap


tileBrick : Bitmap Size8x8
tileBrick =
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
        |> toBitmap


tileStone : Bitmap Size8x8
tileStone =
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
        |> toBitmap


tileHollow : Bitmap Size8x8
tileHollow =
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
        |> toBitmap


tileTopLeftCurvedSolid : Bitmap Size8x8
tileTopLeftCurvedSolid =
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
        |> toBitmap


tileTopRightCurvedSolid : Bitmap Size8x8
tileTopRightCurvedSolid =
    tileTopLeftCurvedSolid
        |> Bitmap.rotateClockwise


tileBottomLeftCurvedSolid : Bitmap Size8x8
tileBottomLeftCurvedSolid =
    tileTopLeftCurvedSolid
        |> Bitmap.rotateCounterClockwise


tileTopCurvedSolid : Bitmap Size8x8
tileTopCurvedSolid =
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
        |> toBitmap


tileRightCurvedSolid : Bitmap Size8x8
tileRightCurvedSolid =
    tileTopCurvedSolid
        |> Bitmap.rotateClockwise


tilePillarMiddle : Bitmap Size8x8
tilePillarMiddle =
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
        |> toBitmap


tilePillarTop : Bitmap Size8x8
tilePillarTop =
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
        |> toBitmap


tilePillarBottom : Bitmap Size8x8
tilePillarBottom =
    tilePillarTop
        |> Bitmap.flipY


tileBush : Bitmap Size8x8
tileBush =
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
        |> toBitmap


tileDoorTop : Bitmap Size8x8
tileDoorTop =
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
        |> toBitmap


tileDoorBottom : Bitmap Size8x8
tileDoorBottom =
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
        |> toBitmap



-- PRIVATE


toBitmap : String -> Bitmap Size8x8
toBitmap string =
    string
        |> Bitmap.fromString8x8 Color.defaultMap
        |> Maybe.withDefault Bitmap.error8x8
