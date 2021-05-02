module Bitmap exposing
    ( Bitmap
    , empty
    , encode
    , fromString
    , height
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
