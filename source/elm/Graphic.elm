module Graphic exposing
    ( Graphic(..)
    , bitmap
    , empty8x8
    , error8x8
    , height
    , width
    )

import Assets.Bitmaps as Bitmaps
import Bitmap exposing (Bitmap)
import Bitmap.Color exposing (Color(..))
import Size exposing (Size8x8)


type Graphic
    = Empty
    | Solid
    | Error
    | TileDirt
    | TileGrass
    | TileBrick
    | TileStone
    | TileHollow
    | TileTopLeftCurvedSolid
    | TileTopRightCurvedSolid
    | TileBottomLeftCurvedSolid
    | TileTopCurvedSolid
    | TileRightCurvedSolid
    | TilePillarMiddle
    | TilePillarTop
    | TilePillarBottom
    | TileBush
    | TileDoorTop
    | TileDoorBottom
    | AvatarAirborneRight
    | AvatarAirborneLeft
    | AvatarHopRight
    | AvatarHopLeft
    | AvatarStandingRight
    | AvatarStandingLeft
    | AvatarBobRight
    | AvatarBobLeft


empty8x8 : Graphic
empty8x8 =
    Empty


error8x8 : Graphic
error8x8 =
    Error



-- ACCESSORS


bitmap : Graphic -> Bitmap Size8x8
bitmap tile =
    case tile of
        Empty ->
            Bitmaps.empty

        Solid ->
            Bitmaps.solid

        Error ->
            Bitmaps.error

        TileDirt ->
            Bitmaps.tileDirt

        TileGrass ->
            Bitmaps.tileGrass

        TileBrick ->
            Bitmaps.tileBrick

        TileStone ->
            Bitmaps.tileStone

        TileHollow ->
            Bitmaps.tileHollow

        TileTopLeftCurvedSolid ->
            Bitmaps.tileTopLeftCurvedSolid

        TileTopRightCurvedSolid ->
            Bitmaps.tileTopRightCurvedSolid

        TileBottomLeftCurvedSolid ->
            Bitmaps.tileBottomLeftCurvedSolid

        TileTopCurvedSolid ->
            Bitmaps.tileTopCurvedSolid

        TileRightCurvedSolid ->
            Bitmaps.tileRightCurvedSolid

        TilePillarMiddle ->
            Bitmaps.tilePillarMiddle

        TilePillarTop ->
            Bitmaps.tilePillarTop

        TilePillarBottom ->
            Bitmaps.tilePillarBottom

        TileBush ->
            Bitmaps.tileBush

        TileDoorTop ->
            Bitmaps.tileDoorTop

        TileDoorBottom ->
            Bitmaps.tileDoorBottom

        AvatarAirborneRight ->
            Bitmaps.avatarAirborneRight

        AvatarAirborneLeft ->
            Bitmaps.avatarAirborneLeft

        AvatarHopRight ->
            Bitmaps.avatarHopRight

        AvatarHopLeft ->
            Bitmaps.avatarHopLeft

        AvatarStandingRight ->
            Bitmaps.avatarStandingRight

        AvatarStandingLeft ->
            Bitmaps.avatarStandingLeft

        AvatarBobRight ->
            Bitmaps.avatarBobRight

        AvatarBobLeft ->
            Bitmaps.avatarBobLeft


width : Graphic -> Int
width tile =
    bitmap tile
        |> Bitmap.width


height : Graphic -> Int
height tile =
    bitmap tile
        |> Bitmap.height
