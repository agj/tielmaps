module Sprite exposing
    ( Sprite
    , animated
    , graphic
    , height
    , static
    , tick
    , width
    )

import Graphic exposing (Graphic)
import List.Nonempty exposing (Nonempty)
import Sprite.HeldFrame as HeldFrame exposing (HeldFrame)


type Sprite
    = Static Graphic
    | Animated Int (Nonempty HeldFrame)


static : Graphic -> Sprite
static frame =
    Static frame


animated : HeldFrame -> List HeldFrame -> Sprite
animated firstFrame frames =
    Animated 0
        (List.Nonempty.singleton firstFrame
            |> List.Nonempty.replaceTail frames
        )


tick : Sprite -> Sprite
tick sprite =
    case sprite of
        Static _ ->
            sprite

        Animated ticks frames ->
            let
                newTicks =
                    ticks + 1
            in
            if newTicks >= totalTicks frames then
                Animated 0 frames

            else
                Animated newTicks frames


graphic : Sprite -> Graphic
graphic sprite =
    case sprite of
        Static frame ->
            frame

        Animated ticks frames ->
            currentFrame ticks frames
                |> HeldFrame.frame


width : Sprite -> Int
width _ =
    8


height : Sprite -> Int
height _ =
    8



-- INTERNAL


totalTicks : Nonempty HeldFrame -> Int
totalTicks frames =
    List.Nonempty.foldl (\f acc -> HeldFrame.duration f + acc) 0 frames


currentFrame : Int -> Nonempty HeldFrame -> HeldFrame
currentFrame ticks frames =
    let
        iterate n f fs =
            let
                currentFrameDuration =
                    HeldFrame.duration f
            in
            if n < currentFrameDuration then
                f

            else
                case fs of
                    f2 :: fs2 ->
                        iterate (n - currentFrameDuration) f2 fs2

                    [] ->
                        f
    in
    iterate ticks
        (List.Nonempty.head frames)
        (List.Nonempty.tail frames)
