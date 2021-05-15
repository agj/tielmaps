module Levers exposing (..)


type alias FramesPerSecond =
    Int


type alias Frames =
    Int


framesPerSecond : Int
framesPerSecond =
    30


width : Int
width =
    22 * 8


height : Int
height =
    22 * 8


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
