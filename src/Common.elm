module Common exposing (..)


type alias Coordinate =
    { x : Float
    , y : Float
    }
    

type alias Board =
    { ant : Coordinate
    , blackSquares : List Coordinate
    }