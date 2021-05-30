module Point exposing
    ( Point
    , x
    , y
    )


type alias Point =
    ( Int, Int )


x : Point -> Int
x ( x_, _ ) =
    x_


y : Point -> Int
y ( _, y_ ) =
    y_
