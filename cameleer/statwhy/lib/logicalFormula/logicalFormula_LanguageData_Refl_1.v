(* This file is generated by Why3's Coq driver *)
(* Beware! Only edit allowed sections below    *)
Require Import BuiltIn.
Require BuiltIn.
Require HighOrd.
Require int.Int.
Require int.Abs.
Require int.ComputerDivision.
Require real.Real.
Require real.RealInfix.
Require list.List.
Require list.Length.
Require list.Mem.
Require set.Fset.
Require list.Nth.
Require option.Option.
Require list.HdTl.
Require list.NthHdTl.
Require list.Append.
Require list.Reverse.
Require list.RevAppend.
Require list.Combine.
Require list.NumOcc.
Require list.Permut.

(* Why3 assumption *)
Fixpoint fold {a:Type} {a_WT:WhyType a} {b:Type} {b_WT:WhyType b}
  (f:b -> a -> b) (acc:b) (lst:Init.Datatypes.list a) {struct lst}: b :=
  match lst with
  | Init.Datatypes.nil => acc
  | Init.Datatypes.cons x r => fold f (f acc x) r
  end.

(* Why3 assumption *)
Fixpoint foldr {a:Type} {a_WT:WhyType a} {b:Type} {b_WT:WhyType b}
  (f:b -> a -> b) (acc:b) (lst:Init.Datatypes.list a) {struct lst}: b :=
  match lst with
  | Init.Datatypes.nil => acc
  | Init.Datatypes.cons x r => f (foldr f acc r) x
  end.

Axiom fold__append :
  forall {a:Type} {a_WT:WhyType a} {b:Type} {b_WT:WhyType b},
  forall (l1:Init.Datatypes.list a) (l2:Init.Datatypes.list a)
    (f:b -> a -> b) (acc:b),
  ((fold f acc (Init.Datatypes.app l1 l2)) = (fold f (fold f acc l1) l2)).

(* Why3 assumption *)
Fixpoint map {a:Type} {a_WT:WhyType a} {b:Type} {b_WT:WhyType b} (f:a -> b)
  (lst:Init.Datatypes.list a) {struct lst}: Init.Datatypes.list b :=
  match lst with
  | Init.Datatypes.nil => Init.Datatypes.nil
  | Init.Datatypes.cons x xs => Init.Datatypes.cons (f x) (map f xs)
  end.

Parameter fc:
  forall {a:Type} {a_WT:WhyType a}, (a -> Init.Datatypes.bool) ->
  Init.Datatypes.bool -> a -> Init.Datatypes.bool.

Axiom fc'def :
  forall {a:Type} {a_WT:WhyType a},
  forall (p:a -> Init.Datatypes.bool) (acc:Init.Datatypes.bool) (x:a),
  ((fc p acc x) = Init.Datatypes.true) <->
  (acc = Init.Datatypes.true) /\ ((p x) = Init.Datatypes.true).

(* Why3 assumption *)
Definition for_all {a:Type} {a_WT:WhyType a} (p:a -> Init.Datatypes.bool)
    (l:Init.Datatypes.list a) : Init.Datatypes.bool :=
  fold (fc p) Init.Datatypes.true l.

Axiom for_all_correctness :
  forall {a:Type} {a_WT:WhyType a},
  forall (p:a -> Init.Datatypes.bool) (l:Init.Datatypes.list a),
  ((for_all p l) = Init.Datatypes.true) -> forall (x:a), list.Mem.mem x l ->
  ((p x) = Init.Datatypes.true).

Parameter fc1:
  forall {a:Type} {a_WT:WhyType a} {b:Type} {b_WT:WhyType b},
  (a -> b -> Init.Datatypes.bool) ->
  Init.Datatypes.bool -> (a* b)%type -> Init.Datatypes.bool.

Axiom fc'def1 :
  forall {a:Type} {a_WT:WhyType a} {b:Type} {b_WT:WhyType b},
  forall (p:a -> b -> Init.Datatypes.bool) (acc:Init.Datatypes.bool)
    (t:(a* b)%type),
  ((fc1 p acc t) = Init.Datatypes.true) <->
  match t with
  | (x, y) => (acc = Init.Datatypes.true) /\ ((p x y) = Init.Datatypes.true)
  end.

(* Why3 assumption *)
Definition for_all2 {a:Type} {a_WT:WhyType a} {b:Type} {b_WT:WhyType b}
    (p:a -> b -> Init.Datatypes.bool) (l:Init.Datatypes.list a)
    (r:Init.Datatypes.list b) : Init.Datatypes.bool :=
  fold (fc1 p) Init.Datatypes.true (Lists.List.combine l r).

Parameter fc2:
  forall {a:Type} {a_WT:WhyType a}, (a -> Init.Datatypes.bool) ->
  Init.Datatypes.bool -> a -> Init.Datatypes.bool.

Axiom fc'def2 :
  forall {a:Type} {a_WT:WhyType a},
  forall (p:a -> Init.Datatypes.bool) (acc:Init.Datatypes.bool) (x:a),
  ((fc2 p acc x) = Init.Datatypes.true) <->
  (acc = Init.Datatypes.true) \/ ((p x) = Init.Datatypes.true).

(* Why3 assumption *)
Definition for_some {a:Type} {a_WT:WhyType a} (p:a -> Init.Datatypes.bool)
    (l:Init.Datatypes.list a) : Init.Datatypes.bool :=
  fold (fc2 p) Init.Datatypes.false l.

(* Why3 assumption *)
Definition mem_list {a:Type} {a_WT:WhyType a}
    (eq:a -> a -> Init.Datatypes.bool) (x:a) (l:Init.Datatypes.list a) :
    Init.Datatypes.bool :=
  for_some (eq x) l.

(* Why3 assumption *)
Definition rset := set.Fset.fset Reals.Rdefinitions.R.

(* Why3 assumption *)
Fixpoint fold_left {a:Type} {a_WT:WhyType a} {b:Type} {b_WT:WhyType b}
  (f:b -> a -> b) (acc:b) (l:Init.Datatypes.list a) {struct l}: b :=
  match l with
  | Init.Datatypes.nil => acc
  | Init.Datatypes.cons x r => fold_left f (f acc x) r
  end.

Axiom fold_left_append :
  forall {a:Type} {a_WT:WhyType a} {b:Type} {b_WT:WhyType b},
  forall (l1:Init.Datatypes.list a) (l2:Init.Datatypes.list a)
    (f:b -> a -> b) (acc:b),
  ((fold_left f acc (Init.Datatypes.app l1 l2)) =
   (fold_left f (fold_left f acc l1) l2)).

Parameter concat: BuiltIn.string -> BuiltIn.string -> BuiltIn.string.

Axiom concat_assoc :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string) (s3:BuiltIn.string),
  ((concat (concat s1 s2) s3) = (concat s1 (concat s2 s3))).

