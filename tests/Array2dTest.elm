module Array2dTest exposing (..)

import Array
import Array2d
import Expect
import Test exposing (..)



-- CONSTRUCTION


repeat : Test
repeat =
    describe "repeat"
        [ test "Returns an Array2d prefilled with the filler value and of the specified dimensions" <|
            \_ ->
                Array2d.repeat 3 2 ()
                    |> Expect.equal
                        (Array2d.fromList 3 () [ (), (), (), (), (), () ])
        ]


fromList : Test
fromList =
    describe "fromList"
        [ test "Returns an Array2d of the expected size" <|
            \_ ->
                [ False, False, False, True ]
                    |> Array2d.fromList 2 True
                    |> Expect.all
                        [ Array2d.width >> Expect.equal 2
                        , Array2d.height >> Expect.equal 2
                        ]
        , test "Fills the Array2d to complete the last row" <|
            \_ ->
                [ False, False, False ]
                    |> Array2d.fromList 2 True
                    |> Expect.all
                        [ Array2d.height >> Expect.equal 2
                        , Array2d.get 1 1 >> Expect.equal (Just True)
                        ]
        ]


initialArray2d =
    [ False, False, False, False, False, True ]
        |> Array2d.fromList 3 True



-- ACCESSORS


get : Test
get =
    describe "get"
        [ test "Returns the item at that position" <|
            \_ ->
                initialArray2d
                    |> Array2d.get 2 1
                    |> Expect.equal (Just True)
        , test "Returns Nothing when out of bounds" <|
            \_ ->
                initialArray2d
                    |> Expect.all
                        [ Array2d.get 0 2 >> Expect.equal Nothing
                        , Array2d.get 3 0 >> Expect.equal Nothing
                        ]
        ]


width : Test
width =
    describe "width"
        [ test "Returns the width of the Array2d" <|
            \_ ->
                initialArray2d
                    |> Array2d.width
                    |> Expect.equal 3
        ]


height : Test
height =
    describe "height"
        [ test "Returns the height of the Array2d" <|
            \_ ->
                initialArray2d
                    |> Array2d.height
                    |> Expect.equal 2
        ]



-- MODIFICATION


set : Test
set =
    describe "set"
        [ test "Sets the item at that position" <|
            \_ ->
                initialArray2d
                    |> Array2d.set 1 0 True
                    |> Expect.equal
                        (Array2d.fromList 3 False [ False, True, False, False, False, True ])
        , test "Ignores out of bounds points" <|
            \_ ->
                initialArray2d
                    |> Expect.all
                        [ Array2d.set 3 0 True
                            >> Expect.equal initialArray2d
                        , Array2d.set 0 2 True
                            >> Expect.equal initialArray2d
                        ]
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
