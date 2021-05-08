module Avatar exposing
    ( Avatar
    , bitmap
    , collide
    , make
    , tick
    , x
    , y
    )

import Bitmap exposing (Bitmap)
import CollisionLayer exposing (CollisionLayer)
import Sprite exposing (Sprite)


type Avatar a
    = Avatar (Data a)


type alias Data a =
    { sprite_ : Sprite a
    , x_ : Int
    , y_ : Int
    , collidedX_ : Int
    , collidedY_ : Int
    , width_ : Int
    , height_ : Int
    }


make : Sprite a -> Avatar a
make spr =
    Avatar
        { sprite_ = spr
        , x_ = 0
        , y_ = 0
        , collidedX_ = 0
        , collidedY_ = 0
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


collide : CollisionLayer -> Avatar a -> Avatar a
collide coll (Avatar data) =
    Avatar data


bitmap : Avatar a -> Bitmap
bitmap (Avatar { sprite_ }) =
    Sprite.bitmap sprite_


x : Avatar a -> Int
x (Avatar { x_ }) =
    x_


y : Avatar a -> Int
y (Avatar { y_ }) =
    y_
