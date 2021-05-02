port module Js exposing (paintCanvas)

import Bitmap exposing (Bitmap)
import Json.Encode as E


paintCanvas : Bitmap -> Cmd msg
paintCanvas bm =
    command
        { kind = "paintCanvas"
        , value = Bitmap.encode bm
        }



-- INTERNAL


type alias ToJs =
    { kind : String
    , value : E.Value
    }


port command : ToJs -> Cmd msg
