module Graphic exposing
    ( Graphic(..)
    , bitmap
    , empty8x8
    , error8x8
    , height
    , width
    )

import Assets.Tiles as Tiles
import Bitmap exposing (Bitmap)
import Bitmap.Color exposing (Color(..))
import Size exposing (Size8x8)


type Graphic
    = Empty
    | Solid
    | Error
    | Dirt
    | Grass
    | Brick
    | Stone
    | Hollow
    | TopLeftCurvedSolid
    | TopRightCurvedSolid
    | BottomLeftCurvedSolid
    | TopCurvedSolid
    | RightCurvedSolid
    | PillarMiddle
    | PillarTop
    | PillarBottom
    | Bush
    | DoorTop
    | DoorBottom


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
            Tiles.empty

        Solid ->
            Tiles.solid

        Error ->
            Bitmap.error8x8

        Dirt ->
            Tiles.dirt

        Grass ->
            Tiles.grass

        Brick ->
            Tiles.brick

        Stone ->
            Tiles.stone

        Hollow ->
            Tiles.hollow

        TopLeftCurvedSolid ->
            Tiles.topLeftCurvedSolid

        TopRightCurvedSolid ->
            Tiles.topRightCurvedSolid

        BottomLeftCurvedSolid ->
            Tiles.bottomLeftCurvedSolid

        TopCurvedSolid ->
            Tiles.topCurvedSolid

        RightCurvedSolid ->
            Tiles.rightCurvedSolid

        PillarMiddle ->
            Tiles.pillarMiddle

        PillarTop ->
            Tiles.pillarTop

        PillarBottom ->
            Tiles.pillarBottom

        Bush ->
            Tiles.bush

        DoorTop ->
            Tiles.doorTop

        DoorBottom ->
            Tiles.doorBottom


width : Graphic -> Int
width tile =
    bitmap tile
        |> Bitmap.width


height : Graphic -> Int
height tile =
    bitmap tile
        |> Bitmap.height
