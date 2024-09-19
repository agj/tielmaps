module Levers exposing
    ( durationGiven60Fps
    , framesPerSecond
    , gravity
    , jumpDuration
    , jumpSpeed
    , runSpeed
    , screenHeight
    , screenHeightInTiles
    , screenWidth
    , screenWidthInTiles
    , speedGiven60Fps
    , tileHeight
    , tileWidth
    )


type alias FramesPerSecond =
    Int


type alias Frames =
    Int


framesPerSecond : Int
framesPerSecond =
    60


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
    speedGiven60Fps 1


runSpeed : FramesPerSecond
runSpeed =
    speedGiven60Fps 1


jumpSpeed : FramesPerSecond
jumpSpeed =
    speedGiven60Fps 1


jumpDuration : Frames
jumpDuration =
    durationGiven60Fps 24


speedGiven60Fps : Float -> FramesPerSecond
speedGiven60Fps n =
    round (n * 60 / toFloat framesPerSecond)


durationGiven60Fps : Float -> FramesPerSecond
durationGiven60Fps n =
    round (n * toFloat framesPerSecond / 60)
