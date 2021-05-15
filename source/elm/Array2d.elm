module Array2d exposing (Array2d, fromList, get, height, repeat, set, toUnidimensional, width)

import Array exposing (Array)


type Array2d a
    = Array2d
        { width_ : Int
        , height_ : Int
        , array : Array a
        }


repeat : Int -> Int -> a -> Array2d a
repeat width_ height_ item =
    Array2d
        { width_ = width_
        , height_ = height_
        , array = Array.repeat (width_ * height_) item
        }


fromList : Int -> a -> List a -> Array2d a
fromList width_ filler list =
    let
        listLength =
            List.length list

        remain =
            remainderBy width_ listLength

        lack =
            if remain == 0 then
                0

            else
                width_ - remain

        filledList =
            list
                ++ List.repeat lack filler
    in
    Array2d
        { width_ = width_
        , height_ = List.length filledList // width_
        , array = Array.fromList filledList
        }


get : Int -> Int -> Array2d a -> Maybe a
get x y (Array2d { width_, height_, array }) =
    if x < width_ && y < height_ then
        Array.get (pos width_ x y) array

    else
        Nothing


set : Int -> Int -> a -> Array2d a -> Array2d a
set x y item ((Array2d ({ width_, height_, array } as data)) as array2d) =
    if x < width_ && y < height_ then
        Array2d { data | array = Array.set (pos width_ x y) item array }

    else
        array2d


width : Array2d a -> Int
width (Array2d { width_ }) =
    width_


height : Array2d a -> Int
height (Array2d { height_ }) =
    height_


toUnidimensional : Array2d a -> Array a
toUnidimensional (Array2d { array }) =
    array



-- INTERNAL


pos : Int -> Int -> Int -> Int
pos w x y =
    x + (w * y)
