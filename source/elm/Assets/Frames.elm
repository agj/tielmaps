module Assets.Frames exposing
    ( airborneLeft
    , airborneRight
    , bobLeft
    , bobRight
    , hopLeft
    , hopRight
    , standingLeft
    , standingRight
    )

import Bitmap exposing (Bitmap)
import Bitmap.Color as Color
import Size exposing (Size8x8)


airborneRight =
    """
    █ █ █ █ █ █ █ █
    █ . . . . . . █
    █ . . █ . █ . █
    █ . . . . . . █
    █ █ █ █ █ █ █ █
    / █ / / █ █ / /
    █ █ / / / / █ /
    / / / / / / / /
    """
        |> toBitmap


airborneLeft =
    airborneRight
        |> Bitmap.flipX


hopRight =
    """
    █ █ █ █ █ █ █ █
    █ . . . . . . █
    █ . . █ . █ . █
    █ . . . . . . █
    █ █ █ █ █ █ █ █
    / / █ / █ / / /
    / / █ █ / / / /
    / / / / / / / /
    """
        |> toBitmap


hopLeft =
    hopRight
        |> Bitmap.flipX


standingRight =
    """
    / / / / / / / /
    █ █ █ █ █ █ █ █
    █ . . . . . . █
    █ . . █ . █ . █
    █ . . . . . . █
    █ █ █ █ █ █ █ █
    / █ / / / █ / /
    / █ / / / █ / /
    """
        |> toBitmap


standingLeft =
    standingRight
        |> Bitmap.flipX


bobRight =
    """
    █ █ █ █ █ █ █ █
    █ . . . . . . █
    █ . . █ . █ . █
    █ . . . . . . █
    █ █ █ █ █ █ █ █
    / █ / / / █ / /
    / █ / / / █ / /
    / █ / / / █ / /
    """
        |> toBitmap


bobLeft =
    bobRight
        |> Bitmap.flipX



-- INTERNAL


toBitmap : String -> Bitmap Size8x8
toBitmap str =
    str
        |> Bitmap.fromString8x8 Color.defaultMap
        |> Maybe.withDefault Bitmap.error8x8
