module Tile exposing
    ( Tile(..)
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


type Tile
    = TileEmpty
    | TileSolid
    | TileError
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


empty8x8 : Tile
empty8x8 =
    TileEmpty


error8x8 : Tile
error8x8 =
    TileError



-- ACCESSORS


bitmap : Tile -> Bitmap Size8x8
bitmap tile =
    case tile of
        TileEmpty ->
            Tiles.empty

        TileSolid ->
            Tiles.solid

        TileError ->
            Bitmap.error8x8

        TileDirt ->
            Tiles.dirt

        TileGrass ->
            Tiles.grass

        TileBrick ->
            Tiles.brick

        TileStone ->
            Tiles.stone

        TileHollow ->
            Tiles.hollow

        TileTopLeftCurvedSolid ->
            Tiles.topLeftCurvedSolid

        TileTopRightCurvedSolid ->
            Tiles.topRightCurvedSolid

        TileBottomLeftCurvedSolid ->
            Tiles.bottomLeftCurvedSolid

        TileTopCurvedSolid ->
            Tiles.topCurvedSolid

        TileRightCurvedSolid ->
            Tiles.rightCurvedSolid

        TilePillarMiddle ->
            Tiles.pillarMiddle

        TilePillarTop ->
            Tiles.pillarTop

        TilePillarBottom ->
            Tiles.pillarBottom

        TileBush ->
            Tiles.bush

        TileDoorTop ->
            Tiles.doorTop

        TileDoorBottom ->
            Tiles.doorBottom


width : Tile -> Int
width tile =
    bitmap tile
        |> Bitmap.width


height : Tile -> Int
height tile =
    bitmap tile
        |> Bitmap.height
