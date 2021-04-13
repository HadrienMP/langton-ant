module Main exposing (..)

import Browser
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Time
import Core exposing (..)



-- MAIN


main : Program () Board Msg
main =
    Browser.element
        { init = init
        , view = view >> toUnstyled
        , update = update
        , subscriptions = subscriptions
        }



-- BOARD


init : () -> ( Board, Cmd Msg )
init flags =
    ( { ant = Coordinate 0 0
      , blackSquares =
            [ Coordinate 0 0
            , Coordinate 1 1
            , Coordinate 2 2
            ]
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Tick Time.Posix


update : Msg -> Board -> ( Board, Cmd Msg )
update msg board =
    case msg of
        Tick _ ->
            ( Core.tick board
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Board -> Sub Msg
subscriptions _ =
    Time.every 1000 Tick



-- VIEW


view : Board -> Html Msg
view board =
    div []
        ((board.blackSquares
            |> List.map displaySquare
        ) ++ [displayAnt board.ant])


displayAnt : Coordinate -> Html Msg
displayAnt ant =
    div
        [ css
            [ position absolute
            , backgroundColor (rgb 255 0 0)
            , width (vw 1)
            , height (vh 3)
            , top (vh (50 + (ant.y * 3)))
            , left (vw (50 + ant.x))
            , borderRadius (pct 100)
            ]
        ]
        []

displaySquare : Coordinate -> Html Msg
displaySquare square =
    div
        [ css
            [ position absolute
            , backgroundColor (rgb 0 0 0)
            , width (vw 1)
            , height (vh 3)
            , top (vh (50 + (square.y * 3)))
            , left (vw (50 + square.x))
            ]
        ]
        []
