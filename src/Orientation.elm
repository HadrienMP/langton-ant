module Orientation exposing (Orientation(..), left, right, forward)



import Coordinate exposing (Coordinate)
type Orientation
    = North
    | South
    | East
    | West


forward : Orientation -> Coordinate -> Coordinate
forward orientation coordinates =
    case orientation of
        North ->
            { x = coordinates.x, y = coordinates.y + 1 }

        South ->
            { x = coordinates.x, y = coordinates.y - 1 }

        East ->
            { x = coordinates.x + 1, y = coordinates.y }

        West ->
            { x = coordinates.x - 1, y = coordinates.y }


right : Orientation -> Orientation
right orientation =
    case orientation of
        North ->
            East

        East ->
            South

        South ->
            West

        West ->
            North


left : Orientation -> Orientation
left orientation =
    case orientation of
        North ->
            West

        South ->
            East

        East ->
            North

        West ->
            South
