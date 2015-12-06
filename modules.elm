module Modules where
import Debug as D
import Signal exposing (constant)
import Graphics.Element exposing (..)
import Html exposing (span, nav, div, button, text, hr, h1, h2, h3, img, ul, li, a)
import Html.Attributes exposing (class, style, href)

type HeadingType = H1 | H2 | H3

heading : String -> HeadingType -> String 
heading innerText hType = 
  case hType of
    H1 ->
      "<h1>" ++ innerText ++ "</h1>" 
    H2 ->
      "<h1>" ++ innerText ++ "</h2>"
    H3 ->
      "<h1>" ++ innerText ++ "</h3>"

renderHtml: Signal String 
renderHtml =
     constant (heading "blah" H1) 

port renderPort : Signal String
port renderPort = 
  renderHtml

htmlToElement str =
  D.log str
  show str

main : Signal Element 
main = 
  Signal.map htmlToElement renderHtml 
