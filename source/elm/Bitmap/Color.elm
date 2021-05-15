module Bitmap.Color exposing (Color(..), ColorMap, defaultMap)


type Color
    = Dark
    | Light
    | Transparent


type alias ColorMap =
    { dark : Char
    , light : Char
    , transparent : Char
    }


defaultMap : ColorMap
defaultMap =
    { dark = '█'
    , light = '.'
    , transparent = '/'
    }
