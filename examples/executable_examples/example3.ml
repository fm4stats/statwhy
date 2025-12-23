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

  let y1 =
    [
      0.602625786295998389;
      2.14566916029819144;
      1.35823522315676626;
      1.17182034121895451;
      2.73483412251327973;
      0.748574993793243215;
      -1.23872899202434184;
      1.13256387540348635;
      2.13263167487555538;
      -0.690867157847799;
    ]

  let y2 =
    [
      1.11323083456496041;
      1.50709387256810068;
      2.01790413657013223;
      0.0128054313581813517;
      0.654213861773376149;
      1.24534175639978573;
      1.08690184443523741;
      3.33147931443587;
      1.92634477831957263;
      0.92746490751175148;
    ]

  let y3 =
    [
      1.14554997101001144;
      2.09354953993055126;
      0.28536806688398042;
      1.57022519724889831;
      1.26631134649714849;
      1.67061757744275519;
      0.91372878636115662;
      1.56607760911782146;
      0.481864022121295088;
      0.652102852392709709;
    ]

  let y4 =
    [
      0.539477742609872912;
      -0.084818902916167;
      1.09543658715494718;
      0.787026591762991501;
      2.11532125513984681;
      3.0309656104628373;
      1.32704853381800114;
      0.623024431984707;
      1.09926233277460139;
      -0.884200978762662571;
    ]

  let[@run] a =
    let res1 = example3_eq y1 y2 in
    let res2 = example3_neq y3 y4 in
    Printf.printf "p-value 1 : %f\np-value 2 : %f\n" res1 res2
end