Parameter rliteral: BuiltIn.string.

Axiom rliteral_axiom : True.

Axiom concat_empty :
  forall (s:BuiltIn.string), ((concat s rliteral) = (concat rliteral s)).

Axiom concat_empty1 : forall (s:BuiltIn.string), ((concat rliteral s) = s).

Parameter length: BuiltIn.string -> Numbers.BinNums.Z.

Axiom length_empty : ((length rliteral) = 0%Z).

Axiom length_concat :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string),
  ((length (concat s1 s2)) = ((length s1) + (length s2))%Z).

Parameter lt: BuiltIn.string -> BuiltIn.string -> Prop.

Axiom lt_empty :
  forall (s:BuiltIn.string), ~ (s = rliteral) -> lt rliteral s.

Axiom lt_not_com :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string), lt s1 s2 -> ~ lt s2 s1.

Axiom lt_ref : forall (s1:BuiltIn.string), ~ lt s1 s1.

Axiom lt_trans :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string) (s3:BuiltIn.string),
  lt s1 s2 /\ lt s2 s3 -> lt s1 s3.

Parameter le: BuiltIn.string -> BuiltIn.string -> Prop.

Axiom le_empty : forall (s:BuiltIn.string), le rliteral s.

Axiom le_ref : forall (s1:BuiltIn.string), le s1 s1.

