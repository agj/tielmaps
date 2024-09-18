module Sprite.HeldFrame exposing (HeldFrame, duration, frame, make)

import Sprite.Frame exposing (Frame)


type HeldFrame
    = HeldFrame Int Frame


make : Int -> Frame -> HeldFrame
make dur f =
    HeldFrame dur f


frame : HeldFrame -> Frame
frame (HeldFrame _ f) =
    f


duration : HeldFrame -> Int
duration (HeldFrame dur _) =
    dur
