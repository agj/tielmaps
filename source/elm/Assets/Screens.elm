module Assets.Screens exposing (testScreen)

import Assets.Tiles as Tiles
import CollisionLayer exposing (CollisionLayer)
import Dict
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


tilemapString : String
tilemapString =
    """
. . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . █ . . . . . . . . . . . . .
█ █ █ . █ █ █ . █ █ . . . . . . . . . . . .
█ . █ . █ . █ . █ . . . . . . . . . . . . .
█ . █ . █ █ █ . █ █ . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . █ . . . . . . .
█ █ █ █ █ . █ . █ . █ █ █ . █ █ █ . . . . .
█ . █ . █ . █ . █ . █ . . . █ . █ . . . . .
█ . █ . █ . █ █ █ . █ █ █ . █ . █ . . . . .
. . . . . . . . . . . . . . . . . . . . . .
█ . . . . . . . . . . . . . . . . . . . . .
█ █ . █ █ █ . . . . . . . . . . . . . . . .
█ . . █ . █ . . . . . . . . . . . . . . . .
█ █ . █ █ █ . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . .
. . . . █ . . . . . . . . . . . . . █ . . .
. █ █ . █ █ █ . █ █ █ . █ . █ . █ . █ . . .
. █ . . █ . █ . █ . █ . █ . █ . █ . . . . .
█ █ . . █ . █ . █ █ █ . . █ █ █ █ . █ . . .
. . . . . . . . . . . . . . . . . . . . . .
"""


testTilemap : Tilemap Size8x8
testTilemap =
    tilemapString
        |> Tilemap.fromString
            (Dict.fromList
                [ ( '.', Tiles.empty )
                , ( '█', Tiles.solid )
                , ( '◤', Tiles.topLeftSlant )
                , ( '◥', Tiles.topRightSlant )
                , ( '◣', Tiles.bottomLeftSlant )
                , ( '◢', Tiles.bottomRightSlant )
                ]
            )
        |> Maybe.withDefault (Tilemap.empty8x8Tile 0 0)


testCollisionLayer : CollisionLayer
testCollisionLayer =
    tilemapString
        |> CollisionLayer.fromString [ '█' ]
