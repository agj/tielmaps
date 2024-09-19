module Sprite.HeldFrame exposing (HeldFrame, duration, frame, make)

import Graphic exposing (Graphic)


type HeldFrame
    = HeldFrame Int Graphic


make : Int -> Graphic -> HeldFrame
make dur f =
    HeldFrame dur f


frame : HeldFrame -> Graphic
frame (HeldFrame _ f) =
    f


duration : HeldFrame -> Int
duration (HeldFrame dur _) =
    dur
