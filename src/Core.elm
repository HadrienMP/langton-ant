module Core exposing (..)
import Common exposing (..)

tick : Board -> Board
tick board =
    { ant = Coordinate -1 -1
    , blackSquares = [Coordinate 0 0, Coordinate 1 1]
    }