module Api.Api exposing (..) -- Adjusted the module name here

import Http

getRoutes : String -> Cmd Msg
getRoutes input =
    Http.get
        { url = "/routes?input=" ++ input
        , expect = Http.expectJson SuggestionsReceived (Json.Decode.list Json.Decode.string)
        }
