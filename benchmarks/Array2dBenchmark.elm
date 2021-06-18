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
        [ benchmark "100×100" <|
            \_ ->
                array100x100
                    |> Array2d.set 50 50 True
        , benchmark "1000×1000" <|
            \_ ->
                array1000x1000
                    |> Array2d.set 500 500 True
        ]



-- UTILITIES


array100x100 : Array2d Bool
array100x100 =
    Array2d.repeat 100 100 False


array1000x1000 : Array2d Bool
array1000x1000 =
    Array2d.repeat 1000 1000 False
