module Keys.Key exposing (Key(..), decodeEvent, fromCode)

import Json.Decode as D


type Key
    = Left
    | Right
    | Jump


fromCode : String -> Maybe Key
fromCode code =
    case code of
        "ArrowLeft" ->
            Just Left

        "ArrowRight" ->
            Just Right

        " " ->
            Just Jump

        _ ->
            Nothing


decodeEvent : D.Decoder (Maybe Key)
decodeEvent =
    D.map fromCode (D.field "key" D.string)
