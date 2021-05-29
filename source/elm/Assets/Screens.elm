module Assets.Screens exposing (testScreen1, testScreen2, testScreen3)

import Assets.Tiles as Tiles
import CollisionLayer exposing (CollisionLayer)
import Dict
import Levers
import Screen exposing (Screen)
import Size exposing (Size22x22, Size8x8)
import Tilemap exposing (Tilemap)


testScreen3 : Screen Size22x22 Size8x8
testScreen3 =
    """
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . █ █ . . █ █ █ █ . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . █ █ . . █ █ . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . █ . . . █ █ . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . █ █ █ █ █ . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . █ █ █ █ . . █ █ █ █ . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . █ █ . . █ █ █ █ . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . █ █ . . █ █ . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    """
        |> toScreen


testScreen2 : Screen Size22x22 Size8x8
testScreen2 =
    """
    . . . . . . . . . . . . . . . . . . . . . .
    . . █ █ . . . . . . . . . . . . . . . . . .
    . . █ █ █ █ █ . . . . . . . . . . . . . . .
    . . . . . █ █ . . . . . . . . . . . . . . .
    . . . . . █ █ █ █ █ . . . . . . . . . . . .
    . . . . . . . . █ █ . . . . . . . . . . . .
    . . . . . . . . █ █ █ █ █ . . . . . . . . .
    . . . . . . . . . . . █ █ . . . . . . . . .
    █ █ █ █ . . . . . . . █ █ █ █ █ █ █ █ █ █ █
    . . █ █ . . . . . . . . . . . █ █ █ █ █ █ █
    . . █ █ █ █ █ . . . . . . . . █ █ █ █ █ █ █
    . . . . . █ █ . . . . . . . . █ █ █ █ █ █ █
    . . . . . █ █ █ █ █ . . . . . █ █ █ █ █ █ █
    . . . . . . . . . █ █ . . . . █ █ █ █ █ █ █
    . . . . . . . . . █ █ . . . . █ █ █ █ █ █ █
    . . . . . . . . . . . . . . . █ █ █ █ █ █ █
    . . . . . . . . . . . . █ █ █ █ █ █ █ █ █ █
    . . . . . . . . . . . . █ █ █ █ █ █ █ █ █ █
    . . . . . . . . . █ █ █ █ █ . . . . . . . .
    . . . . . . . . . █ █ █ █ █ . . . . . . . .
    . . . . . . █ █ █ █ █ . . . . . . . . . . .
    . . . . . . █ █ █ █ █ . . . . . . . . . . .
    """
        |> toScreen


testScreen1 : Screen Size22x22 Size8x8
testScreen1 =
    """
    . . . . . . █ █ █ █ █ . . . . . . . . . . .
    . . . █ █ █ █ █ . . . . . . . . . . . . . .
    . . . █ █ . . . . . . . . . . . . . . . . .
    . . . █ █ . . . . . . . . . . . . . . . . .
    █ █ █ █ . . . . . . . . . . █ █ █ █ █ █ █ █
    █ █ █ █ . . . . . . . . . . . █ █ █ █ █ █ █
    █ █ █ █ . . . . . . . . . . . █ █ █ █ █ █ █
    █ █ █ █ . . . . █ █ █ █ █ █ █ █ █ █ █ █ █ █
    . . . █ . █ . . . . . . . . . . . . . . . .
    . . . █ . . . . . . . . . . . . . . . . . .
    █ █ █ █ █ █ █ █ █ █ . . . . █ █ █ █ █ █ █ █
    █ █ . . . . . . . . . . . . █ █ █ █ █ █ █ █
    █ █ . . . . . . . . . . . . █ █ █ █ █ █ █ █
    █ █ . . . . █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █
    █ █ . . . . . . . . . . . . █ █ █ █ █ █ █ █
    █ █ . . . . . . . . . . . . █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █ . . . . . . █ █ █ █ █ █ █ █
    █ █ . . . . █ █ █ █ █ . . . █ █ █ █ █ █ █ █
    █ . . . . . . . . . . . . . █ █ █ █ █ █ █ █
    █ . . . . . . . . . . . . . █ █ █ █ █ █ █ █
    █ █ █ █ █ . . . . . . . █ █ █ █ █ █ █ █ █ █
    █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █
    """
        |> toScreen



-- INTERNAL


toScreen string =
    let
        tilemap =
            string
                |> Tilemap.fromString charTiles
                |> Maybe.withDefault (Tilemap.empty8x8Tile 0 0)

        collisionLayer =
            string
                |> CollisionLayer.fromString
                    (Dict.keys charTiles |> List.filter ((/=) '.'))
                |> Maybe.withDefault (CollisionLayer.empty Levers.screenWidthTiles Levers.screenHeightTiles)
    in
    Screen.make22x22 tilemap collisionLayer
        |> Maybe.withDefault Screen.error22x22


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
