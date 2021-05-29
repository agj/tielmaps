module Assets.Worlds exposing (..)

import Array2d
import Assets.Screens as Screens
import Screen
import Size exposing (Size22x22, Size8x8)
import World exposing (World)


testWorld : World Size22x22 Size8x8
testWorld =
    [ Screens.testScreen3, Screens.testScreen2, Screens.testScreen1 ]
        |> Array2d.fromList 1
        |> Maybe.andThen World.fromArray2d
        |> Maybe.withDefault (World.singleton Screen.error22x22)
