module Main exposing (..)

import Browser
import Html exposing (Html, button, div, h1, li, text, ul)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import List



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- MODEL


type alias Todo =
    { id : Int
    , action : String
    , completed : Bool
    }


type alias Model =
    { input : String
    , todos : List Todo
    }


init : () -> ( Model, Cmd msg )
init _ =
    ( { input = ""
      , todos =
            [ Todo 0 "Learn Elm" True
            , Todo 1 "Take over the world" False
            ]
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Show
    | ToggleTodo Int


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Show ->
            ( model, Cmd.none )

        ToggleTodo id ->
            ( { model | todos = List.map (toggleTodo id) model.todos }
            , Cmd.none
            )


toggleTodo : Int -> Todo -> Todo
toggleTodo id todo =
    if id == todo.id then
        Todo todo.id todo.action (not todo.completed)

    else
        todo



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ h1 [ class "heading" ] [ text "elm todo" ]
        , viewTodoList model.todos
        ]


viewTodoList : List Todo -> Html Msg
viewTodoList todos =
    ul [ class "todo-list" ] (List.map viewTodo todos)


viewTodo : Todo -> Html Msg
viewTodo todo =
    let
        className =
            if todo.completed then
                "todo-item complete"

            else
                "todo-item"
    in
    li [ class className, onClick (ToggleTodo todo.id) ] [ Html.span [] [ text todo.action ] ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
