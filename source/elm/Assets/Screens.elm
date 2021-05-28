module Assets.Screens exposing (testScreen)

import Assets.Tiles as Tiles
import CollisionLayer exposing (CollisionLayer)
import Dict
import Levers
import Screen exposing (Screen)
import Size exposing (Size22x22, Size8x8)
import Tilemap exposing (Tilemap)


testScreen : Screen Size22x22 Size8x8
testScreen =
    Screen.make22x22
        testTilemap
        testCollisionLayer
        |> Maybe.withDefault Screen.error22x22



-- INTERNAL


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


testTilemap : Tilemap Size8x8
testTilemap =
    tilemapString2
        |> Tilemap.fromString charTiles
        |> Maybe.withDefault (Tilemap.empty8x8Tile 0 0)


testCollisionLayer : CollisionLayer
testCollisionLayer =
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
