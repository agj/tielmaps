module Screen exposing
    ( Screen
    , collider
    , colors
    , empty22x22
    , error22x22
    , heightInTiles
    , make22x22
    , tileHeight
    , tileWidth
    , tilemap
    , widthInTiles
    )

import CollisionLayer exposing (CollisionLayer)
import Colors exposing (Colors)
import Dict
import Graphic
import Size exposing (Size22x22, Size8x8)
import Tilemap exposing (Tilemap)


type Screen mapSize tileSize
    = Screen
        { tilemap_ : Tilemap tileSize
        , collisionLayer_ : CollisionLayer
        , tileWidth_ : Int
        , tileHeight_ : Int
        , colors_ : Colors
        }


make22x22 : Colors -> Tilemap a -> CollisionLayer -> Maybe (Screen Size22x22 a)
make22x22 colors_ m coll =
    let
        width_ =
            Tilemap.width m

        height_ =
            Tilemap.height m
    in
    if
        (width_ == 22)
            && (height_ == 22)
            && (CollisionLayer.width coll == 22)
            && (CollisionLayer.height coll == 22)
    then
        Just
            (Screen
                { tilemap_ = m
                , collisionLayer_ = coll
                , tileWidth_ = Tilemap.tileWidth m
                , tileHeight_ = Tilemap.tileHeight m
                , colors_ = colors_
                }
            )

    else
        Nothing


empty22x22 : Colors -> Screen Size22x22 Size8x8
empty22x22 colors_ =
    Screen
        { tilemap_ = Tilemap.empty8x8Tile 22 22
        , collisionLayer_ = CollisionLayer.empty 22 22
        , tileWidth_ = 8
        , tileHeight_ = 8
        , colors_ = colors_
        }


error22x22 : Screen Size22x22 Size8x8
error22x22 =
    Screen
        { tilemap_ = errorTilemap
        , collisionLayer_ = CollisionLayer.empty 22 22
        , tileWidth_ = 8
        , tileHeight_ = 8
        , colors_ = Colors.default
        }


tilemap : Screen a b -> Tilemap b
tilemap (Screen { tilemap_ }) =
    tilemap_


{-| Checks whether there's a solid object at position x, y.
Normally called from within `Collider.collide`.
-}
collider : Screen a b -> Int -> Int -> Bool
collider (Screen { collisionLayer_, tileWidth_, tileHeight_ }) x_ y_ =
    CollisionLayer.getAt (x_ // tileWidth_) (y_ // tileHeight_) collisionLayer_


tileWidth : Screen a b -> Int
tileWidth (Screen { tileWidth_ }) =
    tileWidth_


tileHeight : Screen a b -> Int
tileHeight (Screen { tileHeight_ }) =
    tileHeight_


widthInTiles : Screen a b -> Int
widthInTiles (Screen { tilemap_ }) =
    Tilemap.width tilemap_


heightInTiles : Screen a b -> Int
heightInTiles (Screen { tilemap_ }) =
    Tilemap.height tilemap_


colors : Screen a b -> Colors
colors (Screen { colors_ }) =
    colors_



-- INTERNAL


errorTilemap : Tilemap Size8x8
errorTilemap =
    fullTilemapString
        |> Tilemap.fromString
            (Dict.fromList
                [ ( '#', Graphic.error8x8 )
                ]
            )
        |> Maybe.withDefault (Tilemap.empty8x8Tile 0 0)


fullTilemapString : String
fullTilemapString =
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
