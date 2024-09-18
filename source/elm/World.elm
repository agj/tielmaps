module World exposing
    ( World
    , avatarPositionOnScreen
    , collider
    , currentScreen
    , fromArray2d
    , heightInScreens
    , screenAt
    , singleton
    , stitchHorizontally
    , stitchVertically
    , tileHeight
    , tileWidth
    , widthInScreens
    )

import Array2d exposing (Array2d)
import Avatar exposing (Avatar)
import Collider.Interface as Collider
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
    World
        { screens = Array2d.repeat 1 1 screen
        , tileWidth_ = 8
        , tileHeight_ = 8
        , screenWidthInTiles = Screen.widthInTiles screen
        , screenHeightInTiles = Screen.heightInTiles screen
        , screenWidthInPixels = Screen.widthInTiles screen * 8
        , screenHeightInPixels = Screen.heightInTiles screen * 8
        }


fromArray2d : Array2d (Screen a b) -> Maybe (World a b)
fromArray2d screens =
    Array2d.get 0 0 screens
        |> Maybe.map
            (\screen ->
                World
                    { screens = screens
                    , tileWidth_ = 8
                    , tileHeight_ = 8
                    , screenWidthInTiles = Screen.widthInTiles screen
                    , screenHeightInTiles = Screen.heightInTiles screen
                    , screenWidthInPixels = Screen.widthInTiles screen * 8
                    , screenHeightInPixels = Screen.heightInTiles screen * 8
                    }
            )


stitchHorizontally : World a b -> World a b -> Maybe (World a b)
stitchHorizontally (World left) (World right) =
    stitchArray2dX left.screens right.screens
        |> Maybe.map
            (\stitchedScreens ->
                World
                    { screens = stitchedScreens
                    , tileWidth_ = left.tileWidth_
                    , tileHeight_ = left.tileHeight_
                    , screenWidthInTiles = left.screenWidthInTiles
                    , screenHeightInTiles = left.screenHeightInTiles
                    , screenWidthInPixels = left.screenWidthInPixels
                    , screenHeightInPixels = left.screenHeightInPixels
                    }
            )


stitchVertically : World a b -> World a b -> Maybe (World a b)
stitchVertically (World top) (World bottom) =
    stitchArray2dY top.screens bottom.screens
        |> Maybe.map
            (\stitchedScreens ->
                World
                    { screens = stitchedScreens
                    , tileWidth_ = top.tileWidth_
                    , tileHeight_ = top.tileHeight_
                    , screenWidthInTiles = top.screenWidthInTiles
                    , screenHeightInTiles = top.screenHeightInTiles
                    , screenWidthInPixels = top.screenWidthInPixels
                    , screenHeightInPixels = top.screenHeightInPixels
                    }
            )


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


screenAt : Int -> Int -> World a b -> Maybe (Screen a b)
screenAt x y (World { screenWidthInPixels, screenHeightInPixels, screens }) =
    getScreenWrapping screens screenWidthInPixels screenHeightInPixels x y


currentScreen : Avatar c -> World a b -> Maybe (Screen a b)
currentScreen avatar (World { screenWidthInPixels, screenHeightInPixels, screens }) =
    let
        x =
            Avatar.baseX avatar

        y =
            Avatar.baseY avatar

        ( screenX, screenY ) =
            getScreenPosWrapping screens screenWidthInPixels screenHeightInPixels x y
    in
    Array2d.get screenX screenY screens


avatarPositionOnScreen : Avatar c -> World a b -> ( Int, Int )
avatarPositionOnScreen avatar (World { screenWidthInPixels, screenHeightInPixels }) =
    let
        x =
            Avatar.baseX avatar

        y =
            Avatar.baseY avatar

        xOffset =
            x - modBy screenWidthInPixels x

        yOffset =
            y - modBy screenHeightInPixels y
    in
    ( Avatar.topLeftX avatar - xOffset
    , Avatar.topLeftY avatar - yOffset
    )


collider : World a b -> Collider.PointChecker
collider (World { screenWidthInPixels, screenHeightInPixels, screens }) x y =
    let
        screenM =
            getScreenWrapping screens screenWidthInPixels screenHeightInPixels x y
    in
    case screenM of
        Just screen ->
            Screen.collider screen (modBy screenWidthInPixels x) (modBy screenHeightInPixels y)

        Nothing ->
            False



-- INTERNAL


getScreenWrapping : Array2d (Screen a b) -> Int -> Int -> Int -> Int -> Maybe (Screen a b)
getScreenWrapping screens screenWidthInPixels screenHeightInPixels x_ y_ =
    let
        ( x, y ) =
            getScreenPosWrapping screens screenWidthInPixels screenHeightInPixels x_ y_
    in
    Array2d.get x y screens


getScreenPosWrapping : Array2d (Screen a b) -> Int -> Int -> Int -> Int -> ( Int, Int )
getScreenPosWrapping screens screenWidthInPixels screenHeightInPixels x_ y_ =
    let
        x =
            floor (toFloat x_ / toFloat screenWidthInPixels)

        y =
            floor (toFloat y_ / toFloat screenHeightInPixels)

        w =
            Array2d.width screens

        h =
            Array2d.height screens
    in
    ( modBy w x
    , modBy h y
    )


stitchArray2dX : Array2d a -> Array2d a -> Maybe (Array2d a)
stitchArray2dX left right =
    if Array2d.height left == Array2d.height right then
        let
            leftWidth =
                Array2d.width left

            fullWidth =
                leftWidth
                    + Array2d.width right

            height_ =
                Array2d.height left

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
                                        if x < leftWidth then
                                            Array2d.get x y left

                                        else
                                            Array2d.get (x - leftWidth) y right
                                    )
                           )
                )
                []
            |> Maybe.combine
            |> Maybe.andThen (Array2d.fromList fullWidth)

    else
        Nothing


stitchArray2dY : Array2d a -> Array2d a -> Maybe (Array2d a)
stitchArray2dY top bottom =
    if Array2d.width top == Array2d.width bottom then
        let
            topHeight =
                Array2d.height top

            fullHeight =
                topHeight
                    + Array2d.height bottom

            width_ =
                Array2d.width top

            listX =
                List.range 0 (width_ - 1)

            listY =
                List.range 0 (fullHeight - 1)
        in
        listX
            |> List.foldl
                (\x r ->
                    r
                        ++ (listY
                                |> List.map
                                    (\y ->
                                        if y < topHeight then
                                            Array2d.get x y top

                                        else
                                            Array2d.get x (y - topHeight) bottom
                                    )
                           )
                )
                []
            |> Maybe.combine
            |> Maybe.andThen (Array2d.fromList width_)

    else
        Nothing
