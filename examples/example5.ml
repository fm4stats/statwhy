open CameleerBHL

module Example5 = struct
  open Ttest

  let t_n = NormalD (Param "mu1", Param "var")
  let fmlA_l = mean t_n $< const_term 1.0
  let fmlA_u = mean t_n $> const_term 1.0
  let fmlA = mean t_n $!= const_term 1.0

  (* Example of p-value hacking *)
  (* This program is INCORRECT and so its verification FAILS *)
  let example5 d1 d2 =
    let p1 = exec_ttest_1samp t_n 1.0 d1 Two in
    let p2 = exec_ttest_1samp t_n 1.0 d2 Two in
    let p = min p1 p2 in
    (p1, p2, p)
  (*@
    (p1, p2, p) = ex_hack d1 d2
    requires
      is_empty (!st) /\
      sampled d1 t_n /\ sampled d2 t_n /\
      d1.scale = d2.scale = Interval /\
      (World (!st) interp) |= Possible fmlA_l /\
      (World (!st) interp) |= Possible fmlA_u
    ensures
      (Eq p = compose_pvs fmlA !st (* This is incorrect *)
        && (World !st interp) |= StatB (Eq p) fmlA) /\
      (Leq (p1 +. p2) = compose_pvs fmlA !st (* This is correct *)
        && (World !st interp) |= StatB (Leq (p1 +. p2)) fmlA)
  *)
end
