module TilemapBenchmark exposing (..)

import Array2d exposing (Array2d)
import Assets.Tiles as Tiles
import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)
import Dict exposing (Dict)
import Size exposing (Size8x8)
import Tilemap exposing (Tilemap)


main : BenchmarkProgram
main =
    program suite


suite : Benchmark
suite =
    describe "Tilemap"
        [ benchmark ".fromString" <|
            \_ ->
                tilemapString
                    |> Tilemap.fromString charTiles
        , benchmark ".toBitmap" <|
            \_ ->
                tilemap
                    |> Tilemap.toBitmap
        , benchmark ".toBitmapMemoized" <|
            \_ ->
                tilemapMemoized
                    |> Tilemap.toBitmapMemoized
        ]



-- INTERNAL


tilemapMemoized : Tilemap Size8x8
tilemapMemoized =
    tilemap
        |> Tilemap.toBitmapMemoized
        |> Tuple.second


tilemap : Tilemap Size8x8
tilemap =
    tilemapString
        |> Tilemap.fromString charTiles
        |> Maybe.withDefault (Tilemap.empty8x8Tile 0 0)


tilemapString : String
tilemapString =
    """
    █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █
    █ . . . . . . . . . . . . . . . . . . . . █
    █ . . . . . . . . . . . . . . . . . . . . █
    █ . . . . . . . . . . . . . . . . . . . . █
    █ . . . . . . . . . . . . . . . . . . . . █
    █ . . . . . . . . . . . . . . . . . . . . █
    █ . . . . . . . . . . . . . . . . . . . . █
    █ . . . . . . . . . . . . . . . . . . . . █
    █ . . . . . . . . . . . . . . . . . . . . █
    █ . . . . . . . . . . . . . . . . . . . . █
    █ . . . . . . . ╮ . . . . . . . . . . . . █
    █ . . . . . . . █ ╮ . . . . . . . . . . . █
    █ ▢ ▢ . . . . . █ █ ╮ . . . . . . . . . . █
    █ . . . . . . . █ █ █ ╮ . . . . . . . . . █
    █ . . . . . ▢ ▢ █ █ █ █ ╮ . . . . . . . ╭ █
    █ . . ▢ ▢ . . . ╰ █ █ █ █ ╮ . . . . . ╭ █ █
    █ . . . . . . . . . . . . . . . . . ╭ █ █ █
    █ . . . . . . ▢ ▢ . . . . . . . . ╭ █ █ █ █
    █ . . ▢ ▢ . . . . . . . . . . . ╭ █ █ █ █ █
    █ . . . . . . . . . . . . . . ╭ █ █ █ █ █ █
    █ . . . . . . . . . . . . . ╭ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █
    """


charTiles =
    Dict.fromList
        [ ( '.', Tiles.empty )
        , ( '█', Tiles.solid )
        , ( '▢', Tiles.hollow )
        , ( '╭', Tiles.topLeftCurvedSolid )
        , ( '╮', Tiles.topRightCurvedSolid )
        , ( '╰', Tiles.bottomLeftCurvedSolid )
        ]
