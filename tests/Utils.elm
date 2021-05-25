module Utils exposing (..)

import Fuzz exposing (Fuzzer)
import Random
import Shrink


positiveInt : Fuzzer Int
positiveInt =
    Fuzz.intRange 0 99


smallPositiveInt : Fuzzer Int
smallPositiveInt =
    Fuzz.intRange 0 10


oneOrGreater : Fuzzer Int
oneOrGreater =
    Fuzz.intRange 1 99


twoOrGreater : Fuzzer Int
twoOrGreater =
    Fuzz.intRange 2 99


zeroOrLess : Fuzzer Int
zeroOrLess =
    Fuzz.intRange Random.minInt 0


zeroOrLessTwice : Fuzzer ( Int, Int )
zeroOrLessTwice =
    Fuzz.oneOf
        [ Fuzz.tuple ( zeroOrLess, oneOrGreater )
        , Fuzz.tuple ( oneOrGreater, zeroOrLess )
        , Fuzz.tuple ( zeroOrLess, zeroOrLess )
        ]


sizeAndPos : Fuzzer ( Int, Int )
sizeAndPos =
    Fuzz.map2
        (\size fraction -> ( size, floor (toFloat size * (fraction * 0.99999999999999)) ))
        oneOrGreater
        Fuzz.percentage


sizeAndInvalidPos : Fuzzer ( Int, Int )
sizeAndInvalidPos =
    Fuzz.map2
        (\size pos ->
            ( size
            , if pos >= 0 then
                pos + size

              else
                pos
            )
        )
        oneOrGreater
        Fuzz.int


sizeAndInvalidPos2 : Fuzzer ( ( Int, Int ), ( Int, Int ) )
sizeAndInvalidPos2 =
    Fuzz.oneOf
        [ Fuzz.tuple ( sizeAndPos, sizeAndInvalidPos )
        , Fuzz.tuple ( sizeAndInvalidPos, sizeAndPos )
        ]


listAndDimensions : Fuzzer ( List Int, Int, Int )
listAndDimensions =
    Fuzz.custom
        randomListAndDimensions
        Shrink.noShrink


randomListAndDimensions : Random.Generator ( List Int, Int, Int )
randomListAndDimensions =
    Random.pair randomSize randomSize
        |> Random.andThen
            (\( w, h ) ->
                randomList (w * h)
                    |> Random.map (\list -> ( list, w, h ))
            )


randomList : Int -> Random.Generator (List Int)
randomList length =
    Random.list length (Random.int 0 99)


randomSize : Random.Generator Int
randomSize =
    Random.int 1 99
