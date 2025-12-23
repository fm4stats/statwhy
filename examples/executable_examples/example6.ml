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

  let y1 =
    [
      0.766619176600281671;
      1.21789185837721869;
      1.99159246988234928;
      1.60647913567575529;
      1.47148639466940301;
      0.184253105479018964;
      -0.305625265984637684;
      0.391653042798745687;
      0.751061964281471761;
      0.636099333870649319;
    ]

  let y2 =
    [
      1.33080408985008525;
      0.818096098824745;
      0.358846712280329605;
      2.03612265448292229;
      1.53355196013926487;
      2.86422867768522549;
      0.33717261327312964;
      2.97841750606052269;
      0.911561712359776899;
      1.51455005196473058;
    ]

  let y3 =
    [
      2.73343897147291148;
      1.73257203436255591;
      0.846962147974803514;
      2.38736316604747723;
      2.99839846928943121;
      2.22163792102414837;
      1.03345074000452164;
      0.336433008189366722;
      2.844524316810912;
      0.911470664085555438;
    ]
  
  let[@run] a =
    let res = example6_tukey_hsd y1 y2 y3 in
    List.iter (fun p -> Printf.printf "p-value : %f\n" p) (to_list res)
end
