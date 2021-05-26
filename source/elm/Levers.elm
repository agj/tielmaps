module Levers exposing
    ( colorDark
    , colorLight
    , framesPerSecond
    , gravity
    , jumpDuration
    , jumpSpeed
    , runSpeed
    , screenHeight
    , screenHeightTiles
    , screenWidth
    , screenWidthTiles
    , tileHeight
    , tileWidth
    )

import Color exposing (Color)


type alias FramesPerSecond =
    Int


type alias Frames =
    Int


framesPerSecond : Int
framesPerSecond =
    30


tileWidth : Int
tileWidth =
    8


tileHeight : Int
tileHeight =
    8


screenWidthTiles : Int
screenWidthTiles =
    22


screenHeightTiles : Int
screenHeightTiles =
    22


screenWidth : Int
screenWidth =
    screenWidthTiles * tileWidth


screenHeight : Int
screenHeight =
    screenHeightTiles * tileHeight


gravity : FramesPerSecond
gravity =
    3


runSpeed : FramesPerSecond
runSpeed =
    2


jumpSpeed : FramesPerSecond
jumpSpeed =
    2


jumpDuration : Frames
jumpDuration =
    10


colorLight : Color
colorLight =
    -- Color.hsl (deg 102.4) (pc 64.3) (pc 86.6)
    Color.hsl (deg 53.2) (pc 100) (pc 94.5)


colorDark : Color
colorDark =
    -- Color.hsl (deg 200.9) (pc 89.5) (pc 54.5)
    Color.hsl (deg 30.7) (pc 100) (pc 54.6)



-- INTERNAL


deg : Float -> Float
deg n =
    n / 360


pc : Float -> Float
pc n =
    n / 100
