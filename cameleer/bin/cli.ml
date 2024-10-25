open Format

let fname = ref None
let debug = ref false
let batch = ref false
let extract = ref false
let prover = ref None
let path = Queue.create ()
let version = "1.0.0"

let spec =
  [
    ( "-L",
      Arg.String (fun s -> Queue.add s path),
      "add <dir> to the search path" );
    ("--genconf", Arg.Unit (fun () -> Genconf.generate_conf_file (); exit 0), "generate config file");
    ("--debug", Arg.Unit (fun () -> debug := true), "print debug information");
    ("--batch", Arg.Unit (fun () -> batch := true), "activate batch mode");
    ( "--extract",
      Arg.Unit (fun () -> extract := true),
      "activate extraction mode" );
    ( "--prover",
      Arg.String (fun s -> prover := Some s),
      "set prover for batch mode" );
    ( "--version",
      Arg.Unit
        (fun () ->
          printf "StatWhy %s@." version;
          exit 0),
      " print version information" );
  ]

let usage_msg =
  sprintf "%s <file>.(ml|mlw)\nVerify (OCaml|WhyML) program\n" Sys.argv.(0)

let usage () =
  Arg.usage spec usage_msg;
  exit 1

let set_file f =
  match !fname with
  | None when Filename.check_suffix f ".ml" || Filename.check_suffix f ".mlw" ->
      fname := Some f
  | _ -> usage ()

let () = Arg.parse spec set_file usage_msg
let fname = match !fname with None -> usage () | Some f -> f
let debug = if !debug then "--debug=print_modules" else ""
let path = Queue.fold (fun acc s -> sprintf "-L %s %s" s acc) "" path

let execute_ide fname path debug =
  Sys.command (sprintf "why3 ide %s %s %s --extra-config $HOME/.statwhy.conf" fname path debug)

let execute_extract fname =
  Sys.command (sprintf "why3 extract -D ocaml64 %s" fname)

let execute_batch fname path debug prover =
  Sys.command
    (sprintf "why3 prove %s %s %s -P %s -a split_vc" fname path debug prover)

let ensure_conf_exists () =
  let name = Filename.concat (Sys.getenv "HOME") ".statwhy.conf" in
  if Sys.file_exists name then () else
    (Genconf.generate_conf_file ();
     print_endline ".statwhy.conf is generated.")
    

let batch = !batch
let extract = !extract

let _ =
  ensure_conf_exists ();
  if batch then
    let p = match !prover with None -> usage () | Some s -> s in
    exit (execute_batch fname path debug p)
  else if extract then exit (execute_extract fname)
  else exit (execute_ide fname path debug)
