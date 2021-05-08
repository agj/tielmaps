module Screen exposing
    ( Screen
    , empty22x22
    , error22x22
    , make22x22
    , map
    )

import CollisionLayer exposing (CollisionLayer)
import Dict
import Map exposing (Map)
import Size exposing (Size22x22, Size8x8)
import Tile


type Screen mapSize tileSize
    = Screen (Map tileSize) CollisionLayer


make22x22 : Map a -> CollisionLayer -> Maybe (Screen Size22x22 a)
make22x22 m coll =
    if
        Map.width m
            == 22
            && Map.height m
            == 22
            && CollisionLayer.width coll
            == 22
            && CollisionLayer.height coll
            == 22
    then
        Just (Screen m coll)

    else
        Nothing


empty22x22 : Screen Size22x22 Size8x8
empty22x22 =
    Screen (Map.empty8x8Tile 22 22) (CollisionLayer.empty 22 22)


error22x22 : Screen Size22x22 Size8x8
error22x22 =
    Screen errorMap (CollisionLayer.empty 22 22)


map : Screen a b -> Map b
map (Screen m _) =
    m



-- INTERNAL


errorMap : Map Size8x8
errorMap =
    """
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # #
"""
        |> Map.fromString
            (Dict.fromList
                [ ( '#', Tile.error8x8 )
                ]
            )
        |> Maybe.withDefault (Map.empty8x8Tile 0 0)
