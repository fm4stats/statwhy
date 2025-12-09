open CameleerBHL

module Example4 = struct
  open Ttest

  let t_n1 = NormalD (Param "mu1", Param "var")
  let t_n2 = NormalD (Param "mu2", Param "var")
  let t_n3 = NormalD (Param "mu3", Param "var")
  let fmlA_l = mean t_n1 $< mean t_n2
  let fmlA_u = mean t_n1 $> mean t_n2
  let fmlA = mean t_n1 $!= mean t_n2
  let fmlB_l = mean t_n1 $< mean t_n3
  let fmlB_u = mean t_n1 $> mean t_n3
  let fmlB = mean t_n1 $!= mean t_n3
  let fmlC_l = mean t_n2 $< mean t_n3
  let fmlC_u = mean t_n2 $> mean t_n3
  let fmlC = mean t_n2 $!= mean t_n3
  let fml_or_or = fmlA $|| fmlB $|| fmlC
  let fml_and_or = fmlA $&& fmlB $|| fmlC
  let fml_or_and = fmlA $|| fmlB $&& fmlC
  let fml_and_and = fmlA $&& fmlB $&& fmlC

  (* H1 : (fmlA \/ fmlB) \/ fmlC *)
  let example_or_or d1 d2 d3 : float =
    let p1 = exec_ttest_ind_eq t_n1 t_n2 d1 d2 Two in
    let p2 = exec_ttest_ind_eq t_n1 t_n3 d1 d3 Two in
    let p3 = exec_ttest_ind_eq t_n2 t_n3 d2 d3 Two in
    p1 +. p2 +. p3
  (*@
    p = example_or_or d1 d2 d3
    requires
      is_empty (!st) /\
      sampled d1 t_n1 /\ sampled d2 t_n2 /\ sampled d3 t_n3 /\
      d1.scale = d2.scale = d3.scale = Interval /\
      independent d1 d2 /\ independent d1 d3 /\ independent d2 d3 /\
      (World (!st) interp) |= Possible fmlA_l /\
      (World (!st) interp) |= Possible fmlA_u /\
      (World (!st) interp) |= Possible fmlB_l /\
      (World (!st) interp) |= Possible fmlB_u /\
      (World (!st) interp) |= Possible fmlC_l /\
      (World (!st) interp) |= Possible fmlC_u
    ensures
      (Leq p) = compose_pvs fml_or_or !st &&
      (World !st interp) |= StatB (Leq p) ((((mean t_n1) $!= (mean t_n2)) $|| fmlB) $|| fmlC)
  *)

  (* H1 : (fmlA /\ fmlB) \/ fmlC *)
  let example_and_or d1 d2 d3 : float =
    let p1 = exec_ttest_ind_eq t_n1 t_n2 d1 d2 Two in
    let p2 = exec_ttest_ind_eq t_n1 t_n3 d1 d3 Two in
    let p3 = exec_ttest_ind_eq t_n2 t_n3 d2 d3 Two in
    min p1 p2 +. p3
  (*@
    p = example_and_or d1 d2 d3
    requires
      is_empty (!st) /\
      sampled d1 t_n1 /\ sampled d2 t_n2 /\ sampled d3 t_n3 /\
      d1.scale = d2.scale = d3.scale = Interval /\
      independent d1 d2 /\ independent d1 d3 /\ independent d2 d3 /\
      (World (!st) interp) |= Possible fmlA_l /\
      (World (!st) interp) |= Possible fmlA_u /\
      (World (!st) interp) |= Possible fmlB_l /\
      (World (!st) interp) |= Possible fmlB_u /\
      (World (!st) interp) |= Possible fmlC_l /\
      (World (!st) interp) |= Possible fmlC_u
    ensures
      (Leq p) = compose_pvs fml_and_or !st &&
      (World !st interp) |= StatB (Leq p) fml_and_or
  *)

  (* H1 : (fmlA \/ fmlB) \/ fmlC *)
  let example_or_and d1 d2 d3 : float =
    let p1 = exec_ttest_ind_eq t_n1 t_n2 d1 d2 Two in
    let p2 = exec_ttest_ind_eq t_n1 t_n3 d1 d3 Two in
    let p3 = exec_ttest_ind_eq t_n2 t_n3 d2 d3 Two in
    min (p1 +. p2) p3
  (*@
    p = example_or_and d1 d2 d3
    requires
      is_empty (!st) /\
      sampled d1 t_n1 /\ sampled d2 t_n2 /\ sampled d3 t_n3 /\
      d1.scale = d2.scale = d3.scale = Interval /\
      independent d1 d2 /\ independent d1 d3 /\ independent d2 d3 /\
      (World (!st) interp) |= Possible fmlA_l /\
      (World (!st) interp) |= Possible fmlA_u /\
      (World (!st) interp) |= Possible fmlB_l /\
      (World (!st) interp) |= Possible fmlB_u /\
      (World (!st) interp) |= Possible fmlC_l /\
      (World (!st) interp) |= Possible fmlC_u
    ensures
      (Leq p) = compose_pvs fml_or_and !st &&
      (World !st interp) |= StatB (Leq p) fml_or_and
  *)

  (* H1 : (fmlA /\ fmlB) /\ fmlC *)
  let example_and_and d1 d2 d3 : float =
    let p1 = exec_ttest_ind_eq t_n1 t_n2 d1 d2 Two in
    let p2 = exec_ttest_ind_eq t_n1 t_n3 d1 d3 Two in
    let p3 = exec_ttest_ind_eq t_n2 t_n3 d2 d3 Two in
    min (min p1 p2) p3
  (*@
    p = example_and_and d1 d2 d3
    requires
      is_empty (!st) /\
      sampled d1 t_n1 /\ sampled d2 t_n2 /\ sampled d3 t_n3 /\
      d1.scale = d2.scale = d3.scale = Interval /\
      independent d1 d2 /\ independent d1 d3 /\ independent d2 d3 /\
      (World (!st) interp) |= Possible fmlA_l /\
      (World (!st) interp) |= Possible fmlA_u /\
      (World (!st) interp) |= Possible fmlB_l /\
      (World (!st) interp) |= Possible fmlB_u /\
      (World (!st) interp) |= Possible fmlC_l /\
      (World (!st) interp) |= Possible fmlC_u
    ensures
      (Leq p) = compose_pvs fml_and_and !st &&
      (World !st interp) |= StatB (Leq p) fml_and_and
  *)
end
