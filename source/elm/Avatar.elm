module Avatar exposing
    ( Avatar
    , bitmap
    , collide
    , make
    , reposition
    , tick
    , x
    , y
    )

import Bitmap exposing (Bitmap)
import Collider.Callback as Collider
import CollisionLayer exposing (CollisionLayer)
import Keys exposing (Keys)
import Levers
import Screen exposing (Screen)
import Sprite exposing (Sprite)


type Avatar a
    = Avatar (Data a)


type Position
    = OnGround CanJumpStatus
    | Falling CanJumpStatus
    | Jumping Int


{-| Identifies when jumping is valid.
This is to avoid having the avatar constantly hop around while the jump button is being held.
-}
type CanJumpStatus
    = CanJump
    | CannotJump


type alias Data a =
    { sprite_ : Sprite a
    , x_ : Int
    , y_ : Int
    , prevX : Int
    , prevY : Int
    , width_ : Int
    , height_ : Int
    , position : Position
    }


make : Sprite a -> Avatar a
make spr =
    Avatar
        { sprite_ = spr
        , x_ = 0
        , y_ = 0
        , prevX = 0
        , prevY = 0
        , width_ = Sprite.width spr
        , height_ = Sprite.height spr
        , position = Falling CanJump
        }


reposition : Int -> Int -> Avatar a -> Avatar a
reposition newX newY (Avatar ({ x_, y_, prevX, prevY, position } as data)) =
    Avatar
        { data
            | x_ = newX
            , y_ = newY
            , prevX = newX
            , prevY = newY
        }


tick : Keys -> Avatar a -> Avatar a
tick keys (Avatar ({ sprite_, y_, x_, position } as data)) =
    let
        newX =
            case Keys.direction keys of
                Keys.Static ->
                    x_

                Keys.Left ->
                    x_ - Levers.runSpeed

                Keys.Right ->
                    x_ + Levers.runSpeed

        newY =
            case newPosition of
                Jumping _ ->
                    y_ - Levers.jumpSpeed

                _ ->
                    y_ + Levers.gravity

        newPosition =
            -- The next position is always either Jumping or Falling.
            -- It's set as OnGround only when colliding against the floor!
            if Keys.jumping keys then
                case position of
                    OnGround CanJump ->
                        Jumping 0

                    Falling _ ->
                        -- Jump key is being held--let's make sure
                        -- we don't immediately jump again after landing!
                        Falling CannotJump

                    OnGround CannotJump ->
                        -- We're still holding the jump key
                        -- after landing, so no jump yet!
                        position

                    Jumping ticks ->
                        if ticks < Levers.jumpDuration then
                            Jumping (ticks + 1)

                        else
                            Falling CannotJump

            else
                case position of
                    OnGround _ ->
                        -- Was on the ground and the jump key isn't held,
                        -- so now we're sure we can jump later!
                        Falling CanJump

                    Jumping _ ->
                        -- Started falling after a jump, so should not jump
                        -- until touching the ground.
                        Falling CannotJump

                    Falling _ ->
                        position
    in
    Avatar
        { data
            | sprite_ = Sprite.tick sprite_
            , x_ = newX
            , y_ = newY
            , position = newPosition
        }


collide : Collider.Callback -> Avatar b -> Avatar b
collide collider (Avatar ({ x_, y_, prevX, prevY, width_, height_, position } as data)) =
    let
        ( newX, newY ) =
            collider
                { x = x_
                , y = y_
                , prevX = prevX
                , prevY = prevY
                , width = width_
                , height = height_
                }
    in
    Avatar
        { data
            | x_ = newX
            , y_ = newY
            , prevX = newX
            , prevY = newY
            , position =
                if newY < y_ then
                    -- Collider bounced us back up.
                    case position of
                        OnGround canJumpStatus ->
                            OnGround canJumpStatus

                        Falling canJumpStatus ->
                            OnGround canJumpStatus

                        Jumping _ ->
                            -- Normally, this should never occur.
                            OnGround CannotJump

                else if newY > y_ then
                    -- Collider bounced us back down.
                    Falling CannotJump

                else
                    position
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



-- INTERNAL


moveX : Int -> Avatar a -> Avatar a
moveX amount (Avatar ({ x_ } as data)) =
    Avatar { data | x_ = x_ + amount }
