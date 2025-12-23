(* CameleerReal *)
val ( =. ) : float -> float -> bool
val ( <=. ) : float -> float -> bool
val ( >=. ) : float -> float -> bool
val ( <. ) : float -> float -> bool
val ( >. ) : float -> float -> bool

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

val ppl : 'a dataset -> distribution

type real_term = private
  | Real of real_number
  | Mean of distribution
  | Var of distribution
  | Med of distribution

type term = RealT of real_term | DistributionT of distribution

val mean : distribution -> real_term
val var : distribution -> real_term
val med : distribution -> real_term
val const_term : float -> real_term
val param_term : real_number -> real_term

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

val ( $< ) : real_term -> real_term -> formula
val ( $> ) : real_term -> real_term -> formula
val ( $<= ) : real_term -> real_term -> formula
val ( $<= ) : real_term -> real_term -> formula
val ( $= ) : real_term -> real_term -> formula
val ( $!= ) : real_term -> real_term -> formula

val ( $|| ) : formula -> formula -> formula
val ( $&& ) : formula -> formula -> formula

(* statBHL *)
type store_elm = fsymb * formula * float
type store = store_elm list
type alternative = Two | Up | Low

(* statELHT *)
type interpretation = real_term -> float
type world = World of store * interpretation

val interp : interpretation
