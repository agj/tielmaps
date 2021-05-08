module Screens exposing (testScreen)

import CollisionLayer exposing (CollisionLayer)
import Dict
import Map exposing (Map)
import Screen exposing (Screen)
import Size exposing (Size22x22, Size8x8)
import Tiles


testScreen : Screen Size22x22 Size8x8
testScreen =
    Screen.make22x22
        testMap
        testCollisionLayer
        |> Maybe.withDefault Screen.error22x22



-- INTERNAL


mapString : String
mapString =
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


testMap : Map Size8x8
testMap =
    mapString
        |> Map.fromString
            (Dict.fromList
                [ ( '.', Tiles.empty )
                , ( '█', Tiles.solid )
                , ( '◤', Tiles.topLeftSlant )
                , ( '◥', Tiles.topRightSlant )
                , ( '◣', Tiles.bottomLeftSlant )
                , ( '◢', Tiles.bottomRightSlant )
                ]
            )
        |> Maybe.withDefault (Map.empty8x8Tile 0 0)


testCollisionLayer : CollisionLayer
testCollisionLayer =
    mapString
        |> CollisionLayer.fromString [ '█' ]
