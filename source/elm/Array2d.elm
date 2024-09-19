module Array2d exposing
    ( Array2d
    , empty
    , forceFromList
    , fromList
    , get
    , height
    , indexedFoldl
    , map
    , repeat
    , set
    , toUnidimensional
    , width
    )

import Array exposing (Array)
import List.Extra


type Array2d a
    = Array2d
        { width_ : Int
        , height_ : Int
        , array : Array a
        }



-- CONSTRUCTION


{-| Constructs an empty `Array2d`.
-}
empty : Array2d a
empty =
    Array2d
        { width_ = 0
        , height_ = 0
        , array = Array.empty
        }


{-| Constructs an `Array2d` of the given width and height by repeating a value for
every row and column.
-}
repeat : Int -> Int -> a -> Array2d a
repeat width_ height_ item =
    if isInvalidSize width_ || isInvalidSize height_ then
        empty

    else
        Array2d
            { width_ = width_
            , height_ = height_
            , array = Array.repeat (width_ * height_) item
            }


{-| Constructs an `Array2d` given a list and a desired width. If the list can't
be split into even rows given the width, or if the width is not 1 or larger, it
returns `Nothing`.
-}
fromList : Int -> List a -> Maybe (Array2d a)
fromList width_ list =
    if isInvalidSize width_ then
        Nothing

    else
        let
            listLength : Int
            listLength =
                List.length list

            height_ : Int
            height_ =
                listLength // width_
        in
        if remainderBy width_ listLength == 0 then
            Just
                (Array2d
                    { width_ = width_
                    , height_ = height_
                    , array = Array.fromList list
                    }
                )

        else
            Nothing


{-| The same as `fromList`, however this function also takes a `filler` value
that will be used to fill up the last row in case the list is not divisible
neatly by the width. If the width is an invalid value, this returns an empty
`Array2d`.
-}
forceFromList : Int -> a -> List a -> Array2d a
forceFromList width_ filler list =
    if isInvalidSize width_ then
        empty

    else
        let
            listLength : Int
            listLength =
                List.length list

            remain : Int
            remain =
                remainderBy width_ listLength

            lack : Int
            lack =
                if listLength == 0 then
                    width_

                else if remain == 0 then
                    0

                else
                    width_ - remain

            filledList : List a
            filledList =
                list
                    ++ List.repeat lack filler

            height_ : Int
            height_ =
                List.length filledList // width_
        in
        Array2d
            { width_ = width_
            , height_ = height_
            , array = Array.fromList filledList
            }



-- ACCESSORS


{-| Get a value in an `Array2d` given `x` and `y` coordinates.
-}
get : Int -> Int -> Array2d a -> Maybe a
get x y (Array2d { width_, height_, array }) =
    if areValidCoords x y width_ height_ then
        Array.get (pos width_ x y) array

    else
        Nothing


{-| Returns the width of an `Array2d`.
-}
width : Array2d a -> Int
width (Array2d { width_ }) =
    width_


{-| Returns the height of an `Array2d`.
-}
height : Array2d a -> Int
height (Array2d { height_ }) =
    height_



-- MODIFICATION


{-| Sets the value in an `Array2d` given x and y coordinates. If the coordinates
are invalid, the same `Array2d` is returned.
-}
set : Int -> Int -> a -> Array2d a -> Array2d a
set x y item ((Array2d ({ width_, height_, array } as data)) as array2d) =
    if areValidCoords x y width_ height_ then
        Array2d { data | array = Array.set (pos width_ x y) item array }

    else
        array2d


{-| Converts an `Array2d` into a plain `Array`.
-}
toUnidimensional : Array2d a -> Array a
toUnidimensional (Array2d { array }) =
    array


{-| Transforms all values in an `Array2d` according to a `mapper` function.
-}
map : (a -> b) -> Array2d a -> Array2d b
map mapper (Array2d { width_, height_, array }) =
    Array2d
        { width_ = width_
        , height_ = height_
        , array = Array.map mapper array
        }


{-| Transforms an `Array2d` by iterating through all of its values and their x
and y coordinates, to build up a result value using the `mapper` function.
-}
indexedFoldl : (Int -> Int -> a -> b -> b) -> b -> Array2d a -> b
indexedFoldl mapper init (Array2d { width_, array }) =
    array
        |> Array.toList
        |> List.Extra.indexedFoldl
            (\index a b ->
                let
                    x : Int
                    x =
                        index |> modBy width_

                    y : Int
                    y =
                        index // width_
                in
                mapper x y a b
            )
            init



-- INTERNAL


{-| Converts a width and x/y coordinates into an index in an unidimensional
`Array`.
-}
pos : Int -> Int -> Int -> Int
pos w x y =
    x + (w * y)


{-| Determines whether a number is an appropriate width or height value.
-}
isInvalidSize : Int -> Bool
isInvalidSize n =
    n <= 0


{-| Determines whether x and y coordinates are valid according to a width and
a height.
-}
areValidCoords : Int -> Int -> Int -> Int -> Bool
areValidCoords x y w h =
    x >= 0 && y >= 0 && x < w && y < h
