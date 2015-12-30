module CallToAction where

import Html exposing (div, button, text, a, input, form, span)
import Html.Attributes exposing (class, id, contenteditable, href, type', name, autofocus, placeholder, autocomplete, value, attribute)
import Html.Events exposing (onClick, targetValue, on)
import Signal exposing (Signal, Address)
import StartApp.Simple as StartApp
import Tabs as Tabs
import AlignTabs as AlignTabs

type ButtonStyle = Style1 | Style2 | Style3

type Action = UpdateTitle String | SelectStyle Tabs.Action CallToActionModel Int

type alias CallToActionModel =
    { styleTabs : Tabs.Model
    , alignTabs : Tabs.Model
    , buttonHref : String
    , title : String
  }

init : String -> String -> Int -> Int -> CallToActionModel
init text href selectedStyle selectedAlign =
  {
    styleTabs = (Tabs.init 1 AlignTabs.createTabInfo)
  , alignTabs = (Tabs.init 1 AlignTabs.createTabInfo)
  , title = text
  , buttonHref = href
  }

buttonStyleToString : Int -> String
buttonStyleToString bStyle =
  case bStyle of
    1 -> "1"
    2 -> "2"
    3 -> "3"

view address model =
  div [] [
  preview model
  , callToActionForm address model
  ]

preview : CallToActionModel -> Html.Html
preview model =
  div [id "module-preview"] [
    div [class "jtpl-main jtpl-section cc-content-parent"] [
      div [id "cc-m-10813654799", class "j-module n j-callToAction "] [
        div [class ("j-calltoaction-wrapper j-calltoaction-align-" ++ (toString model.alignTabs.selectedIndex))] [
          a [class ("j-calltoaction-link j-calltoaction-link-style-" ++ (buttonStyleToString model.styleTabs.selectedIndex)), href model.buttonHref] [
            text model.title
          ]
        ]
      ]
    ]
  ]

callToActionForm : Address Action -> CallToActionModel -> Html.Html
callToActionForm address model =
  form [] [
    titleField address model.title
    , Tabs.view address model.buttonStyle
  ]

titleField : Address Action -> String -> Html.Html
titleField address title =
  input [type' "text", name "title",
  autocomplete False
  , autofocus True
  , placeholder "Enter your button title here"
  , value title
  , on "input" targetValue (Signal.message address << UpdateTitle)] []

update : Action -> CallToActionModel -> CallToActionModel
update action model =
  case action of
    UpdateTitle title ->
      { model |
        title <- title
      }
    SelectStyle action model newIndex ->
      {  model |
        styleTabs <- Tabs.update action model.styleTabs newIndex
      }

main =
  StartApp.start { model = init, view = view, update = update }
