module Tabs where
import Html exposing (div, button, text, a, input, form, span)
import Html.Attributes exposing (class, id, contenteditable, href, type', name, autofocus, placeholder, autocomplete, value, attribute)
import Html.Events exposing (onClick, targetValue, on)
import Signal exposing (Signal, Address)

type Action =
  SelectIndex Int

type alias TabInfo =
  { title : String
  , value : String
  , buttonClass : String
  , titleClass : String
  , active : Bool
  }

createTabInfo : Bool -> String -> String -> String -> String -> TabInfo
createTabInfo active title value buttonClass titleClass =
  { active = active
  , title = title
  , value = value
  , buttonClass = buttonClass
  , titleClass = titleClass
  }

type alias Model =
  {
    selectedIndex : Int
    , info : List TabInfo
  }

init : Int -> List TabInfo -> Model
init idx info =
    { selectedIndex = idx
    , info = info
    }

isSelected : Int -> Model -> Bool
isSelected idx model =
  model.selectedIndex == idx

update : Action -> Model -> Int -> Model
update action model newSelectedIndex =
  { model |
    selectedIndex <- newSelectedIndex
  }

view : Address Action -> Model -> Html.Html
view address model =
  div [class "editor-group"] (List.map renderTabButton model.info)

renderTabButton : TabInfo -> Html.Html
renderTabButton info =
  let cssClass = if (info.active == True) then info.buttonClass ++ " btn-active" else info.buttonClass
  in
  button [type' "button", (attribute "data-params" info.value), class info.buttonClass] [
    span [class info.titleClass] [text info.title]
  ]
