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
    List Todo


init : () -> ( Model, Cmd msg )
init _ =
    ( [ Todo 0 "Learn Elm" True
      , Todo 1 "Take over the world" False
      ]
    , Cmd.none
    )



-- UPDATE


type Msg
    = Show


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Show ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ h1 [ class "heading" ] [ text "elm todo" ]
        , viewTodoList model
        ]


viewTodoList : List Todo -> Html msg
viewTodoList todos =
    ul [ class "todo-list" ] (List.map viewTodo todos)


viewTodo : Todo -> Html msg
viewTodo todo =
    let
        className =
            if todo.completed then
                "todo-item complete"

            else
                "todo-item"
    in
    li [ class className ] [ Html.span [] [ text todo.action ] ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
