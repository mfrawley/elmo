module Tabs where
import Html exposing (div, button, text, a, input, form, span)
import Html.Attributes exposing (class, id, contenteditable, href, type', name, autofocus, placeholder, autocomplete, value, attribute)
import Html.Events exposing (onClick, targetValue, on)
import Signal exposing (Signal, Address)

type alias Idx = Int

type SelectAction =
  SelectIndex Idx

type alias TabInfo =
  { title : String
  , value : String
  , buttonClass : String
  , titleClass : String
  , active : Bool
  , idx : Int
  }

createTabInfo : Bool -> String -> String -> String -> String -> Int -> TabInfo
createTabInfo active title value buttonClass titleClass idx =
  { active = active
  , title = title
  , value = value
  , buttonClass = buttonClass
  , titleClass = titleClass
  , idx = idx
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

update : SelectAction -> Model -> Int -> Model
update action model newSelectedIndex =
  { model |
    selectedIndex <- newSelectedIndex
  }

view : Address SelectAction -> Model -> Html.Html
view address model =
  div [class "editor-group"] (List.map (\info -> renderTabButton info address) model.info)

renderTabButton : TabInfo -> Address SelectAction -> Html.Html
renderTabButton info address =
  let cssClass = if (info.active == True) then info.buttonClass ++ " btn-active" else info.buttonClass
  in
  button [type' "button", (attribute "data-params" info.value), class info.buttonClass, (onClick address (SelectIndex info.idx))] [
    span [class info.titleClass] [text info.title]
  ]
