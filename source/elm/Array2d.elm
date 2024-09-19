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


empty : Array2d a
empty =
    Array2d
        { width_ = 0
        , height_ = 0
        , array = Array.empty
        }


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


fromList : Int -> List a -> Maybe (Array2d a)
fromList width_ list =
    if isInvalidSize width_ then
        Nothing

    else
        let
            listLength =
                List.length list

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


forceFromList : Int -> a -> List a -> Array2d a
forceFromList width_ filler list =
    if isInvalidSize width_ then
        empty

    else
        let
            listLength =
                List.length list

            remain =
                remainderBy width_ listLength

            lack =
                if listLength == 0 then
                    width_

                else if remain == 0 then
                    0

                else
                    width_ - remain

            filledList =
                list
                    ++ List.repeat lack filler

            height_ =
                List.length filledList // width_
        in
        Array2d
            { width_ = width_
            , height_ = height_
            , array = Array.fromList filledList
            }



-- ACCESSORS


get : Int -> Int -> Array2d a -> Maybe a
get x y (Array2d { width_, height_, array }) =
    if areValidCoords x y width_ height_ then
        Array.get (pos width_ x y) array

    else
        Nothing


width : Array2d a -> Int
width (Array2d { width_ }) =
    width_


height : Array2d a -> Int
height (Array2d { height_ }) =
    height_



-- MODIFICATION


set : Int -> Int -> a -> Array2d a -> Array2d a
set x y item ((Array2d ({ width_, height_, array } as data)) as array2d) =
    if areValidCoords x y width_ height_ then
        Array2d { data | array = Array.set (pos width_ x y) item array }

    else
        array2d


toUnidimensional : Array2d a -> Array a
toUnidimensional (Array2d { array }) =
    array


map : (a -> b) -> Array2d a -> Array2d b
map mapper (Array2d { width_, height_, array }) =
    Array2d
        { width_ = width_
        , height_ = height_
        , array = Array.map mapper array
        }


indexedFoldl : (Int -> Int -> a -> b -> b) -> b -> Array2d a -> b
indexedFoldl mapper init (Array2d { width_, array }) =
    array
        |> Array.toList
        |> List.Extra.indexedFoldl
            (\index a b ->
                let
                    x =
                        index |> modBy width_

                    y =
                        index // width_
                in
                mapper x y a b
            )
            init



-- INTERNAL


pos : Int -> Int -> Int -> Int
pos w x y =
    x + (w * y)


isInvalidSize : Int -> Bool
isInvalidSize n =
    n <= 0


areValidCoords : Int -> Int -> Int -> Int -> Bool
areValidCoords x y w h =
    x >= 0 && y >= 0 && x < w && y < h
