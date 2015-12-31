module CallToAction where

import Html exposing (div, button, text, a, input, form, span)
import Html.Attributes exposing (class, id, contenteditable, href, type', name, autofocus, placeholder, autocomplete, value, attribute)
import Html.Events exposing (onClick, targetValue, on)
import Signal exposing (Signal, Address)
import StartApp.Simple as StartApp
import Tabs as Tabs
import AlignTabs as AlignTabs
import Debug as Debug

type ButtonStyle = Style1 | Style2 | Style3

type Action
  = UpdateTitle String
  | SelectStyle Tabs.Idx Tabs.SelectAction

type alias CallToActionModel =
    { styleTabsModel : Tabs.Model
    , alignTabsModel : Tabs.Model
    , buttonHref : String
    , title : String
  }

init : String -> String -> CallToActionModel
init title href =
  {
    styleTabsModel = (Tabs.init 1 AlignTabs.createTabInfo)
  , alignTabsModel = (Tabs.init 1 AlignTabs.createTabInfo)
  , title = title
  , buttonHref = href
  }

buttonStyleToString : Int -> String
buttonStyleToString bStyle =
  case bStyle of
    1 -> "1"
    2 -> "2"
    3 -> "3"

view : Address Action -> CallToActionModel -> Html.Html
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
        div [class ("j-calltoaction-wrapper j-calltoaction-align-" ++ (toString model.alignTabsModel.selectedIndex))] [
          a [class ("j-calltoaction-link j-calltoaction-link-style-" ++ (buttonStyleToString model.styleTabsModel.selectedIndex)), href model.buttonHref] [
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
    , Tabs.view (Signal.forwardTo address (SelectStyle 1)) model.styleTabsModel
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
    SelectStyle idx tabsAction ->
      {  model |
        styleTabsModel <- Tabs.update tabsAction model.styleTabsModel idx
      }

main =
  StartApp.start { model = (init "" ""), view = view, update = update }
