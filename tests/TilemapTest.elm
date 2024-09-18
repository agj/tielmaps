module TilemapTest exposing (..)

import Dict exposing (Dict)
import Expect
import Size exposing (Size8x8)
import Test exposing (..)
import Tile exposing (Tile)
import Tilemap exposing (Tilemap)


setTile : Test
setTile =
    describe "setTile"
        [ test "Invalidates memoization" <|
            \_ ->
                let
                    ( bitmapBefore, _ ) =
                        Tilemap.toBitmapMemoized tilemapMemoized
                in
                tilemapMemoized
                    |> Tilemap.setTile 0 0 Tile.TileHollow
                    |> Tilemap.toBitmapMemoized
                    |> Tuple.first
                    |> Expect.notEqual bitmapBefore
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
    █ █
    █ █
    """


charTiles : Dict Char Tile
charTiles =
    Dict.fromList
        [ ( '.', Tile.TileEmpty )
        , ( '█', Tile.TileSolid )
        ]
