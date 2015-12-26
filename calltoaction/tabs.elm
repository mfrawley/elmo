module Tabs where
import Html exposing (div, button, text, a, input, form, span)
import Html.Attributes exposing (class, id, contenteditable, href, type', name, autofocus, placeholder, autocomplete, value, attribute)
import Html.Events exposing (onClick, targetValue, on)
import Signal exposing (Signal, Address)

type Action = 
  SelectItem

type alias Model = 
  {
    selectedIndex : Int
    , tabTitles : List String
    , tabValues : List String
    , cssClasses : List String
  }

init : Int -> Model
init selected values descriptions = 
    { selectedIndex = selected
    , tabValues = values
    , tabTitles = descriptions
    }


isSelected : Int -> Model -> Bool
isSelected idx model =
  model.selectedIndex == idx

view : Address Action -> Model -> Html.Html
view address model =
  let tabData = List.indexedMap (\idx -> ( model.tabValues[idx]
  , model.tabTitles[idx]
  , model.cssClasses[idx]
  , (isSelected idx model)))
  in
  div [class "editor-group"] (List.map renderTabButton tabData)

renderTabButton : (String, String, String, Bool) -> Html.Html
renderTabButton (val, desc, cssClass, active) =
  let cssClass = if (active == True) then cssClass ++ " btn-active" else cssClass
  in
  button [type' "button", (attribute "data-params" val), class cssClass] [
    span [class "btn-text-content"] [text desc] 
  ]
