module Maps exposing (..)

import Dict exposing (Dict)
import Map exposing (Map)
import Tiles


testMap : Map
testMap =
    """
◢ ◣ ◢ ◣
◥ █ . ◤
◢ . █ ◣
◥ ◤ ◥ ◤
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
        |> Maybe.withDefault (Map.empty 0 0 0 0)
