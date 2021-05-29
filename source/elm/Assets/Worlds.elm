module Assets.Worlds exposing (..)

import Assets.Screens as Screens
import Screen
import Size exposing (Size22x22, Size8x8)
import World exposing (World)


testWorld : World Size22x22 Size8x8
testWorld =
    World.stitchVertically
        (World.singleton Screens.testScreen2)
        (World.singleton Screens.testScreen1)
        |> Maybe.andThen
            (\w ->
                World.stitchVertically
                    (World.singleton Screens.testScreen3)
                    w
            )
        |> Maybe.withDefault (World.singleton Screen.error22x22)
