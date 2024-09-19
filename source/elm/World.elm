module World exposing
    ( World
    , avatarPositionOnScreen
    , collider
    , currentScreen
    , fromArray2d
    , heightInScreens
    , screenAt
    , singleton
    , tileHeight
    , tileWidth
    , widthInScreens
    )

import Array2d exposing (Array2d)
import Avatar exposing (Avatar)
import Collider.Interface as Collider
import Maybe.Extra as Maybe
import Screen exposing (Screen)


type World mapSize
    = World
        { screens : Array2d (Screen mapSize)
        , tileWidth_ : Int
        , tileHeight_ : Int
        , screenWidthInTiles : Int
        , screenHeightInTiles : Int
        , screenWidthInPixels : Int
        , screenHeightInPixels : Int
        }


singleton : Screen a -> World a
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


fromArray2d : Array2d (Screen a) -> Maybe (World a)
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


widthInScreens : World a -> Int
widthInScreens (World { screens }) =
    Array2d.width screens


heightInScreens : World a -> Int
heightInScreens (World { screens }) =
    Array2d.height screens


tileWidth : World a -> Int
tileWidth (World { tileWidth_ }) =
    tileWidth_


tileHeight : World a -> Int
tileHeight (World { tileHeight_ }) =
    tileHeight_


screenAt : Int -> Int -> World a -> Maybe (Screen a)
screenAt x y (World { screenWidthInPixels, screenHeightInPixels, screens }) =
    getScreenWrapping screens screenWidthInPixels screenHeightInPixels x y


currentScreen : Avatar -> World a -> Maybe (Screen a)
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


avatarPositionOnScreen : Avatar -> World a -> ( Int, Int )
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


collider : World a -> Collider.PointChecker
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


getScreenWrapping : Array2d (Screen a) -> Int -> Int -> Int -> Int -> Maybe (Screen a)
getScreenWrapping screens screenWidthInPixels screenHeightInPixels x_ y_ =
    let
        ( x, y ) =
            getScreenPosWrapping screens screenWidthInPixels screenHeightInPixels x_ y_
    in
    Array2d.get x y screens


getScreenPosWrapping : Array2d (Screen a) -> Int -> Int -> Int -> Int -> ( Int, Int )
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
