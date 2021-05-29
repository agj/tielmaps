module Assets.Screens exposing (testScreen1, testScreen2)

import Assets.Tiles as Tiles
import CollisionLayer exposing (CollisionLayer)
import Dict
import Levers
import Screen exposing (Screen)
import Size exposing (Size22x22, Size8x8)
import Tilemap exposing (Tilemap)


testScreen1 : Screen Size22x22 Size8x8
testScreen1 =
    Screen.make22x22
        testTilemap1
        testCollisionLayer1
        |> Maybe.withDefault Screen.error22x22


testScreen2 : Screen Size22x22 Size8x8
testScreen2 =
    Screen.make22x22
        testTilemap2
        testCollisionLayer2
        |> Maybe.withDefault Screen.error22x22



-- INTERNAL


tilemapString1 : String
tilemapString1 =
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
    . . . . . . . . ◠ . . . . . . . . . . . . .
    . . . . . . . . █ ╮ . . . . . . . . . . . .
    . ▢ ▢ . . . . . █ █ ╮ . . . . . . . . . . .
    . . . . . . . . █ █ █ ╮ . . . . . . . . . .
    █ . . . . . ▢ ▢ █ █ █ █ ╮ . . . . . . . ╭ █
    █ . . ▢ ▢ . . . ╰ █ █ █ █ ) . . . . . ╭ █ █
    █ . . . . . . . . . . . . . . . . . ╭ █ █ █
    █ . . . . . . ▢ ▢ . . . . . . . . ╭ █ █ █ █
    █ . . ▢ ▢ . . . . . . . . . . . ╭ █ █ █ █ █
    █ . . . . . . . . . . . . . . ╭ █ █ █ █ █ █
    . . . . . . . . . . . . . . . . . . . . . .
    █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █
    """


tilemapString2 : String
tilemapString2 =
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
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    █ . . . . . . . . . . . . . . . . . . . . █
    █ . . . . . . . . . . . . . . . . . . . . █
    █ . . . . . . . . . . . . . . . . . . . . █
    █ . . . . . . . . . . . . . . . . . . . . █
    █ . . . . . . . . . . . . . . . . . . . . █
    █ . . . . . . . . . . . . . . . . . . . . █
    . . . . . . . . . . . . . . . . . . . . . .
    █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █
    """


testTilemap1 : Tilemap Size8x8
testTilemap1 =
    tilemapString1
        |> Tilemap.fromString charTiles
        |> Maybe.withDefault (Tilemap.empty8x8Tile 0 0)


testTilemap2 : Tilemap Size8x8
testTilemap2 =
    tilemapString2
        |> Tilemap.fromString charTiles
        |> Maybe.withDefault (Tilemap.empty8x8Tile 0 0)


testCollisionLayer1 : CollisionLayer
testCollisionLayer1 =
    tilemapString1
        |> CollisionLayer.fromString
            (Dict.keys charTiles |> List.filter ((/=) '.'))
        |> Maybe.withDefault (CollisionLayer.empty Levers.screenWidthTiles Levers.screenHeightTiles)


testCollisionLayer2 : CollisionLayer
testCollisionLayer2 =
    tilemapString2
        |> CollisionLayer.fromString
            (Dict.keys charTiles |> List.filter ((/=) '.'))
        |> Maybe.withDefault (CollisionLayer.empty Levers.screenWidthTiles Levers.screenHeightTiles)


charTiles =
    Dict.fromList
        [ ( '.', Tiles.empty )
        , ( '█', Tiles.solid )
        , ( '▢', Tiles.hollow )
        , ( '╭', Tiles.topLeftCurvedSolid )
        , ( '╮', Tiles.topRightCurvedSolid )
        , ( '╰', Tiles.bottomLeftCurvedSolid )
        , ( '◠', Tiles.topCurvedSolid )
        , ( ')', Tiles.rightCurvedSolid )
        ]
