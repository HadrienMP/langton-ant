module SquareColor exposing (..)


import Orientation exposing (Orientation)
type SquareColor
    = Black
    | White


turn : SquareColor -> Orientation -> Orientation
turn color =
    case color of
        Black ->
            Orientation.left

        White ->
            Orientation.right