Axiom lt_le :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string), lt s1 s2 -> le s1 s2.

Axiom lt_le_eq :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string), le s1 s2 ->
  lt s1 s2 \/ (s1 = s2).

Axiom le_trans :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string) (s3:BuiltIn.string),
  le s1 s2 /\ le s2 s3 -> le s1 s3.

Parameter s_at: BuiltIn.string -> Numbers.BinNums.Z -> BuiltIn.string.

Axiom at_out_of_range :
  forall (s:BuiltIn.string) (i:Numbers.BinNums.Z), (i < 0%Z)%Z ->
  ((s_at s i) = rliteral).

Axiom at_out_of_range1 :
  forall (s:BuiltIn.string) (i:Numbers.BinNums.Z), ((length s) <= i)%Z ->
  ((s_at s i) = rliteral).

Axiom at_empty :
  forall (i:Numbers.BinNums.Z), ((s_at rliteral i) = rliteral).

Axiom at_length :
  forall (s:BuiltIn.string) (i:Numbers.BinNums.Z),
  (0%Z <= i)%Z /\ (i < (length s))%Z -> ((length (s_at s i)) = 1%Z).

Axiom at_length1 :
  forall (s:BuiltIn.string) (i:Numbers.BinNums.Z), ~ (0%Z <= i)%Z ->
  ((length (s_at s i)) = 0%Z).

Axiom at_length2 :
  forall (s:BuiltIn.string) (i:Numbers.BinNums.Z), ~ (i < (length s))%Z ->
  ((length (s_at s i)) = 0%Z).

Axiom concat_at :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string),
  forall (i:Numbers.BinNums.Z), (0%Z <= i)%Z /\ (i < (length s1))%Z ->
  ((s_at (concat s1 s2) i) = (s_at s1 i)).

Axiom concat_at1 :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string),
  let s := concat s1 s2 in
  forall (i:Numbers.BinNums.Z), ((length s1) <= i)%Z /\ (i < (length s))%Z ->
  ((s_at s i) = (s_at s2 (i - (length s1))%Z)).

Parameter substring:
  BuiltIn.string -> Numbers.BinNums.Z -> Numbers.BinNums.Z -> BuiltIn.string.

Axiom substring_out_of_range :
  forall (s:BuiltIn.string) (i:Numbers.BinNums.Z) (x:Numbers.BinNums.Z),
  (i < 0%Z)%Z -> ((substring s i x) = rliteral).

Axiom substring_out_of_range1 :
  forall (s:BuiltIn.string) (i:Numbers.BinNums.Z) (x:Numbers.BinNums.Z),
  ((length s) <= i)%Z -> ((substring s i x) = rliteral).

Axiom substring_of_length_zero_or_less :
  forall (s:BuiltIn.string) (i:Numbers.BinNums.Z) (x:Numbers.BinNums.Z),
  (x <= 0%Z)%Z -> ((substring s i x) = rliteral).

Axiom substring_of_empty :
  forall (i:Numbers.BinNums.Z) (x:Numbers.BinNums.Z),
  ((substring rliteral i x) = rliteral).

Axiom substring_smaller :
  forall (s:BuiltIn.string) (i:Numbers.BinNums.Z) (x:Numbers.BinNums.Z),
  ((length (substring s i x)) <= (length s))%Z.

Axiom substring_smaller_x :
  forall (s:BuiltIn.string) (i:Numbers.BinNums.Z) (x:Numbers.BinNums.Z),
  (0%Z <= x)%Z -> ((length (substring s i x)) <= x)%Z.

Axiom substring_length :
  forall (s:BuiltIn.string) (i:Numbers.BinNums.Z) (x:Numbers.BinNums.Z),
  (0%Z <= x)%Z /\ (0%Z <= i)%Z /\ (i < (length s))%Z ->
  ((length s) < (i + x)%Z)%Z ->
  ((length (substring s i x)) = ((length s) - i)%Z).

