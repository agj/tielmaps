module Sprite exposing
    ( Sprite
    , animated
    , bitmap
    , bitmaps
    , height
    , static
    , tick
    , width
    )

import Bitmap exposing (Bitmap)
import List.Nonempty exposing (Nonempty)
import Size exposing (Size8x8)
import Sprite.Frame as Frame exposing (Frame)
import Sprite.HeldFrame as HeldFrame exposing (HeldFrame)


type Sprite
    = Sprite
        { width_ : Int
        , height_ : Int
        , animation : Animation
        }


type Animation
    = Static Frame
    | Animated Int (Nonempty HeldFrame)


static : Frame -> Sprite
static frame =
    Sprite
        { width_ = 8
        , height_ = 8
        , animation = Static frame
        }


animated : HeldFrame -> List HeldFrame -> Sprite
animated firstFrame frames =
    Sprite
        { width_ = HeldFrame.frame firstFrame |> Frame.width
        , height_ = HeldFrame.frame firstFrame |> Frame.height
        , animation =
            Animated 0
                (List.Nonempty.singleton firstFrame
                    |> List.Nonempty.replaceTail frames
                )
        }


tick : Sprite -> Sprite
tick ((Sprite state) as sprite) =
    case state.animation of
        Static _ ->
            sprite

        Animated ticks frames ->
            let
                newTicks =
                    ticks + 1
            in
            if newTicks >= totalTicks frames then
                Sprite { state | animation = Animated 0 frames }

            else
                Sprite { state | animation = Animated newTicks frames }


bitmaps : Sprite -> List (Bitmap Size8x8)
bitmaps (Sprite { animation }) =
    case animation of
        Static frame ->
            [ Frame.bitmap frame ]

        Animated _ frames ->
            frames
                |> List.Nonempty.toList
                |> List.map (HeldFrame.frame >> Frame.bitmap)


bitmap : Sprite -> Bitmap Size8x8
bitmap (Sprite { animation }) =
    case animation of
        Static frame ->
            Frame.bitmap frame

        Animated ticks frames ->
            currentFrame ticks frames
                |> HeldFrame.frame
                |> Frame.bitmap


width : Sprite -> Int
width (Sprite { width_ }) =
    width_


height : Sprite -> Int
height (Sprite { height_ }) =
    height_



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
