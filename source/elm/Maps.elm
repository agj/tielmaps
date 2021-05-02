module Maps exposing (..)

import Dict exposing (Dict)
import Map exposing (Map)
import Tiles


testMap : Map
testMap =
    """
? . . .
. ? . .
. . ? .
? . . ?
"""
        |> Map.fromString
            (Dict.fromList
                [ ( '.', Tiles.empty )
                , ( '?', Tiles.bottomLeftSlant )
                ]
            )
        |> Maybe.withDefault (Map.empty 0 0 0 0)
