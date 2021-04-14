module Core exposing (..)


type alias Coordinate =
    { x : Float
    , y : Float
    }


type Orientation
    = North
    | South
    | West
    | East


type alias Ant =
    { coordinates : Coordinate
    , orientation : Orientation
    }


type alias Board =
    { ant : Ant
    , blackSquares : List Coordinate
    }


tick : Board -> Board
tick board =
    case board.blackSquares of
        [] ->
            { ant = { coordinates = { x = board.ant.coordinates.x + 1, y = 0 }, orientation = North }
            , blackSquares = [ board.ant.coordinates ]
            }

        _ ->
            if board.blackSquares == [ Coordinate -1 -1 ] then
                { ant = { coordinates = Coordinate 2 0, orientation = North }
                , blackSquares = [ Coordinate 1 0, Coordinate -1 -1 ]
                }

            else
                { ant = { coordinates = Coordinate -1 0, orientation = North }, blackSquares = [] }
