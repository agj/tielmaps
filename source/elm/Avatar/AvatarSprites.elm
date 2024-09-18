module Avatar.AvatarSprites exposing
    ( AvatarSprites
    , bitmaps
    , single
    )

import Bitmap exposing (Bitmap)
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


bitmaps : AvatarSprites a -> List (Bitmap a)
bitmaps avs =
    [ avs.standingRight
    , avs.standingLeft
    , avs.runningLeft
    , avs.runningRight
    , avs.jumpingRight
    , avs.jumpingLeft
    ]
        |> List.concatMap Sprite.bitmaps
