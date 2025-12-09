open CameleerBHL

module Example1 = struct
  open Ttest

  (* Declarations of a distribution and formulas *)
  let t_n = NormalD (Param "mu1", Param "var")
  let fmlA_l = mean t_n $< const_term 1.0
  let fmlA_u = mean t_n $> const_term 1.0
  let fmlA = mean t_n $!= const_term 1.0

  (* executes the t-test for a population mean *)
  let example1 (d : float dataset) : float = exec_ttest_1samp t_n 1.0 d Two
  (*@ p = example1 d
    requires
      is_empty (!st) /\
      sampled d t_n /\
      d.scale = Interval /\
      (World (!st) interp) |= Possible fmlA_l /\
      (World (!st) interp) |= Possible fmlA_u
    ensures
      Eq p = compose_pvs fmlA !st &&
      (World !st interp) |= StatB (Eq p) fmlA
  *)

  (* executes the same test but lacks one of the precondition, "sampled d t_n" *)
  (* This program is INCORRECT and so its verification FAILS *)
  let example1' (d : float dataset) : float =
    exec_ttest_1samp t_n 1.0 d Two
  (*@ p = example1 d
    requires
      is_empty (!st) /\
      (* sampled d t_n /\ *)
      d.scale = Interval /\
      (World (!st) interp) |= Possible fmlA_l /\
      (World (!st) interp) |= Possible fmlA_u
    ensures
      Eq p = compose_pvs fmlA !st &&
      (World !st interp) |= StatB (Eq p) fmlA
  *)
end
