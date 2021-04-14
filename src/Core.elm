module Core exposing (..)

import Ant exposing (Ant)
import Coordinate exposing (Coordinate)
import SquareColor exposing (SquareColor(..))



type alias Board =
    { ant : Ant
    , blackSquares : List Coordinate
    }


tick : Board -> Board
tick board =
    { ant = Ant.move (currentColor board) board.ant
    , blackSquares =
        flipCurrentSquare board
            |> (\cs ->
                    case cs of
                        Just square ->
                            square :: board.blackSquares

                        Nothing ->
                            board.blackSquares |> List.filter (\c -> c /= board.ant.coordinates)
               )
    }


flipCurrentSquare : Board -> Maybe Coordinate
flipCurrentSquare board =
    case currentColor board of
        Black ->
            Nothing

        White ->
            Just board.ant.coordinates


currentColor : Board -> SquareColor
currentColor board =
    board.blackSquares
        |> List.filter (\c -> c == board.ant.coordinates)
        |> List.head
        |> Maybe.map (\_ -> Black)
        |> Maybe.withDefault White
