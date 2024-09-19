module Array2dTest exposing (..)

import Array
import Array2d
import Expect
import Test exposing (..)
import Utils exposing (..)



-- CONSTRUCTION


repeat : Test
repeat =
    describe "repeat"
        [ fuzz zeroOrLessTwice "Result is empty for zero or negative numbers as dimensions" <|
            \( w, h ) ->
                Array2d.repeat w h ()
                    |> Expect.equal Array2d.empty
        , fuzz2 oneOrGreater oneOrGreater "Result's width and height equal input dimensions" <|
            \w h ->
                Array2d.repeat w h ()
                    |> Expect.all
                        [ Array2d.width >> Expect.equal w
                        , Array2d.height >> Expect.equal h
                        ]
        , fuzz2 sizeAndPos sizeAndPos "Any value from the result should equal the input value" <|
            \( w, x ) ( h, y ) ->
                Array2d.repeat w h ()
                    |> Array2d.get x y
                    |> Expect.equal (Just ())
        ]


fromList : Test
fromList =
    describe "fromList"
        [ fuzz2 zeroOrLess smallPositiveInt "Returns an empty Array2d with zero or negative numbers" <|
            \w listLength ->
                List.repeat listLength False
                    |> Array2d.forceFromList w True
                    |> Expect.equal Array2d.empty
        , fuzz2 oneOrGreater oneOrGreater "Returns an Array2d of the expected size" <|
            \w h ->
                List.repeat (w * h) False
                    |> Array2d.forceFromList w True
                    |> Expect.all
                        [ Array2d.width >> Expect.equal w
                        , Array2d.height >> Expect.equal h
                        ]
        , fuzz2 twoOrGreater oneOrGreater "Fills the Array2d to complete the last row" <|
            \w h ->
                List.repeat (w * h - 1) False
                    |> Array2d.forceFromList w True
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
                    |> Array2d.forceFromList 3 False
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
        [ fuzz listAndDimensions "Returns a plain Array with the values" <|
            \( list, w, _ ) ->
                list
                    |> Array2d.forceFromList w 0
                    |> Array2d.toUnidimensional
                    |> Expect.equal
                        (Array.fromList list)
        ]


indexedFoldl : Test
indexedFoldl =
    describe "indexedFoldl"
        [ test "Passes items in in rows and columns" <|
            \_ ->
                Array2d.repeat 3 3 True
                    |> Array2d.indexedFoldl
                        (\x y _ acc -> ( x, y ) :: acc)
                        []
                    |> List.reverse
                    |> Expect.equal
                        [ ( 0, 0 ), ( 1, 0 ), ( 2, 0 ), ( 0, 1 ), ( 1, 1 ), ( 2, 1 ), ( 0, 2 ), ( 1, 2 ), ( 2, 2 ) ]
        ]
