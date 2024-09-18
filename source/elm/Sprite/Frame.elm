module Sprite.Frame exposing
    ( Frame(..)
    , HeldFrame
    , bitmap
    , duration
    , height
    , make
    , width
    )

import Assets.Frames as Frames
import Bitmap exposing (Bitmap)
import Size exposing (Size8x8)


type HeldFrame
    = Frame Int Frame


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
    Frame dur f



-- ACCESSORS


bitmap : HeldFrame -> Bitmap Size8x8
bitmap (Frame _ f) =
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
duration (Frame dur _) =
    dur


width : HeldFrame -> Int
width heldFrame =
    bitmap heldFrame
        |> Bitmap.width


height : HeldFrame -> Int
height heldFrame =
    bitmap heldFrame
        |> Bitmap.height
