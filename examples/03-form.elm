import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
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
  , age : String
  , password : String
  , passwordAgain : String
  , hasSubmitted : Bool
  }


model : Model
model =
  Model "" "" "" "" False



-- UPDATE


type Msg
    = Name String
    | Age String
    | Password String
    | PasswordAgain String
    | Submit


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Age age ->
      { model | age = age }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }

    Submit ->
      { model | hasSubmitted = True }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ input [ type_ "text", placeholder "Name", onInput Name ] []
    , input [ type_ "text", placeholder "Age", onInput Age ] []
    , input [ type_ "password", placeholder "Password", onInput Password ] []
    , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , button [ onClick Submit ] [ text "Submit" ]
    , viewValidationMessages model
    ]



validationMessages : Model -> List (Bool, String, String)
validationMessages model =
  [ ( validateAge model.age == False, "red", "Age must be a number" )
  , ( validatePassword model.password == False, "red", "Password must be at least 8 characters and contain at least one uppercase letter, one lowercase letter, and one number" )
  , ( model.password /= model.passwordAgain, "red", "Passwords must match" )
  ]


viewValidationMessages : Model -> Html msg
viewValidationMessages model =
  let
    messages =
      List.filter ( \( invalid, _ , _ ) -> invalid == True) (validationMessages model)
    messages_ =
      if List.length messages > 0 then
        messages
      else
        [ ( False, "green", "OK" ) ]
  in
    if model.hasSubmitted == True then
      messages_
        |> List.map ( \( _, color, message ) -> div [ style [("color", color)] ] [text message])
        |> div []
    else
      text ""

validatePassword : String -> Bool
validatePassword =
  Regex.contains (Regex.regex "^(?=.*[A-Z])(?=.*[a-z])(?=.*[\\d])(?=.{8,})")

validateAge : String -> Bool
validateAge =
  Regex.contains (Regex.regex "^\\d+$")

