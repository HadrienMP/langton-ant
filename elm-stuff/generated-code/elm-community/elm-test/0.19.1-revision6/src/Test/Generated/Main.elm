module Test.Generated.Main exposing (main)

import Example

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    Test.Runner.Node.run
        { runs = 100
        , report = ConsoleReport UseColor
        , seed = 11549777376883
        , processes = 1
        , globs =
            []
        , paths =
            [ "/home/ec2-user/environment/langton-ant/tests/Example.elm"
            ]
        }
        [ ( "Example"
          , [ Test.Runner.Node.check Example.suite
            ]
          )
        ]