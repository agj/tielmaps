module Collider exposing (collideAvatar)

import Avatar exposing (Avatar)
import CollisionLayer exposing (CollisionLayer)
import Html exposing (q)
import Screen exposing (Screen)


collideAvatar : Screen a b -> Avatar b -> Avatar b
collideAvatar screen avatar =
    let
        collisionLayer =
            Screen.collisionLayer screen

        tw =
            Screen.tileWidth screen

        th =
            Screen.tileHeight screen

        collider { left, right, top, bottom } =
            let
                ( x, y ) =
                    pointToTile { x = left, y = top, tw = tw, th = th }

                tileChecks =
                    [ ( x, y )
                    , ( x + 1, y )
                    , ( x, y + 1 )
                    , ( x + 1, y + 1 )
                    ]
                        |> List.map
                            (\( x_, y_ ) -> CollisionLayer.getAt x_ y_ collisionLayer)
            in
            List.any ((==) True) tileChecks
    in
    Avatar.collide collider avatar



-- INTERNAL


pointToTile : { x : Int, y : Int, tw : Int, th : Int } -> ( Int, Int )
pointToTile { x, y, tw, th } =
    ( x // tw, y // th )
