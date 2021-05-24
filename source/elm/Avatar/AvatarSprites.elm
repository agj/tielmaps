module Avatar.AvatarSprites exposing
    ( AvatarSprites
    , single
    )

import Sprite exposing (Sprite)


type alias AvatarSprites a =
    { standing : Sprite a
    , runningRight : Sprite a
    , runningLeft : Sprite a
    , jumping : Sprite a
    }


single : Sprite a -> AvatarSprites a
single sprite =
    { standing = sprite
    , runningLeft = sprite
    , runningRight = sprite
    , jumping = sprite
    }
