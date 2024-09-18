module Assets.Screens exposing (testScreen1, testScreen2, testScreen3, testScreen4, testScreen5, testScreen6)

import CollisionLayer
import Colors exposing (Colors)
import Dict exposing (Dict)
import Graphic exposing (Graphic)
import Levers
import Palette
import Screen exposing (Screen)
import Size exposing (Size22x22)
import Tilemap


testScreen6 : Screen Size22x22
testScreen6 =
    """
    . . . . . . . . . . . . . ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒
    . . . . . . . . . . . . . ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒
    . . . . . . . . . . . . . ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒
    . . ▓ ▀ ▀ ▓ . . ▓ . . ▓ . ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒
    . . ▓ . . ▓ . . ▓ . . ▓ . . . . . . . . . .
    . . ▓ . . ▓ . . ▓ . . ▓ . . . . . . . . . .
    ▀ ▀ ▓ . . ▓ . . ▓ . . ▓ . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒ . . . . . . . . . . . . ▒ ▒
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . ▓ . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . ▓ . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    ▓ . . . . . ▀ ▀ ▀ ▀ . . ▀ ▀ ▀ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ . . . . . . . . . . . . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ . . . . . . . . . . . . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ . . . . . . . . . △ ▓ . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ . . . . . . ◍ ◍ . ▯ ▓ . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ . . . . . ▒ ▒ ▒ ▒ ▒ ▒ ▒ . . ▓ ▓ ▓ ▓ ▓ ▓ ▓
    """
        |> toScreen Palette.deepBlueSet


testScreen5 : Screen Size22x22
testScreen5 =
    """
    ▓ . . . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓ . . ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ . . . . ▒ ▒ ▓ ▓ ▓ ▓ ▓ ▓ ▓ . ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ . . . . ▓ ▓ ▓ . . . . . . . ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ . . ▒ ▒ ▒ ▓ ▓ . . . . . . . ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ . . ▓ . . . . . . ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ . . ▓ . . . . . . . . . . ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ ▀ . ▓ . . . . . . . . . . ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ . . ▓ . ▚ ▚ ▚ ▚ . . . . . ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ . . ▓ . . . . . . . . . . ▓ ▓ ▓ ▓ ▚ ▚ ▚ ▚
    ▓ . ▀ ▓ . . . . . . . . . . ▓ ▓ ▓ ▓ ▚ ▚ ▚ ▚
    ▓ . . ▓ . . . . . ▚ ▚ ▚ ▚ . ▓ ▓ ▓ ▓ ▚ ▚ ▚ ▚
    ▓ . . ▓ . . . . . . . . . . ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ ▀ . ▓ . . . . . . . . . . ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ . . ▓ ▚ ▚ ▚ ▚ . . . . . . ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ . . ▓ . . . . . . . . . . ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ . ▀ ▓ . . . . . . ◍ ◍ . . . ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ . . ▓ . . . . ▚ ▚ ▚ ▚ . . . ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ . . ▓ . . . . . . . . . . . ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ ▀ . ▓ . . . . . . . . . . . ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ . . ▓ ▚ ▚ ▚ ▚ . . . . . . . ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ . . ▓ . . . . . . . . . . . ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ . ▀ ▓ . . . . . ▚ ▚ ▚ ▚ . . ▚ ▚ ▚ ▚ ▚ ▚ ▚
    """
        |> toScreen Palette.deepBlueSet


testScreen4 : Screen Size22x22
testScreen4 =
    """
    ▓ . . ▓ . . . . . ▚ ▚ ▚ ▚ . . ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ . . ▓ . . . . . . . . . . ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ ▀ . ▓ . . . . . . . . . . ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ . . ▓ . . . . ◍ ◍ . . . . ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚
    ▓ . . ▓ . . . ▓ ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚ ▚
    . . ▀ ▓ . . . ▓ ▓ . . . . . . . . . . . . .
    . . . ▓ . . . ▓ ▓ . . . . . . . . . . . . .
    . . . ▓ . ▀ ▀ ▓ ▓ . . . . . . . . . . . . .
    ▓ ▓ ▓ ▓ . . . ▓ ▓ . . . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ ▓ ▓ ▓ . . . ▓ ▓ . . . ▀ ▀ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ ▓ ▓ ▓ ▀ ▀ . ▓ ▓ . . . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ ▓ ▓ ▓ . . . ▓ ▓ . . . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    . . . . . . ▀ . . . ▀ ▀ . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . ▀ ▀ ▀ ▀ ▀ . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . ▀ ▀ ▀ ▀ . . ▀ ▀ ▀ ▀ . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . ▀ ▀ ▀ ▀ . . . . . . .
    """
        |> toScreen Palette.sunsetSet


testScreen3 : Screen Size22x22
testScreen3 =
    """
    . . . . . . . . . . . ▀ ▀ ▀ ▀ . . . . . . .
    . . . . . . . ▀ ▀ . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . ▀ ▀ . . ▀ ▀ . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . ▀ . . . ▀ ▀ . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . ▀ ▀ ▀ ▀ ▀ . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . ▀ ▀ ▀ ▀ . . ▀ ▀ ▀ ▀ . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . ▀ ▀ . . ▀ ▀ ▀ ▀ . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . . . . ▀ ▀ . . ▀ ▀ . . . . . . . . . . .
    . . . . . . . . . . . . . . . . . . . . . .
    . . ▓ ▓ . . . . . . . . . . . . . . . . . .
    . . ▓ ▒ ▒ ▒ ▒ . . . . . . . . . . . . . . .
    """
        |> toScreen Palette.sunsetSet


