module Graphic exposing
    ( Graphic(..)
    , all
    , avatarAirborneLeft
    , avatarAirborneRight
    , avatarBobLeft
    , avatarBobRight
    , avatarHopLeft
    , avatarHopRight
    , avatarStandingLeft
    , avatarStandingRight
    , bitmap
    , empty
    , error
    , index
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

import Assets.Bitmaps as Bitmaps
import Bitmap exposing (Bitmap)
import Dict exposing (Dict)
import Dict.Extra
import Size exposing (Size8x8)


type Graphic
    = Graphic Int


all : List Graphic
all =
    indexBitmapDict
        |> Dict.keys
        |> List.map Graphic


index : Graphic -> Int
index (Graphic index_) =
    index_


bitmap : Graphic -> Bitmap Size8x8
bitmap (Graphic index_) =
    indexBitmapDict
        |> Dict.get index_
        |> Maybe.withDefault Bitmaps.error



-- GRAPHICS


error : Graphic
error =
    Graphic 0


empty : Graphic
empty =
    getGraphicForBitmap Bitmaps.empty


solid : Graphic
solid =
    getGraphicForBitmap Bitmaps.solid


tileDirt : Graphic
tileDirt =
    getGraphicForBitmap Bitmaps.tileDirt


tileGrass : Graphic
tileGrass =
    getGraphicForBitmap Bitmaps.tileGrass


tileBrick : Graphic
tileBrick =
    getGraphicForBitmap Bitmaps.tileBrick


tileStone : Graphic
tileStone =
    getGraphicForBitmap Bitmaps.tileStone


tileHollow : Graphic
tileHollow =
    getGraphicForBitmap Bitmaps.tileHollow


tileTopLeftCurvedSolid : Graphic
tileTopLeftCurvedSolid =
    getGraphicForBitmap Bitmaps.tileTopLeftCurvedSolid


tileTopRightCurvedSolid : Graphic
tileTopRightCurvedSolid =
    getGraphicForBitmap Bitmaps.tileTopRightCurvedSolid


tileBottomLeftCurvedSolid : Graphic
tileBottomLeftCurvedSolid =
    getGraphicForBitmap Bitmaps.tileBottomLeftCurvedSolid


tileTopCurvedSolid : Graphic
tileTopCurvedSolid =
    getGraphicForBitmap Bitmaps.tileTopCurvedSolid


tileRightCurvedSolid : Graphic
tileRightCurvedSolid =
    getGraphicForBitmap Bitmaps.tileRightCurvedSolid


tilePillarMiddle : Graphic
tilePillarMiddle =
    getGraphicForBitmap Bitmaps.tilePillarMiddle


tilePillarTop : Graphic
tilePillarTop =
    getGraphicForBitmap Bitmaps.tilePillarTop


tilePillarBottom : Graphic
tilePillarBottom =
    getGraphicForBitmap Bitmaps.tilePillarBottom


tileBush : Graphic
tileBush =
    getGraphicForBitmap Bitmaps.tileBush


tileDoorTop : Graphic
tileDoorTop =
    getGraphicForBitmap Bitmaps.tileDoorTop


tileDoorBottom : Graphic
tileDoorBottom =
    getGraphicForBitmap Bitmaps.tileDoorBottom


avatarAirborneRight : Graphic
avatarAirborneRight =
    getGraphicForBitmap Bitmaps.avatarAirborneRight


avatarAirborneLeft : Graphic
avatarAirborneLeft =
    getGraphicForBitmap Bitmaps.avatarAirborneLeft


avatarHopRight : Graphic
avatarHopRight =
    getGraphicForBitmap Bitmaps.avatarHopRight


avatarHopLeft : Graphic
avatarHopLeft =
    getGraphicForBitmap Bitmaps.avatarHopLeft


avatarStandingRight : Graphic
avatarStandingRight =
    getGraphicForBitmap Bitmaps.avatarStandingRight


avatarStandingLeft : Graphic
avatarStandingLeft =
    getGraphicForBitmap Bitmaps.avatarStandingLeft


avatarBobRight : Graphic
avatarBobRight =
    getGraphicForBitmap Bitmaps.avatarBobRight


avatarBobLeft : Graphic
avatarBobLeft =
    getGraphicForBitmap Bitmaps.avatarBobLeft



-- INTERNAL


getGraphicForBitmap : Bitmap Size8x8 -> Graphic
getGraphicForBitmap bitmap_ =
    indexBitmapDict
        |> Dict.Extra.find (\_ bm -> bm == bitmap_)
        |> Maybe.map Tuple.first
        |> Maybe.withDefault 0
        |> Graphic


indexBitmapDict : Dict Int (Bitmap Size8x8)
indexBitmapDict =
    [ Bitmaps.error
    , Bitmaps.empty
    , Bitmaps.solid
    , Bitmaps.tileDirt
    , Bitmaps.tileGrass
    , Bitmaps.tileBrick
    , Bitmaps.tileStone
    , Bitmaps.tileHollow
    , Bitmaps.tileTopLeftCurvedSolid
    , Bitmaps.tileTopRightCurvedSolid
    , Bitmaps.tileBottomLeftCurvedSolid
    , Bitmaps.tileTopCurvedSolid
    , Bitmaps.tileRightCurvedSolid
    , Bitmaps.tilePillarMiddle
    , Bitmaps.tilePillarTop
    , Bitmaps.tilePillarBottom
    , Bitmaps.tileBush
    , Bitmaps.tileDoorTop
    , Bitmaps.tileDoorBottom
    , Bitmaps.avatarAirborneRight
    , Bitmaps.avatarAirborneLeft
    , Bitmaps.avatarHopRight
    , Bitmaps.avatarHopLeft
    , Bitmaps.avatarStandingRight
    , Bitmaps.avatarStandingLeft
    , Bitmaps.avatarBobRight
    , Bitmaps.avatarBobLeft
    ]
        |> List.indexedMap Tuple.pair
        |> Dict.fromList
