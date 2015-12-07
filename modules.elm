module Modules where
import Debug as D
import Signal exposing (constant)
import Time exposing (every, second)
import Graphics.Element exposing (..)
import Html exposing (span, nav, div, button, text, hr, h1, h2, h3, img, ul, li, a)
import Html.Attributes exposing (class, style, href)

type HeadingType = H1 | H2 | H3

type alias HeadingPayload = 
  { h : HeadingType
  , header : String   
  }

model : HeadingPayload
model = 
  { h = H1
  , header = ""
  }

heading : String -> HeadingType -> String 
heading innerText hType = 
  case hType of
    H1 ->
      "<h1>" ++ innerText ++ "</h1>" 
    H2 ->
      "<h1>" ++ innerText ++ "</h2>"
    H3 ->
      "<h1>" ++ innerText ++ "</h3>"

renderHtml: String 
renderHtml =
     heading "blah" H1

htmlToElement : String -> Element
htmlToElement str =
  show str

port handleSaveAction : Signal String 
port handleSaveAction =
  saveModule model
  "" 

port saveModule : Signal HeadingPayload 
port saveModule = 
  model

port renderPort : Signal String
port renderPort = 
  Signal.map (\_ -> renderHtml) (every second)

main : Signal Element 
main = 
  let x = renderHtml
  in
  Signal.map (\_ -> htmlToElement renderHtml) (every second)
