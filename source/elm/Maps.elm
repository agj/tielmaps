module Maps exposing (..)

import Dict exposing (Dict)
import Map exposing (Map)
import Size exposing (Size8x8)
import Tiles


testMap : Map Size8x8
testMap =
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
