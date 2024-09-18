module Avatar.AvatarSprites exposing
    ( AvatarSprites
    , bitmaps
    , single
    )

import Bitmap exposing (Bitmap)
import Size exposing (Size8x8)
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


bitmaps : AvatarSprites -> List (Bitmap Size8x8)
bitmaps avs =
    [ avs.standingRight
    , avs.standingLeft
    , avs.runningLeft
    , avs.runningRight
    , avs.jumpingRight
    , avs.jumpingLeft
    ]
        |> List.concatMap Sprite.bitmaps
