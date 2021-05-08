module Screen exposing
    ( Screen
    , collisionLayer
    , empty22x22
    , error22x22
    , make22x22
    , map
    , tileHeight
    , tileWidth
    )

import CollisionLayer exposing (CollisionLayer)
import Dict
import Map exposing (Map)
import Size exposing (Size22x22, Size8x8)
import Tile


type Screen mapSize tileSize
    = Screen
        { map_ : Map tileSize
        , collisionLayer_ : CollisionLayer
        , tileWidth_ : Int
        , tileHeight_ : Int
        }


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
        Just
            (Screen
                { map_ = m
                , collisionLayer_ = coll
                , tileWidth_ = Map.tileWidth m
                , tileHeight_ = Map.tileHeight m
                }
            )

    else
        Nothing


empty22x22 : Screen Size22x22 Size8x8
empty22x22 =
    Screen
        { map_ = Map.empty8x8Tile 22 22
        , collisionLayer_ = CollisionLayer.empty 22 22
        , tileWidth_ = 8
        , tileHeight_ = 8
        }


error22x22 : Screen Size22x22 Size8x8
error22x22 =
    Screen
        { map_ = errorMap
        , collisionLayer_ = CollisionLayer.empty 22 22
        , tileWidth_ = 8
        , tileHeight_ = 8
        }


map : Screen a b -> Map b
map (Screen { map_ }) =
    map_


collisionLayer : Screen a b -> CollisionLayer
collisionLayer (Screen { collisionLayer_ }) =
    collisionLayer_


tileWidth : Screen a b -> Int
tileWidth (Screen { tileWidth_ }) =
    tileWidth_


tileHeight : Screen a b -> Int
tileHeight (Screen { tileHeight_ }) =
    tileHeight_



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
