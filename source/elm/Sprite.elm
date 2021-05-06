module Sprite exposing
    ( Sprite
    , animated
    , bitmap
    , static
    , tick
    )

import Bitmap exposing (Bitmap)
import List.Nonempty as Nonempty exposing (Nonempty)
import Sprite.Frame as Frame exposing (Frame)
import Tile exposing (Tile)


type Sprite size
    = Static Bitmap
    | Animated Int (Nonempty (Frame size))


static : Tile a -> Sprite a
static tile =
    Static (Tile.bitmap tile)


animated : Frame a -> List (Frame a) -> Sprite a
animated firstFrame frames =
    Animated 0
        (Nonempty.singleton firstFrame
            |> Nonempty.replaceTail frames
        )


tick : Sprite a -> Sprite a
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


bitmap : Sprite a -> Bitmap
bitmap sprite =
    case sprite of
        Static bm ->
            bm

        Animated ticks frames ->
            currentFrame ticks frames
                |> Frame.bitmap



-- INTERNAL


totalTicks : Nonempty (Frame a) -> Int
totalTicks frames =
    Nonempty.foldl (\f acc -> Frame.duration f + acc) 0 frames


currentFrame : Int -> Nonempty (Frame a) -> Frame a
currentFrame ticks frames =
    let
        iterate n f fs =
            if n >= ticks then
                f

            else
                case fs of
                    f2 :: fs2 ->
                        iterate (n + Frame.duration f) f2 fs2

                    [] ->
                        f
    in
    iterate 0
        (Nonempty.head frames)
        (Nonempty.tail frames)
