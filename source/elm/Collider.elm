module Collider exposing (collideAvatar)

import Avatar exposing (Avatar)
import Collider.Interface exposing (Collider, PointChecker, Position)
import Point exposing (Point)
import World exposing (World)


collideAvatar : World a -> Avatar -> Avatar
collideAvatar world avatar =
    let
        pointChecker =
            World.collider world

        tw =
            World.tileWidth world

        th =
            World.tileHeight world
    in
    collide tw th pointChecker Avatar.collide avatar


collide : Int -> Int -> PointChecker -> (Collider -> movingObject -> movingObject) -> movingObject -> movingObject
collide tileWidth tileHeight pointChecker collideFn movingObject =
    collideFn (collider pointChecker tileWidth tileHeight) movingObject



-- INTERNAL


{-| Given a `PointChecker`, generates a `Collider` function
to provide a moving object in order to let them adjust position for collisions.
-}
collider : PointChecker -> Int -> Int -> Collider
collider collidesAt tileWidth tileHeight ({ x, y, prevX, prevY, width, height } as avatar) =
    let
        { checkXPoint, checkYPoint, needsChecksPoint } =
            getPointsToCheck avatar

        stopX =
            collidesAt (Point.x checkXPoint) (Point.y checkXPoint)

        stopY =
            collidesAt (Point.x checkYPoint) (Point.y checkYPoint)

        needsFurtherChecks =
            collidesAt (Point.x needsChecksPoint) (Point.y needsChecksPoint)
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


{-| Returns three corner points that can be collision-checked to know
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


{-| When colliding directly against an outer corner, we need to know whether to stop movement
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
