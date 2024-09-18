module Assets.Frames exposing (airborne, bob, hop, standing, toBitmap)

import Bitmap exposing (Bitmap)
import Bitmap.Color as Color
import Size exposing (Size8x8)


airborne =
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


hop =
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


standing =
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


bob =
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



-- INTERNAL


toBitmap : String -> Bitmap Size8x8
toBitmap str =
    str
        |> Bitmap.fromString8x8 Color.defaultMap
        |> Maybe.withDefault Bitmap.error8x8
