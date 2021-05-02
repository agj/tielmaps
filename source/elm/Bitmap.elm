module Bitmap exposing
    ( Bitmap
    , empty
    , encode
    , fromString
    , height
    , paintBitmap
    , paintPixel
    , pixel
    , width
    )

import Array exposing (Array)
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

This will produce a 5 × 5 Bitmap with a black L in the middle.
The spaces are ignored, the dots mark white pixels, and any other character marks black pixels.

-}
fromString : String -> Bitmap
fromString str =
    let
        rawLines =
            str
                |> String.lines
                |> List.map removeSpaces
                |> List.filter (not << String.isEmpty)

        w =
            rawLines
                |> List.map String.length
                |> List.foldl max 0

        h =
            List.length rawLines

        lines =
            rawLines
                |> List.map (String.padRight w '.')

        toBool ch =
            ch /= ' ' && ch /= '.'
    in
    lines
        |> List.map (String.toList >> List.map toBool)
        |> List.foldr (++) []
        |> Array.fromList
        |> Bitmap w h



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
        |> Array.get (pos w x y)


encode : Bitmap -> Value
encode (Bitmap w h pixels) =
    Encode.object
        [ ( "width", w |> Encode.int )
        , ( "height", h |> Encode.int )
        , ( "pixels", pixels |> Encode.array boolEncoder )
        ]



-- SETTERS


paintPixel : Int -> Int -> Bool -> Bitmap -> Bitmap
paintPixel x y on (Bitmap w h pixels) =
    pixels
        |> Array.set (pos w x y) on
        |> Bitmap w h


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



-- INTERNAL


pos : Int -> Int -> Int -> Int
pos w x y =
    x + (w * y)


boolEncoder : Bool -> Value
boolEncoder value =
    if value then
        Encode.int 1

    else
        Encode.int 0


removeSpaces : String -> String
removeSpaces =
    String.filter (\ch -> ch /= ' ')
