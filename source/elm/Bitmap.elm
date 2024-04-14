module Bitmap exposing
    ( Bitmap
    , empty
    , encode
    , error
    , flipX
    , flipY
    , fromString
    , height
    , paintBitmap
    , paintPixel
    , pixel
    , pixels
    , rotate180
    , rotateClockwise
    , rotateCounterClockwise
    , solid
    , transform
    , width
    )

import Array2d exposing (Array2d)
import Bitmap.Color as Color exposing (Color(..), ColorMap)
import Helper
import Json.Encode as Encode exposing (Value)
import Maybe.Extra as Maybe


type Bitmap
    = Bitmap Int Int (Array2d Color)


{-| Takes a specially formatted string and converts it into a Bitmap. Here's an example:

    import Bitmap.Color
    import Maybe

    """
    / / / / / /
    / █ █ █ █ /
    / █ . . █ /
    / █ . . █ /
    / █ █ █ █ /
    / / / / / /
    """
        |> Bitmap.fromString Bitmap.Color.defaultMap
        |> Maybe.andThen (Bitmap.pixel 1 1)

    --> Just Bitmap.Color.Dark

The above example is constructing a 6 × 6 Bitmap with a square in the middle,
drawn with a dark outline and light color fill, and surrounded by transparent pixels.
The spaces are always ignored, but the other characters need to be specified
by passing a Bitmap.Color.ColorMap which defines which character is which color.

-}
fromString : ColorMap -> String -> Maybe Bitmap
fromString cMap str =
    let
        mapper ch =
            if ch == cMap.dark then
                Just Dark

            else if ch == cMap.light then
                Just Light

            else if ch == cMap.transparent then
                Just Transparent

            else
                Nothing

        maybeResult =
            Helper.stringToArray2d mapper str
    in
    maybeResult
        |> Maybe.map
            (\array2d -> Bitmap (Array2d.width array2d) (Array2d.height array2d) array2d)


empty : Int -> Int -> Bitmap
empty w h =
    solid Transparent w h


solid : Color -> Int -> Int -> Bitmap
solid color w h =
    Bitmap w h (Array2d.repeat w h color)


error : Bitmap
error =
    """
█ . . . . . . █
. █ . . . . █ .
. . █ . . █ . .
. . . █ █ . . .
. . . █ █ . . .
. . █ . . █ . .
. █ . . . . █ .
█ . . . . . . █
"""
        |> fromString Color.defaultMap
        |> Maybe.withDefault (empty 8 8)



-- ACCESSORS


width : Bitmap -> Int
width (Bitmap w _ _) =
    w


height : Bitmap -> Int
height (Bitmap _ h _) =
    h


pixel : Int -> Int -> Bitmap -> Maybe Color
pixel x y (Bitmap _ _ pixels_) =
    pixels_
        |> Array2d.get x y


pixels : Bitmap -> Array2d Color
pixels (Bitmap _ _ pixels_) =
    pixels_


encode : Bitmap -> Value
encode (Bitmap w h pixels_) =
    Encode.object
        [ ( "width", Encode.int w )
        , ( "height", Encode.int h )
        , ( "pixels"
          , pixels_
                |> Array2d.toUnidimensional
                |> Encode.array colorEncoder
          )
        ]



-- SETTERS


paintPixel : Int -> Int -> Color -> Bitmap -> Bitmap
paintPixel x y color ((Bitmap w h pixels_) as bm) =
    if x < w && y < h && x >= 0 && y >= 0 then
        pixels_
            |> Array2d.set x y color
            |> Bitmap w h

    else
        bm


paintBitmap : Int -> Int -> Bitmap -> Bitmap -> Bitmap
paintBitmap x y source target =
    let
        sourceW =
            width source

        sourceH =
            height source

        targetW =
            width target

        targetH =
            height target

        iterator row col bm =
            let
                nextRow =
                    if row >= sourceW - 1 then
                        0

                    else
                        row + 1

                nextCol =
                    if nextRow == 0 then
                        col + 1

                    else
                        col

                color =
                    pixel row col source
                        |> Maybe.withDefault Transparent

                setX =
                    x + row

                setY =
                    y + col

                newBm =
                    if color /= Transparent && setX < targetW && setY < targetH && setX >= 0 && setY >= 0 then
                        paintPixel setX setY color bm

                    else
                        bm
            in
            if nextCol >= sourceH then
                newBm

            else
                iterator nextRow nextCol newBm
    in
    iterator 0 0 target


rotateClockwise : Bitmap -> Bitmap
rotateClockwise ((Bitmap w _ _) as bm) =
    bm
        |> transform
            (\x y -> ( w - y - 1, x ))


rotateCounterClockwise : Bitmap -> Bitmap
rotateCounterClockwise ((Bitmap _ h _) as bm) =
    bm
        |> transform
            (\x y -> ( y, h - x - 1 ))


rotate180 : Bitmap -> Bitmap
rotate180 ((Bitmap w h _) as bm) =
    bm
        |> transform
            (\x y -> ( w - x - 1, h - y - 1 ))


flipX : Bitmap -> Bitmap
flipX ((Bitmap w _ _) as bm) =
    bm
        |> transform
            (\x y -> ( w - x - 1, y ))


flipY : Bitmap -> Bitmap
flipY ((Bitmap _ h _) as bm) =
    bm
        |> transform
            (\x y -> ( x, h - y - 1 ))


transform : (Int -> Int -> ( Int, Int )) -> Bitmap -> Bitmap
transform fn ((Bitmap w h _) as bitmap) =
    let
        iterator x y bm =
            let
                nextX =
                    if x >= w - 1 then
                        0

                    else
                        x + 1

                nextY =
                    if nextX == 0 then
                        y + 1

                    else
                        y

                ( tx, ty ) =
                    fn x y

                newBm =
                    paintPixel
                        tx
                        ty
                        (pixel x y bitmap |> Maybe.withDefault Transparent)
                        bm
            in
            if nextY >= h then
                newBm

            else
                iterator nextX nextY newBm
    in
    empty w h
        |> iterator 0 0



-- INTERNAL


colorEncoder : Color -> Value
colorEncoder value =
    Encode.int <|
        case value of
            Dark ->
                0

            Light ->
                1

            Transparent ->
                -1
