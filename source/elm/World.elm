module World exposing
    ( World
    , collider
    , currentScreen
    , heightInScreens
    , render
    , singleton
    , stitchHorizontally
    , tileHeight
    , tileWidth
    , widthInScreens
    )

import Array2d exposing (Array2d)
import Avatar exposing (Avatar)
import Bitmap exposing (Bitmap)
import List.Extra as List
import Maybe.Extra as Maybe
import Screen exposing (Screen)


type World mapSize tileSize
    = World
        { screens : Array2d (Screen mapSize tileSize)
        , tileWidth_ : Int
        , tileHeight_ : Int
        , screenWidthInTiles : Int
        , screenHeightInTiles : Int
        , screenWidthInPixels : Int
        , screenHeightInPixels : Int
        }


singleton : Screen a b -> World a b
singleton screen =
    let
        tileWidth_ =
            Screen.tileWidth screen

        tileHeight_ =
            Screen.tileHeight screen
    in
    World
        { screens = Array2d.repeat 1 1 screen
        , tileWidth_ = tileWidth_
        , tileHeight_ = tileHeight_
        , screenWidthInTiles = Screen.widthInTiles screen
        , screenHeightInTiles = Screen.heightInTiles screen
        , screenWidthInPixels = Screen.widthInTiles screen * tileWidth_
        , screenHeightInPixels = Screen.heightInTiles screen * tileHeight_
        }


stitchHorizontally : World a b -> World a b -> Maybe (World a b)
stitchHorizontally (World dataA) (World dataB) =
    case stitchArray2dX dataA.screens dataB.screens of
        Just stitchedScreens ->
            Just
                (World
                    { screens = stitchedScreens
                    , tileWidth_ = dataA.tileWidth_
                    , tileHeight_ = dataA.tileHeight_
                    , screenWidthInTiles = dataA.screenWidthInTiles
                    , screenHeightInTiles = dataA.screenHeightInTiles
                    , screenWidthInPixels = dataA.screenWidthInPixels
                    , screenHeightInPixels = dataA.screenHeightInPixels
                    }
                )

        Nothing ->
            Nothing


widthInScreens : World a b -> Int
widthInScreens (World { screens }) =
    Array2d.width screens


heightInScreens : World a b -> Int
heightInScreens (World { screens }) =
    Array2d.height screens


tileWidth : World a b -> Int
tileWidth (World { tileWidth_ }) =
    tileWidth_


tileHeight : World a b -> Int
tileHeight (World { tileHeight_ }) =
    tileHeight_


currentScreen : Int -> Int -> World a b -> Maybe (Screen a b)
currentScreen x y (World { screenWidthInPixels, screenHeightInPixels, screens }) =
    getScreenWrapping screens (x // screenWidthInPixels) (y // screenHeightInPixels)


render : Avatar c -> World a b -> ( Bitmap, World a b )
render avatar ((World ({ screenWidthInPixels, screenHeightInPixels, screens } as state)) as world) =
    let
        x =
            Avatar.baseX avatar

        y =
            Avatar.baseY avatar

        ( screenX, screenY ) =
            getScreenPosWrapping screens (x // screenWidthInPixels) (y // screenHeightInPixels)

        screenM =
            Array2d.get screenX screenY screens
    in
    case screenM of
        Just screen ->
            let
                ( bm, newScreen ) =
                    Screen.toBitmapMemoized screen

                xOffset =
                    x - modBy screenWidthInPixels x

                yOffset =
                    y - modBy screenHeightInPixels y

                bitmap =
                    bm
                        |> Bitmap.paintBitmap
                            (Avatar.topLeftX avatar - xOffset)
                            (Avatar.topLeftY avatar - yOffset)
                            (Avatar.bitmap avatar)
            in
            ( bitmap, World { state | screens = Array2d.set screenX screenY newScreen screens } )

        Nothing ->
            ( Bitmap.error, world )


collider : World a b -> Int -> Int -> Bool
collider (World { screenWidthInPixels, screenHeightInPixels, screens }) x y =
    let
        screenM =
            getScreenWrapping screens (x // screenWidthInPixels) (y // screenHeightInPixels)
    in
    case screenM of
        Just screen ->
            Screen.collider screen (modBy screenWidthInPixels x) (modBy screenHeightInPixels y)

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
    in
    ( modBy w x_
    , modBy h y_
    )


stitchArray2dX : Array2d a -> Array2d a -> Maybe (Array2d a)
stitchArray2dX a b =
    if Array2d.height a == Array2d.height b then
        let
            aWidth =
                Array2d.width a

            fullWidth =
                aWidth
                    + Array2d.width b

            height_ =
                Array2d.height a

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
