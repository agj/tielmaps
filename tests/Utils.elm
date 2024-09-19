module Utils exposing (..)

import Fuzz exposing (Fuzzer)
import Random


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
        [ Fuzz.pair zeroOrLess oneOrGreater
        , Fuzz.pair oneOrGreater zeroOrLess
        , Fuzz.pair zeroOrLess zeroOrLess
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
        [ Fuzz.pair sizeAndPos sizeAndInvalidPos
        , Fuzz.pair sizeAndInvalidPos sizeAndPos
        ]


listAndDimensions : Fuzzer ( List Int, Int, Int )
listAndDimensions =
    Fuzz.pair sizeFuzzer sizeFuzzer
        |> Fuzz.andThen
            (\( w, h ) ->
                listOfIntsFuzzer (w * h)
                    |> Fuzz.map (\list -> ( list, w, h ))
            )


listOfIntsFuzzer : Int -> Fuzzer (List Int)
listOfIntsFuzzer length =
    Fuzz.listOfLength length (Fuzz.intRange 0 99)


sizeFuzzer : Fuzzer Int
sizeFuzzer =
    Fuzz.intRange 1 70
