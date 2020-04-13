module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text, ul, li)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)
import List



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL
type alias Todo = { id: Int, action: String, completed: Bool }

type alias Model =
    List Todo


init : Model
init =
    [ (Todo 0 "Learn Elm" True)
    , (Todo 1 "Take over the world" False)
    ]



-- UPDATE


type Msg
    = Show


update : Msg -> Model -> Model
update msg model =
    case msg of
        Show ->
            model



-- VIEW


view : Model -> Html Msg
view model =
    div [] [ ul [] (List.map viewTodo model) ]

viewTodo: Todo -> Html msg
viewTodo todo =
    if todo.completed then
        li [ style "text-decoration" "line-through" ] [ text todo.action ]
    else
        li [] [ text todo.action ]