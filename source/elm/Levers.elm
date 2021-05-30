module Levers exposing
    ( canvasId
    , colorDark
    , colorLight
    , framesPerSecond
    , gravity
    , jumpDuration
    , jumpSpeed
    , runSpeed
    , screenHeight
    , screenHeightInTiles
    , screenWidth
    , screenWidthInTiles
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


screenWidthInTiles : Int
screenWidthInTiles =
    22


screenHeightInTiles : Int
screenHeightInTiles =
    22


screenWidth : Int
screenWidth =
    screenWidthInTiles * tileWidth


screenHeight : Int
screenHeight =
    screenHeightInTiles * tileHeight


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
    12


colorLight : Color
colorLight =
    Color.hsl (deg 53.2) (pc 100) (pc 94.5)


colorDark : Color
colorDark =
    Color.hsl (deg 30.7) (pc 100) (pc 54.6)


canvasId : String
canvasId =
    "canvas"



-- INTERNAL


deg : Float -> Float
deg n =
    n / 360


pc : Float -> Float
pc n =
    n / 100
