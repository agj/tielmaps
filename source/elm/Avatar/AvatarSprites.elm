module Avatar.AvatarSprites exposing
    ( AvatarSprites
    , single
    )

import Sprite exposing (Sprite)


type alias AvatarSprites =
    { standingRight : Sprite
    , standingLeft : Sprite
    , runningRight : Sprite
    , runningLeft : Sprite
    , jumpingRight : Sprite
    , jumpingLeft : Sprite
    }


single : Sprite -> AvatarSprites
single sprite =
    { standingRight = sprite
    , standingLeft = sprite
    , runningLeft = sprite
    , runningRight = sprite
    , jumpingRight = sprite
    , jumpingLeft = sprite
    }
