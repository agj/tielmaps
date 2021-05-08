module Bitmap exposing
    ( Bitmap
    , empty
    , encode
    , fromString
    , height
    , paintBitmap
    , paintPixel
    , pixel
    , rotate180
    , rotateClockwise
    , rotateCounterClockwise
    , transform
    , width
    )

import Array exposing (Array)
import Helper
import Json.Encode as Encode exposing (Value)


type Bitmap
    = Bitmap Int Int (Array Bool)


empty : Int -> Int -> Bitmap
empty w h =
    Bitmap w h (Array.initialize (w * h) (always False))


{-| Takes a specially formatted string and converts it into a Bitmap. Here's an example:

    """
    . . . . .
    . # . . .
    . # . . .
    . # # # .
    . . . . .
    """
        |> Bitmap.fromString

This will produce a 5 × 5 Bitmap with a black L in the middle.
The spaces are ignored, the dots mark white pixels, and any other character marks black pixels.

-}
fromString : String -> Bitmap
fromString str =
    let
        mapper ch =
            ch /= '.'

        r =
            Helper.stringToArray mapper str
    in
    Bitmap r.width r.height r.array



-- ACCESSORS


width : Bitmap -> Int
width (Bitmap w _ _) =
    w


height : Bitmap -> Int
height (Bitmap _ h _) =
    h


pixel : Int -> Int -> Bitmap -> Maybe Bool
pixel x y (Bitmap w h pixels) =
    pixels
        |> Array.get (Helper.pos w x y)


encode : Bitmap -> Value
encode (Bitmap w h pixels) =
    Encode.object
        [ ( "width", w |> Encode.int )
        , ( "height", h |> Encode.int )
        , ( "pixels", pixels |> Encode.array boolEncoder )
        ]



-- SETTERS


paintPixel : Int -> Int -> Bool -> Bitmap -> Bitmap
paintPixel x y on ((Bitmap w h pixels) as bm) =
    if x < w && y < h && x >= 0 && y >= 0 then
        pixels
            |> Array.set (Helper.pos w x y) on
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

                value =
                    pixel row col source
                        |> Maybe.withDefault False

                setX =
                    x + row

                setY =
                    y + col

                newBm =
                    if setX < targetW && setY < targetH && setX >= 0 && setY >= 0 then
                        paintPixel setX setY value bm

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
                        (pixel x y bitmap |> Maybe.withDefault False)
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


boolEncoder : Bool -> Value
boolEncoder value =
    if value then
        Encode.int 1

    else
        Encode.int 0
