module Main exposing (..)

import Ant exposing (Ant)
import Browser
import Coordinate exposing (Coordinate)
import Core exposing (..)
import Dict
import Html.Styled exposing (..)
import Orientation exposing (Orientation(..))
import Svg.Styled exposing (Svg, svg)
import Svg.Styled.Attributes
import Task
import Time



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view >> toUnstyled
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { board : Board, turns : Int, start : Time.Posix, now : Time.Posix }


init : () -> ( Model, Cmd Msg )
init flags =
    ( { board =
            { ant = { coordinates = Coordinate 0 0, orientation = West }
            , blackSquares = Dict.fromList []
            }
      , turns = 0
      , start = Time.millisToPosix 0
      , now = Time.millisToPosix 0
      }
    , Task.perform Start Time.now
    )



-- UPDATE


type Msg
    = Tick Time.Posix
    | Start Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick now ->
            ( { model | board = Core.tick model.board, turns = model.turns + 1, now = now }
            , Cmd.none
            )

        Start posix ->
            ( { model | start = posix, now = posix }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every 1 Tick



-- VIEW


view : Model -> Html Msg
view model =
    let
        params =
            { origin = 200, size = 4 }
        elapsed = Time.posixToMillis model.now - Time.posixToMillis model.start
    in
    div []
        [ ul []
            [ li [] [ text <| (++) "Turns: " <| String.fromInt model.turns ]
            , li [] [ text <| (++) "Elapsed: " <| String.fromInt elapsed ]
            , li [] [ text <| (++) "Turn time: " <| String.fromInt (elapsed // model.turns) ++ "ms" ]
            ]
        , svg
            [ Svg.Styled.Attributes.width "1000", Svg.Styled.Attributes.height "1000" ]
            ((model.board.blackSquares
                |> Dict.values
                |> List.map (displaySquare params)
             )
                ++ [ displayAnt model.board.ant params ]
            )
        ]


type alias Params =
    { origin : Float, size : Float }


displayAnt : Ant -> Params -> Svg Msg
displayAnt ant params =
    let
        origin =
            params.origin

        size =
            params.size

        x1 =
            origin + ant.coordinates.x * size

        y1 =
            origin - ant.coordinates.y * size

        x2 =
            x1 + size

        y2 =
            y1

        x3 =
            x1 + size / 2

        y3 =
            y1 + size

        points =
            [ [ x1, y1 ], [ x2, y2 ], [ x3, y3 ] ]

        rotation =
            case ant.orientation of
                North ->
                    "180"

                South ->
                    "0"

                East ->
                    "270"

                West ->
                    "90"
    in
    Svg.Styled.polygon
        [ Svg.Styled.Attributes.fill "red"
        , points
            |> List.map (List.map String.fromFloat)
            |> List.map (String.join ",")
            |> String.join " "
            |> Svg.Styled.Attributes.points
        , Svg.Styled.Attributes.transform <|
            "rotate("
                ++ rotation
                ++ " "
                ++ (String.join " " <| List.map String.fromFloat [ x1 + size / 2, y1 + size / 2 ])
                ++ ")"
        ]
        []


displaySquare : Params -> Coordinate -> Html Msg
displaySquare params square =
    Svg.Styled.rect
        [ Svg.Styled.Attributes.fill "black"
        , Svg.Styled.Attributes.width (String.fromFloat params.size)
        , Svg.Styled.Attributes.height (String.fromFloat params.size)
        , Svg.Styled.Attributes.x <| String.fromFloat <| params.origin + square.x * params.size
        , Svg.Styled.Attributes.y <| String.fromFloat <| params.origin - square.y * params.size
        ]
        []
