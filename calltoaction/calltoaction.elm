module CallToAction where

import Html exposing (div, button, text, a, input, form)
import Html.Attributes exposing (class, id, contenteditable, href, type', name, autofocus, placeholder, autocomplete, value)
import Html.Events exposing (onClick, targetValue, on)
import Signal exposing (Signal, Address)
import StartApp.Simple as StartApp

type ButtonStyle = Style1 | Style2 | Style3

buttonStyleToString : Int -> String
buttonStyleToString bStyle =
  case bStyle of
    1 -> "1"
    2 -> "2"
    3 -> "3"

type alias ButtonModel =
    { buttonAlign : Int
    , buttonStyle : Int
    , buttonHref : String
    , title : String
  }

model : ButtonModel
model = {
  buttonAlign = 2
  , buttonStyle = 2
  , buttonHref = "http://google.com"
  , title = "yo"
  }

view address model =
  div [] [
  preview model
  , callToActionForm address model.title
  ]

preview : ButtonModel -> Html.Html
preview model =
  div [id "module-preview"] [
    div [class "jtpl-main jtpl-section cc-content-parent"] [
      div [id "cc-m-10813654799", class "j-module n j-callToAction "] [
        div [class ("j-calltoaction-wrapper j-calltoaction-align-" ++ (toString model.buttonAlign))] [
          a [class ("j-calltoaction-link j-calltoaction-link-style-" ++ (buttonStyleToString model.buttonStyle)), href model.buttonHref] [
            text model.title
          ]
        ]
      ]
    ]
  ]

callToActionForm : Address Action -> String -> Html.Html
callToActionForm address val =
  form [] [
    titleField address val
  ]

titleField : Address Action -> String -> Html.Html
titleField address title =
  input [type' "text", name "title",
  autocomplete False
  , autofocus True
  , placeholder "Enter your button title here"
  , value title
  , on "input" targetValue (Signal.message address << UpdateTitle)] []


type Action
  = UpdateTitle String

update : Action -> ButtonModel -> ButtonModel
update action model =
  case action of
    UpdateTitle title ->
      { title = title
      ,  buttonHref = model.buttonHref
      ,  buttonStyle = model.buttonStyle
      ,  buttonAlign = model.buttonAlign
    }

main =
  StartApp.start { model = model, view = view, update = update }
