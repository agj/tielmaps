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


screenWidth : Int
screenWidth =
    22 * tileWidth


screenHeight : Int
screenHeight =
    22 * tileHeight


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
