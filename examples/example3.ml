open CameleerBHL

module Example3 = struct
  open Ttest

  let t_n1 = NormalD (Param "mu1", Param "var1")
  let t_n2 = NormalD (Param "mu2", Param "var2")
  let fmlA_l : formula = mean t_n1 $< mean t_n2
  let fmlA_u : formula = mean t_n1 $> mean t_n2
  let fmlA : formula = mean t_n1 $!= mean t_n2

  (* Execute Student's t-test for two population means *)
  let example3_eq (d1 : float dataset) (d2 : float dataset) : float =
    exec_ttest_ind_eq t_n1 t_n2 d1 d2 Two
  (*@
    p = example3_eq d1 d2
    requires
      is_empty (!st) /\
      independent d1 d2 /\
      sampled d1 t_n1 /\ sampled d2 t_n2 /\
      d1.scale = Interval /\ d2.scale = Interval /\
      (World (!st) interp) |= eq_variance t_n1 t_n2 /\
      (World (!st) interp) |= Possible fmlA_l /\
      (World (!st) interp) |= Possible fmlA_u
    ensures
      Eq p = compose_pvs fmlA !st &&
      (World !st interp) |= StatB (Eq p) fmlA
  *)

  (* Execute Welch's t-test for two population means *)
  let example3_neq (d1 : float dataset) (d2 : float dataset) : float =
    exec_ttest_ind_neq t_n1 t_n2 d1 d2 Two
  (*@
    p = example3_neq d1 d2
    requires
      is_empty (!st) /\
      independent d1 d2 /\
      sampled d1 t_n1 /\ sampled d2 t_n2 /\
      d1.scale = Interval /\ d2.scale = Interval /\
      (World (!st) interp) |= Not (eq_variance t_n1 t_n2) /\
      (World (!st) interp) |= Possible fmlA_l /\
      (World (!st) interp) |= Possible fmlA_u
    ensures
      Eq p = compose_pvs fmlA !st &&
      (World !st interp) |= StatB (Eq p) fmlA
  *)
end
