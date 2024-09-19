module Graphic exposing
    ( Graphic
    , all
    , avatarAirborneLeft
    , avatarAirborneRight
    , avatarBobLeft
    , avatarBobRight
    , avatarHopLeft
    , avatarHopRight
    , avatarStandingLeft
    , avatarStandingRight
    , empty
    , error
    , getIndex
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
    , toBitmap
    )

import Assets.Bitmaps as Bitmaps
import Bitmap exposing (Bitmap)
import Dict exposing (Dict)
import Dict.Extra
import Size exposing (Size8x8)


type Graphic
    = Graphic Int


{-| List of all available `Graphic`s.
-}
all : List Graphic
all =
    indexBitmapDict
        |> Dict.keys
        |> List.map Graphic


{-| Gets the index of a `Graphic` in the list of all `Graphic`s available as
`all`.
-}
getIndex : Graphic -> Int
getIndex (Graphic index_) =
    index_


{-| Converts a `Graphic` to a `Bitmap`.
-}
toBitmap : Graphic -> Bitmap Size8x8
toBitmap (Graphic index_) =
    indexBitmapDict
        |> Dict.get index_
        |> Maybe.withDefault Bitmaps.error



-- GRAPHICS


{-| `Graphic` for “error”.
-}
error : Graphic
error =
    Graphic 0


{-| `Graphic` for “empty”.
-}
empty : Graphic
empty =
    getGraphicForBitmap Bitmaps.empty


{-| `Graphic` for “solid”.
-}
solid : Graphic
solid =
    getGraphicForBitmap Bitmaps.solid


{-| `Graphic` for “tileDirt”.
-}
tileDirt : Graphic
tileDirt =
    getGraphicForBitmap Bitmaps.tileDirt


{-| `Graphic` for “tileGrass”.
-}
tileGrass : Graphic
tileGrass =
    getGraphicForBitmap Bitmaps.tileGrass


{-| `Graphic` for “tileBrick”.
-}
tileBrick : Graphic
tileBrick =
    getGraphicForBitmap Bitmaps.tileBrick


{-| `Graphic` for “tileStone”.
-}
tileStone : Graphic
tileStone =
    getGraphicForBitmap Bitmaps.tileStone


{-| `Graphic` for “tileHollow”.
-}
tileHollow : Graphic
tileHollow =
    getGraphicForBitmap Bitmaps.tileHollow


{-| `Graphic` for “tileTopLeftCurvedSolid”.
-}
tileTopLeftCurvedSolid : Graphic
tileTopLeftCurvedSolid =
    getGraphicForBitmap Bitmaps.tileTopLeftCurvedSolid


{-| `Graphic` for “tileTopRightCurvedSolid”.
-}
tileTopRightCurvedSolid : Graphic
tileTopRightCurvedSolid =
    getGraphicForBitmap Bitmaps.tileTopRightCurvedSolid


{-| `Graphic` for “tileBottomLeftCurvedSolid”.
-}
tileBottomLeftCurvedSolid : Graphic
tileBottomLeftCurvedSolid =
    getGraphicForBitmap Bitmaps.tileBottomLeftCurvedSolid


{-| `Graphic` for “tileTopCurvedSolid”.
-}
tileTopCurvedSolid : Graphic
tileTopCurvedSolid =
    getGraphicForBitmap Bitmaps.tileTopCurvedSolid


{-| `Graphic` for “tileRightCurvedSolid”.
-}
tileRightCurvedSolid : Graphic
tileRightCurvedSolid =
    getGraphicForBitmap Bitmaps.tileRightCurvedSolid


{-| `Graphic` for “tilePillarMiddle”.
-}
tilePillarMiddle : Graphic
tilePillarMiddle =
    getGraphicForBitmap Bitmaps.tilePillarMiddle


{-| `Graphic` for “tilePillarTop”.
-}
tilePillarTop : Graphic
tilePillarTop =
    getGraphicForBitmap Bitmaps.tilePillarTop


{-| `Graphic` for “tilePillarBottom”.
-}
tilePillarBottom : Graphic
tilePillarBottom =
    getGraphicForBitmap Bitmaps.tilePillarBottom


{-| `Graphic` for “tileBush”.
-}
tileBush : Graphic
tileBush =
    getGraphicForBitmap Bitmaps.tileBush


{-| `Graphic` for “tileDoorTop”.
-}
tileDoorTop : Graphic
tileDoorTop =
    getGraphicForBitmap Bitmaps.tileDoorTop


{-| `Graphic` for “tileDoorBottom”.
-}
tileDoorBottom : Graphic
tileDoorBottom =
    getGraphicForBitmap Bitmaps.tileDoorBottom


{-| `Graphic` for “avatarAirborneRight”.
-}
avatarAirborneRight : Graphic
avatarAirborneRight =
    getGraphicForBitmap Bitmaps.avatarAirborneRight


{-| `Graphic` for “avatarAirborneLeft”.
-}
avatarAirborneLeft : Graphic
avatarAirborneLeft =
    getGraphicForBitmap Bitmaps.avatarAirborneLeft


{-| `Graphic` for “avatarHopRight”.
-}
avatarHopRight : Graphic
avatarHopRight =
    getGraphicForBitmap Bitmaps.avatarHopRight


{-| `Graphic` for “avatarHopLeft”.
-}
avatarHopLeft : Graphic
avatarHopLeft =
    getGraphicForBitmap Bitmaps.avatarHopLeft


{-| `Graphic` for “avatarStandingRight”.
-}
avatarStandingRight : Graphic
avatarStandingRight =
    getGraphicForBitmap Bitmaps.avatarStandingRight


{-| `Graphic` for “avatarStandingLeft”.
-}
avatarStandingLeft : Graphic
avatarStandingLeft =
    getGraphicForBitmap Bitmaps.avatarStandingLeft


{-| `Graphic` for “avatarBobRight”.
-}
avatarBobRight : Graphic
avatarBobRight =
    getGraphicForBitmap Bitmaps.avatarBobRight


{-| `Graphic` for “avatarBobLeft”.
-}
avatarBobLeft : Graphic
avatarBobLeft =
    getGraphicForBitmap Bitmaps.avatarBobLeft



-- INTERNAL


{-| Gets the `Graphic` for a corresponding `Bitmap`.
-}
getGraphicForBitmap : Bitmap Size8x8 -> Graphic
getGraphicForBitmap bitmap_ =
    indexBitmapDict
        |> Dict.Extra.find (\_ bm -> bm == bitmap_)
        |> Maybe.map Tuple.first
        |> Maybe.withDefault 0
        |> Graphic


{-| `Dict` mapping from an index to a `Bitmap`.
-}
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
