module Palette exposing
    ( cave
    , caveSet
    , deepBlue
    , deepBlueSet
    , sunset
    , sunsetSet
    )

import Color exposing (Color)
import Color.Manipulate as Color
import Colors exposing (Colors)



-- COLOR SETS


caveSet : Colors
caveSet =
    standardSet cave


deepBlueSet =
    standardSet deepBlue


sunsetSet =
    standardSet sunset



-- COLORS


cave : Color
cave =
    hsl 300 14 36


deepBlue : Color
deepBlue =
    hsl 249 46 45


sunset : Color
sunset =
    hsl 21 93 48



-- INTERNAL


standardSet color =
    { darkColor = color
    , lightColor = lighten 0.7 color
    }


hsl : Float -> Float -> Float -> Color
hsl hue sat lum =
    Color.hsl (deg hue) (pc sat) (pc lum)


lighten : Float -> Color -> Color
lighten amount color =
    color
        |> Color.scaleHsl
            { lightnessScale = amount
            , saturationScale = 0
            , alphaScale = 0
            }


deg : Float -> Float
deg n =
    n / 360


pc : Float -> Float
pc n =
    n / 100
