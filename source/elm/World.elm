module World exposing
    ( World
    , collider
    , currentScreen
    , height
    , singleton
    , stitchHorizontally
    , tileHeight
    , tileWidth
    , toScreenBitmapMemoized
    , width
    )

import Array2d exposing (Array2d)
import Bitmap exposing (Bitmap)
import List.Extra as List
import Maybe.Extra as Maybe
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


stitchHorizontally : World a b -> World a b -> Maybe (World a b)
stitchHorizontally ((World dataA) as wa) ((World dataB) as wb) =
    let
        stitchedScreensM =
            stitchArray2dX dataA.screens dataB.screens
    in
    case stitchedScreensM of
        Just stitchedScreens ->
            Just
                (World
                    { screens = stitchedScreens
                    , tileWidth_ = dataA.tileWidth_
                    , tileHeight_ = dataA.tileHeight_
                    , screenWidth_ = dataA.screenWidth_
                    , screenHeight_ = dataA.screenHeight_
                    }
                )

        Nothing ->
            Nothing


stitchArray2dX : Array2d a -> Array2d a -> Maybe (Array2d a)
stitchArray2dX a b =
    if Array2d.height a == Array2d.height b then
        let
            aWidth =
                Array2d.width a
                    |> Debug.log "aWidth"

            fullWidth =
                aWidth
                    + Array2d.width b
                    |> Debug.log "fullWidth"

            height_ =
                Array2d.height a
                    |> Debug.log "height"

            listX =
                List.range 0 (fullWidth - 1)

            listY =
                List.range 0 (height_ - 1)
        in
        listX
            |> List.foldl
                (\x r ->
                    r
                        ++ (listY
                                |> List.map
                                    (\y ->
                                        if x < aWidth then
                                            Array2d.get x y a

                                        else
                                            Array2d.get (x - aWidth) y b
                                    )
                           )
                )
                []
            |> Maybe.combine
            |> Maybe.andThen (Array2d.fromList fullWidth)

    else
        Nothing


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
currentScreen x y (World { tileWidth_, tileHeight_, screenWidth_, screenHeight_, screens }) =
    let
        screenPixelW =
            screenWidth_ * tileWidth_

        screenPixelH =
            screenHeight_ * tileHeight_
    in
    getScreenWrapping screens (x // screenPixelW) (y // screenPixelH)


toScreenBitmapMemoized : Int -> Int -> World a b -> ( Bitmap, World a b )
toScreenBitmapMemoized x y ((World ({ tileWidth_, tileHeight_, screenWidth_, screenHeight_, screens } as state)) as world) =
    let
        screenPixelW =
            screenWidth_ * tileWidth_

        screenPixelH =
            screenHeight_ * tileHeight_

        ( screenX, screenY ) =
            getScreenPosWrapping screens (x // screenPixelW) (y // screenPixelH)

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
