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
  { dieImgs : (String, String)
  }


init : (Model, Cmd Msg)
init =
  ( Model
     ( "https://www.wpclipart.com/recreation/games/dice/die_face_1.png"
     , "https://www.wpclipart.com/recreation/games/dice/die_face_1.png"
     )
  , Cmd.none
  )



-- UPDATE


type Msg
  = Roll
  | NewFace (Int, Int)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace diePair)

    NewFace ( die1, die2 ) ->
      let
        urls = (dieFaceUrl die1, dieFaceUrl die2)
      in
        (Model urls, Cmd.none)


diePair : Random.Generator (Int, Int)
diePair =
  Random.pair randomFace randomFace

randomFace : Random.Generator Int
randomFace =
  Random.int 1 6


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
  let
    (die1, die2) = model.dieImgs
  in
    div []
      [ img [src die1, alt "die face", title <| "Die showing " ++ toString 1 ] []
      , img [src die2, alt "die face", title <| "Die showing " ++ toString 1 ] []
      , div []
        [ button [ style [("padding", "20px"),("font-size", "24px"), ("margin", "16px")], onClick Roll ] [ text "Roll" ]
        ]
      ]
