(* CameleerReal *)
let ( =. ) (x : float) (y : float) = x = y
let ( <=. ) (x : float) (y : float) = x <= y
let ( >=. ) (x : float) (y : float) = x >= y
let ( <. ) (x : float) (y : float) = x < y
let ( >. ) (x : float) (y : float) = x > y

(* logicalFormula *)
type 'a dataset = 'a list
type vsymb = int
type fsymb = string
type psymb = string
type pvalue = Eq of float | Leq of float
type parameter = string
type real_number = Param of parameter | Const of float

type distribution =
  | NormalD of real_number * real_number
  | BernoulliD of real_number
  | CategoricalD of real_number list
  | UnknownD of string

let ppl _ = UnknownD "ppl"

type real_term =
  | Real of real_number
  | Mean of distribution
  | Var of distribution
  | Med of distribution

type term = RealT of real_term | DistributionT of distribution

let mean ppl = Mean ppl
let var ppl = Var ppl
let med ppl = Med ppl
let const_term r = Real (Const r)
let param_term r = Real r

type atomic_formula = Pred of psymb * term list

type formula =
  | Atom of atomic_formula
  | Not of formula
  | Conj of formula * formula
  | Disj of formula * formula
  | Impl of formula * formula
  | Equiv of formula * formula
  | Possible of formula
  | Know of formula
  | StatTau of pvalue * formula
  | StatB of pvalue * formula

(* atomicFormulas *)

let ( $< ) r1 r2 = Atom (Pred ("<", [RealT r1; RealT r2]))
let ( $> ) r1 r2 = Atom (Pred (">", [RealT r1; RealT r2]))
let ( $<= ) r1 r2 = Atom (Pred ("<=", [RealT r1; RealT r2]))
let ( $>= ) r1 r2 = Atom (Pred (">=", [RealT r1; RealT r2]))
let ( $= ) r1 r2 = Atom (Pred ("=", [RealT r1; RealT r2]))
let ( $!= ) r1 r2 = Atom (Pred ("!=", [RealT r1; RealT r2]))

let ( $|| ) f1 f2 = Disj (f1, f2)
let ( $&& ) f1 f2 = Conj (f1, f2)

(* statBHL *)
type store_elm = fsymb * formula * float
type store = store_elm list
type alternative = Two | Up | Low

(* statELHT *)
type interpretation = real_term -> float
type world = World of store * interpretation

let interp : interpretation = fun _ -> 0.0
