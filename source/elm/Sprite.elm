module Sprite exposing
    ( Sprite
    , animated
    , bitmap
    , height
    , static
    , tick
    , width
    )

import Bitmap exposing (Bitmap)
import List.Nonempty as Nonempty exposing (Nonempty)
import Sprite.Frame as Frame exposing (Frame)
import Tile exposing (Tile)


type Sprite size
    = Sprite
        { width_ : Int
        , height_ : Int
        , animation : Animation size
        }


type Animation size
    = Static Bitmap
    | Animated Int (Nonempty (Frame size))


static : Tile a -> Sprite a
static tile =
    Sprite
        { width_ = Tile.width tile
        , height_ = Tile.height tile
        , animation = Static (Tile.bitmap tile)
        }


animated : Frame a -> List (Frame a) -> Sprite a
animated firstFrame frames =
    Sprite
        { width_ = Frame.width firstFrame
        , height_ = Frame.height firstFrame
        , animation =
            Animated 0
                (Nonempty.singleton firstFrame
                    |> Nonempty.replaceTail frames
                )
        }


tick : Sprite a -> Sprite a
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


bitmap : Sprite a -> Bitmap
bitmap (Sprite { animation }) =
    case animation of
        Static bm ->
            bm

        Animated ticks frames ->
            currentFrame ticks frames
                |> Frame.bitmap


width : Sprite a -> Int
width (Sprite { width_ }) =
    width_


height : Sprite a -> Int
height (Sprite { height_ }) =
    height_



-- INTERNAL


totalTicks : Nonempty (Frame a) -> Int
totalTicks frames =
    Nonempty.foldl (\f acc -> Frame.duration f + acc) 0 frames


currentFrame : Int -> Nonempty (Frame a) -> Frame a
currentFrame ticks frames =
    let
        iterate n f fs =
            let
                currentFrameDuration =
                    Frame.duration f
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
        (Nonempty.head frames)
        (Nonempty.tail frames)