testScreen2 : Screen Size22x22
testScreen2 =
    """
    . . ▓ ▒ ▒ ▒ ▒ . . . . . . . . . . . . . . .
    . . . . . ▓ ▓ . . . . . . . . . . . . . . .
    . . . . . ▓ ▒ ▒ ▒ ▒ . . . . ╥ . . . . . . .
    . . . . . . . . ▓ ▓ . . . . ║ . . . . . . .
    . . . . ╥ . . . ▓ ▒ ▒ ▒ ▒ . ║ . . . . . . .
    . ◍ ◍ . ║ . . . . . . ▓ ▓ . ╨ . . . . . . .
    ▒ ▒ ▒ ▒ ║ . . . . . . ▓ ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒
    . . ▓ ▓ ╨ . . . . . . . . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓
    . . ▓ ▒ ▒ ▒ ▒ . . . . . . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓
    . . . . . ▓ ▓ . ◍ ◍ . . . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓
    . . . . . ▓ ▒ ▒ ▒ ▒ . . . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓
    . . . . . . . . ╥ ▓ ▓ . . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓
    . . . . . . . . ║ ▓ ▓ . . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓
    . . . . . . . . . . . . . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓
    . . . . . . . . . . . . ▒ ▒ ▒ ▒ ▓ ▓ ▓ ▓ ▓ ▓
    . . . . . . . . . ◍ ◍ . ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    . . . . . . . . . ▒ ▒ ▒ ▒ ▓ . . . . . . . .
    . . . . . . . . . ▓ ▓ ▓ ▓ ▓ . . . . . . . .
    . . . . . . ▒ ▒ ▒ ▒ ▓ . . . . . . . . . . .
    . . . . . . ▓ ▓ ▓ ▓ ▓ . . . . . . . . . . .
    . . . . . . ▓ ▓ ▓ ▓ ▓ . . . . . . . . . . .
    . . . ▒ ▒ ▒ ▒ ▓ . . . . . . . . . . . . . .
    """
        |> toScreen Palette.caveSet


testScreen1 : Screen Size22x22
testScreen1 =
    """
    . . . ▒ ▒ ▒ ▒ ▓ . . . . . . . . . . . . . .
    . . . ▓ ▓ ╥ . . . . . . . . . . . . . . . .
    ▓ ▓ ▓ ▓ . . . . . . . . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ ▓ ▓ ▓ . . . . . . . . . . △ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ ▓ ▓ ▓ . . . . . . . . . . ▯ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ ▓ ▓ ▓ . . . . ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒
    . . . ▓ . ▒ . . . . . . . . . . . . . . . .
    . . . ▓ . . . . . . . . . . . . . . . . . .
    ▓ ▓ ▒ . . . . . . . . . . . . . ▓ ▓ ▓ ▓ ▓ ▓
    ▓ ▓ ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒ . . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ ▓ ╥ . . . . . . . . . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ ▓ ║ . . . ◍ ◍ . . . . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ ▓ . . . . ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ ▓ . . . . . . ╥ . . . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ ▓ . . . . . . ║ . . . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ ▓ ▒ ▒ ▒ ▒ ▓ ▓ ╨ ◍ ◍ . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ ▓ . . . . ▓ ▒ ▒ ▒ ▒ . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ △ . . . . ╥ . . . ╥ . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ ▯ . . . . ║ . . . ║ . . . ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ ▒ ▒ ▒ ▒ . ╨ . . . ╨ . ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ ▓ ▓ ▓ ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▒ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓ ▓
    """
        |> toScreen Palette.caveSet



-- INTERNAL


toScreen : Colors -> String -> Screen Size22x22
toScreen colors string =
    let
        tilemap =
            string
                |> Tilemap.fromString charTiles
                |> Maybe.withDefault (Tilemap.empty8x8Tile 0 0)

        collisionLayer =
            string
                |> CollisionLayer.fromString
                    (Dict.keys charTiles
                        |> List.filter isSolid
                    )
                |> Maybe.withDefault (CollisionLayer.empty Levers.screenWidthInTiles Levers.screenHeightInTiles)
    in
    Screen.make22x22 colors tilemap collisionLayer
        |> Maybe.withDefault Screen.error22x22


charTiles : Dict Char Graphic
charTiles =
    Dict.fromList
        [ ( '.', Graphic.Empty )
        , ( '▓', Graphic.TileDirt )
        , ( '▒', Graphic.TileBrick )
        , ( '▀', Graphic.TileGrass )
        , ( '▚', Graphic.TileStone )
        , ( '╥', Graphic.TilePillarTop )
        , ( '║', Graphic.TilePillarMiddle )
        , ( '╨', Graphic.TilePillarBottom )
        , ( '◍', Graphic.TileBush )
        , ( '△', Graphic.TileDoorTop )
        , ( '▯', Graphic.TileDoorBottom )
        ]


isSolid : Char -> Bool
isSolid ch =
    [ '.', '╥', '║', '╨', '◍', '△', '▯' ]
        |> List.member ch
        |> not
