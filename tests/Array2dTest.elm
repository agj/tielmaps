module Array2dTest exposing (..)

import Array
import Array2d exposing (Array2d)
import Expect
import Fuzz exposing (Fuzzer)
import Random
import Test exposing (..)



-- CONSTRUCTION


repeat : Test
repeat =
    describe "repeat"
        [ fuzz2 negativeOrZero negativeOrZero "Returns an empty Array2d with zero or negative numbers" <|
            \w h ->
                Array2d.repeat w h ()
                    |> Expect.equal Array2d.empty
        , fuzz2 oneOrGreater oneOrGreater "Returns an Array2d prefilled with the filler value and of the specified dimensions" <|
            \w h ->
                Array2d.repeat w h ()
                    |> Expect.equal
                        (Array2d.fromList w () (List.repeat (w * h) ()))
        ]


fromList : Test
fromList =
    describe "fromList"
        [ fuzz2 negativeOrZero smallPositiveInt "Returns an empty Array2d with zero or negative numbers" <|
            \w listLength ->
                List.repeat listLength False
                    |> Array2d.fromList w True
                    |> Expect.equal Array2d.empty
        , fuzz2 oneOrGreater oneOrGreater "Returns an Array2d of the expected size" <|
            \w h ->
                List.repeat (w * h) False
                    |> Array2d.fromList w True
                    |> Expect.all
                        [ Array2d.width >> Expect.equal w
                        , Array2d.height >> Expect.equal h
                        ]
        , fuzz2 twoOrGreater oneOrGreater "Fills the Array2d to complete the last row" <|
            \w h ->
                List.repeat (w * h - 1) False
                    |> Array2d.fromList w True
                    |> Expect.all
                        [ Array2d.height >> Expect.equal h
                        , Array2d.get (w - 1) (h - 1) >> Expect.equal (Just True)
                        ]
        ]



-- ACCESSORS


get : Test
get =
    describe "get"
        [ test "Returns the item at that position" <|
            \_ ->
                [ False, False, False, False, False, True ]
                    |> Array2d.fromList 3 False
                    |> Array2d.get 2 1
                    |> Expect.equal (Just True)
        , fuzz sizeAndInvalidPos2 "Returns Nothing when out of bounds" <|
            \( ( w, x ), ( h, y ) ) ->
                Array2d.repeat w h False
                    |> Array2d.get x y
                    |> Expect.equal Nothing
        ]


width : Test
width =
    describe "width"
        [ test "Returns zero when Array2d is empty" <|
            \_ ->
                Array2d.empty
                    |> Array2d.width
                    |> Expect.equal 0
        , fuzz2 oneOrGreater oneOrGreater "Returns the width of the Array2d" <|
            \w h ->
                Array2d.repeat w h True
                    |> Array2d.width
                    |> Expect.equal w
        ]


height : Test
height =
    describe "height"
        [ test "Returns zero when Array2d is empty" <|
            \_ ->
                Array2d.empty
                    |> Array2d.height
                    |> Expect.equal 0
        , fuzz2 oneOrGreater oneOrGreater "Returns the height of the Array2d" <|
            \w h ->
                Array2d.repeat w h True
                    |> Array2d.height
                    |> Expect.equal h
        ]



-- MODIFICATION


set : Test
set =
    describe "set"
        [ fuzz2 sizeAndPos sizeAndPos "Sets the item at that position" <|
            \( w, x ) ( h, y ) ->
                Array2d.repeat w h False
                    |> Array2d.set x y True
                    |> Array2d.get x y
                    |> Expect.equal (Just True)
        , fuzz sizeAndInvalidPos2 "Ignores out of bounds points" <|
            \( ( w, x ), ( h, y ) ) ->
                let
                    array2d =
                        Array2d.repeat w h False
                in
                array2d
                    |> Array2d.set x y True
                    |> Expect.equal array2d
        ]


toUnidimensional : Test
toUnidimensional =
    describe "toUnidimensional"
        [ test "Returns a plan Array with the values" <|
            \_ ->
                let
                    initialList =
                        [ 0, 1, 2, 3 ]
                in
                initialList
                    |> Array2d.fromList 2 9
                    |> Array2d.toUnidimensional
                    |> Expect.equal
                        (Array.fromList initialList)
        ]



-- UTILITIES


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


negativeOrZero : Fuzzer Int
negativeOrZero =
    Fuzz.intRange Random.minInt 0


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