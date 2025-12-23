let () = if not @@ Py.is_initialized () then Py.initialize ()

let scipy_alt (alt : CameleerBHL.alternative) =
  (match alt with Two -> "two-sided" | Up -> "greater" | Low -> "less")
  |> Py.String.of_string


(* Implementations of hypothesis tests *)

(** Test 7 : t-test for a population mean (variance unknown) *)
let test7 x mu0 alt =
  let x = List.map Py.Float.of_float x |> Py.List.of_list in
  let mu0 = Py.Float.of_float mu0 in
  let scipy_stats = Py.import "scipy.stats" in
  let res =
    Py.Module.get_function_with_keywords scipy_stats "ttest_1samp" [| x; mu0 |]
      [ ("alternative", scipy_alt alt) ]
  in
  Array.get (Py.Tuple.to_array res) 1 |> Py.Float.to_float

(** Test 8 : t-test for two population means (variances unknown but equal) *)
let test8 x1 x2 alt =
  let x1 = List.map Py.Float.of_float x1 |> Py.List.of_list in
  let x2 = List.map Py.Float.of_float x2 |> Py.List.of_list in
  let scipy_stats = Py.import "scipy.stats" in
  let res =
    Py.Module.get_function_with_keywords scipy_stats "ttest_ind" [| x1; x2 |]
      [ ("equal_var", Py.Bool.of_bool true); ("alternative", scipy_alt alt) ]
  in
  Array.get (Py.Tuple.to_array res) 1 |> Py.Float.to_float

(** Test 9 : t-test for two population means (variances unknown and unequal) *)
let test9 x1 x2 alt =
  let x1 = List.map Py.Float.of_float x1 |> Py.List.of_list in
  let x2 = List.map Py.Float.of_float x2 |> Py.List.of_list in
  let scipy_stats = Py.import "scipy.stats" in
  let res =
    Py.Module.get_function_with_keywords scipy_stats "ttest_ind" [| x1; x2 |]
      [ ("equal_var", Py.Bool.of_bool false); ("alternative", scipy_alt alt) ]
  in
  Array.get (Py.Tuple.to_array res) 1 |> Py.Float.to_float

(** Test 10 : t-test for two population means (method of paired comparisons) *)
let test10 x1 x2 alt =
  let x1 = List.map Py.Float.of_float x1 |> Py.List.of_list in
  let x2 = List.map Py.Float.of_float x2 |> Py.List.of_list in
  let scipy_stats = Py.import "scipy.stats" in
  let res =
    Py.Module.get_function_with_keywords scipy_stats "ttest_rel" [| x1; x2 |]
      [ ("alternative", scipy_alt alt) ]
  in
  Array.get (Py.Tuple.to_array res) 1 |> Py.Float.to_float


let exec_ttest_1samp _ mu y alt = test7 y mu alt

let exec_ttest_ind_eq _ _ y1 y2 alt = test8 y1 y2 alt

let exec_ttest_ind_neq _ _ y1 y2 alt = test9 y1 y2 alt

let exec_ttest_paired _ _ y1 y2 alt = test10 y1 y2 alt
