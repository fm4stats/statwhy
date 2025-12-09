let run_command cmd =
  try
    let ic = Unix.open_process_in cmd in
    let output = input_line ic in
    let () = close_in ic in
    output
  with End_of_file -> ""


(* get cvc5 version *)
let get_cvc5_version () =
  run_command "cvc5 -V | awk '/This is cvc5 version/ {print $5}'"
  |> String.trim

(* template *)
let temp = String.trim "
[strategy]
code = \"
init:
t subst_all_statwhy init
t compute_specified_statwhy start
g start

start:
c CVC5,??? 1. 1000
t split_vc start
c CVC5,??? 5. 1000
t introduce_premises afterintro

afterintro:
t split_goal_full afterintro
t compute_in_goal_statwhy afterintro
t subst_all_statwhy afterintro
t split_goal_full start
g trylongertime

trylongertime:
c CVC5,??? 60. 4000
\"
desc = \"Automatic@ run@ of@ provers@ and@ the@ transformations@ which@ are@ specialized@ to@ StatWhy\"
name = \"StatWhy\"
shortcut = \"4\"

[strategy]
code = \"
init:
t compute_in_goal_statwhy start
g start

start:
c CVC5,??? 1. 1000
t split_vc start
c CVC5,??? 5. 1000
t introduce_premises afterintro

afterintro:
t split_goal_full afterintro
t compute_in_goal_statwhy afterintro
t subst_all_statwhy afterintro
t split_goal_full start
g trylongertime

trylongertime:
c CVC5,??? 60. 4000
\"
desc = \"Automatic@ run@ of@ provers@ and@ the@ aggressive@ transformations@ which@ are@ specialized@ to@ StatWhy\"
name = \"StatWhy_aggressive\"
shortcut = \"5\"
"

let generate_conf_file () =
  let version = get_cvc5_version () in
  let target = ".statwhy.conf" in
  let home = Sys.getenv "HOME" in
  let home_target = Filename.concat home target in
  let sed_cmd = Printf.sprintf "echo '%s' | sed 's/???/%s/g' > %s" temp version home_target in
  ignore (run_command sed_cmd)