Axiom substring_length1 :
  forall (s:BuiltIn.string) (i:Numbers.BinNums.Z) (x:Numbers.BinNums.Z),
  (0%Z <= x)%Z /\ (0%Z <= i)%Z /\ (i < (length s))%Z ->
  ~ ((length s) < (i + x)%Z)%Z -> ((length (substring s i x)) = x).

Axiom substring_at :
  forall (s:BuiltIn.string) (i:Numbers.BinNums.Z),
  ((s_at s i) = (substring s i 1%Z)).

Axiom substring_substring :
  forall (s:BuiltIn.string) (ofs:Numbers.BinNums.Z) (len:Numbers.BinNums.Z)
    (ofs':Numbers.BinNums.Z) (len':Numbers.BinNums.Z),
  (0%Z <= ofs)%Z /\ (ofs <= (length s))%Z -> (0%Z <= len)%Z ->
  ((ofs + len)%Z <= (length s))%Z -> (0%Z <= ofs')%Z /\ (ofs' <= len)%Z ->
  (0%Z <= len')%Z -> ((ofs' + len')%Z <= len)%Z ->
  ((substring (substring s ofs len) ofs' len') =
   (substring s (ofs + ofs')%Z len')).

Axiom concat_substring :
  forall (s:BuiltIn.string) (ofs:Numbers.BinNums.Z) (len:Numbers.BinNums.Z)
    (len':Numbers.BinNums.Z),
  (0%Z <= ofs)%Z /\ (ofs <= (length s))%Z -> (0%Z <= len)%Z ->
  ((ofs + len)%Z <= (length s))%Z -> (0%Z <= len')%Z ->
  (0%Z <= ((ofs + len)%Z + len')%Z)%Z /\
  (((ofs + len)%Z + len')%Z <= (length s))%Z ->
  ((concat (substring s ofs len) (substring s (ofs + len)%Z len')) =
   (substring s ofs (len + len')%Z)).

Parameter prefixof: BuiltIn.string -> BuiltIn.string -> Prop.

Axiom prefixof_substring :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string), prefixof s1 s2 ->
  (s1 = (substring s2 0%Z (length s1))).

Axiom prefixof_substring1 :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string),
  (s1 = (substring s2 0%Z (length s1))) -> prefixof s1 s2.

Axiom prefixof_concat :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string), prefixof s1 (concat s1 s2).

Axiom prefixof_empty : forall (s2:BuiltIn.string), prefixof rliteral s2.

Axiom prefixof_empty2 :
  forall (s1:BuiltIn.string), ~ (s1 = rliteral) -> ~ prefixof s1 rliteral.

Parameter suffixof: BuiltIn.string -> BuiltIn.string -> Prop.

Axiom suffixof_substring :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string), suffixof s1 s2 ->
  (s1 = (substring s2 ((length s2) - (length s1))%Z (length s1))).

Axiom suffixof_substring1 :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string),
  (s1 = (substring s2 ((length s2) - (length s1))%Z (length s1))) ->
  suffixof s1 s2.

Axiom suffixof_concat :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string), suffixof s2 (concat s1 s2).

Axiom suffixof_empty : forall (s2:BuiltIn.string), suffixof rliteral s2.

Axiom suffixof_empty2 :
  forall (s1:BuiltIn.string), ~ (s1 = rliteral) -> ~ suffixof s1 rliteral.

Parameter contains: BuiltIn.string -> BuiltIn.string -> Prop.

Axiom contains_prefixof :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string), prefixof s1 s2 ->
  contains s2 s1.

Axiom contains_suffixof :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string), suffixof s1 s2 ->
  contains s2 s1.

Axiom contains_empty :
  forall (s2:BuiltIn.string), contains rliteral s2 -> (s2 = rliteral).

Axiom contains_empty1 :
  forall (s2:BuiltIn.string), (s2 = rliteral) -> contains rliteral s2.

Axiom contains_empty2 : forall (s1:BuiltIn.string), contains s1 rliteral.

Axiom contains_substring :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string) (i:Numbers.BinNums.Z),
  ((substring s1 i (length s2)) = s2) -> contains s1 s2.

