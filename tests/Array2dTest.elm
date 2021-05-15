module Array2dTest exposing (..)

import Array2d
import Expect
import Test exposing (..)


suite : Test
suite =
    let
        testArray2d =
            [ False, False, False, True ]
                |> Array2d.fromList 2 True
    in
    describe "Array2d"
        [ describe "fromList"
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
        , describe "get"
            [ test "Returns the item at that position" <|
                \_ ->
                    testArray2d
                        |> Array2d.get 1 1
                        |> Expect.equal (Just True)
            , test "Returns Nothing when out of bounds" <|
                \_ ->
                    testArray2d
                        |> Expect.all
                            [ Array2d.get 0 2 >> Expect.equal Nothing
                            , Array2d.get 2 0 >> Expect.equal Nothing
                            ]
            ]
        ]
