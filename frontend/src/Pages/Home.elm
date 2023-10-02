module Pages.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)
import Api.Api as Api -- Adjusted the import here


type alias Model =
    { userInput : String
    , suggestions : List String
    , selectedRoute : Maybe String
    , busStops : List String
    , busLocation : Maybe String
    }

type Msg
    = InputChanged String
    | SuggestionsReceived (Result Http.Error (List String))
    | SuggestionSelected String

init : Model
init =
    { userInput = ""
    , suggestions = []
    , selectedRoute = Nothing
    , busStops = []
    , busLocation = Nothing
    }

update : Msg -> Model -> Model
update msg model =
    case msg of
        InputChanged input ->
            { model | userInput = input }

        SuggestionsReceived (Ok routes) ->
            { model | suggestions = routes }

        SuggestionsReceived (Err _) ->
            model

        SuggestionSelected route ->
            -- Handle the selected route, e.g., fetch more data or update the model
            { model | selectedRoute = Just route }

view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Enter route", onInput InputChanged, value model.userInput ] []
        , ul [] (List.map viewSuggestion model.suggestions)
        , viewBusStops model.busStops model.busLocation
        ]

viewSuggestion : String -> Html Msg
viewSuggestion suggestion =
    li [ onClick (SuggestionSelected suggestion) ] [ text suggestion ]

viewBusStops : List String -> Maybe String -> Html Msg
viewBusStops stops busLocation =
    div []
        (List.map (viewBusStop busLocation) stops)

viewBusStop : Maybe String -> String -> Html Msg
viewBusStop busLocation stop =
    div []
        [ if Just stop == busLocation then
            span [] [ text "🚌" ]
          else
            text ""
        , text stop
        ]
