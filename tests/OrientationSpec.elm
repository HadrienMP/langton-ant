module OrientationSpec exposing (..)

import Expect
import Orientation exposing (Orientation(..), left, right)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Orientation"
        [ describe "Left"
            ([ ( North, West ), ( West, South ), ( South, East ), ( East, North ) ]
                |> List.map
                    (\( start, expected ) ->
                        test (Debug.toString start ++ " -> " ++ Debug.toString expected) <|
                            \_ ->
                                Expect.equal (left start) expected
                    )
            )
        , describe "Right"
            ([ ( North, East ), ( East, South ), ( South, West ), ( West, North ) ]
                |> List.map
                    (\( start, expected ) ->
                        test (Debug.toString start ++ " -> " ++ Debug.toString expected) <|
                            \_ ->
                                Expect.equal (right start) expected
                    )
            )
        ]
