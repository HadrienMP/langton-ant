module Example exposing (..)

import Core exposing (..)
import Expect exposing (Expectation)
import Test exposing (..)



--Les cases d'une grille bidimensionnelle peuvent être blanches ou noires.
--On considère arbitrairement l'une de ces cases comme étant l'emplacement initial de la fourmi.
--Dans l'état initial, toutes les cases sont de la même couleur.
--
--La fourmi peut se déplacer à gauche, à droite, en haut ou en bas d'une case à chaque fois selon les règles suivantes :
--
--Si la fourmi est sur une case noire, elle tourne de 90° vers la gauche, change la couleur de la case en blanc et avance d'une case.
--Si la fourmi est sur une case blanche, elle tourne de 90° vers la droite, change la couleur de la case en noir et avance d'une case.
--Il est également possible de définir la fourmi de Langton comme un automate cellulaire où la plupart des cases de
--la grille sont blanches ou noires et où la case de la fourmi peut prendre huit états différents, codant à la fois sa couleur et la direction de la fourmi.


move : Coordinate -> Color -> Orientation -> Coordinate
move ant color orientation =
    case orientation of
        S ->
            case color of
                Black ->
                    { ant | x = ant.x + 1 }

                _ ->
                    { ant | x = ant.x - 1 }

        _ ->
            case color of
                Black ->
                    { ant | x = ant.x - 1 }

                _ ->
                    { ant | x = ant.x + 1 }


type Color
    = White
    | Black


type Orientation
    = N
    | S
    | W
    | E


suite : Test
suite =
    describe "Langton ant"
        [ describe "Ant"
            [ test "first" <|
                \_ ->
                    let
                        nextAntCoordinates =
                            move (Coordinate 0 0) White N
                    in
                    Expect.equal nextAntCoordinates <| Coordinate 1 0
            , test "2" <|
                \_ ->
                    let
                        nextAntCoordinates =
                            move (Coordinate 2 0) White N
                    in
                    Expect.equal nextAntCoordinates <| Coordinate 3 0
            , test "left" <|
                \_ ->
                    let
                        nextAntCoordinates =
                            move (Coordinate 0 0) Black N
                    in
                    Expect.equal nextAntCoordinates <| Coordinate -1 0
            , test "orientation" <|
                \_ ->
                    let
                        nextAntCoordinates =
                            move (Coordinate 0 0) White S
                    in
                    Expect.equal nextAntCoordinates <| Coordinate -1 0
            , test "orientation 2" <|
                \_ ->
                    let
                        nextAntCoordinates =
                            move (Coordinate 0 0) Black S
                    in
                    Expect.equal nextAntCoordinates <| Coordinate 1 0
            ]
        , describe "Board"
            [ test "first" <|
                \_ ->
                    let
                        updatedBoard =
                            tick { ant = Coordinate 0 0, blackSquares = [] }
                    in
                    Expect.equal updatedBoard
                        { ant = Coordinate 1 0
                        , blackSquares = [ Coordinate 0 0 ]
                        }
            , test "second" <|
                \_ ->
                    let
                        updatedBoard =
                            tick { ant = Coordinate 0 0, blackSquares = [ Coordinate 0 0 ] }
                    in
                    Expect.equal updatedBoard
                        { ant = Coordinate -1 0
                        , blackSquares = []
                        }
            , test "third" <|
                \_ ->
                    let
                        updatedBoard =
                            { ant = Coordinate 1 0, blackSquares = [] }
                                |> tick
                    in
                    Expect.equal updatedBoard
                        { ant = Coordinate 2 0
                        , blackSquares = [ Coordinate 1 0 ]
                        }
            , test "4" <|
                \_ ->
                    let
                        updatedBoard =
                            { ant = Coordinate 1 0, blackSquares = [ Coordinate -1 -1 ] }
                                |> tick
                    in
                    Expect.equal updatedBoard
                        { ant = Coordinate 2 0
                        , blackSquares = [ Coordinate 1 0, Coordinate -1 -1 ]
                        }
            ]
        ]
