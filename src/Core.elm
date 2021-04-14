module Core exposing (..)

import Ant exposing (Ant)
import Coordinate exposing (Coordinate)
import Dict exposing (Dict)
import SquareColor exposing (SquareColor(..))



type alias Board =
    { ant : Ant
    , blackSquares : Dict String Coordinate
    }


tick : Board -> Board
tick board =
    { ant = Ant.move (currentColor board) board.ant
    , blackSquares =
        flipCurrentSquare board
            |> (\cs ->
                    case cs of
                        Just square ->
                            Dict.insert (squareId square) square board.blackSquares

                        Nothing ->
                            Dict.remove (squareId board.ant.coordinates) board.blackSquares
               )
    }

squareId square =
    (String.fromFloat square.x, String.fromFloat square.y)
    |>  (\(x,y) -> "x" ++ x ++ "y" ++ y)

flipCurrentSquare : Board -> Maybe Coordinate
flipCurrentSquare board =
    case currentColor board of
        Black ->
            Nothing

        White ->
            Just board.ant.coordinates


currentColor : Board -> SquareColor
currentColor board =
    Dict.get (squareId board.ant.coordinates) board.blackSquares
        |> Maybe.map (\_ -> Black)
        |> Maybe.withDefault White
