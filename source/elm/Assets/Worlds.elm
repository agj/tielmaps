module Assets.Worlds exposing (..)

import Assets.Screens as Screens
import Size exposing (Size22x22, Size8x8)
import World exposing (World)


testWorld : World Size22x22 Size8x8
testWorld =
    World.singleton Screens.testScreen