Axiom contains_concat :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string), contains (concat s1 s2) s1.

Axiom contains_concat1 :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string), contains (concat s1 s2) s2.

Axiom contains_at :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string) (i:Numbers.BinNums.Z),
  ((s_at s1 i) = s2) -> contains s1 s2.

Parameter indexof:
  BuiltIn.string -> BuiltIn.string -> Numbers.BinNums.Z -> Numbers.BinNums.Z.

Axiom indexof_empty :
  forall (s:BuiltIn.string) (i:Numbers.BinNums.Z),
  (0%Z <= i)%Z /\ (i <= (length s))%Z -> ((indexof s rliteral i) = i).

Axiom indexof_empty1 :
  forall (s:BuiltIn.string) (i:Numbers.BinNums.Z),
  ((indexof rliteral s i) = (-1%Z)%Z) \/ (s = rliteral).

Axiom indexof_empty11 :
  forall (s:BuiltIn.string) (i:Numbers.BinNums.Z),
  let j := indexof rliteral s i in (j = (-1%Z)%Z) \/ (i = j).

Axiom indexof_empty12 :
  forall (s:BuiltIn.string) (i:Numbers.BinNums.Z),
  let j := indexof rliteral s i in (j = (-1%Z)%Z) \/ (j = 0%Z).

Axiom indexof_contains :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string), contains s1 s2 ->
  (0%Z <= (indexof s1 s2 0%Z))%Z.

Axiom indexof_contains1 :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string), contains s1 s2 ->
  ((indexof s1 s2 0%Z) <= (length s1))%Z.

Axiom indexof_contains2 :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string), contains s1 s2 ->
  ((substring s1 (indexof s1 s2 0%Z) (length s2)) = s2).

Axiom contains_indexof :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string) (i:Numbers.BinNums.Z),
  (0%Z <= (indexof s1 s2 i))%Z -> contains s1 s2.

Axiom not_contains_indexof :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string) (i:Numbers.BinNums.Z),
  ~ contains s1 s2 -> ((indexof s1 s2 i) = (-1%Z)%Z).

Axiom substring_indexof :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string) (i:Numbers.BinNums.Z),
  let j := indexof s1 s2 i in
  (0%Z <= j)%Z -> ((substring s1 j (length s2)) = s2).

Axiom indexof_out_of_range :
  forall (i:Numbers.BinNums.Z) (s1:BuiltIn.string) (s2:BuiltIn.string),
  ~ (0%Z <= i)%Z -> ((indexof s1 s2 i) = (-1%Z)%Z).

Axiom indexof_out_of_range1 :
  forall (i:Numbers.BinNums.Z) (s1:BuiltIn.string) (s2:BuiltIn.string),
  ~ (i <= (length s1))%Z -> ((indexof s1 s2 i) = (-1%Z)%Z).

Axiom indexof_in_range :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string) (i:Numbers.BinNums.Z),
  let j := indexof s1 s2 i in
  (0%Z <= i)%Z /\ (i <= (length s1))%Z -> (j = (-1%Z)%Z) \/ (i <= j)%Z.

Axiom indexof_in_range1 :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string) (i:Numbers.BinNums.Z),
  let j := indexof s1 s2 i in
  (0%Z <= i)%Z /\ (i <= (length s1))%Z ->
  (j = (-1%Z)%Z) \/ (j <= (length s1))%Z.

Axiom indexof_contains_substring :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string) (i:Numbers.BinNums.Z),
  ((0%Z <= i)%Z /\ (i <= (length s1))%Z) /\
  contains (substring s1 i ((length s1) - i)%Z) s2 ->
  (i <= (indexof s1 s2 i))%Z.

Axiom indexof_contains_substring1 :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string) (i:Numbers.BinNums.Z),
  ((0%Z <= i)%Z /\ (i <= (length s1))%Z) /\
  contains (substring s1 i ((length s1) - i)%Z) s2 ->
  ((indexof s1 s2 i) <= (length s1))%Z.

