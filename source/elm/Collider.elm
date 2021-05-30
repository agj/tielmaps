module Collider exposing (collideAvatar)

import Avatar exposing (Avatar)
import Collider.Callback exposing (Callback, Position)
import CollisionLayer exposing (CollisionLayer)
import Screen exposing (Screen)
import World exposing (World)


collideAvatar : World a b -> Avatar b -> Avatar b
collideAvatar world avatar =
    let
        collAt =
            World.collider world

        tw =
            World.tileWidth world

        th =
            World.tileHeight world
    in
    Avatar.collide (collider collAt tw th) avatar



-- INTERNAL


type alias Point =
    ( Int, Int )


{-| Generates a Callback function to provide a moving object in order to check for collisions.
-}
collider : (Int -> Int -> Bool) -> Int -> Int -> Callback
collider collidesAt tileWidth tileHeight ({ x, y, prevX, prevY, width, height } as avatar) =
    let
        { checkXPoint, checkYPoint, needsChecksPoint } =
            getPointsToCheck avatar

        stopX =
            collidesAt (Tuple.first checkXPoint) (Tuple.second checkXPoint)

        stopY =
            collidesAt (Tuple.first checkYPoint) (Tuple.second checkYPoint)

        needsFurtherChecks =
            collidesAt (Tuple.first needsChecksPoint) (Tuple.second needsChecksPoint)
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


{-| Returns three corner points that can be collision-checked against a CollisionLayer to know
if the moving object needs to stop moving on the x or y axis.
-}
getPointsToCheck : Position -> { checkXPoint : Point, checkYPoint : Point, needsChecksPoint : Point }
getPointsToCheck { x, y, width, height, prevX, prevY } =
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
        { checkXPoint = topRight
        , checkYPoint = bottomLeft
        , needsChecksPoint = bottomRight
        }

    else if movingRight && not movingDown then
        { checkXPoint = bottomRight
        , checkYPoint = topLeft
        , needsChecksPoint = topRight
        }

    else if not movingRight && movingDown then
        { checkXPoint = topLeft
        , checkYPoint = bottomRight
        , needsChecksPoint = bottomLeft
        }

    else
        { checkXPoint = bottomLeft
        , checkYPoint = topRight
        , needsChecksPoint = topLeft
        }


{-| After a collision, the position needs to be corrected on one or two axes.
This function provides that offset for one of the axes.
-}
getAxisCorrection : Int -> Int -> Int -> Int -> Int
getAxisCorrection posNow posPrev avSize tileSize =
    if goingPositive posNow posPrev then
        -(modBy tileSize (posNow + avSize))

    else
        tileSize - modBy tileSize posNow


{-| When colliding directly against an edge, we need to know whether to stop movement
on the x or y axes. True is x, False is y.
-}
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


goingPositive : Int -> Int -> Bool
goingPositive current previous =
    current - previous > 0
