module Array2dBenchmark exposing (..)

import Array2d exposing (Array2d)
import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)


main : BenchmarkProgram
main =
    program suite


suite : Benchmark
suite =
    describe "Array2d.set"
        [ benchmark "something" <|
            \_ ->
                initialArray2d
                    |> Array2d.set 50 50 True
        ]



-- UTILITIES


initialArray2d : Array2d Bool
initialArray2d =
    Array2d.repeat 100 100 False
