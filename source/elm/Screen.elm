module Screen exposing
    ( Screen
    , collider
    , colors
    , empty22x22
    , error22x22
    , heightInTiles
    , make22x22
    , tilemap
    , widthInTiles
    )

import CollisionLayer exposing (CollisionLayer)
import Colors exposing (Colors)
import Dict
import Graphic
import Size exposing (Size22x22)
import Tilemap exposing (Tilemap)


type Screen mapSize
    = Screen
        { tilemap_ : Tilemap
        , collisionLayer_ : CollisionLayer
        , colors_ : Colors
        }


make22x22 : Colors -> Tilemap -> CollisionLayer -> Maybe (Screen Size22x22)
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
                , colors_ = colors_
                }
            )

    else
        Nothing


empty22x22 : Colors -> Screen Size22x22
empty22x22 colors_ =
    Screen
        { tilemap_ = Tilemap.empty8x8Tile 22 22
        , collisionLayer_ = CollisionLayer.empty 22 22
        , colors_ = colors_
        }


error22x22 : Screen Size22x22
error22x22 =
    Screen
        { tilemap_ = errorTilemap
        , collisionLayer_ = CollisionLayer.empty 22 22
        , colors_ = Colors.default
        }


tilemap : Screen a -> Tilemap
tilemap (Screen { tilemap_ }) =
    tilemap_


{-| Checks whether there's a solid object at position x, y.
Normally called from within `Collider.collide`.
-}
collider : Screen a -> Int -> Int -> Bool
collider (Screen { collisionLayer_ }) x_ y_ =
    CollisionLayer.getAt (x_ // 8) (y_ // 8) collisionLayer_


widthInTiles : Screen a -> Int
widthInTiles (Screen { tilemap_ }) =
    Tilemap.width tilemap_


heightInTiles : Screen a -> Int
heightInTiles (Screen { tilemap_ }) =
    Tilemap.height tilemap_


colors : Screen a -> Colors
colors (Screen { colors_ }) =
    colors_



-- INTERNAL


errorTilemap : Tilemap
errorTilemap =
    fullTilemapString
        |> Tilemap.fromString
            (Dict.fromList
                [ ( '#', Graphic.Error )
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
