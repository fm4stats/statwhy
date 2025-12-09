open CameleerBHL

module Example2 = struct
  open Ttest

  let t_n1 = NormalD (Param "mu1", Param "var1")
  let t_n2 = NormalD (Param "mu2", Param "var2")
  let fmlA_l : formula = mean t_n1 $< mean t_n2
  let fmlA_u : formula = mean t_n1 $> mean t_n2
  let fmlA : formula = mean t_n1 $!= mean t_n2

  (* Execute Paired t-test for two population means *)
  let example2 (d1: float dataset) (d2: float dataset) : float =
    exec_ttest_paired t_n1 t_n2 d1 d2 Two
  (*@
    p = example2 d1 d2
    requires
      is_empty (!st) /\ paired d1 d2 /\
      d1.scale = Interval /\ d2.scale = Interval /\
      sampled d1 t_n1 /\ sampled d2 t_n2 /\
      (World (!st) interp) |= Possible fmlA_l /\
      (World (!st) interp) |= Possible fmlA_u
    ensures
      Eq p = compose_pvs fmlA !st &&
      (World !st interp) |= StatB (Eq p) fmlA
  *)
end
