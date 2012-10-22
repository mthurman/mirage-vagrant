open Printf
open Lwt
open Cow

module CL = Cohttp_lwt_mirage
module C = Cohttp

module Resp = struct

  (* dynamic response *)
  let dyn ?(headers=[]) req body =
    printf "Dispatch: dynamic URL %s\n%!" (CL.Request.path req);
    lwt body = body in
    let status = `OK in
    let headers = C.Header.of_list headers in
    CL.Server.respond_string ~headers ~status ~body ()

  let dyn_xhtml = dyn ~headers:Pages.content_type_xhtml

  (* dispatch non-file URLs *)
  let dispatch req =
    function
    | [] | [""]
    | [""; "test"]               -> dyn_xhtml req (return "test")
    | x                      -> CL.Server.respond_not_found ~uri:(CL.Request.uri req) ()
end

(* handle exceptions with a 500 *)
let exn_handler exn =
  let body = Printexc.to_string exn in
  eprintf "HTTP: ERROR: %s\n" body;
  return ()

let rec remove_empty_tail = function
  | [] | [""] -> []
  | hd::tl -> hd :: remove_empty_tail tl

(* main callback function *)
let t conn_id ?body req =
  let path = CL.Request.path req in
  let path_elem =
    remove_empty_tail (Re_str.split_delim (Re_str.regexp_string "/") path)
  in
  printf "%s\n" path;
  Resp.dispatch req path_elem
