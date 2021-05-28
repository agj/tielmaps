module World exposing
    ( World
    , collider
    , currentScreen
    , height
    , singleton
    , tileHeight
    , tileWidth
    , toScreenBitmapMemoized
    , width
    )

import Array2d exposing (Array2d)
import Bitmap exposing (Bitmap)
import Screen exposing (Screen)


type World mapSize tileSize
    = World
        { screens : Array2d (Screen mapSize tileSize)
        , tileWidth_ : Int
        , tileHeight_ : Int
        , screenWidth_ : Int
        , screenHeight_ : Int
        }


singleton : Screen a b -> World a b
singleton screen =
    World
        { screens = Array2d.repeat 1 1 screen
        , tileWidth_ = Screen.tileWidth screen
        , tileHeight_ = Screen.tileHeight screen
        , screenWidth_ = Screen.width screen
        , screenHeight_ = Screen.height screen
        }



-- stitchHorizontally : World a b -> World a b -> Maybe (World a b)
-- stitchHorizontally wa wb =
--     if height wa == height wb then
--         Nothing
--     else
--         Nothing


width : World a b -> Int
width (World { screens }) =
    Array2d.width screens


height : World a b -> Int
height (World { screens }) =
    Array2d.height screens


tileWidth : World a b -> Int
tileWidth (World { tileWidth_ }) =
    tileWidth_


tileHeight : World a b -> Int
tileHeight (World { tileHeight_ }) =
    tileHeight_


currentScreen : Int -> Int -> World a b -> Maybe (Screen a b)
currentScreen x y (World { tileWidth_, tileHeight_, screens }) =
    getScreenWrapping screens (x // tileWidth_) (y // tileHeight_)


toScreenBitmapMemoized : Int -> Int -> World a b -> ( Bitmap, World a b )
toScreenBitmapMemoized x y ((World ({ tileWidth_, tileHeight_, screens } as state)) as world) =
    let
        ( screenX, screenY ) =
            getScreenPosWrapping screens (x // tileWidth_) (y // tileWidth_)

        screenM =
            Array2d.get screenX screenY screens
    in
    case screenM of
        Just screen ->
            let
                ( bitmap, newScreen ) =
                    Screen.toBitmapMemoized screen
            in
            ( bitmap, World { state | screens = Array2d.set screenX screenY newScreen screens } )

        Nothing ->
            ( Bitmap.error, world )


collider : World a b -> Int -> Int -> Bool
collider (World { tileWidth_, tileHeight_, screenWidth_, screenHeight_, screens }) x y =
    let
        screenPixelW =
            screenWidth_ * tileWidth_

        screenPixelH =
            screenHeight_ * tileHeight_

        screenM =
            getScreenWrapping screens (x // screenPixelW) (y // screenPixelH)
    in
    case screenM of
        Just screen ->
            Screen.collider screen (modBy screenPixelW x) (modBy screenPixelH y)

        Nothing ->
            False



-- INTERNAL


getScreenWrapping : Array2d (Screen a b) -> Int -> Int -> Maybe (Screen a b)
getScreenWrapping screens x_ y_ =
    let
        ( x, y ) =
            getScreenPosWrapping screens x_ y_
    in
    Array2d.get x y screens


getScreenPosWrapping : Array2d (Screen a b) -> Int -> Int -> ( Int, Int )
getScreenPosWrapping screens x_ y_ =
    let
        w =
            Array2d.width screens

        h =
            Array2d.height screens

        x =
            modBy w x_

        y =
            modBy h y_
    in
    ( x, y )
