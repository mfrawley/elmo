module AlignTabs where
import Tabs as Tabs

buttonClass = "btn btn-sm btn-text"

titleClass = "btn-text-content"

activeClass = "btn-active"

createTabInfo : List Tabs.TabInfo
createTabInfo =
  [ Tabs.createTabInfo True "Style 1" "1" buttonClass titleClass 1
  , Tabs.createTabInfo False "Style 2" "2" buttonClass titleClass 2
  , Tabs.createTabInfo False "Style 3" "3" buttonClass titleClass 3
  ]
