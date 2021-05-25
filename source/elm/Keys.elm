module Keys exposing
    ( Direction(..)
    , Keys
    , direction
    , empty
    , jumping
    , press
    , release
    )

import Json.Decode exposing (bool)
import Key exposing (Key)
import List.Extra as List


type Keys
    = Keys (List Key)


type Direction
    = Static
    | Left
    | Right


empty : Keys
empty =
    Keys []


direction : Keys -> Direction
direction (Keys keys) =
    case List.find isLeftRight keys of
        Just Key.Left ->
            Left

        Just Key.Right ->
            Right

        _ ->
            Static


jumping : Keys -> Bool
jumping (Keys keys) =
    List.member Key.Jump keys



-- MODIFICATION


press : Key -> Keys -> Keys
press key (Keys keys) =
    Keys (key :: keys)


release : Key -> Keys -> Keys
release key (Keys keys) =
    Keys (List.filter ((/=) key) keys)



-- INTERNAL


isLeftRight : Key -> Bool
isLeftRight key =
    key == Key.Left || key == Key.Right
