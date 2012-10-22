open Printf
open Cohttp
open Lwt
open Cow

let none : Html.t = []

let content_type_xhtml = ["content-type","text/html"]
