port module Viewport exposing
    ( Viewport
    , decoder
    , visualViewportChanged
    )

import Json.Decode as Decode exposing (Decoder, Value, int)
import Json.Decode.Pipeline exposing (required)


type alias Viewport =
    { width : Int
    , height : Int
    }


visualViewportChanged : (Viewport -> msg) -> msg -> Sub msg
visualViewportChanged success error =
    visualViewport <|
        \v ->
            case Decode.decodeValue decoder v of
                Ok vp ->
                    success vp

                Err _ ->
                    error


decoder : Decoder Viewport
decoder =
    Decode.succeed Viewport
        |> required "width" int
        |> required "height" int



-- INTERNAL


port visualViewport : (Value -> msg) -> Sub msg
