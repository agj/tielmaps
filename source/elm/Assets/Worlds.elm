module Assets.Worlds exposing (testWorld)

import Array2d
import Assets.Screens as Screens
import Screen
import Size exposing (Size22x22)
import World exposing (World)


testWorld : World Size22x22
testWorld =
    [ Screens.testScreen6
    , Screens.testScreen5
    , Screens.testScreen4
    , Screens.testScreen3
    , Screens.testScreen2
    , Screens.testScreen1
    ]
        |> Array2d.fromList 1
        |> Maybe.andThen World.fromArray2d
        |> Maybe.withDefault (World.singleton Screen.error22x22)
