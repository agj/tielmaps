module Screen exposing
    ( Screen
    , collisionLayer
    , empty22x22
    , error22x22
    , make22x22
    , tileHeight
    , tileWidth
    , tilemap
    , toBitmapMemoized
    )

import Bitmap exposing (Bitmap)
import CollisionLayer exposing (CollisionLayer)
import Dict
import Size exposing (Size22x22, Size8x8)
import Tile
import Tilemap exposing (Tilemap)


type Screen mapSize tileSize
    = Screen
        { tilemap_ : Tilemap tileSize
        , collisionLayer_ : CollisionLayer
        , tileWidth_ : Int
        , tileHeight_ : Int
        }


make22x22 : Tilemap a -> CollisionLayer -> Maybe (Screen Size22x22 a)
make22x22 m coll =
    if
        Tilemap.width m
            == 22
            && Tilemap.height m
            == 22
            && CollisionLayer.width coll
            == 22
            && CollisionLayer.height coll
            == 22
    then
        Just
            (Screen
                { tilemap_ = m
                , collisionLayer_ = coll
                , tileWidth_ = Tilemap.tileWidth m
                , tileHeight_ = Tilemap.tileHeight m
                }
            )

    else
        Nothing


empty22x22 : Screen Size22x22 Size8x8
empty22x22 =
    Screen
        { tilemap_ = Tilemap.empty8x8Tile 22 22
        , collisionLayer_ = CollisionLayer.empty 22 22
        , tileWidth_ = 8
        , tileHeight_ = 8
        }


error22x22 : Screen Size22x22 Size8x8
error22x22 =
    Screen
        { tilemap_ = errorTilemap
        , collisionLayer_ = CollisionLayer.empty 22 22
        , tileWidth_ = 8
        , tileHeight_ = 8
        }


tilemap : Screen a b -> Tilemap b
tilemap (Screen { tilemap_ }) =
    tilemap_


collisionLayer : Screen a b -> CollisionLayer
collisionLayer (Screen { collisionLayer_ }) =
    collisionLayer_


tileWidth : Screen a b -> Int
tileWidth (Screen { tileWidth_ }) =
    tileWidth_


tileHeight : Screen a b -> Int
tileHeight (Screen { tileHeight_ }) =
    tileHeight_


toBitmapMemoized : Screen a b -> ( Bitmap, Screen a b )
toBitmapMemoized (Screen ({ tilemap_ } as state)) =
    let
        ( bitmap, newTilemap ) =
            Tilemap.toBitmapMemoized tilemap_
    in
    ( bitmap, Screen { state | tilemap_ = newTilemap } )



-- INTERNAL


errorTilemap : Tilemap Size8x8
errorTilemap =
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
        |> Tilemap.fromString
            (Dict.fromList
                [ ( '#', Tile.error8x8 )
                ]
            )
        |> Maybe.withDefault (Tilemap.empty8x8Tile 0 0)
