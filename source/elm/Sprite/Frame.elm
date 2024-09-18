module Sprite.Frame exposing
    ( Frame(..)
    , bitmap
    , height
    , width
    )

import Assets.Frames as Frames
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


width : Frame -> Int
width f =
    bitmap f
        |> Bitmap.width


height : Frame -> Int
height f =
    bitmap f
        |> Bitmap.height