Parameter replace:
  BuiltIn.string -> BuiltIn.string -> BuiltIn.string -> BuiltIn.string.

Axiom replace_empty :
  forall (s1:BuiltIn.string) (s3:BuiltIn.string),
  ((replace s1 rliteral s3) = (concat s3 s1)).

Axiom replace_not_contains :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string) (s3:BuiltIn.string),
  ~ contains s1 s2 -> ((replace s1 s2 s3) = s1).

Axiom replace_empty2 :
  forall (s2:BuiltIn.string) (s3:BuiltIn.string), (s2 = rliteral) ->
  ((replace rliteral s2 s3) = s3).

Axiom replace_empty21 :
  forall (s2:BuiltIn.string) (s3:BuiltIn.string), ~ (s2 = rliteral) ->
  ((replace rliteral s2 s3) = rliteral).

Axiom replace_substring_indexof :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string) (s3:BuiltIn.string),
  let j := indexof s1 s2 0%Z in
  ((j < 0%Z)%Z -> ((replace s1 s2 s3) = s1)) /\
  (~ (j < 0%Z)%Z ->
   ((replace s1 s2 s3) =
    (concat (concat (substring s1 0%Z j) s3)
     (substring s1 (j + (length s2))%Z (((length s1) - j)%Z - (length s2))%Z)))).

Parameter replaceall:
  BuiltIn.string -> BuiltIn.string -> BuiltIn.string -> BuiltIn.string.

Axiom replaceall_empty1 :
  forall (s1:BuiltIn.string) (s3:BuiltIn.string),
  ((replaceall s1 rliteral s3) = s1).

Axiom not_contains_replaceall :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string) (s3:BuiltIn.string),
  ~ contains s1 s2 -> ((replaceall s1 s2 s3) = s1).

Parameter to_int: BuiltIn.string -> Numbers.BinNums.Z.

Axiom to_int_gt_minus_1 :
  forall (s:BuiltIn.string), ((-1%Z)%Z <= (to_int s))%Z.

Axiom to_int_empty : ((to_int rliteral) = (-1%Z)%Z).

(* Why3 assumption *)
Definition is_digit (s:BuiltIn.string) : Prop :=
  ((0%Z <= (to_int s))%Z /\ ((to_int s) <= 9%Z)%Z) /\ ((length s) = 1%Z).

Parameter from_int: Numbers.BinNums.Z -> BuiltIn.string.

Axiom from_int_negative :
  forall (i:Numbers.BinNums.Z), (i < 0%Z)%Z -> ((from_int i) = rliteral).

Axiom from_int_negative1 :
  forall (i:Numbers.BinNums.Z), ((from_int i) = rliteral) -> (i < 0%Z)%Z.

Axiom from_int_to_int :
  forall (i:Numbers.BinNums.Z), (0%Z <= i)%Z -> ((to_int (from_int i)) = i).

Axiom from_int_to_int1 :
  forall (i:Numbers.BinNums.Z), ~ (0%Z <= i)%Z ->
  ((to_int (from_int i)) = (-1%Z)%Z).

Axiom char : Type.
Parameter char_WhyType : WhyType char.
Existing Instance char_WhyType.

Parameter contents: char -> BuiltIn.string.

Axiom char'invariant : forall (self:char), ((length (contents self)) = 1%Z).

Axiom char_eq :
  forall (c1:char) (c2:char), ((contents c1) = (contents c2)) -> (c1 = c2).

Parameter code: char -> Numbers.BinNums.Z.

Axiom code1 : forall (c:char), (0%Z <= (code c))%Z.

Axiom code2 : forall (c:char), ((code c) < 256%Z)%Z.

Parameter chr: Numbers.BinNums.Z -> char.

Axiom code_chr :
  forall (n:Numbers.BinNums.Z), (0%Z <= n)%Z /\ (n < 256%Z)%Z ->
  ((code (chr n)) = n).

Axiom chr_code : forall (c:char), ((chr (code c)) = c).

Parameter get: BuiltIn.string -> Numbers.BinNums.Z -> char.

