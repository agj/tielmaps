module Collider exposing (collideAvatar)

import Avatar exposing (Avatar)
import Collider.Callback exposing (Callback, Position)
import CollisionLayer exposing (CollisionLayer)
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
    in
    Avatar.collide (collider collisionLayer tw th) avatar



-- INTERNAL


type alias Point =
    ( Int, Int )


collider : CollisionLayer -> Int -> Int -> Callback
collider collisionLayer tileWidth tileHeight ({ x, y, prevX, prevY, width, height } as avatar) =
    let
        { a, b, c } =
            getAbc avatar

        stopX =
            checkSolidAtPoint collisionLayer tileWidth tileHeight a

        stopY =
            checkSolidAtPoint collisionLayer tileWidth tileHeight b

        needsFurtherChecks =
            checkSolidAtPoint collisionLayer tileWidth tileHeight c
    in
    if stopX || stopY || needsFurtherChecks then
        let
            xCorrection =
                getAxisCorrection x prevX width tileWidth

            yCorrection =
                getAxisCorrection y prevY height tileHeight
        in
        if stopX || stopY then
            ( if stopX then
                x + xCorrection

              else
                x
            , if stopY then
                y + yCorrection

              else
                y
            )

        else if shouldStopXNotY avatar tileWidth tileHeight then
            ( x + xCorrection, y )

        else
            ( x, y + yCorrection )

    else
        ( x, y )


getAbc : Position -> { a : Point, b : Point, c : Point }
getAbc { x, y, width, height, prevX, prevY } =
    let
        movingRight =
            goingPositive x prevX

        movingDown =
            goingPositive y prevY

        topLeft =
            ( x, y )

        topRight =
            ( x + width - 1, y )

        bottomLeft =
            ( x, y + height - 1 )

        bottomRight =
            ( x + width - 1, y + height - 1 )
    in
    if movingRight && movingDown then
        { a = topRight
        , b = bottomLeft
        , c = bottomRight
        }

    else if movingRight && not movingDown then
        { a = bottomRight
        , b = topLeft
        , c = topRight
        }

    else if not movingRight && movingDown then
        { a = topLeft
        , b = bottomRight
        , c = bottomLeft
        }

    else
        { a = bottomLeft
        , b = topRight
        , c = topLeft
        }


checkSolidAtPoint : CollisionLayer -> Int -> Int -> Point -> Bool
checkSolidAtPoint coll tw th ( x, y ) =
    CollisionLayer.getAt (x // tw) (y // th) coll


getAxisCorrection : Int -> Int -> Int -> Int -> Int
getAxisCorrection posNow posPrev avSize tileSize =
    if goingPositive posNow posPrev then
        -(modBy tileSize (posNow + avSize))

    else
        tileSize - modBy tileSize posNow


shouldStopXNotY : Position -> Int -> Int -> Bool
shouldStopXNotY { x, y, prevX, prevY, width, height } tw th =
    let
        shouldStopX =
            shouldStopAxis x prevX width tw

        shouldStopY =
            shouldStopAxis y prevY height th
    in
    if shouldStopX /= shouldStopY then
        shouldStopX

    else
        False


shouldStopAxis : Int -> Int -> Int -> Int -> Bool
shouldStopAxis posNow posPrev avSize tileSize =
    (posNow + avSize) // tileSize /= (posPrev + avSize) // tileSize


goingPositive current previous =
    current - previous > 0
