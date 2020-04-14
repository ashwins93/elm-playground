module Main exposing (..)

import Browser
import Html exposing (Attribute, Html, div, h1, input, li, text, ul)
import Html.Attributes exposing (..)
import Html.Events exposing (keyCode, on, onClick, onInput)
import Json.Decode as Json
import List


onKeyDown : (Int -> Msg) -> Attribute Msg
onKeyDown tagger =
    on "keydown" (Json.map tagger keyCode)



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
    | Change String
    | KeyDown Int
    | ToggleTodo Int
    | DeleteTodo Int


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Show ->
            ( model, Cmd.none )

        Change text ->
            ( { model | input = text }
            , Cmd.none
            )

        KeyDown code ->
            if code == 13 then
                ( { model
                    | todos = addTodo model.input model.todos
                    , input = ""
                  }
                , Cmd.none
                )

            else
                ( model, Cmd.none )

        ToggleTodo id ->
            ( { model | todos = List.map (toggleTodo id) model.todos }
            , Cmd.none
            )

        DeleteTodo id ->
            ( { model | todos = deleteTodo id model.todos }
            , Cmd.none
            )


addTodo : String -> List Todo -> List Todo
addTodo action todos =
    List.append todos
        [ Todo (nextId todos) action False
        ]


toggleTodo : Int -> Todo -> Todo
toggleTodo id todo =
    if id == todo.id then
        Todo todo.id todo.action (not todo.completed)

    else
        todo


deleteTodo : Int -> List Todo -> List Todo
deleteTodo id todos =
    List.filter ((/=) id << .id) todos


nextId : List Todo -> Int
nextId todos =
    case todos of
        [] ->
            0

        [ todo ] ->
            todo.id + 1

        _ :: xs ->
            nextId xs



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ h1 [ class "heading" ] [ text "elm todo" ]
        , viewTodoList model
        ]


viewTodoList : Model -> Html Msg
viewTodoList model =
    ul [ class "todo-list" ]
        (viewTodoInput model.input :: List.map viewTodo model.todos)


viewTodo : Todo -> Html Msg
viewTodo todo =
    let
        className =
            if todo.completed then
                "todo-item complete"

            else
                "todo-item"
    in
    li
        [ class className
        , onClick (ToggleTodo todo.id)
        ]
        [ Html.span [ class "todo-text" ] [ text todo.action ]
        , Html.span
            [ class "todo-delete-btn"
            , onClick (DeleteTodo todo.id)
            ]
            [ text "❌" ]
        ]


viewTodoInput : String -> Html Msg
viewTodoInput inputVal =
    div [ class "todo-input-wrapper " ]
        [ input
            [ placeholder "What's on your mind?"
            , class "todo-input"
            , onInput Change
            , onKeyDown KeyDown
            , value inputVal
            ]
            []
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
