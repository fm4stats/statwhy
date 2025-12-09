open CameleerBHL

module Compare_with_existing_drugs = struct
  open Ttest

  let ppl_new = NormalD (Param "mu_new", Param "var")
  let ppl_drug1 = NormalD (Param "mu_drug1", Param "var")
  let ppl_drug2 = NormalD (Param "mu_drug2", Param "var")
  let h_new_drug1 = mean ppl_new $> mean ppl_drug1
  let h_new_drug1_c = mean ppl_new $< mean ppl_drug1
  let h_new_drug2 = mean ppl_new $> mean ppl_drug2
  let h_new_drug2_c = mean ppl_new $< mean ppl_drug2
  let h1 = Disj (h_new_drug1, h_new_drug2)

  let cmp_with_existing_drugs d_new d_drug1 d_drug2 =
    let p_drug1 = exec_ttest_ind_eq ppl_new ppl_drug1 d_new d_drug1 Up in
    let p_drug2 = exec_ttest_ind_eq ppl_new ppl_drug2 d_new d_drug2 Up in
    p_drug1 +. p_drug2
  (*@ p = testing d_new d_drug1 d_drug2
      
    requires
      is_empty (!st) /\ sampled d_new ppl_new /\
      d_new.scale = d_drug1.scale = d_drug2.scale = Interval /\
      sampled d_drug1 ppl_drug1 /\ sampled d_drug2 ppl_drug2 /\
      independent d_new d_drug1 /\ independent d_new d_drug2 /\
      (World (!st) interp) |= Possible h_new_drug1 /\
      (World (!st) interp) |= Not (Possible h_new_drug1_c) /\
      (World (!st) interp) |= Possible h_new_drug2 /\
      (World (!st) interp) |= Not (Possible h_new_drug2_c)
    
    ensures
      (Leq p) = compose_pvs (Disj h_new_drug1 h_new_drug2) !st &&
      (World !st interp) |= StatB (Leq p) (Disj h_new_drug1 h_new_drug2) *)
end
