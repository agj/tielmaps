module Bitmap.Color exposing (Color(..), ColorMap, defaultMap)


type Color
    = Dark
    | Light
    | Transparent


{-| Used to create Bitmaps with `Bitmap.fromString`.
Use it to specify which characters should map to which pixel color
when converting your string to a Bitmap.
-}
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
