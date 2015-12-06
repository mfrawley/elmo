module Modules where

import Html exposing (span, nav, div, button, text, hr, h1, h2, img, ul, li, a)
import Html.Attributes exposing (class, style, href)

type HeadingType = H1 | H2 | H3

heading : String -> HeadingType -> Html
heading text hType = 
  case hType of
    H1 ->
      h1 text
    H2 ->
      h2 text
    H3 ->
      h3 text
