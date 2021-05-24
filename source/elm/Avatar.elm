module Avatar exposing
    ( Avatar
    , bitmap
    , collide
    , fromSprite
    , fromSprites
    , reposition
    , tick
    , x
    , y
    )

import Avatar.AvatarSprites as AvatarSprites exposing (AvatarSprites)
import Avatar.Padding exposing (Padding)
import Bitmap exposing (Bitmap)
import Collider.Callback as Collider
import CollisionLayer exposing (CollisionLayer)
import Keys exposing (Keys)
import Levers
import Screen exposing (Screen)
import Sprite exposing (Sprite)


type Avatar a
    = Avatar (Data a)


type Motion
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
    { sprites_ : AvatarSprites a
    , x_ : Int
    , y_ : Int
    , prevX : Int
    , prevY : Int
    , width_ : Int
    , height_ : Int
    , padding : Padding
    , motion : Motion
    }



-- CREATION


{-| Creates an Avatar from a single Sprite.
You also need to supply a Padding, which defines
how far into the Sprite should the collision box be calculated.
-}
fromSprite : Padding -> Sprite a -> Avatar a
fromSprite padding spr =
    fromSprites padding (AvatarSprites.single spr)


{-| Creates an Avatar from a group of Sprites, an AvatarSprites record
which defines a Sprite for each possible state the Avatar can be in.
You also need to supply a Padding, which defines
how far into the Sprite should the collision box be calculated.
-}
fromSprites : Padding -> AvatarSprites a -> Avatar a
fromSprites padding sprs =
    Avatar
        { sprites_ = sprs
        , x_ = 0
        , y_ = 0
        , prevX = 0
        , prevY = 0
        , width_ = Sprite.width sprs.standing
        , height_ = Sprite.height sprs.standing
        , padding = padding
        , motion = Falling CanJump
        }



-- ACCESSORS


bitmap : Avatar a -> Bitmap
bitmap (Avatar { sprites_ }) =
    Sprite.bitmap sprites_.runningRight


x : Avatar a -> Int
x (Avatar { x_ }) =
    x_


y : Avatar a -> Int
y (Avatar { y_ }) =
    y_



-- MODIFICATION


{-| Call every tick with the current input to move the Avatar around.
Takes care of gravity, jumping and left-right movement.
-}
tick : Keys -> Avatar a -> Avatar a
tick keys (Avatar ({ sprites_, y_, x_, motion } as data)) =
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
                case motion of
                    OnGround CanJump ->
                        Jumping 0

                    Falling _ ->
                        -- Jump key is being held--let's make sure
                        -- we don't immediately jump again after landing!
                        Falling CannotJump

                    OnGround CannotJump ->
                        -- We're still holding the jump key
                        -- after landing, so no jump yet!
                        motion

                    Jumping ticks ->
                        if ticks < Levers.jumpDuration then
                            Jumping (ticks + 1)

                        else
                            Falling CannotJump

            else
                case motion of
                    OnGround _ ->
                        -- Was on the ground and the jump key isn't held,
                        -- so now we're sure we can jump later!
                        Falling CanJump

                    Jumping _ ->
                        -- Started falling after a jump, so should not jump
                        -- until touching the ground.
                        Falling CannotJump

                    Falling _ ->
                        motion
    in
    Avatar
        { data
            | sprites_ = { sprites_ | runningRight = Sprite.tick sprites_.runningRight }
            , x_ = newX
            , y_ = newY
            , motion = newPosition
        }


{-| Moves the Avatar to a new point given its x and y coordinates.
-}
reposition : Int -> Int -> Avatar a -> Avatar a
reposition newX newY (Avatar data) =
    Avatar
        { data
            | x_ = newX
            , y_ = newY
            , prevX = newX
            , prevY = newY
        }


{-| Makes sure the Avatar isn't going through walls.
It should normally be called from within `Collider.collideAvatar`,
which you should call every tick after calling `tick`.
-}
collide : Collider.Callback -> Avatar b -> Avatar b
collide collider (Avatar ({ x_, y_, prevX, prevY, width_, height_, motion, padding } as data)) =
    let
        ( newXPre, newYPre ) =
            collider
                { x = x_ + padding.left
                , y = y_ + padding.top
                , prevX = prevX + padding.left
                , prevY = prevY + padding.top
                , width = width_ - padding.left - padding.right
                , height = height_ - padding.top - padding.bottom
                }

        newX =
            newXPre - padding.left

        newY =
            newYPre - padding.top
    in
    Avatar
        { data
            | x_ = newX
            , y_ = newY
            , prevX = newX
            , prevY = newY
            , motion =
                if newY < y_ then
                    -- Collider bounced us back up.
                    case motion of
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
                    motion
        }
