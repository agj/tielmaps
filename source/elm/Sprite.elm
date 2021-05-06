module Sprite exposing
    ( Sprite
    , animated
    , static
    , tick
    )

import Sprite.Frame as Frame exposing (Frame)
import Tile exposing (Tile)


type Sprite size
    = Static (Tile size)
    | Animated Int (List (Frame size))


static : Tile a -> Sprite a
static tile =
    Static tile


animated : List (Frame a) -> Sprite a
animated frames =
    Animated 0 frames


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



-- INTERNAL


totalTicks : List (Frame a) -> Int
totalTicks frames =
    List.foldl (\f acc -> Frame.duration f + acc) 0 frames
