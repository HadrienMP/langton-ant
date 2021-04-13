module Core exposing (..)


type alias Coordinate =
    { x : Float
    , y : Float
    }


type alias Board =
    { ant : Coordinate
    , blackSquares : List Coordinate
    }

tick : Board -> Board
tick board =
    case board.blackSquares of
        [] ->
            { ant = { x = board.ant.x + 1, y = 0 }
            , blackSquares = [ board.ant ]
            }

        _ ->
            if board.blackSquares == [ Coordinate -1 -1 ] then
                { ant = Coordinate 2 0
                , blackSquares = [ Coordinate 1 0, Coordinate -1 -1 ]
                }

            else
                { ant = Coordinate -1 0, blackSquares = [] }
