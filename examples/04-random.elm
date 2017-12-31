import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random


main : Program Never Model Msg
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { dieImg : String
  }


init : (Model, Cmd Msg)
init =
  (Model "https://www.wpclipart.com/recreation/games/dice/die_face_1.png", Cmd.none)



-- UPDATE


type Msg
  = Roll
  | NewFace Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace (Random.int 1 6))

    NewFace newFace ->
      let
        url = dieFaceUrl newFace
      in
        (Model url, Cmd.none)


dieFaceUrl : Int -> String
dieFaceUrl num =
  "https://www.wpclipart.com/recreation/games/dice/die_face_" ++ toString num ++ ".png"


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ img [src model.dieImg, alt "die face", title <| "Die showing " ++ toString 1 ] []
    , div []
      [ button [ style [("padding", "20px"),("font-size", "24px"), ("margin", "16px")], onClick Roll ] [ text "Roll" ]
      ]
    ]
