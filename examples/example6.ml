open CameleerBHL

module Example6_Tukey_HSD = struct
  open Tukey_HSD
  open Array

  let t_n1 = NormalD (Param "mu1", Param "var")
  let t_n2 = NormalD (Param "mu2", Param "var")
  let t_n3 = NormalD (Param "mu3", Param "var")
  
  let terms3 = [ mean t_n1; mean t_n2; mean t_n3 ]
  
  (* Execute Tukey's HSD test for multiple comparison of 3 groups *)
  let example6_tukey_hsd d1 d2 d3 : float array =
    exec_tukey_hsd [ t_n1; t_n2; t_n3 ] [ d1; d2; d3 ]
  (*@
    ps = example6_tukey_hsd d1 d2 d3
    requires
      is_empty (!st) /\
      independent_list (Cons d1 (Cons d2 (Cons d3 Nil))) /\
      for_all2
        sampled
        (Cons d1 (Cons d2 (Cons d3 Nil)))
        (Cons t_n1 (Cons t_n2 (Cons t_n3 Nil))) /\
      for_all
        (fun d -> d.scale = Interval)
        (Cons d1 (Cons d2 (Cons d3 Nil))) /\
      for_all (fun fml -> (World !st interp) |= Possible fml) (combinations' terms3 ($<)) /\
      for_all (fun fml -> (World !st interp) |= Possible fml) (combinations' terms3 ($>))
    ensures
      for_all (fun t -> let (i,fml) = t in
                (Eq (ps[i]) = compose_pvs fml !st) &&
                (World !st interp |= StatB (Eq (ps[i])) fml))
              (enumerate (combinations' terms3 ($!=)) 0)
  *)
end
