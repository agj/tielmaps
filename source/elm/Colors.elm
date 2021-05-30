module Colors exposing
    ( Colors
    , default
    )

import Color exposing (Color)


type alias Colors =
    { darkColor : Color
    , lightColor : Color
    }


default : Colors
default =
    { darkColor = Color.black
    , lightColor = Color.white
    }