Axiom get1 :
  forall (s:BuiltIn.string) (i:Numbers.BinNums.Z),
  (0%Z <= i)%Z /\ (i < (length s))%Z -> ((contents (get s i)) = (s_at s i)).

Axiom substring_get :
  forall (s:BuiltIn.string) (ofs:Numbers.BinNums.Z) (len:Numbers.BinNums.Z)
    (i:Numbers.BinNums.Z),
  (0%Z <= ofs)%Z /\ (ofs <= (length s))%Z -> (0%Z <= len)%Z ->
  ((ofs + len)%Z <= (length s))%Z -> (0%Z <= i)%Z /\ (i < len)%Z ->
  ((get (substring s ofs len) i) = (get s (ofs + i)%Z)).

Axiom concat_first :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string),
  forall (i:Numbers.BinNums.Z), (0%Z <= i)%Z /\ (i < (length s1))%Z ->
  ((get (concat s1 s2) i) = (get s1 i)).

Axiom concat_second :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string),
  forall (i:Numbers.BinNums.Z),
  ((length s1) <= i)%Z /\ (i < ((length s1) + (length s2))%Z)%Z ->
  ((get (concat s1 s2) i) = (get s2 (i - (length s1))%Z)).

(* Why3 assumption *)
Definition eq_string (s1:BuiltIn.string) (s2:BuiltIn.string) : Prop :=
  ((length s1) = (length s2)) /\
  (forall (i:Numbers.BinNums.Z), (0%Z <= i)%Z /\ (i < (length s1))%Z ->
   ((get s1 i) = (get s2 i))).

Axiom extensionality :
  forall (s1:BuiltIn.string) (s2:BuiltIn.string), eq_string s1 s2 ->
  (s1 = s2).

Parameter make: Numbers.BinNums.Z -> char -> BuiltIn.string.

Axiom make_length :
  forall (size:Numbers.BinNums.Z) (v:char), (0%Z <= size)%Z ->
  ((length (make size v)) = size).

Axiom make_contents :
  forall (size:Numbers.BinNums.Z) (v:char), (0%Z <= size)%Z ->
  forall (i:Numbers.BinNums.Z), (0%Z <= i)%Z /\ (i < size)%Z ->
  ((get (make size v) i) = v).

Axiom int63 : Type.
Parameter int63_WhyType : WhyType int63.
Existing Instance int63_WhyType.

Parameter int63'int: int63 -> Numbers.BinNums.Z.

Axiom int63'axiom :
  forall (i:int63),
  ((-4611686018427387904%Z)%Z <= (int63'int i))%Z /\
  ((int63'int i) <= 4611686018427387903%Z)%Z.

(* Why3 assumption *)
Definition in_bounds (n:Numbers.BinNums.Z) : Prop :=
  ((-4611686018427387904%Z)%Z <= n)%Z /\ (n <= 4611686018427387903%Z)%Z.

Axiom to_int_in_bounds : forall (n:int63), in_bounds (int63'int n).

Axiom extensionality1 :
  forall (x:int63) (y:int63), ((int63'int x) = (int63'int y)) -> (x = y).

Parameter max_int: int63.

Axiom max_int'def : ((int63'int max_int) = 4611686018427387903%Z).

Parameter min_int: int63.

Axiom min_int'def : ((int63'int min_int) = (-4611686018427387904%Z)%Z).

(* Why3 assumption *)
Definition dataset (a:Type) := a.

(* Why3 assumption *)
Definition vsymb := Numbers.BinNums.Z.

(* Why3 assumption *)
Definition fsymb := BuiltIn.string.

(* Why3 assumption *)
Definition psymb := BuiltIn.string.

(* Why3 assumption *)
Inductive pvalue :=
  | Eq : Reals.Rdefinitions.R -> pvalue
  | Leq : Reals.Rdefinitions.R -> pvalue.
Axiom pvalue_WhyType : WhyType pvalue.
Existing Instance pvalue_WhyType.

(* Why3 assumption *)
Definition parameter := BuiltIn.string.

