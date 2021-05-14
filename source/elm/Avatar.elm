module Avatar exposing
    ( Avatar
    , bitmap
    , collide
    , make
    , moveLeft
    , moveRight
    , tick
    , x
    , y
    )

import Bitmap exposing (Bitmap)
import Collider.Callback as Collider
import CollisionLayer exposing (CollisionLayer)
import Screen exposing (Screen)
import Sprite exposing (Sprite)


type Avatar a
    = Avatar (Data a)


type alias Data a =
    { sprite_ : Sprite a
    , x_ : Int
    , y_ : Int
    , prevX_ : Int
    , prevY_ : Int
    , width_ : Int
    , height_ : Int
    }


make : Sprite a -> Avatar a
make spr =
    Avatar
        { sprite_ = spr
        , x_ = 0
        , y_ = 0
        , prevX_ = 0
        , prevY_ = 0
        , width_ = Sprite.width spr
        , height_ = Sprite.height spr
        }


tick : Avatar a -> Avatar a
tick (Avatar ({ sprite_, y_ } as data)) =
    Avatar
        { data
            | sprite_ = Sprite.tick sprite_
            , y_ = y_ + 3
        }


moveLeft : Avatar a -> Avatar a
moveLeft avatar =
    moveX -3 avatar


moveRight : Avatar a -> Avatar a
moveRight avatar =
    moveX 3 avatar


moveX : Int -> Avatar a -> Avatar a
moveX amount (Avatar ({ x_ } as data)) =
    Avatar
        { data
            | x_ = x_ + amount
        }


collide : Collider.Callback -> Avatar b -> Avatar b
collide collider (Avatar ({ x_, y_, prevX_, prevY_, width_, height_ } as data)) =
    let
        ( newX, newY ) =
            collider
                { x = x_
                , y = y_
                , prevX = prevX_
                , prevY = prevY_
                , width = width_
                , height = height_
                }
    in
    Avatar
        { data
            | x_ = newX
            , y_ = newY
            , prevX_ = newX
            , prevY_ = newY
        }


bitmap : Avatar a -> Bitmap
bitmap (Avatar { sprite_ }) =
    Sprite.bitmap sprite_


x : Avatar a -> Int
x (Avatar { x_ }) =
    x_


y : Avatar a -> Int
y (Avatar { y_ }) =
    y_
