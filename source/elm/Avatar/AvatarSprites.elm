module Avatar.AvatarSprites exposing
    ( AvatarSprites
    , single
    )

import Sprite exposing (Sprite)


type alias AvatarSprites a =
    { standingRight : Sprite a
    , standingLeft : Sprite a
    , runningRight : Sprite a
    , runningLeft : Sprite a
    , jumpingRight : Sprite a
    , jumpingLeft : Sprite a
    }


single : Sprite a -> AvatarSprites a
single sprite =
    { standingRight = sprite
    , standingLeft = sprite
    , runningLeft = sprite
    , runningRight = sprite
    , jumpingRight = sprite
    , jumpingLeft = sprite
    }
