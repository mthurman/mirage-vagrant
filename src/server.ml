open Printf
open Lwt

let port = Config.port

let main () =
  eprintf "listening to HTTP on port %d\n" port;
  eprintf "finding the static kv_ro block device\n";
  let callback = Dispatch.t in
  let spec = {
    Cohttp_lwt_mirage.Server.callback;
    conn_closed = (fun _ () -> ());
  } in
  Net.Manager.create (fun mgr interface id ->
    let src = None, port in
    Net.Manager.configure interface (`DHCP) >>
    Cohttp_lwt_mirage.listen mgr src spec
  )
