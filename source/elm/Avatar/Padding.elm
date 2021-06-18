module Avatar.Padding exposing
    ( Padding
    , zero
    )


type alias Padding =
    { left : Int
    , right : Int
    , top : Int
    , bottom : Int
    }


zero : Padding
zero =
    { left = 0
    , right = 0
    , top = 0
    , bottom = 0
    }
