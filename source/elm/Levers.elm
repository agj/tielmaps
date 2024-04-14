module Levers exposing
    ( framesPerSecond
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
