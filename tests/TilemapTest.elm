module TilemapTest exposing (..)

import Assets.Tiles as Tiles
import Dict exposing (Dict)
import Expect
import Size exposing (Size8x8)
import Test exposing (..)
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
                    |> Tilemap.setTile 0 0 Tiles.hollow
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


charTiles =
    Dict.fromList
        [ ( '.', Tiles.empty )
        , ( '█', Tiles.solid )
        ]
