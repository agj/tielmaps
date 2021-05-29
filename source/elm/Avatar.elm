module Avatar exposing
    ( Avatar
    , baseX
    , baseY
    , bitmap
    , collide
    , fromSprite
    , fromSprites
    , repositionTopLeft
    , tick
    , topLeftX
    , topLeftY
    )

import Avatar.AvatarSprites as AvatarSprites exposing (AvatarSprites)
import Avatar.Padding exposing (Padding)
import Bitmap exposing (Bitmap)
import Collider.Callback as Collider
import CollisionLayer exposing (CollisionLayer)
import Html exposing (pre)
import Keys exposing (Keys, jumping)
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
    , x : Int
    , y : Int
    , prevX : Int
    , prevY : Int
    , width_ : Int
    , height_ : Int
    , baseOffsetX : Int
    , baseOffsetY : Int
    , padding : Padding
    , motion : Motion
    , pose : Pose
    , facing : Facing
    }


type Pose
    = PoseStanding
    | PoseRunning
    | PoseJumping


type Facing
    = FacingLeft
    | FacingRight



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
    let
        width_ =
            Sprite.width sprs.standingRight

        height_ =
            Sprite.height sprs.standingRight
    in
    Avatar
        { sprites_ = sprs
        , x = 0
        , y = 0
        , prevX = 0
        , prevY = 0
        , width_ = width_
        , height_ = height_
        , baseOffsetX = padding.left + round (toFloat (width_ - padding.left - padding.right) / 2)
        , baseOffsetY = height_ - padding.bottom
        , padding = padding
        , motion = Falling CanJump
        , pose = PoseStanding
        , facing = FacingRight
        }



-- ACCESSORS


bitmap : Avatar a -> Bitmap
bitmap avatar =
    Sprite.bitmap (currentSprite avatar)


topLeftX : Avatar a -> Int
topLeftX (Avatar { x }) =
    x


topLeftY : Avatar a -> Int
topLeftY (Avatar { y }) =
    y


baseX : Avatar a -> Int
baseX (Avatar { x, baseOffsetX }) =
    x + baseOffsetX


baseY : Avatar a -> Int
baseY (Avatar { y, baseOffsetY }) =
    y + baseOffsetY



-- MODIFICATION


{-| Call every tick with the current input to move the Avatar around.
Takes care of gravity, jumping and left-right movement.
-}
tick : Keys -> Avatar a -> Avatar a
tick keys (Avatar ({ y, x, prevX, motion, facing } as data)) =
    let
        newX =
            case Keys.direction keys of
                Keys.Static ->
                    x

                Keys.Left ->
                    x - Levers.runSpeed

                Keys.Right ->
                    x + Levers.runSpeed

        newY =
            case newMotion of
                Jumping _ ->
                    y - Levers.jumpSpeed

                _ ->
                    y + Levers.gravity

        newMotion =
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
            | x = newX
            , y = newY
            , motion = newMotion
            , pose = getPose newMotion newX prevX
            , facing = getFacing facing newX prevX
        }
        |> mapCurrentSprite Sprite.tick


{-| Moves the Avatar to a new point given its x and y coordinates.
-}
repositionTopLeft : Int -> Int -> Avatar a -> Avatar a
repositionTopLeft newX newY (Avatar data) =
    Avatar
        { data
            | x = newX
            , y = newY
            , prevX = newX
            , prevY = newY
        }


{-| Makes sure the Avatar isn't going through walls.
It should normally be called from within `Collider.collideAvatar`,
which you should call every tick after calling `tick`.
-}
collide : Collider.Callback -> Avatar b -> Avatar b
collide collider (Avatar ({ x, y, prevX, prevY, width_, height_, motion, padding } as data)) =
    let
        ( newXPre, newYPre ) =
            collider
                { x = x + padding.left
                , y = y + padding.top
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
            | x = newX
            , y = newY
            , prevX = newX
            , prevY = newY
            , motion =
                if newY < y then
                    -- Collider bounced us back up.
                    case motion of
                        OnGround canJumpStatus ->
                            OnGround canJumpStatus

                        Falling canJumpStatus ->
                            OnGround canJumpStatus

                        Jumping _ ->
                            -- Normally, this should never occur.
                            OnGround CannotJump

                else if newY > y then
                    -- Collider bounced us back down.
                    Falling CannotJump

                else
                    motion
        }



-- INTERNAL


currentSprite : Avatar a -> Sprite a
currentSprite (Avatar { sprites_, pose, facing }) =
    case ( pose, facing ) of
        ( PoseStanding, FacingRight ) ->
            sprites_.standingRight

        ( PoseStanding, FacingLeft ) ->
            sprites_.standingLeft

        ( PoseRunning, FacingRight ) ->
            sprites_.runningRight

        ( PoseRunning, FacingLeft ) ->
            sprites_.runningLeft

        ( PoseJumping, FacingRight ) ->
            sprites_.jumpingRight

        ( PoseJumping, FacingLeft ) ->
            sprites_.jumpingLeft


mapCurrentSprite : (Sprite a -> Sprite a) -> Avatar a -> Avatar a
mapCurrentSprite mapper (Avatar ({ sprites_, pose, facing } as data)) =
    Avatar
        { data
            | sprites_ =
                case ( pose, facing ) of
                    ( PoseStanding, FacingRight ) ->
                        { sprites_ | standingRight = mapper sprites_.standingRight }

                    ( PoseStanding, FacingLeft ) ->
                        { sprites_ | standingLeft = mapper sprites_.standingLeft }

                    ( PoseRunning, FacingRight ) ->
                        { sprites_ | runningRight = mapper sprites_.runningRight }

                    ( PoseRunning, FacingLeft ) ->
                        { sprites_ | runningLeft = mapper sprites_.runningLeft }

                    ( PoseJumping, FacingRight ) ->
                        { sprites_ | jumpingRight = mapper sprites_.jumpingRight }

                    ( PoseJumping, FacingLeft ) ->
                        { sprites_ | jumpingLeft = mapper sprites_.jumpingLeft }
        }


getPose : Motion -> Int -> Int -> Pose
getPose motion x_ prevX =
    let
        rightNotLeft =
            x_ > prevX

        onGround =
            if x_ == prevX then
                PoseStanding

            else if rightNotLeft then
                PoseRunning

            else
                PoseRunning
    in
    case motion of
        OnGround _ ->
            onGround

        Jumping _ ->
            PoseJumping

        Falling CanJump ->
            onGround

        Falling CannotJump ->
            PoseJumping


getFacing : Facing -> Int -> Int -> Facing
getFacing previous x_ prevX =
    let
        rightNotLeft =
            x_ > prevX
    in
    if x_ == prevX then
        previous

    else if rightNotLeft then
        FacingRight

    else
        FacingLeft
