module Sprite.Frame exposing
    ( Frame(..)
    , HeldFrame
    , bitmap
    , duration
    , frame
    , height
    , make
    , width
    )

import Assets.Frames as Frames
import Bitmap exposing (Bitmap)
import Size exposing (Size8x8)


type HeldFrame
    = HeldFrame Int Frame


type Frame
    = FrameAirborneRight
    | FrameAirborneLeft
    | FrameHopRight
    | FrameHopLeft
    | FrameStandingRight
    | FrameStandingLeft
    | FrameBobRight
    | FrameBobLeft


make : Int -> Frame -> HeldFrame
make dur f =
    HeldFrame dur f



-- ACCESSORS


frame : HeldFrame -> Frame
frame (HeldFrame _ f) =
    f


bitmap : Frame -> Bitmap Size8x8
bitmap f =
    case f of
        FrameAirborneRight ->
            Frames.airborneRight

        FrameAirborneLeft ->
            Frames.airborneLeft

        FrameHopRight ->
            Frames.hopRight

        FrameHopLeft ->
            Frames.hopLeft

        FrameStandingRight ->
            Frames.standingRight

        FrameStandingLeft ->
            Frames.standingLeft

        FrameBobRight ->
            Frames.bobRight

        FrameBobLeft ->
            Frames.bobLeft


duration : HeldFrame -> Int
duration (HeldFrame dur _) =
    dur


width : Frame -> Int
width f =
    bitmap f
        |> Bitmap.width


height : Frame -> Int
height f =
    bitmap f
        |> Bitmap.height
