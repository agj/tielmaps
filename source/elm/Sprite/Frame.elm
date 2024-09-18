module Sprite.Frame exposing
    ( Frame(..)
    , bitmap
    , height
    , width
    )

import Assets.Bitmaps as Bitmaps
import Bitmap exposing (Bitmap)
import Size exposing (Size8x8)


type Frame
    = FrameAirborneRight
    | FrameAirborneLeft
    | FrameHopRight
    | FrameHopLeft
    | FrameStandingRight
    | FrameStandingLeft
    | FrameBobRight
    | FrameBobLeft



-- ACCESSORS


bitmap : Frame -> Bitmap Size8x8
bitmap f =
    case f of
        FrameAirborneRight ->
            Bitmaps.avatarAirborneRight

        FrameAirborneLeft ->
            Bitmaps.avatarAirborneLeft

        FrameHopRight ->
            Bitmaps.avatarHopRight

        FrameHopLeft ->
            Bitmaps.avatarHopLeft

        FrameStandingRight ->
            Bitmaps.avatarStandingRight

        FrameStandingLeft ->
            Bitmaps.avatarStandingLeft

        FrameBobRight ->
            Bitmaps.avatarBobRight

        FrameBobLeft ->
            Bitmaps.avatarBobLeft


width : Frame -> Int
width f =
    bitmap f
        |> Bitmap.width


height : Frame -> Int
height f =
    bitmap f
        |> Bitmap.height