(* Why3 assumption *)
Inductive real_number :=
  | Param : BuiltIn.string -> real_number
  | Const : Reals.Rdefinitions.R -> real_number.
Axiom real_number_WhyType : WhyType real_number.
Existing Instance real_number_WhyType.

(* Why3 assumption *)
Inductive population :=
  | NormalD : real_number -> real_number -> population
  | BernoulliD : real_number -> population
  | CategoricalD : Init.Datatypes.list real_number -> population
  | UnknownD : BuiltIn.string -> population.
Axiom population_WhyType : WhyType population.
Existing Instance population_WhyType.

Parameter ppl: forall {a:Type} {a_WT:WhyType a}, a -> population.

(* Why3 assumption *)
Inductive real_term :=
  | Real : real_number -> real_term.
Axiom real_term_WhyType : WhyType real_term.
Existing Instance real_term_WhyType.

(* Why3 assumption *)
Inductive term :=
  | RealT : real_term -> term
  | PopulationT : population -> term.
Axiom term_WhyType : WhyType term.
Existing Instance term_WhyType.

Parameter mean: population -> real_term.

Parameter var: population -> real_term.

Parameter med: population -> real_term.

(* Why3 assumption *)
Definition const_term (r:Reals.Rdefinitions.R) : real_term := Real (Const r).

Axiom Refl : True.

Axiom Trans :
  forall (x:BuiltIn.string) (y:BuiltIn.string) (z:BuiltIn.string), (x = y) ->
  (y = z) -> (x = z).

Axiom Symm :
  forall (x:BuiltIn.string) (y:BuiltIn.string), (x = y) -> (y = x).

(* Why3 assumption *)
Definition eq_real_number (r1:real_number) (r2:real_number) : Prop :=
  match (r1, r2) with
  | (Param s, Param t) => (s = t)
  | (Const s, Const t) => (s = t)
  | _ => False
  end.

Axiom Refl1 : forall (x:real_number), eq_real_number x x.

Axiom Trans1 :
  forall (x:real_number) (y:real_number) (z:real_number),
  eq_real_number x y -> eq_real_number y z -> eq_real_number x z.

Axiom Symm1 :
  forall (x:real_number) (y:real_number), eq_real_number x y ->
  eq_real_number y x.

Parameter eq_real_number_closure:
  real_number -> real_number -> Init.Datatypes.bool.

Axiom eq_real_number_closure_def :
  forall (y:real_number) (y1:real_number),
  ((eq_real_number_closure y y1) = Init.Datatypes.true) <->
  eq_real_number y y1.

(* Why3 assumption *)
Definition eq_population (p1:population) (p2:population) : Prop :=
  match (p1, p2) with
  | (NormalD s1 s2, NormalD t1 t2) => (s1 = t1) /\ (s2 = t2)
  | (BernoulliD s, BernoulliD t) => (s = t)
  | (UnknownD i, UnknownD j) => (i = j)
  | (CategoricalD pp, CategoricalD qq) =>
      ((for_all2 eq_real_number_closure pp qq) = Init.Datatypes.true)
  | _ => False
  end.

Parameter x: population.

Parameter x1: Init.Datatypes.list real_number.

Axiom H : (x = (CategoricalD x1)).

Parameter x2: Init.Datatypes.list real_number.

Axiom H1 : (x = (CategoricalD x2)).

Parameter fc3:
  Init.Datatypes.bool ->
  (real_number* real_number)%type -> Init.Datatypes.bool.

Axiom fc'def3 :
  forall (acc:Init.Datatypes.bool) (t:(real_number* real_number)%type),
  ((fc3 acc t) = Init.Datatypes.true) <->
  match t with
  | (x3, y) =>
      (acc = Init.Datatypes.true) /\
      ((eq_real_number_closure x3 y) = Init.Datatypes.true)
  end.

(* Why3 goal *)
Theorem Refl2 :
  ((fold fc3 Init.Datatypes.true (Lists.List.combine x2 x1)) =
   Init.Datatypes.true).
Proof.


Qed.
