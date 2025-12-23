let () = if not @@ Py.is_initialized () then Py.initialize ()

let tukey_hsd xs =
  let py_xs =
    List.map (Py.List.of_list_map Py.Float.of_float) xs |> Array.of_list
  in
  let stats = Py.import "scipy.stats" in
  let result = Py.Module.get_function stats "tukey_hsd" py_xs in
  let py_pvalues = Option.get @@ Py.Object.get_attr_string result "pvalue" in
  let pvalues_mat =
    Py.Object.call_method py_pvalues "tolist" [||]
    |> Py.List.to_list_map @@ Py.List.to_list_map Py.Float.to_float
  in
  let rec drop n = function
    | [] -> []
    | _ :: xs as l -> if n = 0 then l else drop (n - 1) xs
  in
  let rec flatten n = function
    | [] -> []
    | l :: ls -> drop n l @ flatten (n + 1) ls
  in
  let pvalues_list = flatten 1 pvalues_mat in
  Array.of_list pvalues_list

let exec_tukey_hsd _ xs = tukey_hsd xs
