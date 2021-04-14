module Ant exposing (Ant, move)

import Coordinate exposing (Coordinate)
import Orientation exposing (Orientation)
import SquareColor exposing (SquareColor)


type alias Ant =
    { coordinates : Coordinate
    , orientation : Orientation
    }


move : SquareColor -> Ant -> Ant
move square ant =
    ant |> turn square |> forward


forward : Ant -> Ant
forward ant =
    { ant | coordinates = Orientation.forward ant.orientation ant.coordinates }


turn : SquareColor -> Ant -> Ant
turn color ant =
    { ant | orientation = SquareColor.turn color ant.orientation }
