import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import List
import Regex

main : Program Never Model Msg
main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  }


model : Model
model =
  Model "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ input [ type_ "text", placeholder "Name", onInput Name ] []
    , input [ type_ "password", placeholder "Password", onInput Password ] []
    , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , viewValidation model
    ]




viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if List.length (validateWithRegex model.password) == 0 then
        ("red", "Password must be at least 8 characters and contain at least one uppercase letter, one lowercase letter, and one number")
      else if model.password /= model.passwordAgain then
        ("red", "Passwords do not match!")
      else
        ("green", "OK")
  in
    div [ style [("color", color)] ] [ text message ]


validateWithRegex : String -> List Regex.Match
validateWithRegex =
  Regex.find Regex.All (Regex.regex "^(?=.*[A-Z])(?=.*[a-z])(?=.*[\\d])(?=.{8,})")

