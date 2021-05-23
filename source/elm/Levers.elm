module Levers exposing (..)


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
    3


jumpSpeed : FramesPerSecond
jumpSpeed =
    3


jumpDuration : Frames
jumpDuration =
    10
