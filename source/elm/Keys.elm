module Keys exposing
    ( Direction(..)
    , Keys
    , direction
    , empty
    , jumping
    , press
    , release
    )

import Key exposing (Key)


type Keys
    = Keys { direction_ : Direction, jumping_ : Bool }


type Direction
    = Static
    | Left
    | Right


empty : Keys
empty =
    Keys { direction_ = Static, jumping_ = False }


direction : Keys -> Direction
direction (Keys { direction_ }) =
    direction_


jumping : Keys -> Bool
jumping (Keys { jumping_ }) =
    jumping_



-- MODIFICATION


press : Key -> Keys -> Keys
press key (Keys state) =
    case key of
        Key.Left ->
            Keys { state | direction_ = Left }

        Key.Right ->
            Keys { state | direction_ = Right }

        Key.Jump ->
            Keys { state | jumping_ = True }


release : Key -> Keys -> Keys
release key (Keys state) =
    case key of
        Key.Left ->
            Keys { state | direction_ = Static }

        Key.Right ->
            Keys { state | direction_ = Static }

        Key.Jump ->
            Keys { state | jumping_ = True }
